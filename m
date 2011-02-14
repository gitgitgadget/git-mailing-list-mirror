From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 20:04:48 +0900
Message-ID: <buod3muswq7.fsf@dhlpc061.dev.necel.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<87k4h34bhj.fsf@catnip.gol.com>
	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
	<4D58D2DF.1050205@viscovery.net>
	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
	<4D5906FD.7030502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 12:05:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PowF8-0003JV-P0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 12:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab1BNLFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 06:05:17 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:59487 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab1BNLFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 06:05:15 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p1EB4nn8013840;
	Mon, 14 Feb 2011 20:04:49 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p1EB4nR11483; Mon, 14 Feb 2011 20:04:49 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.46])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id p1EB4Lqx026452;
	Mon, 14 Feb 2011 20:04:49 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Mon, 14 Feb 2011 20:04:49 +0900
Received: from dhlpc061 ([10.114.98.26] [10.114.98.26]) by relay11.aps.necel.com with ESMTP; Mon, 14 Feb 2011 20:04:48 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B939C52E1D8; Mon, 14 Feb 2011 20:04:48 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <4D5906FD.7030502@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 14 Feb 2011 11:42:05 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166703>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Short options should really not be "wasted" easily. "-s" named after "to
> stage" is really problematic, as outlined in this thread.

Er, but the point is that this is _such_ a common operation, that a
short option for it would not be "wasted" at all.  [The whole concept of
"wasting" short options doesn't even make sense unless you're willing to
then use the resulting "preserved" options eventually...]

Indeed it seems a little weird that there's not one for this already,
given how common short options are in git generally, often for far less
useful options than --cached/--staged; I can only guess that the reason
is basically historical accident.

As for the exact letter chosen, "-s" seems perfectly fine to me.  Short
options do not need to be "perfect" to be useful, and the connection
with --staged is a perfectly plausible memory aid for that short period
during which people memorize them.

-Miles

-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein
