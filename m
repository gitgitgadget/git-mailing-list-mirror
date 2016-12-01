Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBFA1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760552AbcLAVEa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:04:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58129 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756532AbcLAVE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:04:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18C0754BDC;
        Thu,  1 Dec 2016 16:04:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lz5xGHQRHsT/mr1wURdfBVqXWD4=; b=mIS2H6
        9721zdM8rFM23dyLPfk/t4txACwE/GFlilGf8bu+Y1WZ799banII9XETckbVhs5f
        sZNjOzt0UqIcwZMrcnkOS4lDplLQ/24LU8UZNk8+S4lhUz+4WcL9wfJv4f0aJnae
        sCT3CGD54tWIKxc182cB2VD+yxH3WaUfe1Ve8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cdJ7+BTtuI4k58R51tI25hfIqI0z0XX3
        WNIeoN/TOluLwEMARfiZp9FGv6eG9LaN+56R46aajfJhU4AuZouF31e2DDZMnXbr
        /1uYRWUhDM4PTPbz5752RzKWnqLE+6hObahpJLrwUC+ZhWgxrTCnHaBfTvgfbM8b
        x+i9VFcI2ho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1153E54BDB;
        Thu,  1 Dec 2016 16:04:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CBAB54BDA;
        Thu,  1 Dec 2016 16:04:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
        <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
        <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
        <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Dec 2016 13:04:26 -0800
In-Reply-To: <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Dec 2016 12:58:21 -0800")
Message-ID: <xmqq37i78ip1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEB6BD00-B809-11E6-95FB-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It took me a while to dig it up because the topic is so old, but
>
> https://public-inbox.org/git/Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org/
>
> is the thread I had in mind.  The idea of rename detection followed
> soon afterwards.

... which was this one:

https://public-inbox.org/git/7vr7g4m0lz.fsf_-_@assigned-by-dhcp.cox.net/#t

