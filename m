Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B4C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D39206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sxftCEL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfL3XdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:33:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfL3XdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:33:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 301959FEDA;
        Mon, 30 Dec 2019 18:33:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qyrv5mJ0IoCI1C93Vj3aVmtj6i8=; b=sxftCE
        L5yT+Dy/E1sSh6QsHcxrsf2zLwnpNm6SR3rlXMP79XQqogZ5KF5lw79tgam3oKtN
        zSLzl67KzbqIb+tQfcRcMSPMPJC742leYtcQOE+4zl4B7CF8wy+QQP9CMm9Th2bP
        jNAt87j0Zi57S08njG8Vx8sVqjg40bLwPM4mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H8FYI2prw48vxyY0tnFVBPOkfOPvn9Kd
        HrSliTAaUB9zycRT648DyzLX001KXyAPfUkj0tKPFKOfSpaBFbeEtS84SNF1DKWC
        8ssfOMOjclYN6/Dfy/YZyP68DocxI3H1wK7YLe4iSS7USxx6ykHM3cQXUBPGtsnC
        58coS0zbZqs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28D1C9FED5;
        Mon, 30 Dec 2019 18:33:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50C7E9FED4;
        Mon, 30 Dec 2019 18:33:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org
Subject: Re: "gmane:" search undocumented on lore.kernel.org/git
References: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
        <20191230231350.GA16499@dcvr>
        <20191230231620.lcydd5egk4ma2rph@chatter.i7.local>
Date:   Mon, 30 Dec 2019 15:33:06 -0800
In-Reply-To: <20191230231620.lcydd5egk4ma2rph@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Mon, 30 Dec 2019 18:16:20 -0500")
Message-ID: <xmqqblrpfky5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC3F2A0C-2B5C-11EA-846E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

>> gmane:  doesn't seem configured on lore at all.  Compare:
>> 
>> 	https://lore.kernel.org/git/?q=gmane:1
>> 	https://public-inbox.org/git/?q=gmane:1
>
> I haven't configured them because I don't understand what benefit they 
> serve. If someone can explain their benefit, I can consider adding this 
> to the roadmap.

Just that many old messages you find in the lore and public-inbox
archive (and also a handful of commit log messages) use the syntax
like $gmane/290280 to refer to messages on the list with gmane plus
the article numbers.

