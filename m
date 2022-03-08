Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19773C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 15:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiCHP7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348890AbiCHP6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 10:58:48 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8917E38
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 07:57:49 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id CDAE77E74B;
        Tue,  8 Mar 2022 10:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646755037;
        bh=zCx2flGBIpny1UFiEgIznxuJoy4t17Oh7vY6amcIy68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHHMVMX/R99+nv6fi3nQ1JmQGfocvg5z0LnFAZMsDrIV6qJmE4KxDP/Ya9E/aMCh3
         b4OK36qISrYaBzHB3b+sGGpDkkAHQ7uy6z0MJmyimRnnEnlB+oQeGN3n88Vw/HWARp
         qBRlYbP8cWk3i1rGXfxi8eJSlmfPwz6Xwlj0yXWT7WLmIVvROegMRAdPXvMXNGe+xG
         S5cKqcnrS9HLfLE0Pmtxs4MqTio+AxG2hgLoX1XEsbGauNoHZ5GY8V3UoBTMZcN2++
         eKrE8F7XrzAGIFdDzQ1azqVcvIs+Du3AcBSYPbdoIc+uxLQNG/cbpsVlu1XiPYSvo9
         O4bhiaKAqXj7g==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jason Yundt <jason@jasonyundt.email>
Subject: [PATCH v3 0/2] gitweb: remove invalid http-equiv="content-type"
Date:   Tue,  8 Mar 2022 10:56:10 -0500
Message-Id: <20220308155612.105957-1-jason@jasonyundt.email>
In-Reply-To: <20220308010711.61817-1-jason@jasonyundt.email>
References: <20220308010711.61817-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the second commit's message for more details. Compared to the second
version of this patch, this one

- removes the extra variable again,
- doesn't include a <meta charset="utf-8"/> and
- corrects a technical error in the second commit’s message.

Jason Yundt (2):
  comment: fix typo
  gitweb: remove invalid http-equiv="content-type"

 gitweb/gitweb.perl                        |  4 +---
 t/t9502-gitweb-standalone-parse-output.sh | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.35.1

