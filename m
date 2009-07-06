From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Git gui error RenderBadPicture
Date: 06 Jul 2009 10:22:58 +0100
Message-ID: <87tz1qjhcd.fsf@users.sourceforge.net>
References: <d4cf37a60907051640k215595a1n95b720201243fc89@mail.gmail.com>
	<20090706001658.GA3745@unpythonic.net>
	<d4cf37a60907051747n4ca55c28oed36a0349ace7948@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 11:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNkPs-0002Yt-0A
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 11:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbZGFJXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 05:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZGFJXD
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 05:23:03 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:37627 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861AbZGFJXC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 05:23:02 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MNkPe-0007T6-Ov; Mon, 06 Jul 2009 10:23:02 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MNkPd-0004E9-ET; Mon, 06 Jul 2009 10:23:01 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 5DBD651842; Mon,  6 Jul 2009 10:22:59 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <d4cf37a60907051747n4ca55c28oed36a0349ace7948@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122779>

You might like to raise this on the Tk bug tracker at sourceforge. On
my Ubuntu system I can reproduce this with Tk 8.5.7 but not with
8.4.19 nor the current HEAD (8.6b1.1). As this is something in the use
of Xft I'd not expect to see a problem with 8.4.x as this was added to
8.5+. I can't see anything explicit that should have fixed this in the
8.6 tree though.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
