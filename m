Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369DC1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966389AbcIYOnG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:43:06 -0400
Received: from [195.159.176.226] ([195.159.176.226]:53117 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S966241AbcIYOnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:43:05 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1boAdn-0005eC-RC
        for git@vger.kernel.org; Sun, 25 Sep 2016 16:42:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: git-pack-objects(1): --honor-pack-keep
Date:   Sun, 25 Sep 2016 14:42:41 +0000 (UTC)
Message-ID: <ns8np1$gmi$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

the option `--honor-pack-keep` is not mentioned in the `SYNOPSIS` of
`git-pack-objects(1)` (`Documentation/git-pack-objects.txt`), only below
in the `OPTIONS`.

The same story with `--include-tag`, `--window-memory`,
`--max-pack-size`, `--no-reuse-object`, `--compression`, `--thin`,
`--threads`, and `--index-version`.

Is it a mistake, or different options should be treated differently,
like, often used vs. seldom used? But as far as I can see,
`--honor-pack-keep` is used pretty often by `git gc`.

PS The `--non-empty` block is indented with whitespaces, should it be
corrected?

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

