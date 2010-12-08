From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-rm.txt: Fix quoting
Date: Wed, 08 Dec 2010 09:08:02 +0100
Message-ID: <4CFF3CE2.9040908@drmicha.warpmail.net>
References: <4CFDF388.6060907@drmicha.warpmail.net> <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net> <20101207164315.GA21749@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 09:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQF6b-0006pF-24
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 09:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab0LHIKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 03:10:24 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37366 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753335Ab0LHIKY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 03:10:24 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 69B877BA;
	Wed,  8 Dec 2010 03:10:23 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 08 Dec 2010 03:10:23 -0500
X-Sasl-enc: O8hetQztYfD4SyLnvIQ+RYwWrNBl/i1RaSuUEAxRHDZC 1291795823
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B63F55E3943;
	Wed,  8 Dec 2010 03:10:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101207164315.GA21749@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163174>

Jeff King venit, vidit, dixit 07.12.2010 17:43:
> On Tue, Dec 07, 2010 at 10:07:11AM +0100, Michael J Gruber wrote:
> 
>> Literal " produces typographically incorrect quotations, but "works" in
>> most circumstances. In the subheadings of git-rm.txt, it "works" for the
>> html backend but not for the docbook conversion to nroff: double "" and
>> spurious double spaces appear in the output.
>>
>> Replace "incorrect" quotations by ``correct'' ones, and fix other
>> "quotations" which are really `code fragments`.
>>
>> This should make git-rm.txt "-clean.
> 
> Thanks, this is a much better solution than what I posted earlier.
> 
> Acked-by: Jeff King <peff@peff.net>
> 
>> We still have a lingering inconsistency for denoting code fragments.
>> Single backticks merely are a literal monospaced environment; html outputcolors
>> this, nroff does not indicate it at all. I'm staying consistent with the
>> surrounding text here.
> 
> Try setting MAN_BOLD_LITERAL in your config.mak.

Always learning something new about our doc tooclchain... and what a
great name for an option! Although it should be "Man, bold, literally!".

Michael
