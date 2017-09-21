Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6970E20281
	for <e@80x24.org>; Thu, 21 Sep 2017 01:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdIUBh3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:37:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52349 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdIUBhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D17392DE9;
        Wed, 20 Sep 2017 21:37:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mmrcz3A5nJfeWBapnTQYtGmtP3k=; b=KxNeWY
        vRakP1E1T2f7DOc6pbFszDseAwR1Vh29oNWkeuEkAR5v0pF+kZcjKv4f/ks8F1Kt
        osPJmlmjOcLY2VBhmcvcYRRZMqNffw08noVghd0eMOJhpwmfQz3MZuXBrdkbWzws
        REGakSjOdFVukK6/OgMqVi1x1i0A0QZbFq80E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xAeFdD2yygzs6e7MXE9FEVw6l2Semo7X
        rLUsMk+pj6Eploz1viPUpmIJ3f4m9kYWdrxkNL+uQzE+PNo8v4yaitU1kywlLggW
        nIayG6GRCadoaIVuGEMZUFO5hfCfer4xYbQ0cCMgl49xflbojX7Iuy9684QTfRS9
        6Q12FV1ImNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 355E592DE8;
        Wed, 20 Sep 2017 21:37:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95CF892DE6;
        Wed, 20 Sep 2017 21:37:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] branch: cleanup branch name validation
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
        <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
        <1d620d52-5326-269a-8710-160b75fada81@gmail.com>
Date:   Thu, 21 Sep 2017 10:37:14 +0900
In-Reply-To: <1d620d52-5326-269a-8710-160b75fada81@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 20 Sep 2017 17:34:39 +0530")
Message-ID: <xmqqd16kn86t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65E59A2A-9E6D-11E7-A7D2-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Thanks for giving a better alternative. Sounds catchy. How about
> `validate_branch_creation`?

I do not know what you meant by "catchy", but "git grep ok_to_" will
tell you that ok-to-$do-something is quite an establish phrasing (if
I thought it was a bad way to name it, I would have explicitly said
so).


