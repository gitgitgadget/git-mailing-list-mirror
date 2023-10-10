Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646DACD98C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 22:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjJJWYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjJJWYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 18:24:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF3099
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 15:24:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52524294F0;
        Tue, 10 Oct 2023 18:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6SxeqGzv0qiOwTTEKQYteNpTLCBRPMMc7ca/d/
        MVni8=; b=qQL6MnqXwFfyOfGjZfF3dJ2vJQL5uBTkgorfKhQ4K0fJ2fNm2iohgJ
        xfNdOXtNCckxRfpjXk0ndDHX6M0C1Jl6lEFjc9cmxoponY5lh8iwSonLG19lxErA
        2jDnqy91/MwXdCrpZHXnh+Prtx2jWnTGvEyuB5ae88onjYDJw2qqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B2D3294EF;
        Tue, 10 Oct 2023 18:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D849D294EE;
        Tue, 10 Oct 2023 18:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to
 guidelines when using die() listed in issue #635
In-Reply-To: <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
        (Naomi Ibe's message of "Tue, 10 Oct 2023 16:19:46 +0100")
References: <20231009011546.509-1-naomi.ibeh69@gmail.com>
        <xmqqlecbzl5e.fsf@gitster.g>
        <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
Date:   Tue, 10 Oct 2023 15:24:30 -0700
Message-ID: <xmqq34yiqfoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8B663C8-67BB-11EE-9762-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> Thank you very much! I'd definitely make those changes on my next patch.

[administrivia] do not top post.

> Should I begin work on version 2 or should I still wait for additional
> input on the version 1?

There is no "rule", but based on observations on how people behave,
e.g.

 * for a small patch like this that can be given a good review in 10
   minutes or so, those who do not do so within the first 3 days
   will probably not do so.

 * once a reasonably thorough review is given, those who haven't
   responded to the patch and do not have much else to say are
   unlikely to respond.

 * on the other hand, after such a review is given, those who do not
   agree with the review tend to respond rather quickly, to get
   their voice in before it becomes too late.

I would say it would be good to start working on it right away and
use a couple of days reviewing it yourself before posting it.
