Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090F31F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965009AbdGTUf4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:35:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934670AbdGTUfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:35:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46E54778C6;
        Thu, 20 Jul 2017 16:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WCYb5s2qUXme
        Wcz1Ia1rHDckRMc=; b=dOph0PEipfn0X+5d1akusIiz7lklAGCnRl8Yez7eYaNq
        evBtSmO4O0IMQEvwnsJS5wsM+x/xl4Q2Y9drt01XI8jpqYYIHmwYzodqBD0j/QL3
        z1ELiXYfiR3RBvpuozaVnizkIXfz1+yuYX9q7PHEySUE7a9MJf3uWnEOTji05Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=x72FmR
        GmEnhBOxeiRTSc6yZTSpQv+162QIyX2uxB46Vd9XZJNcHQM/ccQdkedG6Tiql6uV
        VMQ7myBwmIH3SFCfPtDXJZFeTfI/xbno0RLHsIBwYJ2RDSZnCVHkylRwZi6mWWFb
        29cEMd8dz59y2N1m2P6WIWHaHRauUlrNb5ZbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F849778C5;
        Thu, 20 Jul 2017 16:35:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A223A778C4;
        Thu, 20 Jul 2017 16:35:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] 2.14 RelNotes improvements
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
        <20170720141927.18274-1-avarab@gmail.com>
Date:   Thu, 20 Jul 2017 13:35:51 -0700
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jul 2017 14:19:21 +0000")
Message-ID: <xmqqshhqkfrs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0601F0B2-6D8B-11E7-A4D2-61520C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Here's a few patches to improve the relnotes. I started just writing
> 6/6 since I think (I don't care about the wording) that we should in
> some way mention the items in the list in the 6/6 commit message.
>
> Along the way I noticed a few more missing things.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
>   RelNotes: mention "log: add -P as a synonym for --perl-regexp"
>   RelNotes: mention "log: make --regexp-ignore-case work with
>     --perl-regexp"
>   RelNotes: mention "sha1dc: optionally use sha1collisiondetection as a
>     submodule"
>   RelNotes: mention that PCRE v2 exposes the same syntax
>   RelNotes: remove duplicate mention of PCRE v2
>   RelNotes: add more notes about PCRE in 2.14

Thanks.  1-3/6 went straight to 'master'.  I am not outright
rejecting the remainder, but I do not think these are release notes
material---if they need to be told, they should be in a part of the
regular documentation, and I suspect that they already are in your
series.
