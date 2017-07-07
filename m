Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BB4202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdGGPyX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:54:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60318 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751034AbdGGPyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:54:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84C5B7AF13;
        Fri,  7 Jul 2017 11:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=3/kQBasGhxpgr476+x/R+ryOiJA=; b=cbDH2d
        9VNOIJEvJlloOIy3yZuDY3Ku4UemATxCK0je7pBbP9Uv+kBQg5Ug/ExfWOye2lNE
        jjKVJxXn/BH0tSX1pl0wg7txnXKrqzHcSIK/XDmF0nCavlukEEE58guN4PXKwM/5
        k6Q8NtiFC4zDWvr3LbUyeFE/IfJ8fNzTvGgn4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CA777AF12;
        Fri,  7 Jul 2017 11:54:21 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D572C7AF10;
        Fri,  7 Jul 2017 11:54:20 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/7] t1414: document some reflog-walk oddities
In-Reply-To: <20170707090610.x2vodxgc7yr6o5pi@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net> <20170707090610.x2vodxgc7yr6o5pi@sigill.intra.peff.net>
Date:   Fri, 07 Jul 2017 11:54:20 -0400
Message-ID: <87tw2o8cpf.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A58E596-632C-11E7-8BFC-EFB41968708C-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=3/kQBasGhxpgr476+x/R+ryOiJA=; b=ZLqzYwAtMBD42W7sVkpWC1aUmPeVvuLwBFMJjzZGZrE8DeEzOAC8OySpfO1U9rD2TLluDvnPiGarRI4wA7L9Xty9isnWFWIbysqSlIo1NjZ16eh7u/63sVPtf9Wr5RrEfz9XodYvBDGxbPpBBdeqCGnml9247Uk3VT8+pmGaMfA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +test_expect_failure 'walking multiple reflogs shows all' '
> +	# We expect to see all entries for all reflogs, but interleaved by
> +	# date, with order no the command line breaking ties. We

s/order no/order on/

-- 
Kyle
