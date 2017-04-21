Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E729207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 05:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035363AbdDUFaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 01:30:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035246AbdDUFaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 01:30:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD3497D8E8;
        Fri, 21 Apr 2017 01:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pk3L4q/l1iu/u1a4RY8sL7n1w1k=; b=KkOFZ6
        fHmXL63N2xa+P6qxU/2lY03jMHJF1S0LcfEfjo4NMx9BUim5o/aK6ToDZJOwFz4Z
        yt88TKkPZbaLWr6TF7O2qI49mctW5a0mTSoZylxUmFZI2zpK4STHJv6LjUL01VYe
        xWlyef/jMLW8Td7hTafutpEq5MdnKu85Tb/4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XXeFeqIobRSDAZeGwyNiM3JESgM1uXHs
        6PQyzNmCbz8+ZC4kN5rYk4R2j8PpldYlcYC+IgqSTks1vFdCSLoCaRla4Tzv/fAF
        JWINiB0S7DTvQ485n+k+n5E2Bz22/7gJnYyY5EPGTg716CjQJdZnYihuXA1jlBy2
        2JSPs8etWus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3D7E7D8E7;
        Fri, 21 Apr 2017 01:30:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 192527D8E6;
        Fri, 21 Apr 2017 01:30:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
        <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
        <20170421050330.ntnbri6qybi5i3pe@sigill.intra.peff.net>
Date:   Thu, 20 Apr 2017 22:30:20 -0700
In-Reply-To: <20170421050330.ntnbri6qybi5i3pe@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Apr 2017 01:03:30 -0400")
Message-ID: <xmqqvapy49ar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D4AACEA-2653-11E7-8571-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... But I think it's really the
> completion that bugs me. The DWIM is easy to avoid triggering if you
> just don't feed it the remote branch names. It's the completion that
> routinely leads me to doing that. :)

True.
