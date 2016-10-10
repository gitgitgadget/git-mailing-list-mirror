Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2ED20989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbcJJQuw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:50:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55301 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752234AbcJJQuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:50:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61BC245D5C;
        Mon, 10 Oct 2016 12:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bDuxJzMxOOUtPa34/Fhaxk8bSw=; b=BHuWW4
        /pLGZElHRnoeIOqrW/1ALaRlZ1pPa1vWET1lZggn6vD7GPDwZkAe1I1QAnSqdCkR
        n+Enl1gKdR2lUBA8Wyiac9vsd30UOvkQCumc9r533QchT/u+Sgna0TIQX/9Tswc1
        hFE6BTwmaLCaQpZUzvtSKUBnAsagMoap7WOl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vT4g6W6NqUfrsKEcV30o0Kq8PE6mQO4Q
        AGjcksnjqhhXyzYYyPFTCxP1j4KzzN2nQikUvwbmu42nvANwUTSm47Wtm2SHsc5s
        3/8Mk2qZiMsyFv5bWiQgS4HPr8xoEIgGajP4AWjOEFGVQU1ntVT8spcdy1kZFBa8
        TcvgQpOlORA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5262E45D5B;
        Mon, 10 Oct 2016 12:44:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBA6745D5A;
        Mon, 10 Oct 2016 12:44:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] t3700-add.sh: Avoid filename collission between tests which could lead to test failure
References: <20161010035756.38408-1-jeremyhu@apple.com>
Date:   Mon, 10 Oct 2016 09:44:09 -0700
In-Reply-To: <20161010035756.38408-1-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Sun, 9 Oct 2016 20:57:56 -0700")
Message-ID: <xmqqlgxwgnmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C59A5EA8-8F08-11E6-BCA4-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Regressed-in: 610d55af0f082f6b866dc858e144c03d8ed4424c
> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> CC: Thomas Gummerer <t.gummerer@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>

This is also under-explained.  Was the test broken for everybody and
you are the first to report, or was your environment somehow different
that the existing problem was revealed there first?

