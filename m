Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB78320A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755782AbdKGBYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:24:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752722AbdKGBYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:24:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 468439B1AC;
        Mon,  6 Nov 2017 20:24:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XgPyrX+8P32hCXHrbrtnzRkwIzE=; b=UpHCrO
        PgV+UawqFQQBpKcsnoyUquZPQs6ovqd9z4e5O42H3qq323XNCwzBCySQbIc+LJ3M
        Sud+8rkVfKJptv+Oodgy0hJ3S+2LriTOytd9QbSQdsiuYl0XWNmVQhnFUb25Ogb+
        U+cKJ4bLjFTeWcOBzuGhz6TX7LU0KKJ39aK58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZFADR21etLT1FAG49lt4MbSVTJGdJTVD
        geRNRisv1aPS1VsyfRqiguvOggX7N7jIHEzYoh1Kk8etRg6/O0319XqnqWMrTlhZ
        5u2cvJritcjJ3+dY+gYQXB2znCVaordfN4T6vUOWSROhdcmvPxg3VcxveDo8uQQl
        gpu4AHh7iaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E0DA9B1AB;
        Mon,  6 Nov 2017 20:24:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0F859B1AA;
        Mon,  6 Nov 2017 20:24:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] t0021/rot13-filter: add capability functions
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
        <20171105213836.11717-8-chriscool@tuxfamily.org>
Date:   Tue, 07 Nov 2017 10:24:10 +0900
In-Reply-To: <20171105213836.11717-8-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 5 Nov 2017 22:38:35 +0100")
Message-ID: <xmqqfu9qhoed.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C143742-C35A-11E7-AF43-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>  t/t0021/rot13-filter.pl | 58 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 13 deletions(-)

Makes sense.

