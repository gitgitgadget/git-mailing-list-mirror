From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Tue, 22 Mar 2016 14:35:13 +0530
Message-ID: <56F10AC9.4050000@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Mar 22 10:05:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiIFi-0007Q8-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 10:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbcCVJFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 05:05:23 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35803 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbcCVJFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 05:05:19 -0400
Received: by mail-pf0-f170.google.com with SMTP id n5so301403012pfn.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pxFa2pkd3upBzAvUQpOPIfRNDB2fiEi+e6KBQAHM5no=;
        b=U6F7k5nOd47AEE0MOpy4R7KcRn/+IkzNacwSkgz/jxNR4LVqtw5fLtrJKhPNJlDOMy
         CLr5Vg3IbeN0OfWvuPapracHzm+5gZiaPLrZkwCPfizpHD8onDvw0ttboaIauMbrUyVU
         wEga5i2OUobpUJBrqiaE4CuxK6mPc9xvIgyYRs4u2j7lcHD2PJGLzV8Y/pcA9Pz0xncg
         /q4nOWwaQiJaGukmZp6H3VMTiSuM+QFhTiggZh97IKsYDwg4e9XcZB0+iSjfYHi9BGkS
         n6DilBrF7tKesmBjW2jy5XCvoh0adntP9et7+KfdhnE0RX1lr+5RE/tXLZzPDADUEwn1
         tj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pxFa2pkd3upBzAvUQpOPIfRNDB2fiEi+e6KBQAHM5no=;
        b=HZ7X1j05lTGnoMTsE/Tt358okG19IqzUARemhcJfWatdK+3WAeZxjzHvWympN3QMMY
         j01pR9oHyec30rZ3LkTdG3hU/TdGCh2CVaAXEZnVHIlVU8ESYqnl8G8wnYZAc/Vr4Gh6
         ht4qo9KiP5gqahPl/UrprEJKRREBkIRjvHd9FcnHktG9Ezz317Y/4MWNCCwUR2xZGX1h
         cz4k4Xe6eHz88ckFGvIHQNytcNqBsiJ0z8JzcucVYQwZIKRmK4ZY0OSVJMb6FKwkT7wn
         zjSP0lkXsAoRaQc3vkq3yA53fhvK3UgvoVGWUqB+QpcG3b4leSPRfnvm2eJoXs0bzOTm
         WjFg==
X-Gm-Message-State: AD7BkJLi/b2thFsypGnq4gcwWHjGTervpKEcTu7uFuuCY3cRzhQuO+3CYX+e8itXpEjwbQ==
X-Received: by 10.66.235.129 with SMTP id um1mr51828211pac.17.1458637518719;
        Tue, 22 Mar 2016 02:05:18 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.145.96])
        by smtp.gmail.com with ESMTPSA id wh9sm46557243pab.8.2016.03.22.02.05.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 02:05:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <6ACB21B7-060F-4E22-BCA3-04A0341A1BC5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289497>


On Tuesday 22 March 2016 02:08 PM, Lars Schneider wrote:
> On 21 Mar 2016, at 11:19, Sidhant Sharma <tigerkid001@gmail.com> wrot=
e:
>
>> Hi,
>> I updated the draft with links, ggit usage examples and some changes=
 to the
>> timeline. I placed the links with reference here, but in the Google =
Doc, they're
>> inline.
>>
>> Thanks and regards,
>> Sidhant Sharma
>>
>> ---
>>
>> Implement a beginner mode for Git.
>>
>> Abstract
>>
>> Git is a very powerful version control system, with an array of feat=
ures
>> that lend the user with great capabilities. But it often so happens =
that some
>> beginners are overwhelmed by its complexity and are unable to fully =
understand
>> and thus, utilize Git. Moreover, often beginners do not fully unders=
tand
>> the command they are using and end up making destructive (and occasi=
onally,
>> irreversible) changes to the repository.
>>
>> The beginner mode will assist such  users in using Git by warning th=
em
>> before making possibly destructive changes. It will also display tip=
s and
>> short snippets of documentation for better understanding the Git mod=
el.
>>
>> Google summer of code Idea suggested here:
>> http://git.github.io/SoC-2016-Ideas/#git-beginner
>>
>> About Me
>>
>> Name : Sidhant Sharma
>> Email [1] : Sidhant.Sharma1208 <at> gmail.com
>> Email [2] : Tigerkid001 <at>  gmail.com
>> College : Delhi Technological University
>> Studying : Software Engineering
>> IRC : tk001 (or _tk_)
>> Phone : 91-9990-606-081
>> Country : India
>> Interests : Computers, Books, Photography
>> Github : Tigerkid001
>> LinkedIn : https://in.linkedin.com/in/sidhantsharma12
>>
>> Technical Experience
>>
>> Authored several Mozilla Firefox and Google Chrome extensions:
>> Firefox: Owl [1], Blink [2], Spoiler Jedi [3]
>> Chrome: Blink [4]
>>
>> Developed a robust Plugin framework for Android [5] for a startup.
>> Learning Linux kernel programming via the Eudyptula Challenge [6]
>> (currently level 6).
>> Developed natural language processor for sarcasm detection [7] in tw=
eets.
>> Developed hand gesture detection module [8] as a college minor proje=
ct.
>> Active Firefox Add-ons Editor at AMO [9].
>> Currently working on a restaurant image classification project as se=
cond college
>> minor project.
>>
>> Why I chose Git
>>
>> I have been using Git for about two years now, and it has become an
>> indispensable daily-use tool for me. Getting a chance to participate=
 in GSoC
>> for the first time under Git is very exciting. It will give me an op=
portunity
>> to intimately know the system and a chance to help in making it bett=
er and more
>> powerful.
>>
>> Proposal
>>
>> Ideas Page: Git Beginner [10]
>>
>> The following tasks summarize the project:
>>
>> Implement a wrapper around Git
>>
>> A wrapper is to be implemented around (currently called 'ggit'), whi=
ch will
>> provide the following user interface:
>> `ggit <git-command> <options>`
>> For example, `ggit add --all`
>> The wrapper will assess the arguments passed to it, and if they are =
detected to
>> be safe, it will simply pass them through to 'git'. This approach is=
 favorable as the existing
>> users of git will not be affected by the wrapper.
>>
>> Warning for potentially destructive commands
>>
>> For every command that is entered, the wrapper will assess the subco=
mmand and
>> its options. In that, it will first check if the subcommand (eg. add=
,
>> commit, rebase) is present in a list of predefined 'potentially dest=
ructive'
>> commands. This can be done by searching through a radix tree for the=
 subcommand.
>> If found, then the arguments to the subcommand will be checked for s=
pecific
>> flags. The graylisted flags for the destructive commands will be sto=
red as an
>> array of regular expressions, and the current command's arguments wi=
ll be
>> checked against them. If matches are found, a warning is displayed. =
'ggit'
>> for the warning would be
>> "You are about to do X, which will permanently destroy Y. Are you su=
re you wish
>> to continue? [Y/n] "
>> If the user enters Y[es], the command will be executed as is (by pas=
sing it
>> unaltered to git). In the case of Y[es], 'ggit' will also give tips =
for undoing
>> the changes made by this command (by referring the user to correct c=
ommands and
>> reflog),  if the command can be undone. In case the command cannot b=
e undone,
>> 'ggit' will display an additional line in the warning like
>> "The changes made by this command cannot be undone. Please proceed c=
autiously".
>> In the case of n[o], 'ggit' will exit without executing the command.
>>
>> Currently, the list consists of commands like:
>>
>> $ git rebase
>> $ git reset --hard
>> $ git clean -f
>> $ git gc --prune=3Dnow --aggressive
>> $ git push -f <branch>
>> $ git push remote [+/:]<branch>
>> $ git branch -D
>>
>> The list will be updated after some more discussion on the list.
>>
>> Usage tips and documentation
>>
>> The wrapper will also be responsible for showing a short description=
 of every
>> command that is entered through 'ggit'. This shall be done for every=
 command
>> unconditionally. The description will be derived from the actual doc=
umentation,
>> but  will primarily aim to help the beginner understand the Git work=
flow and the
>> Git model.
>>
>> A few examples to illustrate the working of the wrapper are:
>>
>> $ ggit add --all
>> Staging all changes and untracked files. Use ` [g]git commit` to com=
mit the changes.
>>
>> $ ggit commit -m =93Second commit=94
>> Committing staged changes=85
>> [master 0be3142] Second commit
>> 4 files changed, 6 insertions(+), 2 deletions(-)
>>
>> $ ggit reset HEAD~1 --hard
>> Resetting HEAD to 1 previous commit.
>> [WARNING] You are about to hard reset the current HEAD (master) by 1=
 commit.
>> This will take you back to commit b16aae3, and discard all changes m=
ake thereafter.
>> If you want to reset but also want to retain the changes made since,=
 use --soft instead
>> of --hard.
>> Are you sure you want to continue? [Y/n] y
>> Resetting HEAD to b16aae3=85
>> You can undo this action by resetting the HEAD to last commit you we=
re on, which
>> can be seen by running `git reflog`.
> ggit could know the HEAD commit here. Therefore you could suggest 'gi=
t reset --hard $HASH_OF_OLD_HEAD'
> in addition (I like the reference to reflog to teach users where to l=
ook for this info).
>
Yeah, we can put that along with the reference to reflog so it's easier=
 for users
to undo quickly. Will update the proposal.
>> HEAD is now at b16aae3 First commit
>>
>> $ ggit push --force origin master
>> Pushing changes to origin/master
>> [WARNING] You are about to force push your history to origin/master,=
 which will
>> rewrite the remote history. Please ensure you really want to do so.
> I think the hardest challenge of this project is to find short and ea=
sy
> explanations that a newbie with almost no prior Git knowledge underst=
ands.=20
> We don't want to duplicate the man pages here. I have the impression =
visual=20
> explanations can often be superior.
>
>
> [WARNING] You are about to purge commits from the <URL of origin> mas=
ter branch.=20
>
> State right now:
> 	    o---o---o---A---B  master on <URL of origin>
> 		     \
> 		      X---Y---Z  your master
>
> State if you continue:
> 	    o---o---o---X---Y---Z  master on <URL of origin> and your master
>
> Commit A and B will be gone. If other people have worked on top of A =
or B then
> they won't be able to merge their changes easily.
I totally agree that visuals would serve the purpose much better. I'll
update the example with the warning message you suggest, and get starte=
d
with preparing more such visual descriptions. I'll post them for RFC so=
on.
> As a bonus we could also check if the force push would actually do ha=
rm before
> showing the message (that means if 'git push --force' was necessary a=
t all or
> if 'git push' would have done the same).
That'll be a nice touch. Will keep that in mind.


Thanks and regards,
Sidhant Sharma
>
> Thanks,
> Lars
>
>
>
>> Are you sure you want to continue? [Y/n] n
>> Aborting push to origin/master
>>
>> Timeline
>>
>> Community Bonding Period
>>
>> Week 1 : Discuss the flow of course with the mentor. Discuss adequat=
e data
>> structures and search techniques to be used.
>>
>> Week 2-3 : Discuss over an extensive list of commands that should be=
 classified
>> as destructive. Discuss appropriate short descriptions for commands.=
 Submit sample
>> patches for the same for comments and review.
>>
>> Week 4 : Discuss code structure, tests, optimization for least overh=
ead and
>> other details.
>>
>> Coding Starts
>>
>> Week 1-2 : Submit code for a basic wrapper that will warn for a subs=
et of the
>> potentially destructive command, and continue if the command is safe=
=2E
>> and this is stored as per to provide backward compatibility.
>>
>> Week 3-5 : Extend the wrapper to warn for more commands in the list,=
 along with
>> proper instructions for undoing them. Write tests for the commands s=
upported so far.
>>
>> Mid Term Evaluation
>>
>> Week 6-7 : Complete support for all graylisted commands with tests.
>>
>> Week 8-12: Add beginner-friendly documentation snippets to various g=
it commands.
>>
>> Week 13 : Final cleanup, final touches suggested by mentors and comm=
unity.
>>
>> Pens Down Date
>> Submission of Code to GSOC
>>
>> [1]: https://addons.mozilla.org/en-US/firefox/addon/owl/
>> [2]:  https://addons.mozilla.org/en-US/firefox/addon/blink/
>> [3]: https://addons.mozilla.org/en-US/firefox/addon/spoiler-jedi/
>> [4]: https://chrome.google.com/webstore/detail/blink-new-tab/kakaolk=
gegapcgdjdmlmcigejblohpkh/
>> [5]: https://github.com/TigerKid001/flubbr
>> [6]: http://eudyptula-challenge.org/
>> [7]: https://github.com/TigerKid001/Perry
>> [8]: https://github.com/TigerKid001/Dex
>> [9]: https://addons.mozilla.org/en-US/firefox/
>> [10]: http://git.github.io/SoC-2016-Ideas/#git-beginner
>>
