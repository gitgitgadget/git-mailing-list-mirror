Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C943208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756440AbdHYSvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:51:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52315 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754814AbdHYSvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:51:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5E897FF2;
        Fri, 25 Aug 2017 14:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s6MqTXgOazrfNT0/zTca5C2iEO8=; b=nMk46t
        BscyUJYufTuQSdl/RjOgKnnoZhsa/DpANMwYaSVTfK5KHQyq46tfHs93Bgiievau
        FnrBh0bn2Vcw/j3ljn/8dfc9bFR0QRZPxfdkJ51CqSrcVEHHkZ0F4+z+Ya6Oj3M1
        umBF3BNeSlKI2QXoI8u+9o5pfBhVOp0iAXV5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GksD8kvTH74pm73xLVrqWcODYfKi4a3q
        y6zN2lqpHD303HLUcrLaBtoQdXgq5vX6JoriGRGPeMY88e0sI7ESqRoL1GIjdEsJ
        SzKkkKWGKk7oavh8ZBjlMfUUh1MXDmDWtq6XJrLl+Ex1kIzadEmMXtD4oLMsY5u7
        /lbHdclWn4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3697497FF1;
        Fri, 25 Aug 2017 14:51:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 966F397FEE;
        Fri, 25 Aug 2017 14:51:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [GSoC][PATCH v3 0/4] Incremental rewrite of git-submodules
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
        <20170824195051.30900-1-pc44800@gmail.com>
Date:   Fri, 25 Aug 2017 11:51:17 -0700
In-Reply-To: <20170824195051.30900-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 25 Aug 2017 01:20:47 +0530")
Message-ID: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6141E28C-89C6-11E7-8192-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I'll try to queue these before I'll go offline.

Mentors may want to help the student further in adjusting the patch
series to the more recent codebase; unfortunately the area the GSoC
project touches is a bit fluid these days.  I resolved the conflicts
with nd/pune-in-worktree and bw/submodule-config-cleanup topics so
that the result would compile, but I am not sure if the resolution
is correct (e.g. there may be a new leak I introduced while doing
so).

Thanks.


