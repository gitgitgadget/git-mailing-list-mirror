Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4BC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15E160E0C
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 03:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhJMDbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 23:31:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55070 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhJMDa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 23:30:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DB72E9E56;
        Tue, 12 Oct 2021 23:28:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=sasl; bh=l8AtHuuvqyPzpSX8MdaBVW3aC
        2dQIHGXph2dq0P76Z4=; b=jwqfK+wOnTYWkTv++YbH2UDjCzSL+ETHdXUJ7gUCF
        CO7cIieB8RM4rWsSJiYyn58SBQ4Nj5ClZ/niS58/MIhUq7vaamhbkQKqefnC6+eO
        82ifzvd3G4jjd7YivzqjX4Uxn0cfqp+m6p2kbfx9X6sN4CS2KPfZlJLf9uCUb4/U
        fI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 552A4E9E55;
        Tue, 12 Oct 2021 23:28:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.teonanacatl.net (unknown [71.254.192.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9FEAE9E54;
        Tue, 12 Oct 2021 23:28:53 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: add bundle-format to TECH_DOCS
Date:   Tue, 12 Oct 2021 23:28:52 -0400
Message-Id: <20211013032852.959985-1-tmz@pobox.com>
X-Mailer: git-send-email 2.33.1
Reply-To: xmqqczo922vm.fsf@gitster.g
MIME-Version: 1.0
X-Pobox-Relay-ID: B0F8B728-2BD5-11EC-9F55-62A2C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A link to the bundle-format was added in 5c8273d57c (bundle doc: rewrite
the "DESCRIPTION" section, 2021-07-31).

Ensure `technical/bundle-format.html` is created to avoid a broken link
in `git-bundle.html`.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Hi,

While building 2.33.1, I noticed the link to technical/bundle-format in
git-bundle(1) was broken.

 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767..2021568cd5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -90,6 +90,7 @@ SP_ARTICLES +=3D $(API_DOCS)
 TECH_DOCS +=3D MyFirstContribution
 TECH_DOCS +=3D MyFirstObjectWalk
 TECH_DOCS +=3D SubmittingPatches
+TECH_DOCS +=3D technical/bundle-format
 TECH_DOCS +=3D technical/hash-function-transition
 TECH_DOCS +=3D technical/http-protocol
 TECH_DOCS +=3D technical/index-format

--=20
Todd

(My apologies for dropping offline after sending a small patch a few
months back.)
