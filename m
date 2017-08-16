Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6DB1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdHPVrO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:47:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55568 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752439AbdHPVrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:47:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49EC68CC0E;
        Wed, 16 Aug 2017 17:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jbYKmerHegEP
        YPC7wJHhSsLn7mQ=; b=rggjCwv8k9WdDXz4lAjneOQ0LagJr7aIS3UKPubEBwRR
        aJwkhuwvk9+jxJlIEzMQdr4DLPGIEybd83b003/+HZulu8+HIgi3TX78kdojzHgf
        8Uvj22bNtmQHUVJ9bwPfh/F+u3GJ711VB80hZkONwebPLmAIXfnnpc768+Izvf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=s8Tnav
        mQWMnnebnPaOZnbtzMGebvQlDW1jrS5294DPBHLBTegZnU5ZxgLweSKfGaVt/gJ6
        JpEjKBXBp2sDS1KzWQoITLn6HOovYjH+VGodhTgm6Knf6UGr0ggpFmP5WbYzSL61
        kxDj7RK02RRNV7RR403+E9pvzJQTzuQYmKB7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 409CE8CC0C;
        Wed, 16 Aug 2017 17:47:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA75B8CC07;
        Wed, 16 Aug 2017 17:47:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH v2 0/2] Allow building with the external sha1dc library
References: <20170815120417.31616-1-tiwai@suse.de>
Date:   Wed, 16 Aug 2017 14:47:10 -0700
In-Reply-To: <20170815120417.31616-1-tiwai@suse.de> (Takashi Iwai's message of
        "Tue, 15 Aug 2017 14:04:15 +0200")
Message-ID: <xmqqwp63i3s1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75AA6204-82CC-11E7-A620-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> this is the second attempt to allow linking with the external sha1dc
> shlib.  Now I split to two patches: one for cleaning up of sha1dc
> plumbing codes, and another for adding the option to link with the
> external sha1dc lib.
>
> Other changes from v1:
> - Plumbing codes for external lib are also merged commonly in
>   sha1dc_git.[ch]
> - Check the conflict of extlib vs submodule
> - Drop DC_SHA1_LINK, hoping that everyone is well-mannered
> - Minor rephrasing / corrections of texts
>
>
> thanks,

Thank you for an update. =20

I think this round addresses the concerns =C3=86var had with the previous
round.  Let's wait to hear from him just to be sure.

