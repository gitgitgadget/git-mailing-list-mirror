Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B17620281
	for <e@80x24.org>; Fri, 22 Sep 2017 08:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdIVI6f (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 04:58:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51372 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751810AbdIVI6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 04:58:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E734597749;
        Fri, 22 Sep 2017 04:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A8RT7FxXB9M6
        u7m8fgrd2Fg8zEo=; b=rCgZmun4mGdKFAmxUThaCHuNaq10PDqM2WGYIveGlbg7
        MxxGFzqwiNda1vTwLC/GpY+fLikyZP4+lTdKtJ1FHg8s0vr34EO3Ib5ikYhSOIs+
        nMmuh+42BLfsD6RavmOx5+EnD7LbzJt7ZUgnMlSA5tOVVejZOV6gVJiJVl0ZK28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h3I9z4
        T7YpWJQB0lxTgbVzizTKA6XgW0Jzu+u+e6LtiQjWjDoU43AY3P2mCRXXfyzESTXy
        z6H8BLSCRaYoazZ74uHFpzVa9u4iOy5HzI1kq80uDqBPIO9BNn7wauMzbulnfA5V
        rtDDiWH7GJ3nFY5o3i2Ems8CQOqWz/i3epaac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC2CF97748;
        Fri, 22 Sep 2017 04:58:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4542897747;
        Fri, 22 Sep 2017 04:58:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] filter-branch: support for incremental update + fix for ancient tag format
References: <1505980146.4636.9.camel@hellion.org.uk>
        <xmqqzi9njqec.fsf@gitster.mtv.corp.google.com>
        <1506069530.2682.41.camel@hellion.org.uk>
Date:   Fri, 22 Sep 2017 17:58:32 +0900
In-Reply-To: <1506069530.2682.41.camel@hellion.org.uk> (Ian Campbell's message
        of "Fri, 22 Sep 2017 09:38:50 +0100")
Message-ID: <xmqqk20rjeiv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 363B319C-9F74-11E7-B683-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> Travis is happy and the dt reconvert looks sensible (only took 60 hours
> ;-)).

Good.

> Don't know if this is useful to your workflow but:
>
> The following changes since commit 4384e3cde2ce8ecd194202e171ae16333d24=
1326:
>
> =C2=A0 Git 2.14 (2017-08-04 09:31:12 -0700)
>
> are available...

That should match (modulo that they lack my sign-off, for obvious
reasons) what I have in the 'pu' branch, four commits on a single
strand of pearls ending at b2c1ca6b ("filter-branch: use hash-object
instead of mktag", 2017-09-21).

Thanks.
