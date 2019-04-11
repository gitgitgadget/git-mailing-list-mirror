Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA2620248
	for <e@80x24.org>; Thu, 11 Apr 2019 01:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfDKBNB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 21:13:01 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:53639 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKBNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 21:13:00 -0400
Date:   Thu, 11 Apr 2019 01:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1554945178;
        bh=BDjsWPYttEdKAWd7qHosQl6T3AW7bRK8jf3G9CLSjSI=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=lXjpoFybqvw7+nwEq7TJMDHBDpBVy94RxJ9UvVviUUMnLGTcN1h5XLIA10sxNhFzm
         T1nufraBVi7tiyaap9QH9jSHJHZMt6amJ9ErMKsLpKhjSapPWkcrO1BaGyX7GZmHcc
         JNZQ18ctAJr4yNmjWy/TNuxiFNt/wGG3l3jEppwY=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   ron <ronazek@protonmail.com>
Reply-To: ron <ronazek@protonmail.com>
Subject: Git merge should report an actual syntax error when a semicolon is used instead of space for specifying multiple branches
Message-ID: <fQ_n3UAoz-yQ8MMCgPLhVDqkMCqpXQ2Dk34IZgksKIQ1B3Sig_T70nPI5mI0z9z2A5ZLdk5ooUYnAJelV-7eMNrnCr4V73Rz87pP1arR8WA=@protonmail.com>
Feedback-ID: RMis9b9KHKlvsb8KKkeurfBt3UTu5TN-1L1t5jXjkqXfFdr8BIyQs5Ws7O_ywm8jXx2U-EI3XDzu_Y-JlzMpfw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First time reporting a bug :) or at least what I think it may be.

There's a few similar cases I think I've seen in the past, but the one I'm =
sure about is the semicolon instead of space between multiple branches, tha=
t should be a syntax error if git merge can't accept that command .. if the=
 people I spoke with are correct; However, git merge reports it as "not som=
ething we can merge" implying that it suppose to be valid syntax and that i=
t's just not allowed function or that it may be temporairly not possible du=
e to a circumstance (a secondary condition), as if I was mistyping the name=
 of the branch or something, but if it never accepts anything with a semico=
lon it ought to be a syntax error, IMO.
And it may not be uncommon since it comes from the fact that git merge norm=
ally follows git fetch where semicolon is supported as per normal.

Ron

Sent with ProtonMail Secure Email.
