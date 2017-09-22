Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C61202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdIVEmG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:42:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdIVEmF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:42:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D3B6A80D8;
        Fri, 22 Sep 2017 00:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N0+M5sb/sMneQWaeC5giyd8sEUA=; b=FS/rGR
        TUTOOYOdtc6OxfBMSSSdgW2uSBW+YSIr9B+fDHqaHZkDAOr98KrVVXlk1vy9gGRo
        6jcI4BVJRhMMuqo1GhmDm5Zz/SXd+400Ywpd9yZ29zlQS7tygIcJg5A8SJqryg+S
        taGkdAdf7EoId03Vo0k7Bgzi8auKea4iyA7nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eRQvDyPMT2HfIc3uen1BWgWmwAVmM7ZC
        TmE7mUZtnZCK+xP3vxRPMUDnS9OzebURZOOrcp/PnV8aK6/9a/u0O5VNn8ujQfRi
        PxyYWVhAjnArmYoBxYtJTK3HqA/u5K3XdfxApHX7ZO/hZQqGLPh2qb/+65Sj2dx0
        YqEvYv96yGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64ADCA80D7;
        Fri, 22 Sep 2017 00:42:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2050A80D6;
        Fri, 22 Sep 2017 00:42:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] filter-branch: support for incremental update + fix for ancient tag format
References: <1505980146.4636.9.camel@hellion.org.uk>
Date:   Fri, 22 Sep 2017 13:42:03 +0900
In-Reply-To: <1505980146.4636.9.camel@hellion.org.uk> (Ian Campbell's message
        of "Thu, 21 Sep 2017 08:49:06 +0100")
Message-ID: <xmqqzi9njqec.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61FA4DE6-9F50-11E7-9838-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> This is the third version of my patches to add incremental support to
> git-filter-branch. Since the last time I have replaced `git mktag --
> allow-missing-tagger` with `git hash-object -t tag -w --stdin`.
>
> I've force pushed to [1] (Travis is still running) and have set off the
> process of re-rewriting the devicetree tree from scratch (a multi-day
> affair) to validate (it's looking good).

Thanks.
