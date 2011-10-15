From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/4] git-gui: clear the goto line input when hiding
Date: Sat, 15 Oct 2011 23:20:52 +0100
Message-ID: <87bothkibf.fsf@fox.patthoyts.tk>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Fries <David@Fries.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:21:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCbG-0001zQ-LO
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1JOWU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:20:57 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:52178 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442Ab1JOWU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 18:20:57 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015222055.UFMI13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 23:20:55 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFCb9-00057f-QQ; Sat, 15 Oct 2011 23:20:55 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 25C7E201AC; Sat, 15 Oct 2011 23:20:53 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 13 Oct 2011 15:48:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=I66kOcEie8kA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=Q4OZ1Qds3wOeM0q3D0sA:9 a=PP9YqV2Ts4ZZKLF3rnsA:7 a=CjuIK1q_8ugA:10 a=psFEWSvwNxIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183680>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/line.tcl |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/lib/line.tcl b/lib/line.tcl
>index 4913bdd..692485a 100644
>--- a/lib/line.tcl
>+++ b/lib/line.tcl
>@@ -41,6 +41,7 @@ method show {} {
> 
> method hide {} {
> 	if {[visible $this]} {
>+		$w.ent delete 0 end
> 		focus $ctext
> 		grid remove $w
> 	}

You don't say why this one gets cleared but the search box is not
cleared.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
