From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: restore wm state to normal before saving geometry information
Date: 16 Sep 2009 22:07:07 +0100
Message-ID: <87ljkebnus.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	<19120.48177.116508.251237@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Borzenkov <snaury@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo1is-0007zZ-FM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760084AbZIPVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760114AbZIPVHR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:07:17 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:47983 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759965AbZIPVHM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 17:07:12 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Mo1iZ-0003ME-6e; Wed, 16 Sep 2009 22:07:11 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Mo1iY-0008CR-Hz; Wed, 16 Sep 2009 22:07:10 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 3D2FF51843; Wed, 16 Sep 2009 22:07:08 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <19120.48177.116508.251237@cargo.ozlabs.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128676>

Paul Mackerras <paulus@samba.org> writes:

>> patch fixes this issue by storing window geometry in normal state.
>
>Hmmm, shouldn't we be also saving the window state (zoomed/normal) and
>restoring that as well?
>
>Paul.

We do. That got added in c876dbad

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
