From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/8] t1402: Ignore a few cases that must fail due to DOS path expansion
Date: Sat, 15 Oct 2011 14:49:07 +0100
Message-ID: <87k4862wmk.fsf@fox.patthoyts.tk>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-3-git-send-email-patthoyts@users.sourceforge.net>
	<7vwrc6x1cp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 15:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4c0-000624-Qn
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 15:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1JONtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 09:49:12 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:59985 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775Ab1JONtK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 09:49:10 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015134908.VTZU21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 14:49:08 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RF4br-0003YI-Up; Sat, 15 Oct 2011 14:49:08 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 628DC207A7; Sat, 15 Oct 2011 14:49:07 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vwrc6x1cp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Oct 2011 22:36:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=K6nYAIH1qTcA:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=FP58Ms26AAAA:8 a=Rf460ibiAAAA:8 a=QNWGlKUnOGkO6aGBznQA:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183653>

Junio C Hamano <gitster@pobox.com> writes:

>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>>  t/t1402-check-ref-format.sh |   15 +++++++++------
>
>Didn't we see a different patch that attempts to address the same issue
>recently on the list from J6t, or is this a fix for a different problem?
>

You are correct - I'll leave this out of this series then. j6t's patch
is an alternative fix for the same problem.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
