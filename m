Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF6C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F2F61994
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhI3UhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:37:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64351 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348142AbhI3UhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 16:37:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF61B15C2ED;
        Thu, 30 Sep 2021 16:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GcYRXFoLi1uE
        AMbn1HCaT4fTTGrRhrjEA45gudUvI0E=; b=N8wxdDBsXGTKHuYqH18928nNn1BN
        MyKWjLJ2VXEr0LNNdplMaAwFtfvUrfFR4JQHpfTEOYzSti0GLtGCMxhQGi7a7UDQ
        PpADEKilb/uU0d3rKfc7C6Jp1njG96dZMLJhPqA4w+ALb+Gx4QfhKyLubDAoDPf7
        fOCg6KcX0VmlVo8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C795C15C2EC;
        Thu, 30 Sep 2021 16:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C5FB15C2EB;
        Thu, 30 Sep 2021 16:35:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com, avarab@gmail.com
Subject: Re: hn/reftable "fixes"
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <20210930054032.16867-1-carenas@gmail.com>
Date:   Thu, 30 Sep 2021 13:35:36 -0700
In-Reply-To: <20210930054032.16867-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Sep 2021 22:40:28 -0700")
Message-ID: <xmqq1r55by3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F899788A-222D-11EC-ABC2-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Patch 1, was discussed before and might be solved in a better way as an
> alternative.
>
> Patch 2 and 3 are "nice to have" for portability and hopefully not cont=
roversial
> but could be dropped, if someone feels strongly against it.
>
> Patch 4 is not something I'd found failing anywhere, but the fact that =
Microsoft
> mentions it is only supported as an extension and it needs to be suppor=
ted by
> the dynamic linker and I couldn't find anything clear about it in POSIX=
 means,
> that is probably safer this way.

All of them look sensible.  Thanks.
