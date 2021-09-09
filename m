Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB6C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 22:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F09611AD
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348027AbhIIW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:59:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64965 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbhIIW7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 18:59:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CE41157089;
        Thu,  9 Sep 2021 18:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ic/1k2hwa+sQ
        wgCsl+Bi0qGU8b4vGpzUnduJhJcpO0E=; b=HQZrFQpgBxWOXTtEK9V7X3u+nZBS
        DOLUIiZMe0LzIFoih7sn8HGCSAoHE7czjD3tEfFPvaLxTrlkgItCRvlPF44LxxN2
        u84jZGQMu+GKSYdMmUu9y5ENB0RbjMQ5eOPsk6IHGe3Px3/dQNyhEE0xknnVf3r8
        VDpbHFQgYQhyqXs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1533D157088;
        Thu,  9 Sep 2021 18:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 602D0157087;
        Thu,  9 Sep 2021 18:58:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/5] http: drop support for curl < 7.18.0 (again)
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <patch-1.5-3ffa2f491dd-20210908T152807Z-avarab@gmail.com>
Date:   Thu, 09 Sep 2021 15:58:39 -0700
In-Reply-To: <patch-1.5-3ffa2f491dd-20210908T152807Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Sep
 2021 17:31:52 +0200")
Message-ID: <xmqq35qdxso0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 79F47E2A-11C1-11EC-91C7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In 644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30) we
> dropped support for curl < 7.19.4, so we can drop support for this
> non-obvious dependency on curl < 7.18.0.

Will queue; this one is obviously correct.
