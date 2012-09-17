From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] git-gui: Fix a loose/lose mistake
Date: Mon, 17 Sep 2012 11:54:39 +0100
Message-ID: <87d31kkjgw.fsf@fox.patthoyts.tk>
References: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
	<7vsjbkrlsv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Beat Bolli <bbolli@ewanet.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:11:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDZEQ-0004mQ-Px
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab2IQLLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 07:11:06 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:61262 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755561Ab2IQLLE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 07:11:04 -0400
X-Greylist: delayed 894 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 07:11:04 EDT
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.4])
          by mtaout04-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120917105609.XMNI18581.mtaout04-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Mon, 17 Sep 2012 11:56:09 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1TDYyS-0005R7-Ag; Mon, 17 Sep 2012 11:54:44 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C093F22D8F; Mon, 17 Sep 2012 11:54:39 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vsjbkrlsv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 18 Aug 2012 13:24:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=AUhbpHVS+xhHrj9wLCYAQoYnFLYUZdbP8UM0GmH2jwk= c=1 sm=0 a=O9HYxzjLEG8A:10 a=OvGj5OTjUhgA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=Rf460ibiAAAA:8 a=y_OsNOXUAbvi5bOJlo8A:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205673>

Junio C Hamano <gitster@pobox.com> writes:

>Beat Bolli <bbolli@ewanet.ch> writes:
>
>> No po update needed, as this string is untranslated.
>>
>> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
>> ---
>>  git-gui/lib/commit.tcl |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
>> index 0d81432..78c5eeb 100644
>> --- a/git-gui/lib/commit.tcl
>> +++ b/git-gui/lib/commit.tcl
>> @@ -268,7 +268,7 @@ proc commit_commitmsg {curHEAD msg_p} {
>>  	    && 	[is_config_true gui.warndetachedcommit]} {
>>  		set msg [mc "You are about to commit on a detached head.\
>>  This is a potentially dangerous thing to do because if you switch\
>> -to another branch you will loose your changes and it can be difficult\
>> +to another branch you will lose your changes and it can be difficult\
>>  to retrieve them later from the reflog. You should probably cancel this\
>>  commit and create a new branch to continue.\n\
>>  \n\
>
>Looks obviously correct; Pat?
>

Yes. Applied.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
