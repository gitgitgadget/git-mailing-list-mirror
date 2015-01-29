From: Kevin <kevin071586@yahoo.com>
Subject: CTRL+Arrow keys don't work with Git Bash for Windows?
Date: Thu, 29 Jan 2015 15:18:26 +0000 (UTC)
Message-ID: <loom.20150129T161729-820@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 16:20:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGqtL-0003c4-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 16:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbbA2PUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 10:20:17 -0500
Received: from plane.gmane.org ([80.91.229.3]:57359 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbbA2PUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 10:20:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YGqt1-0003PS-Cg
	for git@vger.kernel.org; Thu, 29 Jan 2015 16:20:04 +0100
Received: from bcproxy-dmz-ca-02.ca.sandia.gov ([198.206.219.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 16:20:03 +0100
Received: from kevin071586 by bcproxy-dmz-ca-02.ca.sandia.gov with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 16:20:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.206.219.39 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263148>

Hello,
I'm trying to set up some navigation shortcuts I have become accustomed to
using in Windows environments, as well as KDE Konsole.  I would like to bind
CTRL+Left to "backward-word" and CTRL+Right to "forward-word" (there are
more, but this is a start).  I can enable this behavior by adding something
like "\e[D": forward-word to my ./inputrc file, but this also overwrites the
"forward-char" sequence that comes from a "Right Arrow" press without the
CTRL key.  For some reason, when I use the Git Bash shell the key sequence
for "CTRL+Right" and "Right" (\e[C) are the same -- same with "CTRL+Left"
and "Left" (\e[D).

Most of the solutions I have come across only address adding things to the
".inputrc" file, but in this case that is not the problem.  The problem is
that the CTRL+Arrow keys are not sending any unique sequences.  These
sequences are distinct and can be bound as I am describing when using the
"mintty.exe" xterm terminal emulator.  So why are they not working when I
start up Git Bash (which I believe has no emulator, it just uses windows
cmd.exe?).  I also see this problem when I use the "bash.exe --login -l"
that was installed with MinGW/MSys.

Thanks for any suggestions on how to enable this behavior.

Kevin
