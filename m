From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: update russian translation
Date: Thu, 27 Jan 2011 11:39:04 +0000
Message-ID: <87k4hqo9t3.fsf@fox.patthoyts.tk>
References: <20110119210131.GA8184@blimp.localdomain>
	<87sjwhn9c3.fsf@fox.patthoyts.tk>
	<7vmxmplt2g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 13:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiR2F-00024c-7D
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 13:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab1A0Mcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 07:32:42 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:57918 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754119Ab1A0Mck (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jan 2011 07:32:40 -0500
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PiQC5-0007Yp-Et; Thu, 27 Jan 2011 11:39:17 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PiQBs-0006zi-Bx; Thu, 27 Jan 2011 11:39:04 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2E14F203E7; Thu, 27 Jan 2011 11:39:04 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vmxmplt2g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jan 2011 16:34:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165577>

Junio C Hamano <gitster@pobox.com> writes:

>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> Thank you for the patches. I've applied the four patches and pushed them to
>> http://repo.or.cz/w/git-gui.git master.
>
>I see a few changes outside po/ru.po in this update:
>
> git-gui.sh      |   26 ++-
> lib/browser.tcl |    2 +-
> lib/diff.tcl    |   60 ++++--
> po/ru.po        |  623 ++++++++++++++++++++++++++++---------------------------
> 4 files changed, 381 insertions(+), 330 deletions(-)
>
>Are they all good to go for 1.7.4 final?  My cursory look indicates that
>they are all minor bugfixes and look sane, but I rarely use git-gui
>myself, so I am just double checking.
>
>
>Alex Riesen (2):
>      git-gui: update russian translation
>      git-gui: update russian translation
>
>Bert Wesarg (5):
>      git-gui: fix ANSI-color parsing
>      git-gui: respect conflict marker size
>      git-gui: fix browsers [Up To Parent] in sub-sub-directories.
>      git-gui: Fix use of renamed tag.
>      git-gui: Fix use of hunk tag for non-hunk content.
>
>Serge Ziryukin (1):
>      git-gui: fix russian translation typos
>
>Skip (1):
>      git-gui: spelling fixes in russian translation
>
>Stefan Naewe (1):
>      git-gui: use --exclude-standard to check for untracked files
>

Yes - these are good to go. Anything going onto master should be
suitable for merging to git. Anything that is still being tested I would
put onto pu if it got pushed at all.

So please merge git://repo.or.cz/git-gui.git master

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
