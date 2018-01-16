Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287531FAE2
	for <e@80x24.org>; Tue, 16 Jan 2018 20:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeAPUCs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 15:02:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeAPUCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 15:02:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8316BCDCB5;
        Tue, 16 Jan 2018 15:02:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1BfZyUmwtpwJ0a6WymC2Ue+vxXQ=; b=F8t+pe
        R0UJAPiNlTqJEYsZU764f8c0UAh+ZaNxhpDMLBYACAMvUYPE7Uh+U7MniTnCRLk3
        w+EBHZ6JHoelKOjui+RW3DM3SyWCJz2kDlUSej5VXd9hZkJAsuwoFnS+kjKv3Ie3
        OtvYXrRuZS4eRQk/ybVTZ1khz+HP/37Hp/pUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f3+3eCSJqPluZR4p/ePawzsZ5Qok+DUH
        PBz8Y7FSl8vvgiXK0aaPntwjc7xcNVNF9K/JNFBD4sxxaCu9lN5q5b/0H28Fxa80
        OTa6wLhVumFxHcugASRVsy1BRJOGtA7O8IBplUEMwbbhEq/7rcMhkWXiYqVlRTbV
        +kbDqchzdcU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79BA9CDCB4;
        Tue, 16 Jan 2018 15:02:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECB54CDCB3;
        Tue, 16 Jan 2018 15:02:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH v3 0/2]  Doc/submodules: a few updates
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
        <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
Date:   Tue, 16 Jan 2018 12:02:43 -0800
In-Reply-To: <20180114173737.13012-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 14 Jan 2018 23:07:35 +0530")
Message-ID: <xmqqzi5dtvvg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 379B1982-FAF8-11E7-AFA0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>     These are just a few improvements that I thought would make the documentation
>     related to submodules a little better in various way such as readability,
>     consistency etc., These were things I noticed while reading thise documents.

Overall they look like reasonable improvements.  I had a few "Huh?"
moments while reading the resulting text, but nothing show-stopping.
