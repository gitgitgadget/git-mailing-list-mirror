From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 27 Jun 2014 14:31:06 +0200
Message-ID: <53AD640A.9060006@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net> <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net> <20140613080229.GJ7908@sigill.intra.peff.net> <539ACA8A.90108@drmicha.warpmail.net> <20140613110901.GB14066@sigill.intra.peff.net> <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com> <20140616195428.GB24376@sigill.intra.peff.net> <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com> <20140616203956.GA3546@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0VJV-0003Y0-2R
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 14:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaF0MbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 08:31:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59289 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753442AbaF0MbT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 08:31:19 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8903221A6D;
	Fri, 27 Jun 2014 08:31:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Jun 2014 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1o/L7S1ubY3JIWuR7NnRnv
	838fM=; b=BznHZHPuVe21CO8vo+68gFL8JXX9QcVusuQutZK40Cch00MWYhgJhE
	vXtSMhPHYC/Zh11FCP7JRZYGs2wJCTbMIZyn56z4/p5EHVI/6M8t77HeshkeIo/F
	HShE4KUL70XH1/2mOtIDopKa/gEVXlfqy0dYdZJUlrlMOgSeStFsk=
X-Sasl-enc: U6vPFPvIIMtcy1ZOY3cVGtiFcBsFBlO8LTVC5vqxioWT 1403872277
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 64DF86801B5;
	Fri, 27 Jun 2014 08:31:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140616203956.GA3546@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252547>

Jeff King venit, vidit, dixit 16.06.2014 22:39:
> On Mon, Jun 16, 2014 at 01:34:20PM -0700, Junio C Hamano wrote:
> 
>>> Your middle example above did make me think of one other thing, though.
>>> As you noted, we actually have _three_ signature types:
>>>
>>>   1. signed tags
>>>
>>>   2. signed commits
>>>
>>>   3. merges with embedded mergetag headers
>>>
>>> We already have a tool for (1). Michael is adding a tool for (2). How
>>> would one check (3) in a similar way?
>>
>> Hmph, somehow I misread the patch that it was for both 2 & 3 X-<.
> 
> I was just assuming it handles only (2) without checking further, so I
> may be wrong. But I do not think it makes sense to conflate (2) and (3).
> A merge commit may have both, and they are separate signatures.
> 
> For that matter, is there a way to expose (3) currently, besides via
> --show-signature? It does not trigger "%GG" and friends (nor should it).
> It may make sense to add extra format specifiers for mergetag
> signatures. Though I do not use them myself, so I am not clear on what
> the use case is besides a manual, human verification of a particular
> merge.

I'm afraid I'm on a weekly git schedule at best, sorry. Just trying to
catch up on this:

Admittedly, I simply don't know about "3.". I know only 1. and 2. (and
don't remember why they are implemented differently).

Are they documented/decribed somewhere?

Meanwhile, I'm rebasing on top of the %G related patches by Junio and
Jeff and hope to send out a v4 later today.

Michael
