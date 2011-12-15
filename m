From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered by path
Date: Thu, 15 Dec 2011 22:06:27 +0000
Message-ID: <8739clzdzw.fsf@fox.patthoyts.tk>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
	<CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
	<alpine.DEB.1.00.1112151023280.2615@bonsai2>
	<CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
	<7v1us5obqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJao-0007Ie-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759492Ab1LOWP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:15:56 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:29329 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756377Ab1LOWPz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 17:15:55 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111215221553.HLRI11752.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Thu, 15 Dec 2011 22:15:53 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RbJaj-0003k4-AC; Thu, 15 Dec 2011 22:15:53 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4C13F20A72; Thu, 15 Dec 2011 22:06:27 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7v1us5obqa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Dec 2011 11:50:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=KpAh3GZeS6gA:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=Rf460ibiAAAA:8 a=pc4eVJ78DY2_ZsrD9AoA:9 a=CjuIK1q_8ugA:10 a=U62fhAwekXMA:10 a=qIVjreYYsbEA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187247>

Junio C Hamano <gitster@pobox.com> writes:

>Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> Paul and Junio, the patches I sent in April are still not in git.git,
>> are they? Can we use another repo until the kernel.org one is up? More
>> than eight months to get a patch (or eight) merged is way too long,
>> IMO.
>
>I tend to agree.
>
>I have this slight suspicion that Paul would appreciate if somebody who
>cares about gitk who is capable and willing steps forward and takes over
>the maintainership of gitk, as he is busy in his other projects.

I can do this one along with git-gui if this is the case.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
