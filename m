Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A11420450
	for <e@80x24.org>; Thu,  2 Nov 2017 07:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdKBHst (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 03:48:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57126 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750836AbdKBHss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 03:48:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ECA0AFF31;
        Thu,  2 Nov 2017 03:48:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94TziDt2b/JvUxbLAc4O6jJrMzo=; b=RgfZI/
        jbAPO9g3PNh2UDLNmteQc5ZAyx8E+/SkXLybuzz4pGzQnZtoMMfK9K5b0pvrDr//
        hVgWHsAnZjZ5mAAdY/5qOyQQ1QuyzY6koSynjfP+OU3l2PTt7Qs9DwppVAsa9GWi
        M614ckdEn9Pyy3OD4HP3uTyyVVfMZETOEeuYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IxIVf8BRfz0thj5rzkSsvqDpSRi0jzdr
        qyyb+mRozn76wnDMe5x3kg/JyvtYd5Z54Rj9zL0UuPKd/cMcx04ZwpKV4VHck4vV
        EnJNRvux+QFCcnFDWHTlLX0SXfeIFBfwRnZOR9LipPoohizN6GZhShTJTTugiuk+
        Tol25MV/YoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35682AFF30;
        Thu,  2 Nov 2017 03:48:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1EC0AFF2F;
        Thu,  2 Nov 2017 03:48:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create Git/Packet.pm]
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
        <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net>
        <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
        <CAGZ79kYghF6=AzL1N96fe2zixHCERXu=RpxHw2-kdUrU+j4CXw@mail.gmail.com>
        <20171102072237.wbmrzrgfyxdb3m3v@sigill.intra.peff.net>
Date:   Thu, 02 Nov 2017 16:48:45 +0900
In-Reply-To: <20171102072237.wbmrzrgfyxdb3m3v@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 2 Nov 2017 03:22:37 -0400")
Message-ID: <xmqqh8udqfxe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41C93484-BFA2-11E7-8A2C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the clutter is too much, it could also go into a git-notes ref
> (that's not already implemented, but it seems like it would be pretty
> easy to teach "git am" to do that).

FWIW, that is what I use a notes ref "amlog" for.
