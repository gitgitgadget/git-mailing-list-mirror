Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B291C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiDFVHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiDFVHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:07:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790C11BCEF
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 12:42:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD052176362;
        Wed,  6 Apr 2022 15:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oh5/kBHfT4vO
        LHDwgI7DaU4s/5/BuOycAdqnR4e5c+w=; b=G7S1GD/qKm1bD7S5CZztDsVSRZrv
        AgAnicixPO+C3+Y91tspkitKc+fDmVmsPT+DRrFF4f9VjyaOpCHZAqsnzWy8ddWk
        2Y1jIWTFLWy0bJ73bAWTC5584b4CpVZdrSw3KhO7yipU4N0nfTgml9TaE7zMXt/i
        CcJhi8rCNhmxjrE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B60B117635F;
        Wed,  6 Apr 2022 15:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA4FA17635D;
        Wed,  6 Apr 2022 15:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tao@klerks.biz, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
        <20220406180434.4zlb2bwpu6cfumta@tb-raspi4>
Date:   Wed, 06 Apr 2022 12:42:27 -0700
In-Reply-To: <20220406180434.4zlb2bwpu6cfumta@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 6 Apr 2022 20:04:34
 +0200")
Message-ID: <xmqqo81exal8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B138082E-B5E1-11EC-8FA1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Or may be
>
> "In '%s', CRLF will be replaced by LF the next time a `git checkout` up=
dates it"

As this is a warning(_("")) message, usual "after 'warning:'
heading, the message does not begin in a capital" rule would apply,
I think.

It may not be "git checkout" that updates the path.  And running
"git checkout" may not necessarily update the path.  "... the next
time Git updates it" would probably be more widely applicable.
