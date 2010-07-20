From: Markus Heller <hellerm2@gmail.com>
Subject: Run git from .bat file (Windows)
Date: Tue, 20 Jul 2010 09:34:43 -0700
Message-ID: <0vy6d6nmcc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 18:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFrZ-0000gF-0x
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761368Ab0GTQkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 12:40:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:41149 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758478Ab0GTQkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:40:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ObFrP-0000ap-Ei
	for git@vger.kernel.org; Tue, 20 Jul 2010 18:40:03 +0200
Received: from 142.103.191.98 ([142.103.191.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 18:40:03 +0200
Received: from hellerm2 by 142.103.191.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 18:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 142.103.191.98
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
Cancel-Lock: sha1:/yAnlbxB6E+T1ZJ3H2SjE/XpfpQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151329>

Hello,

I'm trying to get the script below working on a box with Windoze XP and
git version 1.7.0.2.msysgit.0.  The script is a .bat file and is
supposed to be run from the Windoze scheduler; for testing, I run it
from a command prompt.

Here's the script:

=================8<==================8<=====================
@ECHO OFF

REM get date and time
for /f "delims=" %%a in ('date/t') do @set mydate=%%a
for /f "delims=" %%a in ('time/t') do @set mytime=%%a
set fvar=%mydate%%mytime%

REM add all new files
git add .
git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"
================>8===================>8======================

The line "git add ." works, as I can see the additions when I type "git
status" after executing the script.  Committing doesn't work, however:
"git log" shows that no commit was created.

Any idea what's going on?

Thanks
Markus
