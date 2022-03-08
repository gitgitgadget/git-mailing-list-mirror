Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72EFC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 01:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiCHBJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbiCHBJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 20:09:20 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FEC3CFF2
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 17:08:23 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 0DB007F270;
        Mon,  7 Mar 2022 20:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646701702;
        bh=i0vm15Q3Ts3gZK/DKJnviQ9Z8VO/zengojWyGLPHlg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEcyuIP07lsRCdoyO8NXdzUJf2tcIsygal3pVXHBvKhzB4Z5og2tzUvvbNwbClB7F
         2xT9I9/03/UOtVVsMcURTxSKb2/hUJYq8xeysiP761d5pVNXwOZXOVUcYg/xbwA0Cb
         vsAa7pt9hn9xVWZQ16KPBLWDPbIYDdlbqp2KMBlvU2zCIba86TFQYAOLchSXuNnDmi
         h0sUstN0u3RXGmuUcN992ZGxDGL0gCKQOghHgxuQixtOl3/KEw70U4rsdoUJDBOOob
         vuudeqo8sGug1IpDHWBsvw6ToC1FyYsZRLZXeu7LBRcJJPmxhyQUNNcIlfeyxPOBzg
         2k09+c9b01usQ==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jason Yundt <jason@jasonyundt.email>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] gitweb: remove invalid http-equiv="content-type"
Date:   Mon,  7 Mar 2022 20:07:09 -0500
Message-Id: <20220308010711.61817-1-jason@jasonyundt.email>
In-Reply-To: <20220307033723.175553-1-jason@jasonyundt.email>
References: <20220307033723.175553-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the second commit's message for more details. Compared to the first
version of this patch, this one

- keeps an extra variable,
- replaces the http-equiv="content-type" tag with a charset= one, and
- removes the -i flag from grep.

Jason Yundt (2):
  comment: fix typo
  gitweb: remove invalid http-equiv="content-type"

 gitweb/gitweb.perl                        |  2 +-
 t/t9502-gitweb-standalone-parse-output.sh | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.35.1

