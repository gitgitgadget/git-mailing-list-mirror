Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074BC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 23:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C7920758
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 23:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="CgORGy+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSXGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:06:08 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:60958 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSXGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 19:06:08 -0400
Date:   Wed, 19 Aug 2020 23:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1597878366;
        bh=zxHd+7F9oaIIFHzG2NymY7eTjXxHIAKZBNZsBFKnpVc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=CgORGy+layehmCtp9mGOffltWL7LlVyQag1gQamWDtChaMDdSLP/yG0CtePeDJ3tC
         XAI3+4CMSq+X9UkzufI4fM1lCDfRxsuLE/5bRUv+1cyb83Kf7jTgku7LBqjd8WwerR
         GESV/0qggetnLdD5nPruSHpfW86q7P9wEJgZJcCA=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Junio C Hamano <gitster@pobox.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [PATCH v2 0/2] Support enabling bash completion of all options
Message-ID: <20200819230523.773348-1-rtzoeller@rtzoeller.com>
In-Reply-To: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix style guide violations and issue with '--no-' options.

Ryan Zoeller (2):
  parse-options: add --git-completion-helper-all
  completion: add GIT_COMPLETION_SHOW_ALL env var

 contrib/completion/git-completion.bash | 14 +++++++++++++-
 parse-options.c                        | 26 +++++++++++++++++---------
 2 files changed, 30 insertions(+), 10 deletions(-)

--=20
2.28.0.260.g5934a15c94


