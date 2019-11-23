Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77470C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F622070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xU44vxny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWAWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:22:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57468 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:22:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 388AF95ABF;
        Fri, 22 Nov 2019 19:22:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgsC5nW5GPnYYRfoMfRm7hVnIyA=; b=xU44vx
        ny8MM+MZy4P5e6yALWFO7x7qvBhGLa7/zBiA99PT8o0pTPLE8AB6zxSIV9vjMw2e
        /FAIkmKSEla8Zsh1xVr6dmRoy3i5eCnTCcP9Gp9VTn7jUfBZtzDPYNK+CHJUlgDW
        MLzNGJv0MZkF9fZFCZd0W+i1RZJG4s2/aNatQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UavEF5uLY7ofO/Ci8HSd+kLb5n7PAj6S
        /dCIr3ekhL1orYOMrisTJEMx29jy81fHklIKhAaz9yL1f3aMq0UhhcEpXsgr8mcw
        roWBYQ2Azx+FxNaSympQGbQUEN5FWLAVSaJxv67M6XYNQj/Cs/XCLWsC+htD68jG
        usrWF/9q1X4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31A1C95ABE;
        Fri, 22 Nov 2019 19:22:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CE0095ABD;
        Fri, 22 Nov 2019 19:22:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Limit search for primary fingerprint
References: <20191121234336.26300-1-hji@dyntopia.com>
        <20191122202312.10120-1-hji@dyntopia.com>
Date:   Sat, 23 Nov 2019 09:22:18 +0900
In-Reply-To: <20191122202312.10120-1-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Fri, 22 Nov 2019 20:23:10 +0000")
Message-ID: <xmqqwobr30hx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 501BBD06-0D87-11EA-8CEA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> ...
> This patch revision fixes the indentation in the test cases as well as
> an erroneous const qualification.

I made minor tweaks to the log message, but otherwise I think this
is ready for 'next'.

Thanks for working on this.
