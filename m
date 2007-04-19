From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 04:08:58 +0200
Message-ID: <200704190408.59595.jnareb@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 04:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeM1P-00072W-LJ
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993084AbXDSCFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993105AbXDSCFO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:05:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993084AbXDSCFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:05:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so551454uga
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 19:05:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eRES9s2y8O5U9y1iskIRw23nK94XGCk8MDxql4AiAEqSEwZwVpre4u72PtXMumrL1YWmZn5oyzIlTMS9BcWKFU7+s9pw5Xwh3tM6odkL/i84ul5l4NMU1OmHYqaKnITnlKbASM0pt5LIUVdKj4RcqEeJ62IOv21gQEBuYbnYy18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QhvD+geqzhGud1gwaPQojtS5P3zTm0DSIHGjDVg4CFml2nunBXqafFMa5GOJcfOcXyQ+JWgLz+hnJ9+UIUvmdIQjwJWxGxO3Fk6o3UZzr/LwCz0kC6YMYuQwYc4dMmYOJlagP/2ol65CdSILEiM7+cMJoO2fIq30mJ0tzZpYI+k=
Received: by 10.66.216.6 with SMTP id o6mr1674944ugg.1176948310561;
        Wed, 18 Apr 2007 19:05:10 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm1592799muf.2007.04.18.19.05.07;
        Wed, 18 Apr 2007 19:05:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4626C4B9.1040707@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44974>

Steven Grimm wrote:
> Jakub Narebski wrote:

>> In my opinion the update-then-commit workflow CVS and SVN forces on users
>> is one of the more annoying features, forcing the user to resolve conflicts
>> if he/she wants to be up-to-date.
>>   
> 
> I'm not eager to jump to svn's defense -- there's a reason I'm using git 
> and trying to get my coworkers to do the same -- but how does git allow 
> you to stay up to date without resolving conflicts? Granted that git is 
> smarter about resolving certain kinds of conflicts automatically, but 
> fundamentally if the latest revision you've pulled down (from any kind 
> of version control system) makes a change that conflicts with a local 
> change (whether or not you've committed it locally first) you're going 
> to have to resolve it by hand, yes?

The answer is that in git you can separate _having_ most current version
from the server (git fetch) and _merging_ your work with current version
from the server (git pull).

> Also, last I checked, git wouldn't let me push into a branch that had 
> revisions I hadn't yet pulled down. Isn't that just another way of 
> enforcing an update-then-commit workflow? If anything, svn wins in that 
> area -- it allows me to commit without updating as long as my change 
> doesn't touch any files that have changed upstream.
> 
> One can argue about whether allowing partial commits like that is a good 
> idea, but it's just not true that svn forces you to always update before 
> you commit, and if you're pushing into a branch that other people are 
> also updating, the ability to commit files that didn't change upstream 
> means it is actually *less* insistent on update-then-commit than git is 
> (if you take "commit" to mean "commit-and-push" on the git side as was 
> suggested in the message I replied to originally.)
> 
> Unless, of course, I'm misinterpreting you here.

I just think the commit _then_ merge (or commit-then-update) workflow is
much, much better than update-then-commit one.

-- 
Jakub Narebski
Poland
