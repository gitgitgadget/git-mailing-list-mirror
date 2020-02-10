Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38915C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D36C2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 21:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJVCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:02:06 -0500
Received: from unsecure-smtp.soverin.net ([94.130.159.241]:40918 "EHLO
        g02sm02.soverin.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727434AbgBJVCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 16:02:05 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 16:02:05 EST
Received: from soverin.net by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Subject: URL rewrites for submodules
Date:   Mon, 10 Feb 2020 21:56:28 +0100
Message-ID: <87wo8ucgar.fsf@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently learned about rewriting URLs. Pretty cool feature. Learned
about it here:
https://jonhnnyweslley.net/blog/how-to-rewrite-git-urls-to-clone-faster-and-push-safer/ 

But I've been doing some testing, and this feature does not seem to work
for git submodules. Is it like that by design, so are there technical or
practical limitation why we would not like to have this feature on
submodules too?

If it's not by design, would you consider a contribution adding this
feature? What should I then pay attention at? For example, should there
be an option to enable/disable it for submodules, something like:

[url "http://new.url.example.com"]
     insteadOf = "old.url.example.com"
     submodules = true


--
Toon
