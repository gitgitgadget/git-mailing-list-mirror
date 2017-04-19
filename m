Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC80207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 03:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759418AbdDSDoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 23:44:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53188 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759415AbdDSDoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 23:44:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BD7F82890;
        Tue, 18 Apr 2017 23:43:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iH2xOsCE+TNtMntvA3N+mVtfdCk=; b=uIqrLC
        pos6XMX0T/XITyjc8DTOsUh5LzfWN++6OQKDA3r2kTbE/dhSBI9HPnfQSGMMXkdj
        xBdKCESCtBKcKywwOKxPJcgEyA0mEUbEBh/h2nJbI6qEr7pMKq/qdqkVoXzNXL+K
        RC/+RRFJTUoPSweu4ezfu6A4mCODypek90d6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZpFXtt7pQEgyLTuVmfvCuZ7A2O8qVn/s
        TPJ6tK/bk7T04a8+PShOe/c0i+lFejQel5LWiNHa8d3lI+1V+VkmhbO3Cyt2OuIn
        QtdzGClt7ji+IbaCaJkhl/4cq/akGsLKnX7sNqKL9IH0Fs//gicLrJFoLNON7ghz
        vpIBb+8Hm2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 403BC8288F;
        Tue, 18 Apr 2017 23:43:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACA328288E;
        Tue, 18 Apr 2017 23:43:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] rebase: --signoff support
References: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
Date:   Tue, 18 Apr 2017 20:43:55 -0700
In-Reply-To: <20170418092905.20097-1-giuseppe.bilotta@gmail.com> (Giuseppe
        Bilotta's message of "Tue, 18 Apr 2017 11:29:02 +0200")
Message-ID: <xmqqshl5awp0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A79098A-24B2-11E7-9103-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Some work about extending --signoff support to interactive rebases is
> underway in the `rebase-signoff-ext` branch, but there's a lot of
> corner cases to test and work-out, so I guess that'll be fore some
> other time.

Yup, that is fine.

Will queue.  Thanks.
