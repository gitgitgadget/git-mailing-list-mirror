From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Undo last commit?
Date: Sat, 18 Jun 2011 06:54:50 -0700 (PDT)
Message-ID: <m31uyrutx7.fsf@localhost.localdomain>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 15:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXw19-0002P3-46
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 15:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab1FRNyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 09:54:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34223 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1FRNyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 09:54:53 -0400
Received: by fxm17 with SMTP id 17so207580fxm.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=jIN6sc7WATFlwLdvDUp3+46386Vl2arP9jIoi13Wgbs=;
        b=f/w2x4+8WRlk/1hkIZElOLBakWa7iby8XYaFi3giFS8YRvquXNwjYQpXJCepxPdel9
         W8hvmudDIV7CtCEsOI+wLcvv5LqFEZOJvGCreHw6cxtq0yv9OAzLaLQ9nA7/r3Rmltj5
         qGBwBj7CD+4XPwGUV8yGUkZ+K/7EPHaY/YzcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dasFs/bm74VgQBe3UxgEhWB8za5WNYYqZR+Sntm9QjCnp0Ub4sGc25PSuLuLTIdZ+O
         VTo5JhZnMfYUhy5r3zsFkMXgbJblUS6H/Gq+b5FjHdSkHdnj8HVvwlA2wFzrmc5fV2gw
         oUnf0qjXerN71eEcwLQcFv8sdcZa1U3OcBx/o=
Received: by 10.223.41.89 with SMTP id n25mr1634704fae.7.1308405291783;
        Sat, 18 Jun 2011 06:54:51 -0700 (PDT)
Received: from localhost.localdomain (abrz104.neoplus.adsl.tpnet.pl. [83.8.119.104])
        by mx.google.com with ESMTPS id 5sm435768faz.0.2011.06.18.06.54.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 06:54:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5IDsNxY020285;
	Sat, 18 Jun 2011 15:54:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5IDsCYZ020279;
	Sat, 18 Jun 2011 15:54:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175970>

Mike <xandrani@gmail.com> writes:

> Hi fellow gitters,
> 
> I have performed a 'git commit' on all 'added' files by mistake and
> now I want to undo this commit to return to the original state. Here's
> a more detailed description:
> 
> 
> 1. I did a 'git status' and there were files which I had 'added' ready
> for a commit. There were also some changes that had not been 'added'
> yet. See below:
> 
> % git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 7 commits.
> #
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	modified:   cgi-bin/example1.php
> #	modified:   cgi-bin/example2.php
> #	modified:   example3.php
> #
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	modified:   cgi-bin/example4.php
> #	modified:   example5.php
> #
> 
> 
> 2. I accidentally did a commit for ALL files because I forgot to
> specify the filename at the end of the commit.
> e.g. instead of 'commit -m "commit message" example3.php' I did
> 'commit -m "commit message"'.

You committed all staged changes (i.e. only those on "Changes to be
committed" list), not all changes; for that you would need to use '-a'
option to git commit.

BTW. why are you using '-m' option?
 
> 3. I googled the problem and it seems everyone has a different way of
> doing this. (Maybe git is too confusing if everyone has different
> methods that all work slightly differently!?). Anyway I executed this
> command:
> 
> % git commit --amend

You could simply use

  % git commit --amend -m "commit message" example3.php

The `--amend` just means to fix (redo) last commit.

> But I aborted this by exiting my text editor.

O.K.

> 4. I then tried:
> 
> % git reset --hard HEAD~1

Errr... here you screwed up.  This reset state of you working area to
the state at last commit, removing all your changes to tracked files.

> 5. However now when I do a 'git status' none of the files that were
> original listed are there. A git status now gives this:
> 
> # On branch master
> # Your branch is ahead of 'origin/master' by 7 commits.
> #
> nothing to commit (working directory clean)
> 
> 
> Any ideas how to rectify this issue? I presume the 'git commit
> --amend' just changes the commit message? I daren't try anything else
> myself in case I make matters worse.

You lost your changes to files on "Changed but not updated" list,
i.e. cgi-bin/example4.php and example5.php.

What you can do is go back to your last commit (the errorneous one) by
using

  $ git reset --keep HEAD@{1}

Which means reset to last state (before 'git reset --hard HEAD~1'; you
can check it with "git reflog" or "git log -g"), keeping your local
changes (if you used '--keep' not '--hard' then you wouldn't loose
your changes).

Then redo this commit like you wanted to

  $ git commit --amend -m "commit message" example3.php

Or better

  $ git commit --amend -v example3.php

To check if you are committing correct changes.

...................

Alternatively check out state of example3.php from last made commit:

  $ git checkout HEAD@{1} -- example3.php

Do your commit

  $ git commit -m "commit message" example3.php

Get state of other files that you accidentally comitted from next to
last state of HEAD:

  $ git checkout HEAD@{2} -- cgi-bin/example1.php cgi-bin/example2.php

Unfortunately changes to cgi-bin/example4.php and example5.php are
lost.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
