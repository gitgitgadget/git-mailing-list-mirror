Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C7C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0A610CE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbhIMRmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:42:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54810 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345976AbhIMRma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:42:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8990B15497E;
        Mon, 13 Sep 2021 13:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TfFhBjRI4kBQ
        n690c7RCprGjkGVkDWWCeDarSHmKNM4=; b=BfXEFN8+ps73ELEpL2ALOvZd4XjT
        mhzDjmuL7BHHCg/m0nQluufqkTEKEQl7pys+V5R+Hwev5kEaUU4WeXjXyfkIW2/x
        E5iq/oP1kfmHNvprV9o9bcxuHbNwCNPOwquN2KJCNS0gCI8jZDZycpPgpjn0+njY
        adG4T2j8NBYhtrc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81E7115497D;
        Mon, 13 Sep 2021 13:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE80315497B;
        Mon, 13 Sep 2021 13:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v4 0/9] post-v2.33 "drop support for ancient curl"
 follow-up
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
        <YT+EH1O+kPrf4T8j@coredump.intra.peff.net>
Date:   Mon, 13 Sep 2021 10:41:10 -0700
In-Reply-To: <YT+EH1O+kPrf4T8j@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 13 Sep 2021 13:02:23 -0400")
Message-ID: <xmqq4kaogyq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C93BACF6-14B9-11EC-B723-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 13, 2021 at 04:51:20PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This is a hopefully final re-roll with a small grammar improvement in
>> 3/8. See range-diff, pointed out/requested at
>> https://lore.kernel.org/git/YTzBUFY4p6obEqF+@coredump.intra.peff.net/
>
> Well, I did say "no need to re-roll". :) But thank you for addressing
> it. This version looks good to me.

Yup, the word-diff from what was queued with a !fixup step looks
pleasing ;-)

Will replace.

Let me mark it for 'next' in the What's cooking report.

Thanks.


$ git diff --word-diff @{1}
diff --git c/INSTALL w/INSTALL
index 5865e1630d..4140a3f5c8 100644
--- c/INSTALL
+++ w/INSTALL
@@ -144,9 +144,9 @@ Issues of note:
	  not need that functionality, use NO_CURL to build without
	  it.

	  Git requires version "7.19.4" or later of "libcurl" to build
	  without NO_CURL. This version requirement may be bumped in
	  the future.

	- "expat" library; git-http-push uses it for remote lock
	  management over DAV.  Similar to "curl" above, this is optional

