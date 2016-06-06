From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Minor Bug in Renaming Branches
Date: Mon, 6 Jun 2016 21:17:25 +0200
Message-ID: <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Samuel Lijin <samuel.lijin@formlabs.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 21:17:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA01y-0003kl-UX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbcFFTRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 15:17:37 -0400
Received: from mout.web.de ([212.227.15.4]:60774 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbcFFTRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 15:17:36 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LtoGb-1bYqeE2xbJ-011BaM; Mon, 06 Jun 2016 21:17:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
X-Provags-ID: V03:K0:srXphyaa7AsLAzk/D7c4L13YiNtLcwrqK6ivioooZpW3cm75Q3J
 EZSBFCkQaDld7YwzfyOlQyIihe1WAztIXyFxUD6vbsi+KfyVW7Xmuc+/0S1eL7QsHkwvohl
 TnMTUizM1ZdzXde05SjZ+8P8EQ6ELrdxdB9fAe4aQPCzI7h+Z7hZTpEToABsepdUfdNJFOT
 k2S4/J0Srz25g1gcZgEbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+c2NDSdoG3Y=:6JG476xxgyQ9HO5b+NJcWU
 +ZCS2tvaE6pFu2GiPtmxubj7r1vTHsUkUz/XFqjvIqkL2twBv1s8iZGfg/H/PuwooTDMYQrP0
 8E9DRGf3AyNqqwBYfjA06QDJcLdSc7yNuZHNS0dRkfchiiLdTrO8w558fmUpcWBUCy+UHbukS
 3Du0YIzLsoertt4jL51Pl8oG/sPioTuYeGnAz847/P/RX616DEMH0zB3JgI/qRUXsgbQBAi8j
 A2kzNu1/zlDkqLAivguKqfe/07rD+W/C5SPk4YAOX+zEmb1uE4XcdDRzkBvSS2+wKjx6N+r7V
 i342G3WfIz28tDTOO3rgH0WEkYwPTZ7kdTa4CDtTEAe09kULrvrR+t46X2B/CMl9VfpZljnfg
 O5o43UFt4F+/uR1/ww4jJSdNccLuDqPokTND+D4ZNHrxfTKOA946HSMXNNfiboKC2kjpyO578
 IKsHr+yUTafNKUXWnlyqwKE3Hz1sfs8qv7yG+odvQznGQztJrfsYbn3frlUd692EpcCuysR7a
 tDFAnZ4AYhuwFgjMuOsR/Rg/Q7ZMxasByYnpDeke0p1hwjG0dfXMW6Lv2XLhI69yN7Kvdxopa
 7azcuLJDMmnXJQQTHGENwXPXKxpcUi1k5Xy68gEcBDZrLzE1opxVNt6KDM9wycRNPSuOkgm9R
 3FA4KOuLqeSFUfc0cpjWMTYempR1xHSNIN6hMj+APfMWgJ/LCTTTU0oF+ZWW7JLwCiOjX9Wyh
 qOX3IoUeeZGi25qOAIxHsh+w7r/BbSdLgFPTe5PjjBqNQ7VXywH6Kj8q3NJ0m14/wGIMshmA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296552>

On 06.06.16 19:52, Samuel Lijin wrote:
> Hi,
> 
> Not quite sure where to submit bug reports about Git, this was the
> best I could find, so if there's a better place to do this, please let
> me know and I will.
> 
> The short of this issue is that on Mac and Windows, if a branch has a
> slash in its name, changing it from lowercase to uppercase requires
> diving into .git/refs/heads/ and manually moving stuff around - I
> think the behavior should be at least something like this:
> http://stackoverflow.com/questions/26810252/how-to-change-my-local-github-branch-name-to-uppercase.
> 
> It happens that on both Windows box, to rename a branch from
> "branch/name" to "BRANCH/NAME", one has to actually dive into
> .git/refs/heads/ because of how Windows handles upper/lowercase in
> directory paths. (Win7, mingw64 via Git for Bash, git version
> 2.7.0.windows.1)
> user@windows-box MINGW64 ~
> $ mkdir sandbox && cd sandbox && git init
> Initialized empty Git repository in C:/Users/user/sandbox/.git/
> user@windows-box MINGW64 ~/sandbox (master)
> $ touch empty.txt && git add empty.txt && git commit -m 'initialize repo'
> [master (root-commit) 761113d] initialize repo
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 empty.txt
> user@windows-box MINGW64 ~/sandbox (master)
> $ git branch
> * master
> user@windows-box MINGW64 ~/sandbox (master)
> $ git checkout -b branch/name
> Switched to a new branch 'branch/name'
> user@windows-box MINGW64 ~/sandbox (branch/name)
> $ git branch
> * branch/name
>   master
> user@windows-box MINGW64 ~/sandbox (branch/name)
> $ git branch -m BRANCH/NAME
> fatal: A branch named 'BRANCH/NAME' already exists.
> user@windows-box MINGW64 ~/sandbox (branch/name)
> $ git branch -m tmp
> user@windows-box MINGW64 ~/sandbox (tmp)
> $ git branch -m BRANCH/NAME
> user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
> $ git branch
>   branch/NAME
>   master
> user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
> $ mv .git/refs/heads/branch/ .git/refs/heads/BRANCH/
> user@windows-box MINGW64 ~/sandbox (BRANCH/NAME)
> $ git branch
> * BRANCH/NAME
>   master
> 
> Interestingly, from inside an Ubuntu VM (with the directory in
> question mounted as a VBox fileshare), this is not an issue.
> 
> A colleague on a Mac also reproduces the issue successfully (OSX
> 10.11.5, git 2.8.3):
> 
> mac-box:sandbox user$ touch empty.txt && git add empty.txt && git
> commit -m 'initial commit'
> [master (root-commit) 1f4f1fa] initial commit
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 empty.txt
> mac-box:sandbox user$ git branch
> * master
> mac-box:sandbox user$ git checkout -b branch/name
> Switched to a new branch 'branch/name'
> mac-box:sandbox user$ git branch -m BRANCH/NAME
> fatal: A branch named 'BRANCH/NAME' already exists.
> mac-box:sandbox user$ git branch
> * branch/name
>   master
> mac-box:sandbox user$ git branch -m tmp
> mac-box:sandbox user$ git branch
>   master
> * tmp
> mac-box:sandbox user$ git branch -m BRANCH/NAME
> mac-box:sandbox user$ git branch
>   branch/NAME
>   master
> mac-box:sandbox user$ mv .git/refs/heads/branch/ .git/refs/heads/BRANCH/
> mac-box:sandbox user$ git branch
> * BRANCH/NAME
>   master
> 
> Thanks,
> Sam
A limitation is introduced by Mac OS and Windows:
BRANCH/NAME and branch/name refer to the same object in the file
system.
As a workaround, you can pack the branch names:
git pack-refs --all
or, 
that is my preference, avoid using the same name upper- and
lower-case.



> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
