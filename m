Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB2E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbcISP7q (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 11:59:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63496 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750971AbcISP7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 11:59:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 438C03FB71;
        Mon, 19 Sep 2016 11:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmsCQu5xjLSIAWBVZFDD2Kv8dzU=; b=qypLin
        97ye/cg580U7d2bMzG1zU/e0PkMR1Fw9rXXyNEvYGv9kXDpUGRvSATd5cKaSNwEc
        PrXv3ferMJjT2+uE579ptJr1jeH6P9MqY537AaebU3cInadqRE72FFka8nYJAo/u
        LoHtedaZUwhJFOstPlBGLMlAdP1Y+DcqaHXsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jO9ewh0nm2C/vN7HAaAxM/mcj6eX15Zm
        cycHOO2J85HYvavOpepZBLYj17k75gkZWH1ic8Tmql3eIsijcIoLlSweYjpUt6iu
        Tpls2MIf/7QQnL8tmsqhbXmRH1+GJAx5iPbIUwOli0zIdGb156Gi9rLJpo7B7rVd
        Sft27iDk88c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C3333FB6F;
        Mon, 19 Sep 2016 11:59:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4E6A3FB6E;
        Mon, 19 Sep 2016 11:59:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Fredrik Gustafsson" <iveqy@iveqy.com>,
        "Andrew Johnson" <ajohnson388@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: Why are there multiple ways to get the manual in Git?
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
        <20160917183919.GJ20666@paksenarrion.iveqy.com>
        <223e818d-6d10-2679-c2d0-150011e74a59@gmail.com>
        <630656BFF8F84E43A2E4C67138A9A675@PhilipOakley>
Date:   Mon, 19 Sep 2016 08:59:41 -0700
In-Reply-To: <630656BFF8F84E43A2E4C67138A9A675@PhilipOakley> (Philip Oakley's
        message of "Sun, 18 Sep 2016 11:51:41 +0100")
Message-ID: <xmqqlgynhocy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 149E8B60-7E82-11E6-9BAD-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The `git revisions --help` does work ;-)

Not anymore ;-)

I think Ralf Thielow fixed it recently.

