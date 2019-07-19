Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26211F461
	for <e@80x24.org>; Fri, 19 Jul 2019 19:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGSTQs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 15:16:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50405 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfGSTQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 15:16:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3F9885A41;
        Fri, 19 Jul 2019 15:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eqMayLXll+s+lYgIspIRFogvP5Y=; b=Np8v7J
        nF+c+i8ONg4yyaqWno9MNBdyHOWkl49n1gq3DZ8tX+zBlacgV6Hhcbem9eKEAz/r
        mhePtzPeodAuqOsYgum7B1Z6RiG+q5EapctPCPr310arTB87IVYJKV7GUPNUi/Qu
        Ict49Osc0eGmtvruVuszozG+gRXFtHDHUJ3yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AN4WjOhipXDpVG/OudjoujvPMI0NJVcq
        9XGAQTIerbI6hHstEU+tmLhY/MRQL6Kgj5dDi6JT1qVFCoJ55jIBpYo0ZrheOne7
        l6VZUVH8iEs0lL6wy5xipO3UEB4n/8MTJ18/Fmk6V7Rk+whhP/qXpdV7UpCgeCZ2
        fBx5xmsSH/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 901EE85A40;
        Fri, 19 Jul 2019 15:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8EF985A3F;
        Fri, 19 Jul 2019 15:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Fedora 1 and Ubuntu 4
References: <CAH8yC8mcgMh=rjASqePeNZSRoWxBHz7+bKpDoK7ojP=DyOgrtA@mail.gmail.com>
Date:   Fri, 19 Jul 2019 12:16:41 -0700
In-Reply-To: <CAH8yC8mcgMh=rjASqePeNZSRoWxBHz7+bKpDoK7ojP=DyOgrtA@mail.gmail.com>
        (Jeffrey Walton's message of "Fri, 19 Jul 2019 14:41:31 -0400")
Message-ID: <xmqqsgr1vnqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE8B2470-AA59-11E9-92B3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Just wanted to drop a quick note and let everyone know that Git 2.20.1
> builds on both Fedora 1 and Ubuntu 4. I use Fedora 1 and Ubuntu 4 for
> regression tests for some other libraries. It is easier to use the old
> distros then building old GCC's and glibc's on modern platforms.

I am somewhat impressed ;-)  Thanks for a datapoint---I am guessing
that your note was triggered by our recent "let's have a CI build
job that uses gcc 4.8" discussion?
