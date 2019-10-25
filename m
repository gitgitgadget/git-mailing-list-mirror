Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3ACC1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 06:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394092AbfJYGFt (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 02:05:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393713AbfJYGFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 02:05:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ABA429ECA;
        Fri, 25 Oct 2019 02:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yGov73na9qdH/nUrFIYulAJN6ho=; b=BITyfw
        49k+PSf1en5zfsxdPpOpObFYJ1CiHRIQYRLC2m1VUqRGNP3gSBFLVHpUZg0Mm8Po
        y6oxP0KYeCNmm3n1yXt+QNNF44g3vm5dXxpOpKZP1RfqUTQEuimLdIAF/NeeLDvm
        +O+xO8xa3THtlmIV+RmTXyUk3tvNYEaXdFSAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nl9od8BvVYE6vW9fAppCsvScfMFuLMg5
        vYl+O+/NPMGrLA8WSGW8b9K6pJDWyM+Yel48o/aA8+XYoSHrcjecnajQRbmxDVw6
        2dlx9f9OJ7AiPBbx0xZilrrudXfSoCvqIZ7n4aWvJAz8sWlwU28PNskHawss54zJ
        jskbkvmHJhc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0309229EC9;
        Fri, 25 Oct 2019 02:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B99629EC7;
        Fri, 25 Oct 2019 02:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 1/3] t6006: Use test-lib.sh definitions
References: <20191024233617.18716-1-prarit@redhat.com>
        <20191024233617.18716-2-prarit@redhat.com>
Date:   Fri, 25 Oct 2019 15:05:47 +0900
In-Reply-To: <20191024233617.18716-2-prarit@redhat.com> (Prarit Bhargava's
        message of "Thu, 24 Oct 2019 19:36:15 -0400")
Message-ID: <xmqqeez1cqbo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D7DBD86-F6ED-11E9-82BA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> Use name and email definitions from test-lib.sh.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  t/t6006-rev-list-format.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

It is good to see that you did not go overboard to touch all hits
in "git grep -e A.U.Thor -e C.O.Mitt t/" ;-)

These look all good.  Thanks.
