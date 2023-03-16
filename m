Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC958C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCPR2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCPR2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:28:34 -0400
Received: from eostre.piobaire.co.uk (eostre.piobaire.co.uk [88.208.242.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478BBBB0A
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:28:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at piobaire.co.uk
DKIM-Filter: OpenDKIM Filter v2.11.0 eostre.piobaire.co.uk 32GHSIt5721791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piobaire.co.uk;
        s=default; t=1678987711;
        bh=TFKFJmTkzveazb0CXfinfxhotI2Usg68NH06SuZ+UCs=;
        h=From:To:Subject:Date:From;
        b=L6FM9wLXUirtoq+HyyzAV9LTRiPGXqx74d+yE2pkwc5tko3Pr3q5ci7kAo+nXEiqM
         ScoRa57H6fZPdbxOQgUat7pTRq9RhDIS3p7bBeVAfuw6kuUmYtBG2Y3xuNfMjR5yhy
         rXH4VhTwCqg1nXFKLcgSKLDx1iCy1+cL2nkN+UlDHfiOniaIzVkrNCar+Nbd/cT9iC
         WZ7EnBlTL2c90eBbCWmszP1JKgbaxrdgloZmr3pJwHwpnnrAtWDJ6pfVHpBjVwZMT5
         DcFJwEk+1JowjDbyinFFwhx8twhP2uD65Z5g7cVFnopitfFnX5CsZYr8h4HbilFfNE
         Jt1pWQr+9MBnQ==
Received: from niamh (33bba5db.skybroadband.com [51.187.165.219])
        (authenticated bits=0)
        by eostre.piobaire.co.uk (8.16.1/8.16.1) with ESMTPSA id 32GHSIt5721791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 17:28:18 GMT
From:   "Brent" <brent@piobaire.co.uk>
To:     <git@vger.kernel.org>
Subject: git-p4 issue
Date:   Thu, 16 Mar 2023 17:28:14 -0000
Message-ID: <016b01d9582c$b3ba0be0$1b2e23a0$@piobaire.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE3flvrjvmVX0RcbtGUALEXnIECIg==
Content-Language: en-gb
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I=92m having some trouble with git-p4 and wondering if anyone can =
advise. I
have tried to google the problem but as I=92m a P4 admin not a Git admin =
I=92m a
bit lost.

I can clone the P4 branch I need OK, but then when I try to run git p4 =
sync
afterwards I always get an error such as:

Doing initial import of //<snip>/<snip> =A0from revision #head into
refs/remotes/p4/master
fast-import failed: b"warning: Not updating refs/remotes/p4/master (new =
tip
fd3d39549d1d025f3657ab38c3e450d92309dfbe does not contain
0cd5897229761558ef01a6b87c702c86e9bfffd2)

Can anyone help?

Cheers

Brent

