Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D2320446
	for <e@80x24.org>; Mon, 16 Oct 2017 05:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbdJPFZw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 01:25:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51335 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750731AbdJPFZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 01:25:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9959F9B800;
        Mon, 16 Oct 2017 01:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YzlQkpIV7ghBRLAmD7l5RArVZnA=; b=GMdLSe
        lMxMtsE6z5hj2AROAoG3dAx/qRzCUAMqW1NJl7enj6zzGtCK3LkAQl6krnKh8YjE
        nVpHMRQMFZ+2vNyzXRBFLKzXijzB0x2gPojr83X1z/sSMvw0wzXdrpxn7DGyf28q
        5FtecBYGGzB3anS5PvNTW0l9M93tUjquQq2pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qH5QVjCOu9c32FHd13elVlbFFAyEwAwF
        oPYh/O+PVtn8edPLQZz5lUFrw6rWYenzmS0sPDQUFbbCEcY85ufocK0xUjs3Lt1l
        yO2kQLHINkxkeIJ+uJFqKvvrl89uRiJS//Ky/hIcK2X563ndCOHuQnDfy+X8pKfC
        NsbFQZkZQvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FB169B7FF;
        Mon, 16 Oct 2017 01:25:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D84E9B7FE;
        Mon, 16 Oct 2017 01:25:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <chriscool@tuxfamily.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/9] perf/run: add '--config' option to the 'run' script
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
        <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Date:   Mon, 16 Oct 2017 14:25:48 +0900
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
        (Christian Couder's message of "Sat, 23 Sep 2017 19:55:56 +0000")
Message-ID: <xmqqy3obslyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78ABBC1A-B232-11E7-9406-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

> It is error prone and tiring to use many long environment
> variables to give parameters to the 'run' script.

This topic has been sitting in the list archive without getting much
reaction from list participants.  Is anybody happy with these
patches?
