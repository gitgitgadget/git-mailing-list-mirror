Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5011FC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CAA61051
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBTK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:10:57 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:46040 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBTK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:10:56 -0400
Date:   Mon, 02 Aug 2021 19:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627931443;
        bh=qmWe51Imzj9QLfAknMAz02QtzOZQO5csHN+RnTKTSKY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=scJAr3QFb8kHjNdqf2usglOfZ+qlzwiVpzhzeIlG5NLCYDRrsMoJOfAr/DRwWDd1q
         VbJvbHnHQYTI/CXosQiExPN3YsBut7ALwPv6dW8ZBfk5HR0/I5Aky4k4/vFIPam/gQ
         ReeN/06lpCAiDIH5BytEWDFYfpfxeuh0ZYDUEIVQ=
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [Outreachy] MR !2142 ready for your review
Message-ID: <PkIdX0WoFwWKlUzrPN3IZuZAnpycULPcOqXqcjLMW8Sz846YUJhoG5iZs8ygyS2Bm7RbW7eDeV3AEDJfGO5eUkdv0gJWHpJg17XDOdYZd_U=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wireshark,

Following up on the awesome Outreachy internship last fall/winter and the #=
17093 issue, the Git team has reviewed the MR !2142 [1] and we think it's r=
eady for Wireshark's review.

It's a single test case added to `suite_dis=E2=80=8Esection.py` to check fo=
r the Git protocol.

All your feedback very much welcome,
Joey

[1] gitlab.com/wireshark/wireshark/-/merge_requests/2142
