From: marat@slonopotamus.org
Subject: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Thu, 3 Apr 2014 17:18:50 +0400
Message-ID: <20140403131850.GA24449@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 15:22:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVhXm-00021U-VK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 15:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbaDCNSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 09:18:54 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:46151 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbaDCNSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 09:18:53 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WVhXe-0006Nn-Jg
	for git@vger.kernel.org; Thu, 03 Apr 2014 17:18:51 +0400
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245734>

I'm proud to announce WinGit:
an attempt to bring Git powers to 64-bit Windows.

WinGit is currently used only by my coworkers and isn't considered
production-ready-rock-solid. Use at your own risk.


Homepage & build instructions
-----------------------------
https://github.com/slonopotamus/wingit


Binaries
--------
MSI packages: https://github.com/slonopotamus/wingit/releases

After installation, git.exe is ready to be used from cmd.exe or TortoiseGit.
No kind of "Git Bash" or own explorer integration is provided.


Issues
------
Of course WinGit has issues:
https://github.com/slonopotamus/wingit/issues?state=open

Most notable are: git documentation is not packaged, no Tcl/Tk (thus, no gitk),
no SVN, no Explorer integration.


Sources
------------------

All sources are available on GitHub: https://github.com/slonopotamus/wingit

I know that build.sh is UGLY, especially openssl part.


Relationship with msysgit
=========================

Unlike msysgit, WinGit is a pure-Windows binary build with MSVC.

Like msysgit, WinGit also uses msys environment (sh/perl/etc) both during
build-time and runtime.

WinGit adds a few patches to Git itself on top of msysgit ones.
Patches are required due to insufficient testing of MSVC builds
(caused by total absence of any MSVC-built Git distributions).

All WinGit patches are sent upstream, just didn't get to master yet.
