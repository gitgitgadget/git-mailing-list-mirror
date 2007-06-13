From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Mail after commit
Date: Wed, 13 Jun 2007 16:10:40 +0100
Message-ID: <200706131610.42779.andyparkins@gmail.com>
References: <466EBC7E.8040104@gmail.com> <46a038f90706121335i79dc5967l782101bc743dc8e2@mail.gmail.com> <20070613142516.GE22027@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Claudio Scordino <cloud.of.andor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 17:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUW6-0000rR-14
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152AbXFMPKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757749AbXFMPKu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:10:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:18656 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160AbXFMPKt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:10:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so433361ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 08:10:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mxTmq79tLdfduVVls0zJWKezmxuLivHYC1SJURbGeHCgK0TbDd2cZCjtvuEiUB82lgfwREoeI+1HAK551MHgeKI0S8uMfkdjKLfhk9VIkveuP04NoVviQXaI1GW/0PkIsfxbFBkbfqh2mRFC91gvEASTyEvFHm6gugERpZp3Hrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gSaZcHavVVFZLz+SG5gSqXkgqCrm2hdV5nXyBiLT5nZn+f1T5ZDpaTVJEAxXcXSka3jU85vgsw1iqB/RqAZCrb9TQzgCjCowZe2SCQDZodKMajPsM+oWStTIG4mgg10pBJhqB2yRf9gMsX3pgTKU3GwOaAQMc91QhmMMUJ/oT9o=
Received: by 10.82.178.11 with SMTP id a11mr1302502buf.1181747447181;
        Wed, 13 Jun 2007 08:10:47 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm1790019ika.2007.06.13.08.10.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 08:10:46 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070613142516.GE22027@lug-owl.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50075>

On Wednesday 2007 June 13, Jan-Benedict Glaw wrote:

> > I think most people setup gitweb, and follow its rss feed. Not exacty
> > the same, I know, but quite useful.
>
> Erm, no, not really.  Emailing the patches is *quite* useful when
> there's a dedicated review team.

As an aside - I find it better to send announce emails on git-push rather than 
git-commit.  If you send an email on git-commit, then your working repository 
becomes a whole lot less useful.

For example I often do:

 git commit -a -m "Shelve what I'm doing right now"
 git checkout -b temporary-branch HEAD^^^
 vim fix-bug-that-I-never-want-anyone-to-see
 git checkout master
 git rebase temporary-branch
 git branch -d temporary-branch
 git reset HEAD^

Obviously this only works for commits I haven't pushed yet, but it's very 
useful to be able to do - usually I need it because I missed a git-add of a 
file out of a commit and didn't notice for a while.

Once I'm happy with my local history, then I git-push to the shared repository 
and an email is generated to let other members of the team know I've done 
something - they can then git-fetch and review if they feel like it.

To me, sending an email every commit would be like sending an email every time 
I pressed "save" in the editor.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
