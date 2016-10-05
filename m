Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FAB41F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbcJEVnX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:43:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62075 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751020AbcJEVnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:43:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95633442E4;
        Wed,  5 Oct 2016 17:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1N9T9rRQzncy+a0RgPiBBeO59w=; b=W/yKR+
        mV7WO2bjvE34uanWTvqyJUVvscAoENmObsTPVMmo/6Q3GaVttoL8GXyB0Joc8E1g
        6zEJ+pVT/F+8VEsScUapfvd2WxfiR4FFxIZlTQGlprlnBEdKLhpK+GDGsBY418Z1
        6VfdSTSkzEnf5VpAjr9awI8QJ3t4AYiynEqBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OQmUeAZU6QsuKFF/J48UslAGlkkMGEr3
        EYLnwhTpaTf1Lzq/kI8m+rXtJp3ivC0o76LHf0q7tmAwK3ZAmDQ+DZ6qocYCC2xV
        Ayvwo/knkV+YX0CPChGSPNq2FG+Pw+I8qSNwBM5Yg/j6+XXVHdJH+gdb96eQXb4G
        opztjPqTKRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E1A8442E3;
        Wed,  5 Oct 2016 17:43:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D9DC442E2;
        Wed,  5 Oct 2016 17:43:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
        <87shsapjiz.fsf@javad.com>
Date:   Wed, 05 Oct 2016 14:43:19 -0700
In-Reply-To: <87shsapjiz.fsf@javad.com> (Sergey Organov's message of "Thu, 06
        Oct 2016 00:34:28 +0300")
Message-ID: <xmqq60p6o4js.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC1184A0-8B44-11E6-915C-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> So I believe this change is inline with the rest of the patch. The
> reference to git-pull (if it remains) should be a side-note, not part of
> explanation of operation.

Not really.  The thing is, "This is the most common" needs to be
close to "Often...".  "git merge" directly invoked by the end user
is much less likely to encounter a fast forward situation; getting
invoked indirectly by "git pull" makes it common.

