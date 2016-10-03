Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D781C20987
	for <e@80x24.org>; Mon,  3 Oct 2016 21:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbcJCVZ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:25:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751500AbcJCVZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:25:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FA4141AF6;
        Mon,  3 Oct 2016 17:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xrWMw6AzU/jSipU/937o142tMZI=; b=FeN30A
        IMwDR62Hz6FrnZwGqF5aGK0kMJt6oyplohWmArgjhAUsOVvVwntpQXCa3hkx8tTF
        bHj0SJRGRZ/XjTo44skl13iN9z7KfWx2OnFer+DtYLj9nDeXvsOSEELFD1aONs69
        j79NZaQv3OirTzhBDPtGKKIa9NNO1vZLocfU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ANcJLOmdUHagn2zhkFqPOI6EZulkFrIg
        SaCzUmsrJKFjOv//7EiMup1bWSiB4dFTJ7dVQTKCwDuMaDLBUdxkK1Sf89r45EiM
        KrAJJt8ivQ2E93Bhuc7j1j4LCg8+2u4JMJQIwgYYCZ+PdU+BwbK09YCBI6LDQoV3
        05IsoUTXFhg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0733C41AF5;
        Mon,  3 Oct 2016 17:25:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83B2E41AF2;
        Mon,  3 Oct 2016 17:25:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH v2 0/5] receive-pack: quarantine pushed objects
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
        <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net>
Date:   Mon, 03 Oct 2016 14:25:23 -0700
In-Reply-To: <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:48:51 -0400")
Message-ID: <xmqqlgy55dmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E62F4768-89AF-11E6-993D-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a v2; the original was at:
>
>   http://public-inbox.org/git/20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net/
>
> which contains the rationale.  The required alternate-objects patches
> (both the "allow recursive relative" one, and the helper to add an
> internal alt-odb) have been pushed into their own series, that I posted
> here:
>
>   http://public-inbox.org/git/20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net/
>
> This needs to be applied on top.

Sorry, you lost me.  So this 5-patch series comes on top of a brand
new 18-patch clean-up series?
