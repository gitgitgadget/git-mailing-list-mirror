From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: cause a conflict if file mode does
	not match
Date: Fri, 14 Mar 2008 11:07:47 +0100
Message-ID: <20080314100747.GA23145@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 14 11:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6qD-0004bh-C3
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYCNKH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 06:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYCNKH5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:07:57 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:50785 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYCNKH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:07:56 -0400
Received: by mu-out-0910.google.com with SMTP id i10so9463882mue.5
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=VfGbritxZFYStAZTrYzT+tw7QKVnrkgIzaskauMwDuM=;
        b=HmR5b0HRE4AMdgo+0GKFUnx7DlcXPo/oiu3pK73qrFgTVEyi99efZ9+zJjCTuoPxiwXSF45KtzleUF7X2dgDmBk3LJKh6yICPvaHT7hwCxba2qly22dGx6USiCWDHS3ut8K2pt02sGI/QDCfH2hOjMJmpQVr1K6vKNU0jU0rsOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qfW0FoSVoWNw8o4mJI918Y7Ym6xeiaeqP5OA+zH/1zOKDwAkKmnYul5WpbZaDPyXZQrIJ1KEf3FWCDVtaLU5sSa01zFviPI2fgOnLIigu6MwQCHVUVyxQ5UgLzZAKF+bQCPvSJuBFtVZ5VbGzGxlFk1Z/XVB4ytHiK3Fmfmfqeo=
Received: by 10.78.193.5 with SMTP id q5mr4337583huf.75.1205489273239;
        Fri, 14 Mar 2008 03:07:53 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.115.33])
        by mx.google.com with ESMTPS id z40sm8166959ikz.4.2008.03.14.03.07.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 03:07:50 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja6pH-000635-AI; Fri, 14 Mar 2008 11:07:47 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803132216580.4174@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77198>

Hi,

On Thu, Mar 13, 2008 at 10:17:07PM +0100, Johannes Schindelin wrote:
> > Your patch certainly fixes a bug in git-merge-file. It does not fix the 
> > bug in git-merge-recursive, however. The test script also fails with 
> > your patch.
> 
> Now, _that_ is funny.  I tested before sending, and my test suit runs just 
> fine.

I didn't mean the existing test suite, which is fine with your bugfix, of
course. I was talking about the test which I submitted along with my bugfix.

Regards,
Clemens
