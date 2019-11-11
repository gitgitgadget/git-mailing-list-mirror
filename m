Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4441F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKJAj (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:00:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:00:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0134E3949E;
        Mon, 11 Nov 2019 04:00:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0KZtiv5LSnrTD74cJtCoxAEMAos=; b=x0ZFme
        9mkXsEwPg7fRopx9AlrG0WXe2tZ3Vrrl1pX8hzOmEHgC/UZXAKlTN4i5zU58rsl1
        wlUby4AW9t4r7iTspEFXZ9ft6Fu4OWskdO6FU/ousdP2hfSRD+qdDd0Ra7fWANo0
        mgEbUAn3EQAfN7y0GpMSF7bKAK1VYjxQ/UASM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZD2OS/F++Kryn5n2v3MNTZWx3wVC8LGR
        GTiMDbTjyscKGYds9qOO1fP6MX8OnFcKLkihP9La07fypcwi/66VUDQm2Vdqt7KB
        wOW1i4BazPtrbYD3IN1hi2UU2k9hvcjytwk0+Qqh6mL2hlpF2aUEH3lAYpHyAAd0
        /Sv/HRBqriI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE08A3949D;
        Mon, 11 Nov 2019 04:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 616513949B;
        Mon, 11 Nov 2019 04:00:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bundle: framework for options before bundle file
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
        <20191110204126.30553-1-robbat2@gentoo.org>
        <nycvar.QRO.7.76.6.1911110943240.46@tvgsbejvaqbjf.bet>
Date:   Mon, 11 Nov 2019 18:00:34 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911110943240.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 11 Nov 2019 09:46:58 +0100 (CET)")
Message-ID: <xmqqzhh2hjnx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B93A3968-0461-11EA-8D62-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The mail was sent correctly by GMail, at least it reports that, and the
> mbox of the cover letter reads like this (maybe anybody else has a clue
> why vger thinks it okay to just drop the mail without further notice?):

> From: ""Robin H. Johnson" via GitGitGadget" <gitgitgadget@gmail.com>

How does that doubled double quote work?
