Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694AF1F453
	for <e@80x24.org>; Sun, 11 Nov 2018 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeKKKHx (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 05:07:53 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42027 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeKKKHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 05:07:53 -0500
Received: by mail-lf1-f44.google.com with SMTP id l10so196726lfh.9
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qcDyww+fopNwa268fkCsLJMByyOmZxnRyaTgyX9y7YI=;
        b=k3o/Ha/xyfpknizyuPvQdzPyEPftLG9g1NhIRkYFs/IpOu/F5UUQ/PhfKR4yu1ORaJ
         06zNwDvPo3jS/9Y2EcydU56uomzBFOITRLgCj2zb1mWid+IVvOctoOjmPu0IL+I3WeQY
         kdpKPMpaYjrY+JED7uadlUOvrrY6BHmYrx6vIlj/8wbx6eUqlmzT5YCEHFKYnTE20wa9
         e8pHeg/Zj9zdzV7P0XcR86OgBnMc6ZcKLJJ9e58BxqsZ5TOZpW2zNeddWkI9scgfonOy
         W7WzaSN+z7t1q30miYwvCOFllYIXxrkr2J/YbzpiEjJ4oX8Z1JIY6HZyQT/W/ePZaavI
         FS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qcDyww+fopNwa268fkCsLJMByyOmZxnRyaTgyX9y7YI=;
        b=XBW9cNfii0WDvBCqd1/t1NhiIAHqgxcBlrqkTxqlXv2z0TGvV0Gax5/lDER7FqAQ0U
         VcgBRkHtpV1P253/ChsHgP0gFWdMCNEmk+MHEl0MVzm3A4rLHeqwxdktc1LCrlLnwrCN
         I1cpmtTvf8/bcodjfPHhBC4Ie719ct+uDyavK1MVgni/uZnR2p8cYxLasLfxy1ndFsbM
         qgfuOVGYDR1kAfZWdWtcUgNdrkRVP2FA1Rt6d6+ss6V89W1oMi2XnLIWdENn2hxFBLUO
         KIY6ugAe5bLWQZqlR7lH7EK3UB3bKZGT431SnWPsIv08ZOy9cWGQB+EBovTbuQYlOU7s
         vNfg==
X-Gm-Message-State: AGRZ1gJ40TFzihN329J+yoV+XwGtj6qST+QpKBdq/BhFK3KdDwK4tgAD
        e/JJ1QnasndixOyvo6pmZfcCE1TOdQzKtGkvMTvdFM31
X-Google-Smtp-Source: AJdET5dtj9miOUPLv6vkVGZWTfENbXg7GPAJYJtedb/N4Xm/Sm8JSVMDXvtMtyqC3F9W17wKxUJWZGRy40K7v04NVo0=
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr8489846lfi.57.1541895663724;
 Sat, 10 Nov 2018 16:21:03 -0800 (PST)
MIME-Version: 1.0
From:   Fredi Fowler <inredikawb@gmail.com>
Date:   Sun, 11 Nov 2018 03:20:53 +0300
Message-ID: <CAEv5rCuQM_6ch3KX1ji9nY0hW9eFVomO3svg79D67PqR1uY1tg@mail.gmail.com>
Subject: Git Reference Manual enhance
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any way to create pull request to git man (https://git-scm.com/doc=
s)?

I found there some inconsistencies. For example, almost in all pages
are using [no-], but at https://git-scm.com/docs/git-merge each
command (with [no-] or without) write separately.

There are some same inconsistencies that a easy to fix. So, if I can
sent a pull-request for such fix =E2=80=93 inform me.
