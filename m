Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737531FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbcHZTpX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:45:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62784 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753315AbcHZTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:45:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA5538B63;
        Fri, 26 Aug 2016 15:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CiZE3i2ECM0HiJM8iEs0ZpLwrjo=; b=okN6hw
        rRJXH2xsYZW+UE/Xxv0nhLGqapkuTiaiWIS00b87WH7kDfixZCtfxGKNl81TpRlH
        IBssjWgJU4/r/Bb2/mrnxjXHdL3zlyFOcNt/ucO4inY5mSgOSK5b/qTpiTf8Gbo9
        Y0iST2mInPvyzM0InInqKoUYz8m94JvcmZhE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bXmUvjoEkTOFw06aoraDMUBY34IEZxi3
        QCl1fAevSjSYZW3SfAe65U9K2p2rRZxEL9NMSuV0BJpvhv0eAdJV8b15iPey4czK
        oYh453ETRQrED1fomKSXtkSn1dhw0yKgtKMBkm8JsgvfGq+s1Y1ymxBEWJjVD80C
        DDWIm7926oM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7855738B62;
        Fri, 26 Aug 2016 15:45:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F114138B61;
        Fri, 26 Aug 2016 15:45:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 08/13] convert: quote filter names in error messages
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-9-larsxschneider@gmail.com>
Date:   Fri, 26 Aug 2016 12:45:18 -0700
In-Reply-To: <20160825110752.31581-9-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:47
        +0200")
Message-ID: <xmqqoa4ffh69.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F88DA66-6BC5-11E6-AD93-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard to
> read in error messages. Quote them to improve the readability.

Sounds good.  Thanks.
