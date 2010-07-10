From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [BUG] git gui blame: Show History Context [still] broken since 29e5573d
Date: Sun, 11 Jul 2010 00:41:48 +0100
Message-ID: <87sk3qrjk3.fsf@fox.patthoyts.tk>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jul 11 01:47:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXjld-0006A1-45
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 01:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab0GJXr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 19:47:26 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:50222 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753399Ab0GJXrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 19:47:25 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1OXjlU-0006HS-0w; Sun, 11 Jul 2010 00:47:24 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1OXjg5-0005SP-E1; Sun, 11 Jul 2010 00:41:49 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C36BD208C8; Sun, 11 Jul 2010 00:41:48 +0100 (BST)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <vpqy6e4v1h0.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu\, 24 Jun 2010 18\:28\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150736>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>Hi,
>
>I reported this bug a while ago:
>
>http://kerneltrap.org/mailarchive/git/2010/2/22/24038
>
>In short, the "Show history context" item of the context menu of "git
>gui blame" is broken since february. Two patches were proposed:
>
>http://thread.gmane.org/gmane.comp.version-control.git/140688
>http://thread.gmane.org/gmane.comp.version-control.git/140288
>
>But I've just noticed that none of theme were applied.
>

Checking this it seems you are correct. This has been fixed for
msysGit with the above patch included there but is missing from
git-gui itself and hence missing from core git.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
