Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EB81F732
	for <e@80x24.org>; Thu,  1 Aug 2019 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHAUYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:24:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55786 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfHAUYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:24:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA41976CB4;
        Thu,  1 Aug 2019 16:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pfv5eWRyYxfYUEshwxamWIXG/Lo=; b=TnG1wQ
        LVWbsb3xwWacn6xo5W57Z1F7bx6ZvkPFSl8RS+dwaKfc+leFcR/hjf33kWEW1nM2
        iidE3zgX0MNJui06qw00s1xO8FPyZJnVQM+mlH9ac/0aAy6ZzIkF4HlYIhMutGDM
        j3x8SPHXA6QvhrPoPlP4zu16F7qSzImLKmJ3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JwO6WRrvw01T7MbduZNgxs8pZuqV4Nnf
        tpoHq5Nyqp3DG8WrKcJ7fcB2tDbO6vWdi2KPs6mCsSv/IQvo8wyJOQjCY8omKlje
        R3/OK+JpTJByNxCAfLhPWljn7yKfLeFJKMF0l4QA0c6ytpK2Jl45AQ+saqoaDYGA
        fmzCdaNAL/E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A367076CB3;
        Thu,  1 Aug 2019 16:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9373D76CB2;
        Thu,  1 Aug 2019 16:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick merge commit with log message populated
References: <CABUeae8EBzPSM1KrZTMiGj=6F3iyxeXXbqUNMf2p_LfPkqcfnA@mail.gmail.com>
Date:   Thu, 01 Aug 2019 13:24:00 -0700
In-Reply-To: <CABUeae8EBzPSM1KrZTMiGj=6F3iyxeXXbqUNMf2p_LfPkqcfnA@mail.gmail.com>
        (Mateusz Loskot's message of "Thu, 1 Aug 2019 21:49:30 +0200")
Message-ID: <xmqqr264my73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D4A1A6E-B49A-11E9-93E2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mateusz Loskot <mateusz@loskot.net> writes:

> Is there any other way, without remembering to `git merge` with `--log`?

"git config merge.log true"?
