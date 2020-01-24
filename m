Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF3C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EE32071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUK/lgKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAXWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:05:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54869 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:05:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E130A9F2AC;
        Fri, 24 Jan 2020 17:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3xGRvumSTU2NPrlC8HL+VlsXk70=; b=YUK/lg
        KpCNWlcIA96BlBubd9DFnMyNQ2zTASO2zu171IxslT5zn2SdVqQ9rz6/h0aBp3jl
        UMOXLvqm6G1+3vevOArbsZbtSgQuBE1DCwCsw3wIJ6etm7LnMkc/zQkKFB3N25JH
        jHfb4tHVNdBYeAV5ZEHIIt0o2a4AwbLrgtOys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pV0+8HgPZcKujz3c0BZqGYWAwPkhuNJ0
        pOuCub4e8b1kYBkdB/XVXsWUsxnC94ROPvDHsOo64pqTRJQ05M2jb3dT+r71JgC3
        8317tsSuT3qxVCjY1DfOa86f4PNXtl0/Tgxlus2pTeyk5reoSvcPm2YOzdCebLTQ
        JAj+NgApaqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7C3D9F2AB;
        Fri, 24 Jan 2020 17:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FE299F2A4;
        Fri, 24 Jan 2020 17:05:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
References: <20200124212602.74194-1-emilyshaffer@google.com>
Date:   Fri, 24 Jan 2020 14:05:14 -0800
In-Reply-To: <20200124212602.74194-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Fri, 24 Jan 2020 13:26:02 -0800")
Message-ID: <xmqqlfpwy0h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AA7BDE4-3EF5-11EA-956F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Took a slightly modified version of Junio's suggestion for the archive
> link so the final text reads "The archive of this mailing list is
> available to view in a browser" instead of "The archive of this mailing
> list is available at archive to view in a browser".

Looks good.  Thanks.
