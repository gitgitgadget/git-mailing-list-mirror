Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB751F45F
	for <e@80x24.org>; Wed,  8 May 2019 03:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfEHDaa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 23:30:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61263 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEHDaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 23:30:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E73958A9C;
        Tue,  7 May 2019 23:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/R286aJWWFS3MCB0qOlsCcxmDmg=; b=dEjDi0
        QRSqBYZESY5DIadu+CEKkAzWB0+/mYg52WOsp/oEMDtSZkttKelqWt52/PFVflsM
        gfONOPWovrhh13/KbmTh/NUp0dG+/Nv9sUCahRLL9clk1luWFPKD2gcp4leZpjqE
        uqpiqqkFy2E9i2RdmYdOz67JERdx8pVDsiKWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gS0OUTMUwPw5uTNzGyhx6sybZ24QgUJs
        6t5hC9eOaznaWA7NpjUPTOBv+QHTPRMmpPD5qcqzn0HrkhUDY/LFWshjomJ+hPly
        gN/JW4LQnhLcAWLXWj+3+0atD9XNVD0dvwneTXGK0i+tpxnjd5gXAnJmC3J2EGBb
        /Ih0i2jcitI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4671A58A9B;
        Tue,  7 May 2019 23:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 739C058A9A;
        Tue,  7 May 2019 23:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 0/2] documentation: add lab for first contribution
References: <20190423193410.101803-1-emilyshaffer@google.com>
        <20190507213040.151799-1-emilyshaffer@google.com>
Date:   Wed, 08 May 2019 12:30:23 +0900
In-Reply-To: <20190507213040.151799-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 7 May 2019 14:30:38 -0700")
Message-ID: <xmqqpnotipww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E58541C-7141-11E9-AFB4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> - Removed 'extern' from the addition to builtin.h

I said something that conflicts with this in my message to JTan, but
I am fine with this removal of extern, as it is reasonable that
Denton Liu's no-extern work would land soonish.

I agree with the spirit of all the other points listed in the cover
letter as well.  Thanks for working on this.

