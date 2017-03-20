Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0020958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755825AbdCTQuj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:50:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756050AbdCTQua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:50:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E7D79F61;
        Mon, 20 Mar 2017 12:50:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LC8qGNRi0fgj
        LGeoR2JSWX6fN1k=; b=HYTmFWrBjvVwsCC02hsQqMjwWrpWQ330Ef7kAwbaPLBw
        Cenh8+Es56D3d8CpAirwyOuidA3nLrQJJhKc6hQa/rWUz/sS8c4/tfGdiqgPAVB5
        qwXsMCuI48teIGP7RuwPtjtW/QCE3iKrBgciNKmDGtSAbEprfqcMh++0ynIS2Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TaWeZd
        7qHsGCs7pyy6h63joBsOg5kCDdrWUSz3yZmwAtRxQYO7jTnFzMlxQPZbzo/myowD
        vnqasqWCSskRkR+vJSbT6h0WpLPDv+HkfsuVZVWqWcCh4OQhypIVRME4N0915a0P
        feaJlrVcKGYbfxhm14ADvvxxWmumJbNB7zpRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96F6879F60;
        Mon, 20 Mar 2017 12:50:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06F7D79F5F;
        Mon, 20 Mar 2017 12:50:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-1-jn.avila@free.fr>
        <20170318175353.24578-1-jn.avila@free.fr>
        <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
        <xmqq37ea192h.fsf@gitster.mtv.corp.google.com>
        <xmqqr31sy9xe.fsf@gitster.mtv.corp.google.com>
        <46714f87-bf42-81a5-4af0-9b3a3282ad56@free.fr>
Date:   Mon, 20 Mar 2017 09:50:04 -0700
In-Reply-To: <46714f87-bf42-81a5-4af0-9b3a3282ad56@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Mon, 20 Mar 2017 09:10:46 +0100")
Message-ID: <xmqq60j3yjsz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4530276C-0D8D-11E7-AC33-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Asciidoc support was added in 0.45, and was included Ubuntu 14.04 but i=
s
> not present in ubuntu 12.04. The latest version is 0.48.
>
> So I guess you made your trials on 14.04. So, switching to 14.04 on
> Travis would help, at least for this patch series, but that would help
> much for the (close) future.
>
> I'm trying to push for a release of a new version, because I stumbled
> upon a bug on the support of include macros while extending the
> translations to git-commit manpage. This bug is already fixed in master=
,
> but no version has been published yet.
>
> The bottom line is that using po4a brings mixed results, for now.

Thanks for digging. =20

Because people find it inconvenient to leave the tip of 'pu' left in
a state that does not pass the standard test suite for too long, I'm
planning to eject the topic from 'pu' for now; if I find time to do
so, I may try to remove the localized documentation from the default
"make doc" target myself instead though.
