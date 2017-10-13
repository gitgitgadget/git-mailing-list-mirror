Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E4E20372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbdJMAaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:30:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64741 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752644AbdJMAaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:30:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E792A6761;
        Thu, 12 Oct 2017 20:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GejsATQP1XX9axaKS1Y8n6zY9uM=; b=KAqNdq
        VJfFbXTnJzUiRZ+DMw25sWVFq0qO7eqWa0ZatUDi0/5ymBv6P10ELyZsKCp6mkSg
        mwgB/fzHGbX/j+0KliDwB4tKn8KGdoPp5eSGkucpR01SIkn5zFSEGds3cniMPztp
        B3tJij7SckJKRrbwASrsdgx5Uzc6VsMMzC3A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZHjYi+8eaE48w1DFFG4KaCJXvpNayNkA
        YWmfsE+gL5vJFwUBVqo0NSsfPQMfxMu5FnTHLN9vIe0iZRKOrSpUxXEp5uV1q+St
        GzDiBFeTiSKFLVYgg4jSosVBmBN8Qr6OSNFua0xQzHH7/OfcOTNPV5xMIYIencXO
        Y+DSFIvBePs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A9E8A675E;
        Thu, 12 Oct 2017 20:30:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E3FA675A;
        Thu, 12 Oct 2017 20:30:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
        <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com>
        <xmqqvajmmdii.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710122110170.40514@virtualbox>
Date:   Fri, 13 Oct 2017 09:30:01 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710122110170.40514@virtualbox> (Johannes
        Schindelin's message of "Thu, 12 Oct 2017 21:13:40 +0200 (CEST)")
Message-ID: <xmqq60bjyjna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A754C1A6-AFAD-11E7-BB0B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> (The funny "squash!" followed by a complete version of the
>> rewritten commit message is what I do until I -- or anybody else
>> -- comes up with a patch to implement support for "reword!".)

I have wished for something like that for a long time; it has been
(and it still is) a bit unclear what the semantics and UI should
look like, but still, such a feature would be quite useful.

