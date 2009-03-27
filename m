From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 07:09:28 -0700 (PDT)
Message-ID: <m3fxgz2h2n.fsf@localhost.localdomain>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49CCCB3D.8010706@drmicha.warpmail.net>
	<49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCmb-0006NZ-5M
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbZC0OJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZC0OJe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:09:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:60393 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbZC0OJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:09:32 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1270292rvb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=q8KN+UI+N7fUfOLs3X7/6RT6wKP5vVhXr8wDJ3+/BrI=;
        b=stOAGOuG17WOr1bvE5wB7MWbDmuotN4qDOwnbxeseJIj/B/os5xipDvK1WuwjSKNZC
         RVYCP+HBBKi5nXoyZjqgrXbdwAVg/uRBwQePgpfCHnxYnZM+eMPoDwU0hwtTnZWv3ssn
         KI4KCS4GFBvjN+tArmr92CQ1e57i0nUJ9pWHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RmyokOJ95SWN0p+bmDBran+v1Cvwk9vdIByMQKXm5u1X8xvziqoRE55HPDt9lOZ2AV
         HiKFHHo8RID/H/BsXAULbgfKBFXwjJU+3O0zLvPmVzFnHzuX7gm0UU/VlZxgrKK+vth7
         6ZSNyPMgbgnYFoV73YdAvrGrogNdaWCJazaz0=
Received: by 10.114.196.13 with SMTP id t13mr1458877waf.82.1238162970839;
        Fri, 27 Mar 2009 07:09:30 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id a8sm4754613poa.19.2009.03.27.07.09.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 07:09:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2RE9M2e008173;
	Fri, 27 Mar 2009 15:09:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2RE9Kq6008170;
	Fri, 27 Mar 2009 15:09:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114896>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> On 27 Mar 2009 at 13:49, Michael J Gruber wrote: 
> > Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
> 
> [...]
> 
> > Keyword substitution and cvs/svn style version numbers are independent
> > issues. The sha1 describes a commit uniquely, one could use that as a
> > keyword.
> 
> However version numbers and time stamps have the property of being at least 
> partially ordered in respect of "newer/older". That property does not hold for 
> SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft 
> Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft 
> Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)

That is why people use output of git-describe and _tag_ their releases,
and make embedding version number in released version (tarball / binary)
the job of make: see GIT-VERSION-GEN script in git sources, and how it
is used in Makefile.

> 
> > 
> > Increasing version numbers are meaningless in a true DVCS world. What is
> > your 100th commit may not be someone else's, even if both your master's
> > heads are the same! This is why hg version numbers are a local thing.
> > They are merely a local shortcut for specifying a revision and serve the
> > same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
> > work permanently, not even in a local repo, if you allow rebasing.
> 
> Maybe I didn't fully understand, but having a version number that is larger than 
> any parent's version numbers when doing a merge/commit doesn't look wrong to me.

I'm sorry to dissapoint you, but without central server assigning
numbers to commits it wouldn't simply work in distributed version
control world.  Take for example the following situation: somebody
clones your repository, and creates new commit on 'master' (trunk) and
it gets version number N.  Meanwhile you also independently create new
commit on 'master'... and without central authority it would also get
version number N.  Then you would merge (pull) his/her changes, and
you would have two commits with the same number; not something you want.

Not to mention that you can have multiple roots (multiple commits with
no parent) in git repository; besides independent branches (like
'man', 'html' or 'todo') it is usually result of absorbing or
subtree-merging other projects.  In 'master' branch there are 5 roots
or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
and subtree-merged gitk and git-gui.  And here you would again have
multiple commits with the same number...

The idea of generation numbers was discussed on git mailing list, but
rather as mechanism helping in faster topological ordering of commits
(--topo-sort)... but it was dropped.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
