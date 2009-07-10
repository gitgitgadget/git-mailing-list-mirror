From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Pushing to GitHub doesn't push all branches
Date: Fri, 10 Jul 2009 15:24:55 +0200
Message-ID: <h37fga$5ie$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 15:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPG7L-0002gv-Ag
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 15:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbZGJNZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 09:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZGJNZq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 09:25:46 -0400
Received: from main.gmane.org ([80.91.229.2]:49604 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbZGJNZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 09:25:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MPG6g-00088J-8b
	for git@vger.kernel.org; Fri, 10 Jul 2009 13:25:42 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 13:25:42 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 13:25:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123053>

Hi,

What am I doing wrong here.  I 'git svn clone' a SubVersion repository 
and when it was done, I was placed in the "master" branch, which seems 
to track the "trunk" branch of the remote.

I then added GitHub as a remote repository:

$ git remote add origin git@github.com:graemeg/freepascal.git

I then tried to push all the SubVersion branches to GitHub, but only the 
"master" branch went through.  I thought the --mirror will push everything.

Any ideas?

You can view the repository on GitHub with your Web Browser at this URL:
   http://github.com/graemeg/freepascal/tree
As you will notice, under the "all branches" option, only "master" is 
available.


=======================
$ git branch -a
* master
   remotes/aspect
   remotes/avr
   remotes/cleanroom
   remotes/cpstr
   remotes/ctypes
   remotes/fixes_2_0
   remotes/fixes_2_2
   remotes/fixes_2_2_0_dos
   remotes/florian
   remotes/fpc_2_3
   remotes/generics
   remotes/genfunc
   remotes/inline
   remotes/janbruns
   remotes/linker
   remotes/linker@2665
   remotes/llvm
   remotes/merged
   remotes/newthreading
   remotes/objc
   remotes/origin/master
   remotes/rc_2_2_2
   remotes/release_2_1_2x
   remotes/release_2_2_4_rc1
   remotes/resources
   remotes/ssa
   remotes/tags/release_2_0_0
   remotes/tags/release_2_0_2
   remotes/tags/release_2_0_4
   remotes/tags/release_2_0_4_macos
   remotes/tags/release_2_0_4_rc1
   remotes/tags/release_2_0_4_rc2
   remotes/tags/release_2_0_4_rc3
   remotes/tags/release_2_1_2
   remotes/tags/release_2_1_4
   remotes/tags/release_2_2_0
   remotes/tags/release_2_2_2
   remotes/tags/release_2_2_2_rc1
   remotes/tags/release_2_2_2_rc2
   remotes/tags/release_2_2_4
   remotes/tags/test_2_0_4
   remotes/tags/test_2_0_4_1
   remotes/trunk
   remotes/tue
   remotes/unicodertl
   remotes/unicodestring
   remotes/unitrw
   remotes/wpo
=======================


$ git push -v --mirror origin
Pushing to git@github.com:graemeg/freepascal.git
Counting objects: 130317, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (38881/38881), done.
Writing objects: 100% (130317/130317), 54.53 MiB | 51 KiB/s, done.
Total 130317 (delta 100296), reused 120757 (delta 90739)
To git@github.com:graemeg/freepascal.git
  * [new branch]      master -> master
  * [new branch]      aspect -> aspect
  * [new branch]      avr -> avr
  * [new branch]      cleanroom -> cleanroom
  * [new branch]      cpstr -> cpstr
  * [new branch]      ctypes -> ctypes
  * [new branch]      fixes_2_0 -> fixes_2_0
  * [new branch]      fixes_2_2 -> fixes_2_2
  * [new branch]      fixes_2_2_0_dos -> fixes_2_2_0_dos
  * [new branch]      florian -> florian
  * [new branch]      fpc_2_3 -> fpc_2_3
  * [new branch]      generics -> generics
  * [new branch]      genfunc -> genfunc
  * [new branch]      inline -> inline
  * [new branch]      janbruns -> janbruns
  * [new branch]      linker -> linker
  * [new branch]      linker@2665 -> linker@2665
  * [new branch]      llvm -> llvm
  * [new branch]      merged -> merged
  * [new branch]      newthreading -> newthreading
  * [new branch]      objc -> objc
  * [new branch]      rc_2_2_2 -> rc_2_2_2
  * [new branch]      release_2_1_2x -> release_2_1_2x
  * [new branch]      release_2_2_4_rc1 -> release_2_2_4_rc1
  * [new branch]      resources -> resources
  * [new branch]      ssa -> ssa
  * [new branch]      tags/release_2_0_0 -> tags/release_2_0_0
  * [new branch]      tags/release_2_0_2 -> tags/release_2_0_2
  * [new branch]      tags/release_2_0_4 -> tags/release_2_0_4
  * [new branch]      tags/release_2_0_4_macos -> tags/release_2_0_4_macos
  * [new branch]      tags/release_2_0_4_rc1 -> tags/release_2_0_4_rc1
  * [new branch]      tags/release_2_0_4_rc2 -> tags/release_2_0_4_rc2
  * [new branch]      tags/release_2_0_4_rc3 -> tags/release_2_0_4_rc3
  * [new branch]      tags/release_2_1_2 -> tags/release_2_1_2
  * [new branch]      tags/release_2_1_4 -> tags/release_2_1_4
  * [new branch]      tags/release_2_2_0 -> tags/release_2_2_0
  * [new branch]      tags/release_2_2_2 -> tags/release_2_2_2
  * [new branch]      tags/release_2_2_2_rc1 -> tags/release_2_2_2_rc1
  * [new branch]      tags/release_2_2_2_rc2 -> tags/release_2_2_2_rc2
  * [new branch]      tags/release_2_2_4 -> tags/release_2_2_4
  * [new branch]      tags/test_2_0_4 -> tags/test_2_0_4
  * [new branch]      tags/test_2_0_4_1 -> tags/test_2_0_4_1
  * [new branch]      trunk -> trunk
  * [new branch]      tue -> tue
  * [new branch]      unicodertl -> unicodertl
  * [new branch]      unicodestring -> unicodestring
  * [new branch]      unitrw -> unitrw
  * [new branch]      wpo -> wpo
updating local tracking ref 'refs/remotes/origin/master'


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
