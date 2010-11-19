From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: fix ANSI-color parsing
Date: Fri, 19 Nov 2010 09:34:00 +0000
Message-ID: <87sjyxhd2v.fsf@fox.patthoyts.tk>
References: <1289815233-11391-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 10:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJNVv-0001Et-H8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 10:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab0KSJoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 04:44:08 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:39674 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab0KSJoH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 04:44:07 -0500
Received: from [172.23.144.247] (helo=asmtp-out3.blueyonder.co.uk)
	by smtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PJNVg-00031n-Kp; Fri, 19 Nov 2010 09:44:02 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PJNM1-0000CH-La; Fri, 19 Nov 2010 09:34:01 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id F1A4120068; Fri, 19 Nov 2010 09:34:00 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1289815233-11391-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Mon, 15 Nov 2010 11:00:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161729>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>git diff always outputs color reset commands, even when the color for the
>current part is disabled (ie. normal). But the current ANSI-color parsing code
>assumes that color start and reset commands appear in matching pairs.
>
>Relax this assumption.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

Thanks for this. Applied to git-gui repository.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
