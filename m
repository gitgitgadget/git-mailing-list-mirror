Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1222092F
	for <e@80x24.org>; Sun, 22 Jan 2017 23:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750733AbdAVXfW (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 18:35:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58861 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbdAVXfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 18:35:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D37D063E5D;
        Sun, 22 Jan 2017 18:35:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PgsbSYzemVysNtSIe9FRimwSRfY=; b=AkWP9Q
        1jdzo3+NIwpeW8bTFQcKaGeutSRZI+VDPkGL/a5cIJH95g3DhHRx5oFWg4Zb4ogQ
        GPzNx06kdwQONn2th6en2XSh0F+vSTni5s4ngJ8fCXtgFmeCvCjABIViB1FJMysz
        J+ps8t+mJA9Odgnm9KIsthCGldUtr4xP+Zadc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AUFBwp7CL9RBz5mdPfGZOCdsyYcFMG/I
        rxg72YyxuwHRhUbF8zJ2zmmEmXyTVrf/yspCD6ho6WmO4RbsJv6qlLWysW19/NhA
        oi8tTd8QK9T9OoUkl6jReDAuw0xX545rxoKK70zLYNAzmgnOAiYI4sF4RkQEcP3Q
        RkNqDXHzSwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC90F63E5C;
        Sun, 22 Jan 2017 18:35:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27C6063E5B;
        Sun, 22 Jan 2017 18:35:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
References: <20170122212855.25924-1-eantoranz@gmail.com>
        <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
        <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com>
        <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
Date:   Sun, 22 Jan 2017 15:35:18 -0800
In-Reply-To: <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sun, 22 Jan 2017 17:04:46
        -0600")
Message-ID: <xmqqlgu2u0qx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FFF9CB6-E0FB-11E6-B2E3-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> I wrote this for human consumption, actually. 

I see.

> Maybe I overestimated the
> need for this feature (I definitely find it handy, but it might be just me).

That is too early to tell.  At this point we only know there are me
who won't use it and you who will, among all the other people in the
world.

