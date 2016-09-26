Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7C1207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935303AbcIZVEl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:04:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58412 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933166AbcIZVEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:04:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB1A342310;
        Mon, 26 Sep 2016 17:04:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xTAvCbg4Ui3vFvQXyTkShCu7dAw=; b=jLB1LH
        Vk8DOers45iTGAC94Zs5CovOODIk1toGP3phKqQtT6j32NXedWQTHUnvxOQPtxT9
        +btXpaO07VSKst5B1bb5t9QerB+/QVAqQpT5PqIxjSeP3LGpptwRippYr2R/L6gN
        1a4j3/1y+vemtDJCdn3pogiiakkLhYXKHLSXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jYShKfMfuh3iR02a9tBonTwdK4gXkQlR
        A/G1IqJ9lp2OtbHj/uO1xdba+uao7zdKPM/dv8IXaJ0QtQq9Xq95eYoGL24nA6FU
        OwFSyv5TDnuAT0pvgYugXDFv25JJZsCsJqw5dRj+d6+PoPr3Z4pjr3VZwRX516yK
        i4QkSU7PfCs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B39354230F;
        Mon, 26 Sep 2016 17:04:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4045D4230D;
        Mon, 26 Sep 2016 17:04:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCH 0/2] tree-walk improvements
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
Date:   Mon, 26 Sep 2016 14:04:37 -0700
In-Reply-To: <1474918365-10937-1-git-send-email-novalis@novalis.org> (David
        Turner's message of "Mon, 26 Sep 2016 15:32:43 -0400")
Message-ID: <xmqqy42epe3e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6746944-842C-11E6-9545-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> Hopefully the encoding works correctly on these patches. If not, you
> can fetch from
> https://github.com/novalis/git/
> on branch dturner/bad-trees

This does not test cleanly here, unfortunately.  Specifically, tests
30 and 31 t1007 do fine with 1/2 alone, but they seem to break with
2/2 applied.

I didn't dug further.  At least not yet.


