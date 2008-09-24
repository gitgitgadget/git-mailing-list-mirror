From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: On Sponsor Notices
Date: Thu, 25 Sep 2008 11:43:52 +1200
Message-ID: <46a038f90809241643i1e366dfbtea8dbdd9a1bc1de5@mail.gmail.com>
References: <20080924204358.144077183@suse.cz>
	 <20080924225120.GL10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 25 01:45:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kie2Z-0006Dt-Q3
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYIXXny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 19:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYIXXny
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:43:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:16864 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbYIXXnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:43:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so199812wfd.4
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PaUy8i1AKLwUmiemkMqXwN4bnyQC7er471SrA0eOfSQ=;
        b=CdD1lBCFmRxjL3DC2qm6YGPgFAn1Sm+wJQl69Wcagpiayh1md4ZXvOcLshG9snTzxn
         8/mq6mB52r5IA1Ph0tdxza5cEB8DG5upgg/H3uT2K1HjoXk/Dej3nfDRqvbueCZtUr8y
         duQlMmNkGvqy/RS0Rb87BoQ0q2rI3NcaYPkX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hzVYCUUh4LwtjcqfKzh3Go2WTUO0gVDtbVasOEINgkm4mkdgOKkh7iqAYcnNTzF7mg
         Go3VDLk6fAWxEeszM9oGQxm+dA2XrI9WxwQYEepLBSUG1KGPykoNsg0t8qktV1K+M3zq
         7xEb03+HUoK85yKp5xadE8b3ipPLbEDcWEBJk=
Received: by 10.143.43.7 with SMTP id v7mr2803580wfj.234.1222299832395;
        Wed, 24 Sep 2008 16:43:52 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Wed, 24 Sep 2008 16:43:52 -0700 (PDT)
In-Reply-To: <20080924225120.GL10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96714>

On Thu, Sep 25, 2008 at 10:51 AM, Petr Baudis <pasky@suse.cz> wrote:
>  to follow up a little on the "This patch has been sponsored by
> Novartis" messages - I have been on a summer internship at Novartis busy
> deploying Git and these patches (still quite a few more to come, mostly
> for gitweb) have been one of the main outputs of that work.

In my case, if the contribution is done at the behest of a client the
copyright is theirs (they paid for my work, and it's a "work for hire"
in legal terms). So

 - if the contribution is large, I tend to add a copyright line (see
git-cvsserver: copyright != authors, though that's out of date now)

 - they probably have to provide sign-off, so s-o-b line is appropriate

>  However, I'm not sure if acknowledging the Novartis-originated patches
> in the log message like this is the best practice and we will understand
> if the maintainers will decide to strip these notices when applying the
> patches.

AIUI, the signed-off-by line is meant to track this, and it serves
both legal purposes and a as recognition.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
