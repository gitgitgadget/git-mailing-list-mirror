Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CBE2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdCRTFC (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:05:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751612AbdCRTE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:04:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C41A483CD1;
        Sat, 18 Mar 2017 15:04:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z73xb5XpyJPc
        33cD7UkcSwwn0I0=; b=EjzkCGW5+ApgDqvMw3tKwUik/IlIyRQHRS0qMP69e/H8
        A9fvuZV6uFu+GvKEMPp6cdduz70/dNOmrFm2SAWAVwAO8KmT1wLLWR0QLvR722hb
        uk7iqoDcvM7rEBp488mb1N0g3mhtSPp8ky+bI4AQjfR9ZCTjURXlJ6wlggF18MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=u8OPR3
        lnKlnxqf7IKPkqSuADaPEtFCA9Z2RHwXOlpJSxjDAhQDiaclZvBV6tKFQxPza072
        8wTUSw3pfTpVq8fJWU3AjvMPpx4yDISfAnqazjfheQS/m1jJHdauj6Wt8BYEwr6H
        zFJ22y7fr+Cbe5+flKXg92oZpDM33RkRs20uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCDC183CCF;
        Sat, 18 Mar 2017 15:04:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FD4B83CCE;
        Sat, 18 Mar 2017 15:04:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc/SubmittingPatches: clarify the casing convention for "area: change..."
References: <20170318184203.16890-1-avarab@gmail.com>
        <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
        <20170318184203.16890-2-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 12:04:42 -0700
In-Reply-To: <20170318184203.16890-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 18:42:02 +0000")
Message-ID: <xmqq7f3m2yph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF53A2A2-0C0D-11E7-9792-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  prefix the first line with "area: " where the area is a filename or
>  identifier for the general area of the code being modified, e.g.
> =20
> -  . archive: ustar header checksum is computed unsigned
> -  . git-cherry-pick.txt: clarify the use of revision range notation
> +  . doc: clarify distinction between sign-off and pgp-signing
> +  . githooks.txt: improve the intro section

Sorry, but I fail to spot why this is an improvement (it is not
making things worse, either).

>  If in doubt which identifier to use, run "git log --no-merges" on the
>  files you are modifying to see the current conventions.
> =20
> +It's customary to start the remainder of the first line after "area: "
> +with a lower-case letter. E.g. "doc: clarify...", not "doc:
> +Clarify...", or "githooks.txt: improve...", not "githooks.txt:
> +Improve...".

