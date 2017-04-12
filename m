Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017E620960
	for <e@80x24.org>; Wed, 12 Apr 2017 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbdDLIrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 04:47:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751393AbdDLIrW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 04:47:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA979714F8;
        Wed, 12 Apr 2017 04:47:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fqmkq6BQcrPdKpeRJfhvRcvw94E=; b=SuZHIA
        y5UceypCQud/EDRafXanOZYPHC7blEA+qz+7MTssCnC64h61fFmeMrR+58Hw4Ldx
        vNDD3eGD+aR9Qc4yBIzjBiCzO9ivRdq/OZIbru/QN2QrKh2Hj4H9HhkPIHsrTekh
        hgVpOQSSFYwVPpXjEdNZaPa7/pcKbOcDwxHU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ah3wxtMHs8jgqFfMat8Fmi+4vUZ+e2Lc
        JGD75NL4dC1uBpiKTs4srTeD1HJLGh3oXmvoN+bPhID0fhImEuNkADqsN/blGQBI
        mNNKF66pXz8gLQ3Xbm060hzTTisoX9dE7JIXI8ob3/Y0hWwT4CDU7c6HLkTss1sU
        Uk9KsUblhUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2E05714F7;
        Wed, 12 Apr 2017 04:47:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 374F2714F6;
        Wed, 12 Apr 2017 04:47:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix
References: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
        <20170412082205.GA448@pks-xps>
Date:   Wed, 12 Apr 2017 01:47:19 -0700
In-Reply-To: <20170412082205.GA448@pks-xps> (Patrick Steinhardt's message of
        "Wed, 12 Apr 2017 10:22:05 +0200")
Message-ID: <xmqqr30yovvs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3BA2D4C-1F5C-11E7-8B29-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Just a short reminder on this patch, as I haven't seen it or
> v1 being picked up by the What's Cooking reports. Am I simply
> being too eager or was this an oversight?

I have been offline and will be for a few more days; I may
occasionally pop in to give design level guidance on topics, but
won't be reading patches carefully enough to queue a new topic to my
tree.  New topics won't be added to my tree until next week the
earliest.
