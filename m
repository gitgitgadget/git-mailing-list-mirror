From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Fri, 10 Jul 2009 16:45:42 +0200
Message-ID: <4A575416.2090304@drmicha.warpmail.net>
References: <h37fga$5ie$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 16:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPHMc-0004oo-I3
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 16:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbZGJOqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbZGJOqF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 10:46:05 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38811 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964AbZGJOqE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 10:46:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E25263B0B7E;
	Fri, 10 Jul 2009 10:45:59 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 10 Jul 2009 10:45:59 -0400
X-Sasl-enc: Xm/o/JdioCIUhKpIv0Xp/ttxV26tiCwxsSM9gntQkLEp 1247237159
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B4C151C5;
	Fri, 10 Jul 2009 10:45:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <h37fga$5ie$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123054>

Graeme Geldenhuys venit, vidit, dixit 10.07.2009 15:24:
> Hi,
> 
> What am I doing wrong here.  I 'git svn clone' a SubVersion repository 
> and when it was done, I was placed in the "master" branch, which seems 
> to track the "trunk" branch of the remote.
> 
> I then added GitHub as a remote repository:
> 
> $ git remote add origin git@github.com:graemeg/freepascal.git
> 
> I then tried to push all the SubVersion branches to GitHub, but only the 
> "master" branch went through.  I thought the --mirror will push everything.
> 
> Any ideas?
> 
> You can view the repository on GitHub with your Web Browser at this URL:
>    http://github.com/graemeg/freepascal/tree
> As you will notice, under the "all branches" option, only "master" is 
> available.
> 
> 
> =======================
> $ git branch -a
> * master
>    remotes/aspect
>    remotes/avr
>    remotes/cleanroom
>    remotes/cpstr
>    remotes/ctypes
>    remotes/fixes_2_0
>    remotes/fixes_2_2
>    remotes/fixes_2_2_0_dos
>    remotes/florian
>    remotes/fpc_2_3
>    remotes/generics
>    remotes/genfunc
>    remotes/inline
>    remotes/janbruns
>    remotes/linker
>    remotes/linker@2665
>    remotes/llvm
>    remotes/merged
>    remotes/newthreading
>    remotes/objc
>    remotes/origin/master
>    remotes/rc_2_2_2
>    remotes/release_2_1_2x
>    remotes/release_2_2_4_rc1
>    remotes/resources
>    remotes/ssa
>    remotes/tags/release_2_0_0
>    remotes/tags/release_2_0_2
>    remotes/tags/release_2_0_4
>    remotes/tags/release_2_0_4_macos
>    remotes/tags/release_2_0_4_rc1
>    remotes/tags/release_2_0_4_rc2
>    remotes/tags/release_2_0_4_rc3
>    remotes/tags/release_2_1_2
>    remotes/tags/release_2_1_4
>    remotes/tags/release_2_2_0
>    remotes/tags/release_2_2_2
>    remotes/tags/release_2_2_2_rc1
>    remotes/tags/release_2_2_2_rc2
>    remotes/tags/release_2_2_4
>    remotes/tags/test_2_0_4
>    remotes/tags/test_2_0_4_1
>    remotes/trunk
>    remotes/tue
>    remotes/unicodertl
>    remotes/unicodestring
>    remotes/unitrw
>    remotes/wpo
> =======================
> 
> 
> $ git push -v --mirror origin
> Pushing to git@github.com:graemeg/freepascal.git
> Counting objects: 130317, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (38881/38881), done.
> Writing objects: 100% (130317/130317), 54.53 MiB | 51 KiB/s, done.
> Total 130317 (delta 100296), reused 120757 (delta 90739)
> To git@github.com:graemeg/freepascal.git
>   * [new branch]      master -> master
>   * [new branch]      aspect -> aspect
>   * [new branch]      avr -> avr
>   * [new branch]      cleanroom -> cleanroom
>   * [new branch]      cpstr -> cpstr
>   * [new branch]      ctypes -> ctypes
>   * [new branch]      fixes_2_0 -> fixes_2_0
>   * [new branch]      fixes_2_2 -> fixes_2_2
>   * [new branch]      fixes_2_2_0_dos -> fixes_2_2_0_dos
>   * [new branch]      florian -> florian
>   * [new branch]      fpc_2_3 -> fpc_2_3
>   * [new branch]      generics -> generics
>   * [new branch]      genfunc -> genfunc
>   * [new branch]      inline -> inline
>   * [new branch]      janbruns -> janbruns
>   * [new branch]      linker -> linker
>   * [new branch]      linker@2665 -> linker@2665
>   * [new branch]      llvm -> llvm
>   * [new branch]      merged -> merged
>   * [new branch]      newthreading -> newthreading
>   * [new branch]      objc -> objc
>   * [new branch]      rc_2_2_2 -> rc_2_2_2
>   * [new branch]      release_2_1_2x -> release_2_1_2x
>   * [new branch]      release_2_2_4_rc1 -> release_2_2_4_rc1
>   * [new branch]      resources -> resources
>   * [new branch]      ssa -> ssa
>   * [new branch]      tags/release_2_0_0 -> tags/release_2_0_0
>   * [new branch]      tags/release_2_0_2 -> tags/release_2_0_2
>   * [new branch]      tags/release_2_0_4 -> tags/release_2_0_4
>   * [new branch]      tags/release_2_0_4_macos -> tags/release_2_0_4_macos
>   * [new branch]      tags/release_2_0_4_rc1 -> tags/release_2_0_4_rc1
>   * [new branch]      tags/release_2_0_4_rc2 -> tags/release_2_0_4_rc2
>   * [new branch]      tags/release_2_0_4_rc3 -> tags/release_2_0_4_rc3
>   * [new branch]      tags/release_2_1_2 -> tags/release_2_1_2
>   * [new branch]      tags/release_2_1_4 -> tags/release_2_1_4
>   * [new branch]      tags/release_2_2_0 -> tags/release_2_2_0
>   * [new branch]      tags/release_2_2_2 -> tags/release_2_2_2
>   * [new branch]      tags/release_2_2_2_rc1 -> tags/release_2_2_2_rc1
>   * [new branch]      tags/release_2_2_2_rc2 -> tags/release_2_2_2_rc2
>   * [new branch]      tags/release_2_2_4 -> tags/release_2_2_4
>   * [new branch]      tags/test_2_0_4 -> tags/test_2_0_4
>   * [new branch]      tags/test_2_0_4_1 -> tags/test_2_0_4_1
>   * [new branch]      trunk -> trunk
>   * [new branch]      tue -> tue
>   * [new branch]      unicodertl -> unicodertl
>   * [new branch]      unicodestring -> unicodestring
>   * [new branch]      unitrw -> unitrw
>   * [new branch]      wpo -> wpo
> updating local tracking ref 'refs/remotes/origin/master'
> 
> 
> Regards,
>    - Graeme -
> 

git-svn's standard ref structure makes it easy to shoot yourself into
the foot, and so does "--mirror". Combining the two is really a powerful
weapon :)

$git ls-remote   git://github.com/graemeg/freepascal.git
840169d189370c3b08760654800990404b2218df        HEAD
840169d189370c3b08760654800990404b2218df        refs/heads/master
3a5d5a06bbe62fada139c86438348e30ff4fcbe7        refs/remotes/aspect
f8a21acf439e698e7cb57a2a68401cfca2486c0c        refs/remotes/avr
78d1c138d4755f26ae1515842fcf36f13bf6b030        refs/remotes/cleanroom
b2701a7710bc343257b47738a06cb1290cec902f        refs/remotes/cpstr
92c78d3c8efe0bce64fda3f949596f37465bb6bb        refs/remotes/ctypes

etc.

You really mirrored your repo: All your "lost" branches are remotes on
the github side as well. That has two consequences:

1) They're not shown in the shiny interface.
2) They don't get cloned when someone clones from there.

At least 2) is completely unrelated to github, btw.

I think what you really want is to push everything under remote
(assuming there are only svn branches) into proper heads on github, i.e.
a refspec like '+refs/remotes/*:refs/*' for your pushes.

I assume you want to push master only if it differs from trunk, i.e. if
that repos is going to host not only the svn mirror but also your
additions. (I don't recommended that, a fork is better for that.)

Michael
