From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [gitk] [PATCH] 0/2 Merging master into dev
Date: 06 Nov 2009 23:27:37 +0000
Message-ID: <871vkbw7x2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6YDa-0004Hg-RQ
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759922AbZKFX1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759691AbZKFX1f
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:27:35 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:34506 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758666AbZKFX1f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 18:27:35 -0500
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N6YDT-0008Je-Rv; Fri, 06 Nov 2009 23:27:39 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1N6YDT-0006ha-8A; Fri, 06 Nov 2009 23:27:39 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 75DFE13D310; Fri,  6 Nov 2009 23:27:38 +0000 (GMT)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132345>


I've merged the current changes for gitk master onto the dev branch
and fixed some conflicts and then modified the default colour
assignments for windows to use the system colours so that it will pick
up the stock colours defined via the windows property pages.

However, I'm not too certain how to post such a merge commit. Usually
I do 'git format-patch -M' but in this case that emits all the commits
that were merged. It looks like 'git show -p' is producing a merge
patch so I am posting that for 1/2 and a normal patch for 2/2. If
there is better way let me know and I will redo.

Note: these patches are for the gitk dev branch.

Hopefully this themed tk version is suitable for merging up to master
soon as this will significantly improve the look of the application in
msysGit.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
