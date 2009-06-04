From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: di-git-ally managing love letters - a Git presentation
Date: Thu, 04 Jun 2009 07:51:20 -0700 (PDT)
Message-ID: <m3oct46oji.fsf@localhost.localdomain>
References: <d16b1c80906040441n7ad549eay83a6ccfd5db09fb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 16:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCEIX-0007He-CJ
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 16:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZFDOvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbZFDOvX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 10:51:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:42108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZFDOvW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 10:51:22 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1453411fga.17
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vf7QUHfSaqfHYjl4ok3hEX4Aq9SPLr34EFaLNIuUm/A=;
        b=QJSLPB6N7ffEkQTMK4SaKeipvw+wBe+QGp1HOW3qnvVXGLYkXOv0fSEfhSn6nKzQ+4
         1s3I69xBIYKhAiVejcs99H8Re91J6/kU+y9IHxWwBiZi43C46iSxvTKfIjXC5k1LHAUX
         wFagw8cNKIuqsJVrHcT/LAti/dWwrMNItX3qI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Jn3IXRXNZg1Pb5dj/sOHSrrf7HBSxyQgo6k6SgUyftwZ5h0CkIYGtRQOL8DWPTfZiE
         hkAn5LDIQgoRlakQpC60a3MGO5Yv1o1VfEOmHJ65DgPkNv4k4wEUzCf0Pfpp8IkYvBgo
         dzcQPjJxz62KcLsINW/qJcS73IfgnLNdAHx4k=
Received: by 10.86.90.2 with SMTP id n2mr2634102fgb.39.1244127082701;
        Thu, 04 Jun 2009 07:51:22 -0700 (PDT)
Received: from localhost.localdomain (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id 4sm2784232fgg.8.2009.06.04.07.51.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:51:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n54EotuI004282;
	Thu, 4 Jun 2009 16:51:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n54Eogcb004273;
	Thu, 4 Jun 2009 16:50:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d16b1c80906040441n7ad549eay83a6ccfd5db09fb3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120699>

Shakthi Kannan <shakthimaan@gmail.com> writes:

> I have tried to make a basic presentation on Git, that covers some
> basic commands. Please find it here:
> http://shakthimaan.com/downloads/glv/presentations/di-git-ally-managing-love-letters.pdf
> 
> The LaTeX beamer sources are available at:
> http://shakthimaan.com/downloads/glv/presentations/di-git-ally-managing-love-letters.tar.bz2

Why don't you use git to manage LaTeX sources, using for example one
of free git hosting sites (repo.or.cz, GitHub, Gitorious)?


I liked the presentation, especially visualisation of status of
working area, index and object database (repository).

A few comments:
 * For which git version do you write your presentation?  Modern
   git (which might mean just released version, and perhaps even
   yet-to-be-released version) has:
     - git config --global --edit   #; for Windows users
     - git log --oneline == git log --pretty=oneline --abbrev-commit

 * Nitpick: git index (also known as staging area) does not contain
   objects itself.  They are put in objects database.  The index 
   contains references to those objects (so they can be found).

 * Suggestion: When showing "git diff", "git diff --cached" and 
   "git diff HEAD" output you might want to show which parts
   in the diagram below you compare.

 * Why there is no diagram / graph for tagging?

 * Nitpick: you have spelled 'git-format-patch' by mistake
   instead of modern 'git format-patch'.

>
> I start with git init, add, commit;

 * I wonder which of workflows is more common: starting with empty
   repository, or starting with some set of files.  You can do
   "git init" in existing directory.  But perhaps starting with
   clean state is easier to describe, as you can just "git add .",
   while you might want to add only subset of files (using for
   example ignore rules) in project import workflow.

> show how to use rm with -f and --cached options; 

 * I would personally use "git rm -f <file>", but it might be easier
   tu add '-f' at the end of line.

> then go on to show reset HEAD (alternative to using --cached?);

 * I would guess that this usage ("git reset HEAD <file>") is quite
   rare, and would make more sense if there would be some committed
   version of <file>; then it wouldn't be equivalent to 
   "git rm --cached <file>".

> proceed further to show reset --soft

 * I think that actual usage of "git reset --soft" is pretty pretty
   rare since we have "git commit --amend".

> and --hard options.

 * "git reset --hard <revision>" is actually pretty useful.

> Finally, branching, merging, rebase and clone. It is not meant to be a
> comprehensive list of git commands, but, some essential ones to get
> people started with (I hope).
> 
> I would appreciate feedback, suggestions on the same. If you feel the
> commands are to be used differently, or in a different workflow
> perhaps, or if you find something that needs to be added, removed or
> fixed, please let me know.
> 
> Kindly ignore the nouns used.

I don't know if presentation is not too long. On the other hand it
doesn't cover situations such as non fast-formard merge...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
