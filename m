From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Tue, 22 Mar 2016 09:38:02 +0100
Message-ID: <6ACB21B7-060F-4E22-BCA3-04A0341A1BC5@gmail.com>
References: <56EED10B.4010604@gmail.com> <vpq4mc1asmy.fsf@anie.imag.fr> <56EFCAB2.2090804@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:38:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiHpc-00022n-BQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 09:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbcCVIiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 04:38:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34774 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086AbcCVIiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 04:38:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id p65so28156682wmp.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x5s5+nAgbAmsBwQ3lS5ElvpiaqKXn2SYIewbdeqnnAE=;
        b=egmVtws0gDclqIpBjzAqv5EcyRIsZ8tq0eWGhz78CarxdUGm24yLtjENt4QhrOWkUy
         Z2natpdlQh1pC57hrQqu7l7a/g4pnkcxelBKkwf5g38PwdV+KMEI9L1utZ1brWyyKqIH
         Kxd8rxlBb8ksLB8yX7N9w0QMdhF1wFsW+h+kZv4B2t+gnuChZA7Kyhl+3cjIPa4ap1Ov
         sx2IOjJ72csBRWA4vu2HqkRMdoXfPUs450BXVJkulGqwZUPx5up6/lAArKUnmTTaiwlv
         VUuQ2hxAZGcYDagr2eqDWoZyq0doSwI8oGkjXWOh1RItiqwXz3Wl6r1tSi+CJdvcAxns
         zt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x5s5+nAgbAmsBwQ3lS5ElvpiaqKXn2SYIewbdeqnnAE=;
        b=bhEsKuJcoZtdqYW760/bT7sJHhWvHuyd9LzIFdTGCbXVkDA1PBdp390bwzBn2lSh7t
         HO8vcH/f4sjVO/VuqdqaFQCZ/CUA6gpRWYJElegmL2a/Hnt4I+TsxYLs5ZlisBw1T6e8
         R/bqr0WLnIhhSfCMW/WuikbskO0xIcPt7RuKOPA8FRUAZ+vsVUwdB66h+VwH+8eRROS/
         9UV5ue1tBtPI/2eCxB1HSThp3wadJOeEoqoIncv6dOz6QmptophYK694FfbcmUYw1wyH
         3Qu7ChXaJCxeWHfPhC8R5JXWCsqmKxdnImJKj5Psbf9t4AtxTi5cw7gAY8ROgGYwLxUp
         nuCg==
X-Gm-Message-State: AD7BkJLSayUfezAYOIaVkgfRB8fEQSUq0qtVxihW0UACkJbxirsQOKWFbKPqUX0QM7mE8A==
X-Received: by 10.194.6.234 with SMTP id e10mr34807576wja.118.1458635886090;
        Tue, 22 Mar 2016 01:38:06 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA324.dip0.t-ipconnect.de. [80.139.163.36])
        by smtp.gmail.com with ESMTPSA id 198sm16204870wml.22.2016.03.22.01.38.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 01:38:05 -0700 (PDT)
In-Reply-To: <56EFCAB2.2090804@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289495>


On 21 Mar 2016, at 11:19, Sidhant Sharma <tigerkid001@gmail.com> wrote:

> Hi,
> I updated the draft with links, ggit usage examples and some changes =
to the
> timeline. I placed the links with reference here, but in the Google D=
oc, they're
> inline.
>=20
> Thanks and regards,
> Sidhant Sharma
>=20
> ---
>=20
> Implement a beginner mode for Git.
>=20
> Abstract
>=20
> Git is a very powerful version control system, with an array of featu=
res
> that lend the user with great capabilities. But it often so happens t=
hat some
> beginners are overwhelmed by its complexity and are unable to fully u=
nderstand
> and thus, utilize Git. Moreover, often beginners do not fully underst=
and
> the command they are using and end up making destructive (and occasio=
nally,
> irreversible) changes to the repository.
>=20
> The beginner mode will assist such  users in using Git by warning the=
m
> before making possibly destructive changes. It will also display tips=
 and
> short snippets of documentation for better understanding the Git mode=
l.
>=20
> Google summer of code Idea suggested here:
> http://git.github.io/SoC-2016-Ideas/#git-beginner
>=20
> About Me
>=20
> Name : Sidhant Sharma
> Email [1] : Sidhant.Sharma1208 <at> gmail.com
> Email [2] : Tigerkid001 <at>  gmail.com
> College : Delhi Technological University
> Studying : Software Engineering
> IRC : tk001 (or _tk_)
> Phone : 91-9990-606-081
> Country : India
> Interests : Computers, Books, Photography
> Github : Tigerkid001
> LinkedIn : https://in.linkedin.com/in/sidhantsharma12
>=20
> Technical Experience
>=20
> Authored several Mozilla Firefox and Google Chrome extensions:
> Firefox: Owl [1], Blink [2], Spoiler Jedi [3]
> Chrome: Blink [4]
>=20
> Developed a robust Plugin framework for Android [5] for a startup.
> Learning Linux kernel programming via the Eudyptula Challenge [6]
> (currently level 6).
> Developed natural language processor for sarcasm detection [7] in twe=
ets.
> Developed hand gesture detection module [8] as a college minor projec=
t.
> Active Firefox Add-ons Editor at AMO [9].
> Currently working on a restaurant image classification project as sec=
ond college
> minor project.
>=20
> Why I chose Git
>=20
> I have been using Git for about two years now, and it has become an
> indispensable daily-use tool for me. Getting a chance to participate =
in GSoC
> for the first time under Git is very exciting. It will give me an opp=
ortunity
> to intimately know the system and a chance to help in making it bette=
r and more
> powerful.
>=20
> Proposal
>=20
> Ideas Page: Git Beginner [10]
>=20
> The following tasks summarize the project:
>=20
> Implement a wrapper around Git
>=20
> A wrapper is to be implemented around (currently called 'ggit'), whic=
h will
> provide the following user interface:
> `ggit <git-command> <options>`
> For example, `ggit add --all`
> The wrapper will assess the arguments passed to it, and if they are d=
etected to
> be safe, it will simply pass them through to 'git'. This approach is =
favorable as the existing
> users of git will not be affected by the wrapper.
>=20
> Warning for potentially destructive commands
>=20
> For every command that is entered, the wrapper will assess the subcom=
mand and
> its options. In that, it will first check if the subcommand (eg. add,
> commit, rebase) is present in a list of predefined 'potentially destr=
uctive'
> commands. This can be done by searching through a radix tree for the =
subcommand.
> If found, then the arguments to the subcommand will be checked for sp=
ecific
> flags. The graylisted flags for the destructive commands will be stor=
ed as an
> array of regular expressions, and the current command's arguments wil=
l be
> checked against them. If matches are found, a warning is displayed. '=
ggit'
> for the warning would be
> "You are about to do X, which will permanently destroy Y. Are you sur=
e you wish
> to continue? [Y/n] "
> If the user enters Y[es], the command will be executed as is (by pass=
ing it
> unaltered to git). In the case of Y[es], 'ggit' will also give tips f=
or undoing
> the changes made by this command (by referring the user to correct co=
mmands and
> reflog),  if the command can be undone. In case the command cannot be=
 undone,
> 'ggit' will display an additional line in the warning like
> "The changes made by this command cannot be undone. Please proceed ca=
utiously".
> In the case of n[o], 'ggit' will exit without executing the command.
>=20
> Currently, the list consists of commands like:
>=20
> $ git rebase
> $ git reset --hard
> $ git clean -f
> $ git gc --prune=3Dnow --aggressive
> $ git push -f <branch>
> $ git push remote [+/:]<branch>
> $ git branch -D
>=20
> The list will be updated after some more discussion on the list.
>=20
> Usage tips and documentation
>=20
> The wrapper will also be responsible for showing a short description =
of every
> command that is entered through 'ggit'. This shall be done for every =
command
> unconditionally. The description will be derived from the actual docu=
mentation,
> but  will primarily aim to help the beginner understand the Git workf=
low and the
> Git model.
>=20
> A few examples to illustrate the working of the wrapper are:
>=20
> $ ggit add --all
> Staging all changes and untracked files. Use ` [g]git commit` to comm=
it the changes.
>=20
> $ ggit commit -m =93Second commit=94
> Committing staged changes=85
> [master 0be3142] Second commit
> 4 files changed, 6 insertions(+), 2 deletions(-)
>=20
> $ ggit reset HEAD~1 --hard
> Resetting HEAD to 1 previous commit.
> [WARNING] You are about to hard reset the current HEAD (master) by 1 =
commit.
> This will take you back to commit b16aae3, and discard all changes ma=
ke thereafter.
> If you want to reset but also want to retain the changes made since, =
use --soft instead
> of --hard.
> Are you sure you want to continue? [Y/n] y
> Resetting HEAD to b16aae3=85
> You can undo this action by resetting the HEAD to last commit you wer=
e on, which
> can be seen by running `git reflog`.
ggit could know the HEAD commit here. Therefore you could suggest 'git =
reset --hard $HASH_OF_OLD_HEAD'
in addition (I like the reference to reflog to teach users where to loo=
k for this info).


> HEAD is now at b16aae3 First commit
>=20
> $ ggit push --force origin master
> Pushing changes to origin/master
> [WARNING] You are about to force push your history to origin/master, =
which will
> rewrite the remote history. Please ensure you really want to do so.
I think the hardest challenge of this project is to find short and easy
explanations that a newbie with almost no prior Git knowledge understan=
ds.=20
We don't want to duplicate the man pages here. I have the impression vi=
sual=20
explanations can often be superior.


[WARNING] You are about to purge commits from the <URL of origin> maste=
r branch.=20

State right now:
	    o---o---o---A---B  master on <URL of origin>
		     \
		      X---Y---Z  your master

State if you continue:
	    o---o---o---X---Y---Z  master on <URL of origin> and your master

Commit A and B will be gone. If other people have worked on top of A or=
 B then
they won't be able to merge their changes easily.

As a bonus we could also check if the force push would actually do harm=
 before
showing the message (that means if 'git push --force' was necessary at =
all or
if 'git push' would have done the same).


Thanks,
Lars



> Are you sure you want to continue? [Y/n] n
> Aborting push to origin/master
>=20
> Timeline
>=20
> Community Bonding Period
>=20
> Week 1 : Discuss the flow of course with the mentor. Discuss adequate=
 data
> structures and search techniques to be used.
>=20
> Week 2-3 : Discuss over an extensive list of commands that should be =
classified
> as destructive. Discuss appropriate short descriptions for commands. =
Submit sample
> patches for the same for comments and review.
>=20
> Week 4 : Discuss code structure, tests, optimization for least overhe=
ad and
> other details.
>=20
> Coding Starts
>=20
> Week 1-2 : Submit code for a basic wrapper that will warn for a subse=
t of the
> potentially destructive command, and continue if the command is safe.
> and this is stored as per to provide backward compatibility.
>=20
> Week 3-5 : Extend the wrapper to warn for more commands in the list, =
along with
> proper instructions for undoing them. Write tests for the commands su=
pported so far.
>=20
> Mid Term Evaluation
>=20
> Week 6-7 : Complete support for all graylisted commands with tests.
>=20
> Week 8-12: Add beginner-friendly documentation snippets to various gi=
t commands.
>=20
> Week 13 : Final cleanup, final touches suggested by mentors and commu=
nity.
>=20
> Pens Down Date
> Submission of Code to GSOC
>=20
> [1]: https://addons.mozilla.org/en-US/firefox/addon/owl/
> [2]:  https://addons.mozilla.org/en-US/firefox/addon/blink/
> [3]: https://addons.mozilla.org/en-US/firefox/addon/spoiler-jedi/
> [4]: https://chrome.google.com/webstore/detail/blink-new-tab/kakaolkg=
egapcgdjdmlmcigejblohpkh/
> [5]: https://github.com/TigerKid001/flubbr
> [6]: http://eudyptula-challenge.org/
> [7]: https://github.com/TigerKid001/Perry
> [8]: https://github.com/TigerKid001/Dex
> [9]: https://addons.mozilla.org/en-US/firefox/
> [10]: http://git.github.io/SoC-2016-Ideas/#git-beginner
>=20
