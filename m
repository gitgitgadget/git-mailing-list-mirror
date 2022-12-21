Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842F0C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 12:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLUMpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUMpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 07:45:21 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FD22B07
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 04:45:19 -0800 (PST)
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
 <87a63i7h8h.fsf@to1.studio>
 <aab41ec5-7854-b62c-f11c-ba850cbac95b@dunelm.org.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1671626717;
        bh=x25OEM01d49UGDCoCe7teatX3yru6BAxH1B3cG15fzs=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Mime-Version:Content-Type:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=qhzbHH8bKFZ1TlkHO70Th9IWtwV7fKzwqxEktdIsfZJM1SOGk2M8EWnPP/bKjcTMx
         HzwQwo1k3LKShiTKQI50LGLdQ7OrEyrpHUgZ7oarfT+p/RCdaBr+Cm863vj00068yJ
         7yxFQKef/pwOX1DCWgpVR+qC0vSAcF5hXLksrTXrhCE5qCoUzEvL0KA4VPUAomYkeW
         nAK63QbJZeTN3NXiNwJlHp3PmVfSkOHwtWn+bgItIrGwi5qUyMLA6ng4He7DubswzA
         ywvYJ+0vWiCSOMFnDBThz/Qyvg9IFJajzeShBOOzA1BPITQj4q5n/sne0AvMDSPxtO
         BAHd0DiMJCcXg==
From:   Toon Claes <toon@to1.studio>
To:     phillip.wood@dunelm.org.uk
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Date:   Wed, 21 Dec 2022 13:42:02 +0100
In-reply-to: <aab41ec5-7854-b62c-f11c-ba850cbac95b@dunelm.org.uk>
Message-ID: <873599q61v.fsf@to1.studio>
Mime-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Phillip Wood <phillip.wood123@gmail.com> writes:

> Yes it would have been nice, unfortunately it feel through the cracks due to a
> combination of unfortunate timing and lack of time. I think the patch was
> probably in next by the time I realized the problem and wrote that email. Taylor
> was on holiday at the time and then I went away around the time he got back. I
> know it was on his todo list but I think he was busy catching up from being away
> getting ready for git merge. I had other things I was working on and
> unfortunately didn't get round to following it up.

Oh sorry, I didn't want to put blame on anyone. Things happen. I just
wasn't sure I missed anything.

> Overall I'd say it is tempting but risky and inconvenient to any existing users
> of "-z" (assuming someone else is actually using it). Quoting the object name is
> definitively the safer option at this point.

I assume Taylor would be one of the consumers of output of "-z", so
thanks for putting him in Cc to get his take on this.

--
Toon
