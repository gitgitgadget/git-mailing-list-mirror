From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Tue, 22 Mar 2016 15:13:07 +0530
Message-ID: <56F113AB.8010606@gmail.com>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr>
 <56EFCAB2.2090804@gmail.com> <6ACB21B7-060F-4E22-BCA3-04A0341A1BC5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiIqN-0001MU-4b
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 10:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbcCVJnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 05:43:15 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34829 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbcCVJnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 05:43:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so302673300pfn.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5thLOTSaXcy/vZUvpxIIjYxb8Wp6ew0QJygsOYntbRY=;
        b=vQbULhsONu5JzmVQzO/69jIN+40mcQY8n5aw19W/xd2/COnP5x59iGfxfibc/uEUCM
         UqSR7INajfX3IgLNZbv5qDp5JOSq6/YPcrxNvx/ijdeQSCFa1cFKwhFRt91RHzS94dGS
         knpLMsspPwb0TTlvpe7uFzvc9X/ynbks9UtagtBNDzP6WWCyoKlWIAqxzjAwT3Vu04+V
         /lNL21nv5/jQzeKz857xzwUJwhn+HcHXn2VCt/c4BMytptMWJ3Cn4yk/XS9tNwZGefri
         /bAcNILCsrJKxLg7t1HmRoi1ecppbxWoJcABgNjN/36Em6OyvySGarNPrIpDW+LVeEzW
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5thLOTSaXcy/vZUvpxIIjYxb8Wp6ew0QJygsOYntbRY=;
        b=AA7RHn3bpPRuBkcC/uLLORXkaF8SVxR5ySkUGJ0YPhuBwHUy/JTC7tYRMGx2zpprVd
         2cO2PzVRNxUMD3wkMwzBv7Lj8h/rJggMQEOt5D8hGL2I2nr1yethBpJ9CtGpvwZsGUfw
         +qK9KDh64Qj16JE7ofclWJ/PdNgJDQFw16Hk20TI4f/+vT5rj1IsIDDA/2VJc+yo8hsX
         09S7NQa7phLGxQmjs1b9j1oliMYoFrGvd134yAY7BDe56elJPSLX/KpumCAEubj3wv3w
         YQM1prp1IlkceFHdtUO4AYbU1N/stG3BRTJmlxmgtpSGAQWrVi8fVAEDqHyw4aSWAmEU
         NiHw==
X-Gm-Message-State: AD7BkJImYDeijC/U02E1XUAQRFcbXQYKsLs9PxwHpmH5vNe/yYNrIsVwkCEFWr1po7YfUQ==
X-Received: by 10.66.156.232 with SMTP id wh8mr53133734pab.159.1458639792773;
        Tue, 22 Mar 2016 02:43:12 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.145.96])
        by smtp.gmail.com with ESMTPSA id s66sm46857182pfi.3.2016.03.22.02.43.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 02:43:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <6ACB21B7-060F-4E22-BCA3-04A0341A1BC5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289499>

Updated examples with better description for force push and reset HEAD,=
 as
suggested by Lars [11].

Thanks and regards,
Sidhant Sharma

[11]: http://thread.gmane.org/gmane.comp.version-control.git/289365/foc=
us=3D289495

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
vorable
as the existing users of git will not be affected by the wrapper.

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
 the
changes.

$ ggit commit -m =93Second commit=94
Committing staged changes=85
[master 0be3142] Second commit
 4 files changed, 6 insertions(+), 2 deletions(-)

$ ggit reset HEAD~1 --hard
Resetting HEAD to 1 previous commit.
[WARNING] You are about to hard reset the current HEAD (master) by 1 co=
mmit.
This will take you back to commit b16aae3, and discard all changes make
thereafter. If you want to reset but also want to retain the changes ma=
de since,
use --soft instead of --hard.
Are you sure you want to continue? [Y/n] y
Resetting HEAD to b16aae3=85
You can undo this action by resetting the HEAD to last commit you were =
on, that
is:
`$ ggit reset HEAD 0be3142`
In general, you can see the previous positions of HEAD by running `git =
reflog`.
HEAD is now at b16aae3 First commit

$ ggit push --force origin master
Pushing changes to origin/master
[WARNING] You are about to purge commits from the http://example.com/re=
po master
branch and overwrite its history to match yours.

State right now:
        o---o---o---A---B  master on http://example.com/repo
             \
              X---Y---Z  your master

State if you continue:
        o---o---o---X---Y---Z  master on http://example.com/repo and yo=
ur master

Commit A and B will be gone. If other people have worked on top of A or=
 B then
they won't be able to merge their changes easily.

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
bmit
sample patches for the same for comments and review.

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
orted so
far.

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
