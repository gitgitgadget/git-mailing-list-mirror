Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F03F1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdAXXY2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:24:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbdAXXY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:24:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21C09637E6;
        Tue, 24 Jan 2017 18:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9sx779+m2VgE5GFOcPSzogx7fhE=; b=x6IZpu
        7460AJU19eJ7R4HRVsTjac+qLupDh7vIhBs9MKln6Pl8u7TchDGnCzbdTDPHNAJu
        DAaB3N67a4Szlgr5wNTzqck41l5QgvwELtYOzyImVYzztkyq7FvSo5c7JmQ9mYLm
        UWd4zrScSFchS8rjkAKctspj+HZ3S9N8SWwNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P+tvx2bTEkQgi5MVGMpKbKL7PabpL/wh
        lxU2L4QqqsU7z51cINuBdM7U5YfzH5V00ARNrsTtXO4P1woik9mle0fqD83Nmuec
        XuYBeV17NMyU+MeCoe3ZBtOJKgCURKvwc4+5rP/1el9jjvrOTa0jXtkyCirQXAwQ
        clr4JWK1oRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 198C4637E5;
        Tue, 24 Jan 2017 18:24:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CD50637E4;
        Tue, 24 Jan 2017 18:24:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk
Subject: Re: [PATCH 7/7] completion: recognize more long-options
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
        <20170122225724.19360-8-cornelius.weig@tngtech.com>
        <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
        <967937ff-e5ff-2515-2f50-80a96683c068@tngtech.com>
Date:   Tue, 24 Jan 2017 15:24:24 -0800
In-Reply-To: <967937ff-e5ff-2515-2f50-80a96683c068@tngtech.com> (Cornelius
        Weig's message of "Tue, 24 Jan 2017 09:14:25 +0100")
Message-ID: <xmqqd1fcca8n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F2E5AA4-E28C-11E6-B38D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

>> Please study item (5) "Sign your work" in
>> Documentation/SubmittingPatches and sign off your work.
>
> I followed the recommendations to submitting work, and in the first
> round signing is discouraged.

Just this point.  You found a bug in our documentation if that is
the case; it should not be giving that impression to you.  

