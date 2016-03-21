From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Mon, 21 Mar 2016 15:49:30 +0530
Message-ID: <56EFCAB2.2090804@gmail.com>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahww3-0004FJ-9O
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 11:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbcCUKTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 06:19:38 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35509 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbcCUKTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 06:19:35 -0400
Received: by mail-pf0-f181.google.com with SMTP id n5so259691935pfn.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sO2Eg+i4a1UEqqpRJS+aD1WbqonK/YRBFhgbLLgPpzk=;
        b=WIoh5HOxVpblTWRGQL3YJAd0AuZxpZmQIaCuE5/AWXcurwWTQIKX45prPNltyD/H5U
         0Zz7X4kCrPnLzXiW4NDltYfgVc/VOPPyfJNC3fO8sIAxnUBJmjRh5iQyX+rWoVUNSy+j
         49LnCrZnR8GXLxqHJ932AZ13R0FH8ZHgRNevAaI0DISt6Wx72+VBzLgiRjyFAGazXhyR
         8+AGw1zSjEmnQZYrPwo6mS5gs2u7Ul4hoCMNQp1iC2JKGVmT2E/4w9uA8gmzHl4EQtfJ
         1YmLGnend5eIAi08+ScfOhFWyLHkOOagGkaGUadI+3ui6v61J2pIP0hwdMvkfL0Fl+wT
         q44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sO2Eg+i4a1UEqqpRJS+aD1WbqonK/YRBFhgbLLgPpzk=;
        b=UCdr+fHHWbGXozKvG161dJAmFg3pBiFA92nnJrAiClXkoGfWHCDQoSWvIgqGEJEYmy
         GhKSmXRafgxI9Ur1cNJUnLdKuaWg4wzcO22lLtjVS6qZ8HzCCFaA6cvYjUFMHngv8UY9
         RQKkr0aMDppCzqNFeoJYBq+oMBEuHLox9Sj/9bsOxhPnI/BurrQ6rFjbwvVYZg40aCEi
         1EdVxPQJVXgKeZ1v25NrDETJUTOpI7BB2X7cUx3+Wz5jPeioFMYu3pburcRwIrTPWrTg
         QtUwz7pK1PcAv9GFcBrSbpnzCTHgeIgJef8YMwK/tKaTrwSXprW3+1ujB0vxCYFXScW0
         LyYg==
X-Gm-Message-State: AD7BkJIpBvr531/N/wddXPyHxZ7iXc4329VP1Cn3C9foDE0JBcY9e0rJvo/f2fptKapiZA==
X-Received: by 10.98.18.1 with SMTP id a1mr22537335pfj.39.1458555575165;
        Mon, 21 Mar 2016 03:19:35 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.145.96])
        by smtp.gmail.com with ESMTPSA id i9sm39417277pfi.95.2016.03.21.03.19.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 03:19:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <vpq4mc1asmy.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289415>

Hi,
I updated the draft with links, ggit usage examples and some changes to=
 the
timeline. I placed the links with reference here, but in the Google Doc=
, they're
inline.

Thanks and regards,
Sidhant Sharma

---

Implement a beginner mode for Git.

Abstract

Git is a very powerful version control system, with an array of feature=
s
that lend the user with great capabilities. But it often so happens tha=
t some
beginners are overwhelmed by its complexity and are unable to fully und=
erstand
and thus, utilize Git. Moreover, often beginners do not fully understan=
d
the command they are using and end up making destructive (and occasiona=
lly,
irreversible) changes to the repository.

The beginner mode will assist such  users in using Git by warning them
before making possibly destructive changes. It will also display tips a=
nd
short snippets of documentation for better understanding the Git model.

Google summer of code Idea suggested here:
http://git.github.io/SoC-2016-Ideas/#git-beginner

About Me

Name : Sidhant Sharma
Email [1] : Sidhant.Sharma1208 <at> gmail.com
Email [2] : Tigerkid001 <at>  gmail.com
College : Delhi Technological University
Studying : Software Engineering
IRC : tk001 (or _tk_)
Phone : 91-9990-606-081
Country : India
Interests : Computers, Books, Photography
Github : Tigerkid001
LinkedIn : https://in.linkedin.com/in/sidhantsharma12

Technical Experience

Authored several Mozilla Firefox and Google Chrome extensions:
=46irefox: Owl [1], Blink [2], Spoiler Jedi [3]
Chrome: Blink [4]

Developed a robust Plugin framework for Android [5] for a startup.
Learning Linux kernel programming via the Eudyptula Challenge [6]
(currently level 6).
Developed natural language processor for sarcasm detection [7] in tweet=
s.
Developed hand gesture detection module [8] as a college minor project.
Active Firefox Add-ons Editor at AMO [9].
Currently working on a restaurant image classification project as secon=
d college
minor project.

Why I chose Git

I have been using Git for about two years now, and it has become an
indispensable daily-use tool for me. Getting a chance to participate in=
 GSoC
for the first time under Git is very exciting. It will give me an oppor=
tunity
to intimately know the system and a chance to help in making it better =
and more
powerful.

Proposal

Ideas Page: Git Beginner [10]

The following tasks summarize the project:

Implement a wrapper around Git

A wrapper is to be implemented around (currently called 'ggit'), which =
will
provide the following user interface:
`ggit <git-command> <options>`
=46or example, `ggit add --all`
The wrapper will assess the arguments passed to it, and if they are det=
ected to
be safe, it will simply pass them through to 'git'. This approach is fa=
vorable as the existing
users of git will not be affected by the wrapper.

Warning for potentially destructive commands

=46or every command that is entered, the wrapper will assess the subcom=
mand and
its options. In that, it will first check if the subcommand (eg. add,
commit, rebase) is present in a list of predefined 'potentially destruc=
tive'
commands. This can be done by searching through a radix tree for the su=
bcommand.
If found, then the arguments to the subcommand will be checked for spec=
ific
flags. The graylisted flags for the destructive commands will be stored=
 as an
array of regular expressions, and the current command's arguments will =
be
checked against them. If matches are found, a warning is displayed. 'gg=
it'
for the warning would be
"You are about to do X, which will permanently destroy Y. Are you sure =
you wish
to continue? [Y/n] "
If the user enters Y[es], the command will be executed as is (by passin=
g it
unaltered to git). In the case of Y[es], 'ggit' will also give tips for=
 undoing
the changes made by this command (by referring the user to correct comm=
ands and
reflog),  if the command can be undone. In case the command cannot be u=
ndone,
'ggit' will display an additional line in the warning like
"The changes made by this command cannot be undone. Please proceed caut=
iously".
In the case of n[o], 'ggit' will exit without executing the command.

Currently, the list consists of commands like:

$ git rebase
$ git reset --hard
$ git clean -f
$ git gc --prune=3Dnow --aggressive
$ git push -f <branch>
$ git push remote [+/:]<branch>
$ git branch -D

The list will be updated after some more discussion on the list.

Usage tips and documentation

The wrapper will also be responsible for showing a short description of=
 every
command that is entered through 'ggit'. This shall be done for every co=
mmand
unconditionally. The description will be derived from the actual docume=
ntation,
but  will primarily aim to help the beginner understand the Git workflo=
w and the
Git model.

A few examples to illustrate the working of the wrapper are:

$ ggit add --all
Staging all changes and untracked files. Use ` [g]git commit` to commit=
 the changes.

$ ggit commit -m =93Second commit=94
Committing staged changes=85
[master 0be3142] Second commit
 4 files changed, 6 insertions(+), 2 deletions(-)

$ ggit reset HEAD~1 --hard
Resetting HEAD to 1 previous commit.
[WARNING] You are about to hard reset the current HEAD (master) by 1 co=
mmit.
This will take you back to commit b16aae3, and discard all changes make=
 thereafter.
If you want to reset but also want to retain the changes made since, us=
e --soft instead
of --hard.
Are you sure you want to continue? [Y/n] y
Resetting HEAD to b16aae3=85
You can undo this action by resetting the HEAD to last commit you were =
on, which
can be seen by running `git reflog`.
HEAD is now at b16aae3 First commit

$ ggit push --force origin master
Pushing changes to origin/master
[WARNING] You are about to force push your history to origin/master, wh=
ich will
rewrite the remote history. Please ensure you really want to do so.
Are you sure you want to continue? [Y/n] n
Aborting push to origin/master

Timeline

Community Bonding Period

Week 1 : Discuss the flow of course with the mentor. Discuss adequate d=
ata
structures and search techniques to be used.

Week 2-3 : Discuss over an extensive list of commands that should be cl=
assified
as destructive. Discuss appropriate short descriptions for commands. Su=
bmit sample
patches for the same for comments and review.

Week 4 : Discuss code structure, tests, optimization for least overhead=
 and
other details.

Coding Starts

Week 1-2 : Submit code for a basic wrapper that will warn for a subset =
of the
potentially destructive command, and continue if the command is safe.
and this is stored as per to provide backward compatibility.

Week 3-5 : Extend the wrapper to warn for more commands in the list, al=
ong with
proper instructions for undoing them. Write tests for the commands supp=
orted so far.

Mid Term Evaluation

Week 6-7 : Complete support for all graylisted commands with tests.

Week 8-12: Add beginner-friendly documentation snippets to various git =
commands.

Week 13 : Final cleanup, final touches suggested by mentors and communi=
ty.

Pens Down Date
Submission of Code to GSOC

[1]: https://addons.mozilla.org/en-US/firefox/addon/owl/
[2]:  https://addons.mozilla.org/en-US/firefox/addon/blink/
[3]: https://addons.mozilla.org/en-US/firefox/addon/spoiler-jedi/
[4]: https://chrome.google.com/webstore/detail/blink-new-tab/kakaolkgeg=
apcgdjdmlmcigejblohpkh/
[5]: https://github.com/TigerKid001/flubbr
[6]: http://eudyptula-challenge.org/
[7]: https://github.com/TigerKid001/Perry
[8]: https://github.com/TigerKid001/Dex
[9]: https://addons.mozilla.org/en-US/firefox/
[10]: http://git.github.io/SoC-2016-Ideas/#git-beginner
