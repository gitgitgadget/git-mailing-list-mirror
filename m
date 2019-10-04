Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5AF1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 05:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfJDFux (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 01:50:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57108 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfJDFux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 01:50:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6458026687;
        Fri,  4 Oct 2019 01:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EGFxPcEJWS/Q/T021PN+Tqk69M=; b=ucxBI8
        Qe+HQNfFm56UGT/aYGliV/VAS7nmyuSzT3gcS+SNLyQP3kNeWj1A5S1HVFYpEuba
        MZKrCSEo4C0FORzFLHXi2JpsVZUPtc+wgHYAu4Dx7xaxzKs5q30iM2r/i21rNloN
        1vOIvZVfdlIOWbzy6Fyf/CiJeAGwOCe6DVOag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FuEYetqyHwi35ceaK42g4JbbjBflRjCW
        i2Nm7sO47qY1GOhVd1FB4iZO+RQ14U27wUtEiWsjA8Rc7m8ZpfOhZNt4iS7lCOEG
        Qr9RF/N1EjS38w3Frf0dGF0Ih4ydheZTJncyr09dooodkdS3qhFkKPG971kpNe/8
        9H1aQiWV29w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BDB126686;
        Fri,  4 Oct 2019 01:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4E7926684;
        Fri,  4 Oct 2019 01:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] t4214: cleanup and demonstrate graph bug
References: <cover.1569407150.git.liu.denton@gmail.com>
        <cover.1570148053.git.liu.denton@gmail.com>
Date:   Fri, 04 Oct 2019 14:50:50 +0900
In-Reply-To: <cover.1570148053.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 3 Oct 2019 17:23:09 -0700")
Message-ID: <xmqqblux83et.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC612E4C-E66A-11E9-9E60-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Range-diff against v1:
> 1:  e77af8cde5 = 1:  e77af8cde5 test-lib: let test_merge() perform octopus merges

micronit: I would say s/let/allow/ if I were writing this.

> 2:  4a93deb3f6 = 2:  4a93deb3f6 t4214: use test_merge
> 3:  c09f761185 = 3:  c09f761185 t4214: generate expect in their own test cases
> 4:  ad6d89440b = 4:  ad6d89440b t4214: explicitly list tags in log
> 5:  0b84bf5417 ! 5:  e58c1929bc t4214: demonstrate octopus graph coloring failure

Queued and pushed out.  Thanks.
