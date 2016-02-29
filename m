From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git 2.7.2.windows.1 fails to authenticate access to private
 repository over HTTPS
Date: Mon, 29 Feb 2016 14:30:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602291405150.3152@virtualbox>
References: <0eee43fe410bb5db3dc8eeec2f7ff00c@slingshot.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: zacr <zacr@slingshot.co.nz>
X-From: git-owner@vger.kernel.org Mon Feb 29 14:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaNuJ-00056d-Vl
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 14:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbcB2Na2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 08:30:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:49258 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbcB2NaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 08:30:23 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Man6U-1aLTNm0QSQ-00KRek; Mon, 29 Feb 2016 14:30:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <0eee43fe410bb5db3dc8eeec2f7ff00c@slingshot.co.nz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BIVXu9e8e7BGMiCqdaGyq49AjAWvi7Vpv00QTUMmXbF387aJanO
 Mk1fiahsuFrF4W7RoZ/Gyf/sRn93sPvGEtKVoa2pIDmYTCDUDw6xglJHDRNnybTrJNiMsLq
 BHYw7QmZSgTZ5P7axMDaBfwzMBXOXmJ+UKxjiQcJy5E7gXeQlGsmOjP5+dYXXotv/K1agGS
 C75UAqeMHPfOhnlx/x1Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BT9cbyI+VJ4=:NmiD/uz2zYzH/QsskNcMGg
 4LVGKjbEZSCa8GPz9clwe5jiZosdNMeqPqo3e1P2exrzO6XRx1GhIPNxVA1eK7XCwXDMOwpO4
 YD/rBlMzzucfH83Xs4Ull1z7sPaKD2nHxiOfNb9ioEPQuZDSVT62fkxenHJn9joD/HImftBcm
 7ONU/3mSk1V2xu23Re7Hs+UZPaNa41v3x3fZeORTWcIj/SpjExG2/C4pf7WUzDqN7XZAKhVQb
 2152sTsv2J1D2wafv/1kFPoNBiAAAfTzwiF2x46t5IMZpm/z++hi5HrKY5n82LvMG42rGDOOH
 Pnqn78QwBexSoPRv8NRL/cmpK2kXyqWyRWt8cnec9S47/4PPie4F1QJniuWKKJCx65o9x0Cgs
 7zownmyylLYT6rZHs773DVLz7351SvXUZQKwpFgbG8+e4fSIC/sfZqr62oN8/exdnjRqsHa/s
 KUb0/PcvPcHmJHk5LxzAddNLvFy8KeDq6i87TEbjV+XJoZ3vpG+r9NrzeTIOOSZXB6C+W1h9w
 hOLPu8kzrbsumKJ7kYf8p2Lmrq4YcQNLMI9dCCBGU8qiUrqmzvwoNvV/h2ssKaDFtAk4y7D7L
 5XNS+G2hq9Oc4MMEJ0imwXx9KU8TT/SmBLoiVy4S49AouKCAa2WJSi/WHvdaNgaz/ed20qb7V
 PVIYQYW5sBfez7fVDbEKNJD7cvCMxko6sWV6FirdvR3ID11HOMsCKWZzVdVTfwqdVIpHVW2lw
 +LeGgVNrHh44omz1/wQmsuZ21nC6qE75tP1JCJv5qcGpMVoP/h6KV+MlEr7r4H1vBo+Y+NlZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287836>

Hi Zac,

On Mon, 29 Feb 2016, zacr wrote:

> I have recently downloaded 64-bit Git for Windows (the file I downloaded
> was "Git-2.7.2-64-bit.exe"). This reports a version string of "git
> version 2.7.2.windows.1"
>
> Using it from the command line, after cloning a repository, I attempted
> to "git pull" a private repository from GitHub.

Are you using Git CMD? It is rather crucial to get such details right.

> 15:55:58.615147 git.c:348               trace: built-in: git 'pull'
> 15:55:58.617147 run-command.c:343       trace: run_command: 'fetch'
> '--update-head-ok'
> 15:55:58.633149 git.c:348               trace: built-in: git 'fetch'
> '--update-head-ok'
> 15:55:58.636149 run-command.c:343       trace: run_command:
> 'git-remote-https' 'origin' 'https://github.com/username/repository.git'
> 15:55:59.630248 run-command.c:343       trace: run_command: 'bash' '-c' 'cat
> >/dev/tty && read -r line </dev/tty && echo "$line"'
> error: failed to execute prompt script (exit code 1)
> fatal: could not read Username for 'https://github.com': Invalid argument
> 
> 
> It looks like it's trying to run a new bash instance for me to enter my
> password, which fails on Windows because I don't have bash installed.

You do have bash installed. Unless you went out of your way to delete it
after installing Git for Windows.

Assuming that you used Git CMD to perform your test, the sad news is that
I cannot reproduce your problem here.

Let's first of all try to make a Minimal, Complete & Verifiable Example
(MCVE). In other words, let's find the minimal set of steps with no
prerequisites (such as local clones of private repositories) that *still*
reproduce the bug. This is in general a Very Good Idea if you are
reporting bugs because it not only shows that you are dedicated to see
this bug fixed but also that you are not expecting only others to invest
a ton of time into the bug fix.

In your case, the problem is easily triggered without a local clone at
all. A simple `git ls-remote https://github.com/user/repository.git` is
enough, and would count as *Minimal* as per that MCVE acronym.

Alas, when I issue this (with GIT_TRACE=1), I get this:

-- snip --
C:\Users\me>set GIT_TRACE=1

C:\Users\me>git ls-remote https://github.com/user/repository.git
14:14:01.717354 git.c:348               trace: built-in: git 'ls-remote' 'https://github.com/user/repository.git'
14:14:01.718331 run-command.c:343       trace: run_command: 'git-remote-https' 'https://github.com/user/repository.git' 'https://github.com/user/repository.git'
14:14:02.599651 run-command.c:343       trace: run_command: 'bash' '-c' 'cat >/dev/tty && read -r line </dev/tty && echo "$line"'
Username for 'https://github.com': 123
14:14:06.822993 run-command.c:343       trace: run_command: 'bash' '-c' 'cat >/dev/tty && read -r -s line </dev/tty && echo "$line" && echo
>/dev/tty'
Password for 'https://123@github.com':
remote: Invalid username or password.
fatal: Authentication failed for 'https://github.com/user/repository.git/'
-- snap --

So at first I thought maybe you called

	C:\Program Files\Git\mingw64\bin\git.exe

directly, which is a user mistake that is unfortunately quite frequent,
the appropriate entry point is instead

	C:\Program Files\Git\cmd\git.exe

But even then, it succeeds for me (without having sh.exe nor bash.exe in
the PATH):

-- snip --
C:\Users\me>"\Program Files"\git\mingw64\bin\git ls-remote https://github.com/user/repository.git
14:22:44.320489 git.c:348               trace: built-in: git 'ls-remote' 'https://github.com/user/repository.git'
14:22:44.321470 run-command.c:343       trace: run_command: 'git-remote-https' 'https://github.com/user/repository.git' 'https://github.com/user/repository.git'
14:22:44.990258 run-command.c:343       trace: run_command: 'bash' '-c' 'cat >/dev/tty && read -r line </dev/tty && echo "$line"'
Username for 'https://github.com': 123
14:22:45.840206 run-command.c:343       trace: run_command: 'bash' '-c' 'cat >/dev/tty && read -r -s line </dev/tty && echo "$line" && echo >/dev/tty'
Password for 'https://123@github.com':
remote: Invalid username or password.
fatal: Authentication failed for 'https://github.com/user/repository.git/'
-- snap --

Maybe your setup has something funky going on that my setup lacks.

Lastly, for the record, the best way to report bugs in Git for Windows is
through the bug tracker at https://github.com/git-for-windows/git/issues.
I tried to make this obvious on Git for Windows' home page at
https://git-for-windows.github.io/#contribute.

Maybe you have an idea how I could make it more obvious to users who
prefer visiting StackOverflow over visiting Git for Windows' home page?

Ciao,
Johannes
