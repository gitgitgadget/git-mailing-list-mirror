Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC30C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbcJDSxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:53:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63845 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752596AbcJDSxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:53:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15F0341B08;
        Tue,  4 Oct 2016 14:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sEIH4SE6R70zDSbGhSKIQ3j+/WU=; b=oE0mtb
        UWyx5j9uKsx/be5wbwnDrsHD8Eufsd7MKHx4a4ePDM1NsA4Q2I0Pkc6EyV6ufHGB
        nSCs8FIvL5Rpumpx/FeMC1Bk3MDsF3WdXrGKJktMj7wpuR4qbWAjShlHFs20TSbJ
        cyDAjG+XQo2xyAy/iw/qpPvhUrQi+rj3+OcLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rfcvUBD+1LSmbFPcRG2CFzcsvkG9IgP3
        Sc518cKm79r2w9inp1bVhr1l00QQrg37ioOEU1mA8u370AECKszldIeoSO6NI62m
        BbrxHi9PThOtGghyYJG8RN+O/jDtSWrS4CGAIMgDrO4YaeirO0elbVy7FpqE+Lim
        c9RotiT5Nqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A6B041B05;
        Tue,  4 Oct 2016 14:53:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7727F41B03;
        Tue,  4 Oct 2016 14:53:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] Export also the has_un{staged,committed}_changed() functions
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
        <cover.1475586229.git.johannes.schindelin@gmx.de>
        <017586232230ad87dd7cde5801e011cce9255bc0.1475586229.git.johannes.schindelin@gmx.de>
Date:   Tue, 04 Oct 2016 11:53:16 -0700
In-Reply-To: <017586232230ad87dd7cde5801e011cce9255bc0.1475586229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 4 Oct 2016 15:05:29 +0200
        (CEST)")
Message-ID: <xmqqtwcst083.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D073A9E6-8A63-11E6-B49B-15497B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> They will be used in the upcoming rebase helper.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Makes sense.
