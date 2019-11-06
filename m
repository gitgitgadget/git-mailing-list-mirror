Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA11F1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfKFB6j (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:58:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfKFB6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:58:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 803F1A0D8D;
        Tue,  5 Nov 2019 20:58:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hwF4rJ1sTbQdHnaztsC+7NTNh4I=; b=pnOtZ8
        0j5tEEFI2UsnSDJ/4lY4Qdxjo6pqvxwSaKqsrctTGyY4PVTCuv0TbyhgvZPZ84LW
        iREIsj0NbVkvTFyeroVfOGZaWOS29dXaO2WHs71oy+b6OlfrGnnL43hvKZyEEhnf
        +D8WdzAyi06Tihr2LeRe+TCB+35ObTOz67kag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G4eBTmJRuIlYlDHMI9pvxRDItt9SmFKY
        0JBovHzvdmURdW9BdQLcZ22P5ysoGVtTare3cNDEM/oOatICsv3RREEJofmfWK/W
        5L+hyyX02zmwYbH7M5hEsgTTawxvj1ZuPzEny/6/6bRlCLZUE7cBexZka25XEgE4
        ucM2KRQDvGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 776F6A0D8C;
        Tue,  5 Nov 2019 20:58:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A264CA0D8B;
        Tue,  5 Nov 2019 20:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191104222634.GC22367@sigill.intra.peff.net>
Date:   Wed, 06 Nov 2019 10:58:33 +0900
In-Reply-To: <20191104222634.GC22367@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Nov 2019 17:26:34 -0500")
Message-ID: <xmqqsgn1wyt2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F16C88D6-0038-11EA-8725-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. I think this is an improvement over v1, but I'm still a little
> iffy on some of the other movement in the first patch.
>
> TBH, I don't think it's making anything _worse_, but I think it
> highlights how some of our documentation is a mish-mash of low-level and
> high-level details. ;) So it might be a good opportunity to at least
> clean up the documentation around ident environment variables.

Yeah, I hate to suggest another round, but agree with your comments
on 1/4 wrt the way how and the place where the environment variables
are explained, which invalidates the changes in 2/4.  Fortunately
3/4 and 4/4 are unaffected ;-)

Thanks.
