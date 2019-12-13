Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862BC7E0A1
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7E524807
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EX1QZKvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfLMSkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:40:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55745 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfLMSkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:40:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90F0B18A68;
        Fri, 13 Dec 2019 13:40:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kNv1tn6CO+2eAmRJo7zmfmyyxGg=; b=EX1QZK
        vCfYeUY1TXKZgNHnKdTOllHGG/8Cscfvxs56OXoW9e50o+LE8JVFLDPnHSJ+3vew
        8Cb/jo8Tpo4ZA6KDyIdsdeZELajQkDjYhlNCGeoZzuL+byoThpAGALl96X6Czc7H
        JS86pAiIbKNfIbcKcRMbE+RGGWL1IVHOKNW90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N94a73ybvzbp4Ji1IGIx5WzuUdcvkWKA
        TeBPgwezvPbKe9q2i1OC3fxV7JOr2IbfGgytv6oBjQySQapScppapQG5jlZWgSVB
        YxYBhgxgJfYJPn6v3xbHSkUzNBDto3TThEXP+AM1ZTFncXSJME1w66Mu7lNuIg5b
        QN+wL0jY+6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87C9118A67;
        Fri, 13 Dec 2019 13:40:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5DFD18A66;
        Fri, 13 Dec 2019 13:40:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Kerry@google.com,
        Richard <richard.kerry@atos.net>
Subject: Re: [PATCH v3] MyFirstContribution: add avenues for getting help
References: <20191213013128.6268-1-emilyshaffer@google.com>
        <xmqq36dom9bf.fsf@gitster-ct.c.googlers.com>
        <20191213174915.GD135450@google.com>
Date:   Fri, 13 Dec 2019 10:40:27 -0800
In-Reply-To: <20191213174915.GD135450@google.com> (Emily Shaffer's message of
        "Fri, 13 Dec 2019 09:49:15 -0800")
Message-ID: <xmqqlfrgkr1g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0903E072-1DD8-11EA-A9FF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Dec 13, 2019 at 09:20:20AM -0800, Junio C Hamano wrote:
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> 
>> > Since #git-devel's traffic is fairly low, it should be OK to direct some
>> > questions there too.
>> 
>> Correct me if I recall wrong, but wasn't #git the original IRC
>> channel we developers hang out on, and then somebody thought "the
>> traffic is fairly low, so it should be OK" and directed non
>> developer trafic there, which caused the developers to migrate out
>> to #git-devel, a new channel?
>
> I certainly don't have the background to correct you, as that was before
> my time, but I can say that this document isn't directing non-developer
> traffic. This is a tutorial for aspiring Git developers to ask questions
> about Git development.

I do not necessarily think it is a bad idea, but the rationale must
be "#git-devel is for those who work on git, so it is very on topic
there", not "it is low traffic so anything can be sent there".
