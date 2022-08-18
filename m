Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A84AC28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346489AbiHRVCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbiHRVBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:01:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AAC12EB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:00:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 560751A1F26;
        Thu, 18 Aug 2022 17:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ahds8TDWwb/N
        /Wk7sNtoJ0tgzBWdvJxy/GshmgHpu4M=; b=OupvelrLS2YP5xeq7cr5/hcNQmYa
        Y81lQ4Nv1F7F18aNIZzwurt0PqvzrZVbOqGq3KR4LVKlkmLAOJdlOFj3EzpNtK2L
        890ucDELVPM2IkkwAkxFihr1zjieVEWJ+YrZ1uyc69GHc2gH114YL8dRQ4eHbAsf
        z92BBKdt3of9y50=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EF7B1A1F25;
        Thu, 18 Aug 2022 17:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D57031A1F23;
        Thu, 18 Aug 2022 17:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH/RFC 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220814133531.16952-1-tboegi@web.de> <xmqqfshy773n.fsf@gitster.g>
        <20220815063441.uxrtdqsggmrqxxl2@tb-raspi4>
Date:   Thu, 18 Aug 2022 14:00:42 -0700
In-Reply-To: <20220815063441.uxrtdqsggmrqxxl2@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 15 Aug 2022 08:34:41
 +0200")
Message-ID: <xmqqedxdnu6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D31D6FEA-1F38-11ED-B5A6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> (And having written this, there is probably room for test cases,
> IOW: a V2 will come the next days)

Yeah, that all sounds sensible.

Thanks for working on this.
