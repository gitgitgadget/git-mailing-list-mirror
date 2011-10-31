From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Fix a typo in line 117 of git-gui/lib/sshkeys.tcl.
Date: Mon, 31 Oct 2011 08:56:31 +0000
Message-ID: <87aa8h7d4w.fsf@fox.patthoyts.tk>
References: <1319995124-7509-1-git-send-email-dejan.ribic@gmail.com>
	<CABPQNSaLsS9P8hWMEBYVe4FEo5x11+J+pMw29NN+EF2siCO35w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dejan =?utf-8?Q?Ribi=C4=8D?= <dejan.ribic@gmail.com>,
	Git ML <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 31 09:56:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKnfc-0007qi-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 09:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab1JaI4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 04:56:35 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49995 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932119Ab1JaI4e convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 04:56:34 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111031085632.YJVW21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Mon, 31 Oct 2011 08:56:32 +0000
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RKnfU-0000Qk-2P; Mon, 31 Oct 2011 08:56:32 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 452AE207C6; Mon, 31 Oct 2011 08:56:31 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CABPQNSaLsS9P8hWMEBYVe4FEo5x11+J+pMw29NN+EF2siCO35w@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 31 Oct 2011 00:57:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=MAK5S7WqDDcA:10 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=VwokGrflY2j4caaczZgA:9 a=VyDblNnB8XBZlRnBiakA:7 a=QEXdDO2ut3YA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184495>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>Thanks for re-posting inline and with a sign-off. But there's still a
>few minor nits:
>
>2011/10/30 Dejan Ribi=C4=8D <dejan.ribic@gmail.com>:
>> "succeded" changed to "succeeded".
>
>We write commit messages in imperative mood, so this should be
>something like 'change "succeded" to "succeeded"' instead. This is
>documented in Documentation/SubmittingPatches.
>
>> modified: =C2=A0 git-gui/lib/sshkey.tcl
>
>We don't normally include a list of changed files in the commit
>message; the diffstat already provides that information.
>

The change is fine so I've applied this to the git-gui repository with =
a
fixed commit message. Thank you.

git-gui is hosted separately and merged into git-core at intervals so
the development version of git-gui is in fact hosted at=20
git://repo.or.cz/git-gui.git although patches against the git-core
version seldom pose a problem to apply and are gratefully received.
(git am -p2 usually fixes them).

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
