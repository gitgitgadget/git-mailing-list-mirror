Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E56C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D8A20684
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCOcCHag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGWW0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:26:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50276 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgGWW0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 18:26:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2129BDDCCB;
        Thu, 23 Jul 2020 18:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VciKM03KbZFD
        kxW4Fs3k/RpOkq4=; b=bCOcCHagmobyyLTbKY3n121F5by1j9vAVDR7RrOv7bOc
        Pl3yX9ntgX7Qn7yrh4IzPS3ZGQPKnVpLhAvChdggUU0IySaKKIvrPAcMLewAb2U3
        D3rO5Xe/zGtbUCOg2M6Vudb1nohcPYsAOtWsGswBLNFZHA1YuBdr43K47Q+H6Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=teVsq2
        S4ySjCMDnKNfxUXSZ4mjHADnQDQZK+kxnannypN7c9mhOv0DjyMQXwcsqoOFX/VP
        ZyMK8XtP88Qt1ozzAMgH1zbyGpda9aaT0lXr8Sko0oZ6T8cRLf8U9e4NWqH/6FbN
        Y2XIV9IiK/wzjWio9d4SVEF1MXDj3Y1JUEM3s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18FA6DDCCA;
        Thu, 23 Jul 2020 18:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61E44DDCC9;
        Thu, 23 Jul 2020 18:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Carmen Andoh <candoh@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Subject: Re: Git Inclusion Summit
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
        <20200723205928.GB3579560@google.com>
Date:   Thu, 23 Jul 2020 15:26:09 -0700
In-Reply-To: <20200723205928.GB3579560@google.com> (Jonathan Nieder's message
        of "Thu, 23 Jul 2020 13:59:28 -0700")
Message-ID: <xmqq1rl1q35q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8310B074-CD33-11EA-83BF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Carmen Andoh wrote:
>
>> There's been some conversation about holding a virtual contributor
>> summit focused on inclusion [1]. I've volunteered to work with
>> Jonathan Nieder=E2=80=99s team on organizing this event.
>
> Welcome!

Yup, welcome and thanks for helping.

> Thoughts about how to get reasonable coverage for people in different
> time zones?  It's subtle, but the whenisgood link appears to assume
> U.S. pacific time --- I'd be willing to start a little earlier or end
> a little later if it makes participation from other time zones easier.

FWIW, we've timed coordinated security releases at late afternoon
European, which translates to early afternoon Eastern and late
morning Pacific time.  It was a bit inconvenient when I was in east
Asia where it is past midnight but it was OK as it was convenient
for everybody else.

The intended population may be somewhat different for this event,
but I suspect that the difference is not all that much.  Or am I
not being inclusive enough for our Asian friends by assuming so?
