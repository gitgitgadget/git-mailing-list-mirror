From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: restore wm state to normal before saving geometry information
Date: 15 Sep 2009 13:03:43 +0100
Message-ID: <87eiq8ct40.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Borzenkov <snaury@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 15:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnub1-0001we-8g
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 15:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518AbZIPN1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 09:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbZIPN1m
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 09:27:42 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:42517 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbZIPN1i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 09:27:38 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MnWl8-00073D-RC; Tue, 15 Sep 2009 13:03:46 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MnWl8-0001f5-A4; Tue, 15 Sep 2009 13:03:46 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 648D251843; Tue, 15 Sep 2009 13:03:45 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1252437756-81986-1-git-send-email-snaury@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128652>

Alexey Borzenkov <snaury@gmail.com> writes:

>gitk now includes patches for saving and restoring wm state, however
>because it saves wm geometry when window can still be maximized the
>maximize/restore button becomes useless after restarting gitk (you
>will get a huge displaced window if you try to restore it). This
>patch fixes this issue by storing window geometry in normal state.
>

I tried this patch on windows and I find that it causes the columns in
the top view to creep each time you restart the application. This is I
think due to the way this patch sets the state to normal before
recording all the settings.

I will post an alternative patch that records the normal geometry
whenever it changes instead which seems to work better for me.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
