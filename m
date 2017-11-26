Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20FC420954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbdKZDxc (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:53:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50350 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751902AbdKZDxb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:53:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10BFF9F854;
        Sat, 25 Nov 2017 22:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6e2bsDaoKCXIORkw34e6bDltnvI=; b=MHdayX
        rRlHurQkKHsbFKYiIHLvDmaE/SDUC571WP2Uy7TtBQaRwUbffvHlXrJeFCXrejW3
        6MyYp07tJ3BG4AeQhKtw/5bEY0+0fL+soq+t9KhkOxkL/UEg5yhzAdHRzxfG5X09
        pHAB26L99/kyoC6mhtP7RV4aFd/0XS6gcg4ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HiA+pxjb+SPBvzBiWgbRLtMjagz62/RG
        r3fcYlSfTMTnJgV11yIcUlZzqzGkcbI8ZPkvektGTcgE3m+O88XbZv4BBstWRzXJ
        dBstnv6tAaKcIeUz3dXYwYnzotlnwTMi3CejwvTQV4ESoll58UAcdYlBcp18Bind
        KVLB3FMg4vM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0741F9F853;
        Sat, 25 Nov 2017 22:53:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B1C79F852;
        Sat, 25 Nov 2017 22:53:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
        <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com>
Date:   Sun, 26 Nov 2017 12:53:29 +0900
In-Reply-To: <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com>
        (Christian Couder's message of "Sat, 25 Nov 2017 21:46:18 +0100")
Message-ID: <xmqqbmjpitl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC6B08A-D25D-11E7-80A9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> By default running `make install` in the root directory of the
>> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
>> and "gitk-git" sub-directories to build and install these 2
>> sub-projects.
>
> Has this patch fallen through the cracks or is there an unresolved issue?

I had an impression that the conclusion was that the existing error
message at runtime already does an adequate job and there is no
issue to be addressed by this patch.  Am I mistaken?
