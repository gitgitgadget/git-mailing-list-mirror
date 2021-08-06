Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121AEC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A7961181
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhHFUw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:52:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62963 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhHFUw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:52:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24812149FFA;
        Fri,  6 Aug 2021 16:52:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ihVMkjgkULWG
        LM5pbJZljU4TfHRZgXTInaAHy81SMPQ=; b=F3+nBjb3Hu90ghmlK9hT9lU/fw+R
        hmyXK/ZpcCR1tIbIk0UcTDgLUMIp6XhEcJcTSV0aVnuqM69D6pLvczx9wGUUD5my
        Oy0lcgybTE6xzjYRubAdFvrdhimgOUqjNWxOAdwQRusgxL/7vQFOXyYckIH558Pd
        3RAWQ6zv9/xMY+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D63C149FF9;
        Fri,  6 Aug 2021 16:52:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54020149FF8;
        Fri,  6 Aug 2021 16:52:37 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/3] detect-compiler: clang updates
Date:   Fri,  6 Aug 2021 13:52:32 -0700
Message-Id: <20210806205235.988761-1-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-rc1-159-gdd7297d7fa
In-Reply-To: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 3B62FA08-F6F8-11EB-A47D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is a mini-series that summarizes what has been suggested so
far on the topic.

Carlo Marcelo Arenas Bel=C3=B3n (1):
  build: update detect-compiler for newer Xcode version

Jeff King (1):
  build: clang version may not be followed by extra words

Junio C Hamano (1):
  build: catch clang that identifies itself as "$VENDOR clang"

 detect-compiler | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--=20
2.33.0-rc1-159-gdd7297d7fa

