Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524A1207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 04:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdDUEFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 00:05:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751001AbdDUEFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 00:05:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6EF37CDF5;
        Fri, 21 Apr 2017 00:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byxLjQu6wi9NImKNqEZNrgMPD/w=; b=oWA/xf
        LADX+HX6WDRKbEdBSt+c7wMqFiKB+5apP0h7QbYQEAbUIUNE/piSpQ/679STJZu/
        V8oyHRgi94PdgPz2YXAR7FpEq+GH1N5Pt149LIJ7arFE5mYbVoEh7haBfJwGJmFk
        VNdiTDejmlv0OM90YIvKBPorXbUVFguAKcwzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FZUdrcSlOhqtb3BiA7gbs/Bu2bhqZW1v
        g40dF+YkqoWuVv95ovjnmRQmjq2LXRTPcabW/ArS+TuR3V49qn8Id5h97VzofRYj
        Qsbt7lgl4ap6s9/dhn/WAq5xNhb+iiw+qK9RJ3xy0qxYzFRTJn6IRZneqK9F9TSu
        vGPc8bratvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA4D7CDF3;
        Fri, 21 Apr 2017 00:05:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E17E57CDF2;
        Fri, 21 Apr 2017 00:05:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] removing more calls to git_path()
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Date:   Thu, 20 Apr 2017 21:05:06 -0700
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Apr 2017 17:07:54 -0400")
Message-ID: <xmqqbmrq5rt9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B50143AA-2647-11E7-8D1E-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All patches in the series looked sensible. Thanks.
