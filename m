Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A8C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 01:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiECBNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 21:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiECBNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 21:13:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54B45AC5
        for <git@vger.kernel.org>; Mon,  2 May 2022 18:09:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61A7410A816;
        Mon,  2 May 2022 20:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=PwrOlGJnnPol/ffiFQ/TDn8myeh67DkOIOl25Gn/Cp4=; b=IM+jhStlod0O
        IKff+QEuwYhWQvBnlAGt5euYiLC/DDaKafQTU3mNU765ecEHJOQPUI9ijoGIFqWP
        5RdIyBdBbs/s3lwG8wPlJR18n+42ZOYINYeD8dp1YK3WAvPNFfLE8OXDCKHJmm2M
        Iwwn+bIAWTurGKymDWfAmra5c4obVRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F5D10A814;
        Mon,  2 May 2022 20:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8BF510A810;
        Mon,  2 May 2022 20:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] proto-v2 doc: mark-up fix
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Mon, 02 May 2022 17:58:55 -0700
Message-ID: <xmqqczgvsa7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35B93880-CA7C-11EC-8F06-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some reason, the 'object-format' command was surrounded by extra
spaces with extra underline to match.

Noticed when "git grep '^object-format'" did not find this line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/protocol-v2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/technical/protocol-v2.txt w/Documentation/technical/protocol-v2.txt
index 8a877d27e2..c5051e4d29 100644
--- c/Documentation/technical/protocol-v2.txt
+++ w/Documentation/technical/protocol-v2.txt
@@ -514,8 +514,8 @@ a request.
 
 The provided options must not contain a NUL or LF character.
 
- object-format
-~~~~~~~~~~~~~~~
+object-format
+~~~~~~~~~~~~~
 
 The server can advertise the `object-format` capability with a value `X` (in the
 form `object-format=X`) to notify the client that the server is able to deal
