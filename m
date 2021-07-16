Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21297C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA754613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGPTxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:53:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55531 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:53:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C70B0D1E7F;
        Fri, 16 Jul 2021 15:50:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wrRuGQlqQG6A
        weJWEWl2Q+yNZEZw2+Ao75M3ZGRePqo=; b=KzWbjWaFre/2qbbL+cWrS0IwUa2r
        1/ihBvNGgNMmAudxTD2hOAWJSUyEj1WAWRHpUF00E542aJNkpMSz8W4iqPKBt4cF
        7W2wlk0qdly2yr4jogJcdyi9ylzh+3YIvGn3Hgx6eZKolJwp9ZA/TPX6OFj0QFH0
        bkOvmjkR8yKhaCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF6CAD1E7E;
        Fri, 16 Jul 2021 15:50:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EBE3D1E7D;
        Fri, 16 Jul 2021 15:50:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: recommend gender-neutral description
References: <xmqqmtqpzosf.fsf@gitster.g>
        <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
        <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
        <xmqqv95aqeyh.fsf_-_@gitster.g> <87pmvivz8j.fsf@evledraar.gmail.com>
Date:   Fri, 16 Jul 2021 12:50:13 -0700
In-Reply-To: <87pmvivz8j.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 16 Jul 2021 21:11:36 +0200")
Message-ID: <xmqqr1fyqbre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09A93ACA-E66F-11EB-9743-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'd be happy to re-arrange this, if I could only get the submitter of
> the series to respond to my E-Mails...

I'll do this only once to add missing but intended recipient to the
to: line; you are both adults, don't assume malice but instead good
intentions and talk to each other.
