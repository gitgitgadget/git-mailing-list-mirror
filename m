From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git shortlog hangs in bare repo
Date: Mon, 26 Apr 2010 13:25:40 -0500
Message-ID: <20100426182540.GA11378@progeny.tock>
References: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
 <20100425215042.GA25547@progeny.tock>
 <n2i76c5b8581004261103k287ce0fax7b3a511dbb72c95b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:25:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Szd-0001VW-H4
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab0DZSYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 14:24:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:36673 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab0DZSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:24:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2162119fgg.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XEoHMiLm4KkQ1Gy57V2LwAGoq8rqB8s/9WZ7J9z1xf8=;
        b=fRgxjQ1ckFG7BUTKCtCrIjU347oxuTjirS3JbVnXu+gE/iTvDps/XIJvz01jVI49tR
         aZmF/UI4JdCHBpRESQwQ7IOHmTzZAr5wfmc2YJphOlX2znwCrIqpEVZwh/JOLkdXfnzh
         b9rJAv2LmaNcvZk32JQPpiaX08SXZwXsX2iUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=e1/XV0o5JIPK7Duu9wU1gxEv0De7Rlh+1O74djmCo/0nNR+WsN3ncFQOUDhARmP0HD
         CjEXi1e6AJx6kRu7uJQsMDA2+wxrtd6mYi0u10rl72UkNJR/ghyO+87zGZXclldOSAX/
         j3y3RowDGpjA5RFQCUoZSpiIK58g4jonRPDKU=
Received: by 10.87.68.26 with SMTP id v26mr487117fgk.40.1272306287136;
        Mon, 26 Apr 2010 11:24:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm107874fah.20.2010.04.26.11.24.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 11:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <n2i76c5b8581004261103k287ce0fax7b3a511dbb72c95b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145844>

Eugene Sajine wrote:

> This is happening in Git 1.6.5.6.
> The case here is that for the same project (same repo) in bare
> shortlog is not working, in non-bare it is working instantaneously.

Thanks, that was helpful.  This is fixed by v1.7.1-rc0~157^2~1
(setenv(GIT_DIR) clean-up, 2010-02-06).  You can find v1.7.1 at
<http://www.kernel.org/pub/software/scm/git/>, for example[1].

Thanks, Ren=E9.

Jonathan

[1] http://thread.gmane.org/gmane.linux.kernel/977720
