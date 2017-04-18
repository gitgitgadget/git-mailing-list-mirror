Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A761FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 05:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750723AbdDRFNN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 01:13:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53422 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750766AbdDRFNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 01:13:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02098753F8;
        Tue, 18 Apr 2017 01:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vPj3jvIqiV/pnZ6sVBzx1iInsUo=; b=eMd+KL
        MoD7WJ2f+PTpW0mvaCr1y9Jkc/67mz2JbwocnkBvcA4LHF3Z0IHIk4ca5R+NnjHq
        x5Po9LrT6h4wA5gLh1qEBrT8NOJoemg/Uaip8QylIGP8yYa7GLsO7L8FbNx3SQO0
        1QOhgqPpypvA7we7tRRuvhrlrf2mlp55t7bPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r9835iJiKqPi/7X3NrQHv3qWuPqlhIvM
        NreqXknYpetSY25pnAavsKO2IW+9GsBCs6q5MDG0yh/sLtNN1YbeEKum+yL7BmTR
        BXsn5+EH+VJllVoRJ2c012z8n2TtDCMhefaLTXYalOr515aB0PWjVe5EO9BilV5U
        7SlYgiD113k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED857753F6;
        Tue, 18 Apr 2017 01:13:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51285753F5;
        Tue, 18 Apr 2017 01:13:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 4/5] dir_iterator: refactor state machine model
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
        <1492462296-4990-5-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 22:13:09 -0700
In-Reply-To: <1492462296-4990-5-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:35 -0300")
Message-ID: <xmqqinm2e1sq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B71C0BBA-23F5-11E7-B3DE-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> ...
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

I had an impression that you took Michael's code snippet and wrote
this patch, and if that is the case, the flow of the patch is from
Michael to you to me, so these lines are out of order.

Describing which part of this patch owes Michael's contribution in
the log message would also not hurt.
