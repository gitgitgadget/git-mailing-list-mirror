Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84899C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1961002
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJYRC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:02:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59772 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhJYRCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:02:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FD3C16A57F;
        Mon, 25 Oct 2021 13:00:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJ4x9PxAE/ETJGBe+vIRvMkjmCI1hnqz55mtGb
        BqClg=; b=qOdCtKieAkeDQA/h38Qddh3SUkyMsHcnlWNNk5Kg4FIQSOIewuQ0+d
        0HbvaSiqIl5nEMJJ7fM9meefhya7TAlrxtRavU51sfeQHE/UP4ypfUlnggeXBR9g
        hI0BSNYGVfszTXouMyTp0Ka6nY8BL+Esp4apE+clQ1+kb2RGx05gU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2673C16A57E;
        Mon, 25 Oct 2021 13:00:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88AB216A57A;
        Mon, 25 Oct 2021 13:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
        <006c186e-c005-28a3-7a5c-27d365ffe026@gigacodes.de>
        <xmqqilxl2gpj.fsf@gitster.g> <xmqqee892gd1.fsf@gitster.g>
Date:   Mon, 25 Oct 2021 10:00:13 -0700
In-Reply-To: <xmqqee892gd1.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Oct 2021 09:56:10 -0700")
Message-ID: <xmqqa6ix2g6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05E2FD14-35B5-11EC-A17A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps there needs some rewording to clarify that the sentence is
> referring to that case.

So, I came up with this incremental clarification.  I'd wait for
other comments before moving the topic further.

 Documentation/SubmittingPatches | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 2de8f80dc5..aea01bf36b 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -280,9 +280,11 @@ Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the `master`
-branch head.  If you are preparing a work based on selected topics
-merged to `master`, please mark your patch as such.
+sending out, please make sure it cleanly applies to the base you
+have chosen in the "Decide what to base your work on" section,
+and unless it targets the `master` branch (which is the default),
+mark your patches as such.
+
 
 [[send-patches]]
 === Sending your patches.
