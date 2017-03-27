Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743961FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 20:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbdC0U3c (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 16:29:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751801AbdC0U3b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 16:29:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC53B7EB8B;
        Mon, 27 Mar 2017 16:29:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Nl+VHdKQMwhz
        1JDxVvYUSVOM1wA=; b=r1DZUb0WcbEfYDYbMufntmYUaQeoQuZ2ol3wxpLDSJwz
        IisKDL4D6W9CNPZDBCMAKKsPMAlrDFvc0/U6SY2huBosCA82KEE4SXReGH5Q5D74
        pfey9jL0wdJUO6zGNwPrpI/ZP5YMiwHyivUrSzO6usiLv9qvZYH/3ewnEgc6+z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OTq5F/
        5Vl92LF4zYJIybEBDDQNpB5N7XJmB8VqOJjrSWuYdSDe7rU21b9Ja2L4wW+B1+0I
        poFbIHl8Vwj3nUd83Kyts9UPeM/rplYCy0Yyre51OaWOgfnxiT5INuQoU+1lSCkE
        F5xfNsGLERQ7RjAn7xup+kVheQzoRra/rQN6I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34D07EB8A;
        Mon, 27 Mar 2017 16:29:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5127A7EB87;
        Mon, 27 Mar 2017 16:29:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <4046320.m2qk9b67WH@cayenne>
        <xmqqshlz4pfs.fsf@gitster.mtv.corp.google.com>
        <7770933.gyQYXQhLOc@cayenne>
Date:   Mon, 27 Mar 2017 13:29:27 -0700
In-Reply-To: <7770933.gyQYXQhLOc@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Mon, 27 Mar 2017 22:12:16 +0200")
Message-ID: <xmqqefxi1n14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 140511A8-132C-11E7-8F0B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> ...  Doesn't that workflow apply equally well for the
>> documentation l10n?
>
> Theoretically, this workflow should apply to the documentation, so that=
 a=20
> version of the documentation can be cut at each release of git. I still=
 have=20
> to convince po4a not to update the *.pot and *.po files each time it is=
 run,=20
> while at the same time allow translators to produce the output file for=
=20
> proofreading.

Ahh, OK, that does sound like a meaningful difference that may make
the workflow we use for in-code strings not applicable for the
documentation l10n project.  As I said already, I am not married to
the "gitman-l10n at Documentation/po" approach at all, and if the
layout you brought up to turn the containment relationship the other
way around works better, that is perfectly fine by me.

Thanks.



