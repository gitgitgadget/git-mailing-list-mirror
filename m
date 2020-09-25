Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEACC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C61220866
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KoaKxUAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgIYWVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:21:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56779 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIYWVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:21:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D90CC9C0AA;
        Fri, 25 Sep 2020 18:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bGpUx2SJcCMrpqI6kxzswqGFqUM=; b=KoaKxU
        Afzy8DIX4qYHevVJ34qvfMFx0kXmIAuZQUYJvx4NA9orsmvmt9ws3k0HRMrR9z/J
        gieDfUlHr/rUX33lTKh+HNe3Lsr75DiIot/uYwLmSIfo1bumvxTrCJlFHRZcuRcs
        EVWoebKtWOcr8WXazxgrCvSeAXLEOJDVhg/5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GqxMIibyhMk6rUMY5FZY+No1Bvg4aKUT
        4kIFs6bhXHFqQvoPOCLWneq74DH74HnCInjYVajSO/6lycKhj5ld68c6vdvNPJpt
        q5vROmSfdgF1O/MceYmwpzXc1kSFZ3hk6hf8FfmN3qsizCbO+bqSlWUSYXPO5i8z
        5iznSaVnu5o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFBD89C0A8;
        Fri, 25 Sep 2020 18:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10DD59C0A7;
        Fri, 25 Sep 2020 18:21:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 01/26] transport: not report a non-head push as a branch
References: <20200925221944.4020954-1-gitster@pobox.com>
Date:   Fri, 25 Sep 2020 15:21:15 -0700
In-Reply-To: <20200925221944.4020954-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 25 Sep 2020 15:19:19 -0700")
Message-ID: <xmqqd029jy5g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D78DCA6-FF7D-11EA-A820-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When pushing a new reference (not a head or tag), report it as a new
> reference instead of a new branch.

Sorry, operator error.  Please disregard.
