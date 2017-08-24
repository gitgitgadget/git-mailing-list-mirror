Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2067B20285
	for <e@80x24.org>; Thu, 24 Aug 2017 21:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbdHXVw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 17:52:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63875 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753335AbdHXVw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 17:52:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A99E1AD45B;
        Thu, 24 Aug 2017 17:52:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qR+fetUMboFo
        PIQxaAeA7yQq2gw=; b=MMGDYaC+U+dusEH3Nul1FTvMWVjVrw+VW24Qt8VMGpHm
        kDJUINpEPHtKqX2RjXIZpRNU7nyJ5QVwXvIylpEMAnFWMPMeSuLAW7+Kq+WPV39r
        Kb9EAqsNCGgcKpxomTz0BUk1yG+OQXn3/5k3/DJLVXzccIKCSX2s7xyhkd95YmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NZhj0S
        TFfKGbI4RkjgPMRllzHzyHzzfomHpbeEwFCZUvXATP0GefOLDC0fowdnsc8mLkr3
        cBjchxVAae02BPQXdBrs8HI7eLIeHSljHmO8oTakvQabifqPcfgesCuUZHXPtN8v
        LNg/SE+Z317U3m8Hx+UIr23QybWPnyPwcznD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97657AD45A;
        Thu, 24 Aug 2017 17:52:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F8EAAD457;
        Thu, 24 Aug 2017 17:52:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 07/16] refs: add refs_head_ref()
References: <20170823123704.16518-1-pclouds@gmail.com>
        <20170823123704.16518-8-pclouds@gmail.com>
Date:   Thu, 24 Aug 2017 14:52:23 -0700
In-Reply-To: <20170823123704.16518-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 23 Aug 2017 19:36:55 +0700")
Message-ID: <xmqqfucgvdk8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83BFC7B2-8916-11E7-B378-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

... which does what?

    Unlike refs_for_each_ref() and friends, this does not iterate.
    It just uses the same function signature to make a single call
    of fn on the "HEAD" ref.

Did I capture what it does right?

Thanks.
