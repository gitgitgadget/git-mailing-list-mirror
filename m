Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D406BC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD1F2086A
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="STtoagMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgGXA7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:59:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57767 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgGXA7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:59:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FCD6E28E;
        Thu, 23 Jul 2020 20:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rqjw6aXO6Tyf2vdEMvWXxRRpw68=; b=STtoag
        MedgCG72LebsqQ2/pPxNNO6v32W5nYOoKoFTlIL59FYswedN7LQn3PrzeKT/2sdM
        V447raLivEEg9MoLmuUSJtUtFprDGqsQW4sn2OJPhfJ9+KjHMj5Bv8DuexRLms9O
        uKp4Mz6e/YCT61YNz7kA28/tHgU7S+Ih550T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iLOYpWMLKfWi5jGs+SzOGXmqGxb2QpFu
        1FFlzPTTSP4VPu6qEpD7xW/jBc3CkqNPy59wx4cvUtolrORsQNIAzGadT+0TtOmY
        pPsl6QnaPxO7SIB4LJO28BcbMqes3zjCFVaJEn8cHFsfwTa+HKCTaVP9A+b8fb84
        sihbVuUudvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E9D56E28D;
        Thu, 23 Jul 2020 20:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C24766E28C;
        Thu, 23 Jul 2020 20:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
References: <C4EFRPCE3DAH.1L6J33UIORQ02@homura>
Date:   Thu, 23 Jul 2020 17:59:40 -0700
In-Reply-To: <C4EFRPCE3DAH.1L6J33UIORQ02@homura> (Drew DeVault's message of
        "Thu, 23 Jul 2020 20:43:26 -0400")
Message-ID: <xmqqr1t1n2wz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F44B0D1A-CD48-11EA-B097-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> Oh, I'm sorry, I thought I had already sent it out.

Thanks.  As long as nobody has dropped the ball, we are OK, and
again, we are not in a hurry right now.

