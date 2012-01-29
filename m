From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui Ctrl-U (unstage) broken
Date: Sun, 29 Jan 2012 23:19:41 +0000
Message-ID: <877h0at7ua.fsf@fox.patthoyts.tk>
References: <CAA5Ydx-mi7i7mWDYO=Cbw4g1b7LR0hw4Tcqe9gMtBoCkDRuvYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 00:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rre2i-0008U4-1i
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab2A2XTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:19:46 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:17920 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654Ab2A2XTp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 18:19:45 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120129231942.NGDF25056.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sun, 29 Jan 2012 23:19:42 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Rre2A-0007mi-HY; Sun, 29 Jan 2012 23:19:42 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 779E121875; Sun, 29 Jan 2012 23:19:41 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAA5Ydx-mi7i7mWDYO=Cbw4g1b7LR0hw4Tcqe9gMtBoCkDRuvYA@mail.gmail.com>
	(Victor Engmark's message of "Fri, 27 Jan 2012 15:03:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=_oLqP_zIxWQA:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=yrmNcZs1ImvMWikrIv8A:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189302>

Victor Engmark <victor.engmark@gmail.com> writes:

>Using the git-gui available with the default Ubuntu 10.10 repos, I'm
>not able to unstage files with the default keyboard shortcut. To
>reproduce:
>1. Change a file in the repository
>2. Run `git gui`
>3. Stage the changed file
>4. Select the changed file in the "Staged Changes (Will Commit)" list
>5. Click Ctrl-U
>
>Expected outcome: The selected file should be unstaged.
>
>Actual outcome: Nothing at all changes in the GUI.
>
>Verified that other keyboard shortcuts work: Ctrl-T, Ctrl-I, Ctrl--,
>Ctrl-+, F5. These (except Ctrl-T, obviously) were tested in* both the
>"Unstaged Changes" and "Staged Changes (Will Commit)" listsp
>
>* That is, after focusing a single element in that list.
>
>Version info:
>
>git-gui version 0.12.0.64.g89d6
>git version 1.7.1
>
>Tcl/Tk version 8.5.8
>Aspell 0.60.6, en_US

I checked this with the current version (gitgui-0.16.0) and it works ok
for me (on windows) - ie: ctrl-u unstaged a selected file.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
