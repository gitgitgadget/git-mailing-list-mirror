From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: ANNOUNCE: Git for Windows 1.7.9
Date: Thu, 09 Feb 2012 22:44:50 +0900
Message-ID: <20120209224450.35F1.B013761@chejz.com>
References: <CABNJ2GJ-Jtpg=HsB9TmvLskmB9xXSeshHXz8V9koJfvMp5WNvA@mail.gmail.com> <4F33798F.2010908@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <blees@dcon.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Nawe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 14:46:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvUKG-0003Y6-0p
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 14:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616Ab2BINqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 08:46:11 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:37254 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab2BINqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 08:46:10 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q19DjeX9008114;
	Thu, 9 Feb 2012 22:45:40 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id q19Dje709911; Thu, 9 Feb 2012 22:45:40 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q19Djeui005875;
	Thu, 9 Feb 2012 22:45:40 +0900 (JST)
Received: from togyo.jp.nec.com ([10.26.220.4] [10.26.220.4]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-859015; Thu, 9 Feb 2012 22:45:10 +0900
Received: from [10.19.145.21] ([10.19.145.21] [10.19.145.21]) by mail.jp.nec.com with ESMTP; Thu, 9 Feb 2012 22:45:10 +0900
In-Reply-To: <4F33798F.2010908@atlas-elektronik.com>
X-Mailer: Becky! ver. 2.58 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190291>

On Thu, 09 Feb 2012 08:45:19 +0100
Stefan Nawe <stefan.naewe@atlas-elektronik.com> wrote:
> Am 01.02.2012 12:23, schrieb Pat Thoyts:
> > This release brings the latest release of Git to Windows users.
> > 
> > [...]
> 
> I'm getting errors from 'git repack -Ad' with this version on Windows XP:
> 
> $ /bin/git repack -Ad
> Counting objects: 147960, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (35552/35552), done.
> Writing objects: 100% (147960/147960), done.
> Total 147960 (delta 110699), reused 147960 (delta 110699)
> Deletion of directory '.git/objects/01/' failed. Should I try again? (y/n)
> Deletion of directory '.git/objects/05/' failed. Should I try again? (y/n) n
> Deletion of directory '.git/objects/07/' failed. Should I try again? (y/n) n
> Deletion of directory '.git/objects/0c/' failed. Should I try again? (y/n) n
> Deletion of directory '.git/objects/10/' failed. Should I try again? (y/n)
> ...

I was getting this a few months back before I set GIT_ASK_YESNO to
false and forgot all about it.

For me, it occurred every time I allowed git-gui to pack loose objects
and I sort of assumed repack was doing a 'rmdir .git/objects/*/" to
clean up empty directories and was triggering the prompt on non-empty
directories.

There was a bit of discussion regarding a slightly different symptom a
while back:
http://groups.google.com/group/msysgit/browse_thread/thread/0f75ac5abd850e21

Regards,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
