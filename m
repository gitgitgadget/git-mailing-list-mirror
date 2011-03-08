From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 08 Mar 2011 20:08:55 +0100
Message-ID: <m2r5ahqvjs.fsf@igel.home>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
	<4D75ED72.8030203@drmicha.warpmail.net>
	<AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
	<AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
	<4D75FB7B.70403@drmicha.warpmail.net>
	<AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
	<20110308171251.GA1823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2HJ-0004Cg-1H
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab1CHTI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:08:59 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43791 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab1CHTI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:08:58 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 711A31C0F575;
	Tue,  8 Mar 2011 20:08:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 29F1E1C000B0;
	Tue,  8 Mar 2011 20:08:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 5AbYY21cBkCO; Tue,  8 Mar 2011 20:08:55 +0100 (CET)
Received: from igel.home (ppp-88-217-123-39.dynamic.mnet-online.de [88.217.123.39])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue,  8 Mar 2011 20:08:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 4266CCA2A0; Tue,  8 Mar 2011 20:08:55 +0100 (CET)
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
In-Reply-To: <20110308171251.GA1823@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Mar 2011 12:12:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168676>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 08, 2011 at 05:11:16AM -0500, Jay Soffian wrote:
>
>> Going back to my original picture, I mean commit m:
>> 
>>   o---o---x---o---...    foo
>>    \       \
>>     o---o---m---o---...  bar
      b1
>> 
>> merge-base foo bar gives me x; to get m I then need to grep the output
>> of rev-list --parents for x.
>
> Isn't the merge the first commit in bar that is not in foo? IOW:
>
>   git rev-list foo..bar | tail -n 1

That would show the commit marked b1 above, wouldn't it?  ^foo cuts only
x and its parents, but not the other parent of m.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
