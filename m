Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB299C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966D72076A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xpyKAHeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOO50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 10:57:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60660 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgEOO50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 10:57:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8AC3D4C62;
        Fri, 15 May 2020 10:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ELXjDACcWKMVmizhPGfJnwtOlDg=; b=xpyKAH
        eMPNjtvtJqXuMxmQMhfVCli5Aq1CmKFbtRPFMOs5f1o+MYWwzBfm/oHesDNJuKrG
        nHk9tgslzaxr/emvxiOBv6Vk1BC1XQC4/bl8u/v0QefauRnnkc990Vfmdj/au1QR
        iMFiX8xFpTtmLpIAaa+4slFv1JtenFTzs9AaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ky2sp0KaR0lnkwvdwLUjAD0DltPIf8kn
        8h67l4gyIClHe5RFC9+TCcWJ7tlcQwwMxT2m+/3x1O1uqeepgmTsIzYqqKF6U4rb
        jFZkHbvLY3R6spQ00SFX1Xb1bpOgs0f9lFJlutewZkaMwO990PqFuvP9i9iUx0sF
        K9P7X9EdZM4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98F7ED4C61;
        Fri, 15 May 2020 10:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDA36D4C5F;
        Fri, 15 May 2020 10:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc0
References: <xmqqy2punll7.fsf@gitster.c.googlers.com>
        <021601d62ac4$152ff770$3f8fe650$@nexbridge.com>
Date:   Fri, 15 May 2020 07:57:20 -0700
In-Reply-To: <021601d62ac4$152ff770$3f8fe650$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 15 May 2020 10:21:04 -0400")
Message-ID: <xmqqlfltnt4f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61E42E38-96BC-11EA-A4EC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> .... I am starting the HPE NonStop TNS/X test cycle and
> will let you know how it goes. Our TNS/E system is in the middle
> of being moved so I'll probably wait until the official release on
> that one.

Thanks.
