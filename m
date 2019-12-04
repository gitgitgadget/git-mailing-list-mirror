Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BF4C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB1205F4
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ssl4OlPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfLDS22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:28:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61635 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfLDS21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:28:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7168B39CD0;
        Wed,  4 Dec 2019 13:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X+EYfV1eUXYOyv8hnsD4tc0N7V0=; b=Ssl4Ol
        Ph3mhNTN3Rjv1I41YNVfenrN8449ecMpFdprv+0r0lCOcGrH1y+BOaT5PuJZQgbr
        EmTmPw+gsqqrHghoqIeubpkh9xo33QXUu62ElYS4FVgsf+UW12ZDuCnMHyLPHzim
        8d313FCflegz7THO192a17ZyWihPrdP+ikUHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Maych44lqkyQceuULfvT0bgMdH+6aRcm
        5FgSF8kMvktAZ+otJSm7Ed3foFRAwx2yX4y529L9Hp5wBCig/lCePq4M9LMcYoT7
        9gd66RGa580SvqtKmmJiXWsW0tJ1k8ACT+tDqFPdBW5YpKMBsuwPM8jilSeNcN+r
        ed+cVWos6Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6964F39CCE;
        Wed,  4 Dec 2019 13:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D110439CCD;
        Wed,  4 Dec 2019 13:28:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/3] Doc: replace opaque mail archive links with lore.kernel.org
References: <cover.1574882812.git.liu.denton@gmail.com>
        <cover.1575314676.git.liu.denton@gmail.com>
Date:   Wed, 04 Dec 2019 10:28:23 -0800
In-Reply-To: <cover.1575314676.git.liu.denton@gmail.com> (Denton Liu's message
        of "Mon, 2 Dec 2019 11:26:15 -0800")
Message-ID: <xmqqo8wo3pyw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBB51106-16C3-11EA-9B81-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It must have taken some tedious manual work to figure out the
original message IDs, but the end result that uses the message IDs
would have a lot better longevity than the original.

Thanks for working on this; will queue (on top of peff's topic).
