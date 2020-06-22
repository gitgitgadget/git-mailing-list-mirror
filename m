Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD2C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5052070E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Ij66VSkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgFVOUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgFVOUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 10:20:15 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Jun 2020 07:20:14 PDT
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C3C061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 07:20:14 -0700 (PDT)
Received: from mxback29g.mail.yandex.net (mxback29g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:329])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 559AB50E143C
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 17:13:43 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by mxback29g.mail.yandex.net (mxback/Yandex) with ESMTP id MPjBk4UFHO-DhgukMhp;
        Mon, 22 Jun 2020 17:13:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1592835223;
        bh=IY+fA30v0PiNP2HEoYjpuJ8r/zzwBtvwJkERjbM7Ies=;
        h=Subject:To:From:Date:Message-ID;
        b=Ij66VSkpmGSgSaB3/oz3czT9cRbyJFpWZ6FHgrgHTKv9EK8u/2aTioEbfh6lZjfGk
         3R/Z13MsjgN/wvinAgrPxxHlXnfFN+05YzyNZI+T+67mWAGS5r8ei50UstmEcqljdO
         xKppkR+ZcZByul1gb9DeoEFvhM0t1IYU6oeHjaMI=
Authentication-Results: mxback29g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id df1GWvabTx-DgPSC7Ak;
        Mon, 22 Jun 2020 17:13:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 22 Jun 2020 17:13:41 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <18837816.20200622171341@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Displayed information has bad formatting
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

TL;DR; To my mind the ' |/ ' should be after stat files

| = 392df7a4 Add deleting an operation type 'Payment'
| |  lib/MaitreD/Controller/Operation/Payment.pm | 6 +++++-
| |  1 file changed, 5 insertions(+), 1 deletion(-)
| < 9141de5a Implemented prow
|/  
|    lib/MaitreD.pm                                    |   3 +
|    lib/MaitreD/Controller/Operation.pm               |  55 ++++++
|    lib/MaitreD/Controller/Operation/BankStatement.pm |   7 +
|    lib/MaitreD/Controller/Operation/Payment.pm       |  55 ++++++
|    public/maitre_d/api-v1.yaml                       | 184 ++++++++++++++++++++
|    public/maitre_d/payment.html                      |  53 +++++-
|    6 files changed, 348 insertions(+), 9 deletions(-)
o e995c430 Pass lookup hash via formatterParams
   public/maitre_d/utils.js | 5 +++--
   1 file changed, 3 insertions(+), 2 deletions(-)


expected results:

| = 392df7a4 Add deleting an operation type 'Payment'
| |  lib/MaitreD/Controller/Operation/Payment.pm | 6 +++++-
| |  1 file changed, 5 insertions(+), 1 deletion(-)
| < 9141de5a Implemented prow
| |   lib/MaitreD.pm                                    |   3 +
| |   lib/MaitreD/Controller/Operation.pm               |  55 ++++++
| |   lib/MaitreD/Controller/Operation/BankStatement.pm |   7 +
| |   lib/MaitreD/Controller/Operation/Payment.pm       |  55 ++++++
| |   public/maitre_d/api-v1.yaml                       | 184 ++++++++++++++++++++
| |   public/maitre_d/payment.html                      |  53 +++++-
| |   6 files changed, 348 insertions(+), 9 deletions(-)
|/
o e995c430 Pass lookup hash via formatterParams
   public/maitre_d/utils.js | 5 +++--
   1 file changed, 3 insertions(+), 2 deletions(-)

how to reproduce:

git log --stat --graph --decorate --pretty=oneline --abbrev-commit --cherry-mark --boundary --left-right


-- 
Best regards,
Eugen Konkov

