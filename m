From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare 3 on Windows
Date: Sat, 15 Oct 2011 13:39:10 +0100
Message-ID: <87fwiuig41.fsf@fox.patthoyts.tk>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
	<7vobxix0pk.fsf@alter.siamese.dyndns.org> <4E996012.8090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 14:39:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF3WO-0002oj-Qq
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 14:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab1JOMjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 08:39:13 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:65225 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab1JOMjM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 08:39:12 -0400
X-Greylist: delayed 823 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Oct 2011 08:39:12 EDT
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015123911.SVHS13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 13:39:11 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RF3WA-0000p4-W7; Sat, 15 Oct 2011 13:39:11 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 3C5EE207A7; Sat, 15 Oct 2011 13:39:10 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4E996012.8090002@gmail.com> (Sebastian Schuberth's message of
	"Sat, 15 Oct 2011 12:27:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=CUwiMNjKuoMA:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=S357rDhG5uL5TggsHs0A:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183651>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>On 15.10.2011 07:50, Junio C Hamano wrote:
>
>> Hmm, does this only apply to Windows, or are there other platforms on
>> which BC3 supplies bcomp for the exact same reason? What I am trying to
>
>BC3 is only available for Linux and Windows, so it only applies to
>Windows currently.

And checking the linux distribution shows only a bcompare executable so
testing for the presence of 'bcomp' will be fine.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
