Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B595D1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeBTNcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 08:32:42 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:46847 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBTNcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 08:32:41 -0500
Received: by mail-oi0-f43.google.com with SMTP id x12so999829oie.13
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 05:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KgRUBV2jNGajKNNgZbRAt7mmM0X1dx6r67Ehgn2VhOY=;
        b=XVv48pk1mP4L/ST9yjWElIC7DGSWXiEppNKMLzb5BMsMI1M8xvScZDYeB0394+O5xX
         QXwUNF2WubdKVel6eBkgB1DfF3z1LQ+ofujRtp1S4g0P/QiAxYRrMO6yezA0gIAK028l
         WkD4x8tmupNtXwnkicfaLNqcYUCEWVIo1SaBvdcfhBDfcIgq2uOTNiGVJGG1Yp97SbcE
         +rbs+WuXGUVVBmE94MVGTY0p+of79C0u+ilm57sS3AafR0Rdp15O+pSsZXluC9+LmkHd
         adtsjSVJF/jeXEAh29mhaILfYW9XgiDgg+0gd9Ow5ZyF/PcUWslpRkgB/wU7/F51QSi9
         t/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KgRUBV2jNGajKNNgZbRAt7mmM0X1dx6r67Ehgn2VhOY=;
        b=SfhbqNmpAW2d7A3R8Da6z3fDMIdismVIGNTMhnAMyTKAmwGy9esHIilBsVQWnqAD51
         ILBGlt3hAaMfdf23MfIVhtwhZ49yvY/ZzKbiFE/7p4jG8yayk5CBGmHUq+i0s65IFDra
         wwsfVzv2Aj1bze1Mv0cqU8M2qKz4St4wBI52DDdO+hl4hsRqsi8FkcZvAVbPv7CEUpwM
         FvFwQVW1nS1VZ2/ECLCL8r4Cy4knN2ZAHKss1URdnqLrsPSb7bfXKAr+ZNfy4nJWFxKU
         bcTR3y2eYonbQ6YnrMkg5eSz4JO1oMpK1ENTo+SUuOpb7ap3wZgdpsmTdUBZCbRC1Zv9
         KXfg==
X-Gm-Message-State: APf1xPBcgwTS59SIKnPVMsBnxV1J9M154ZcM8xMWFcbR/kk5kk+ijdTX
        umL8QUJjPXknW4zfx6cR8+O8XOWqqByD6qg7ZC25PQ==
X-Google-Smtp-Source: AH8x226CWdtPl/qmx7fnU04ujV4m1j0wF5HiLdTdrlm+qTWePI9NgpTONLIfr9aopNX/SUQkNaJxLABGA8zW9aN5dH0=
X-Received: by 10.202.242.214 with SMTP id q205mr7739243oih.255.1519133560922;
 Tue, 20 Feb 2018 05:32:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.98.4 with HTTP; Tue, 20 Feb 2018 05:32:40 -0800 (PST)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 20 Feb 2018 14:32:40 +0100
Message-ID: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
Subject: git-gui, feature request: add hotkeys to focus different widgets
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To fully use git-gui with keyboard-only, a few more hotkeys are
needed. I am missing hotkeys to change focus between the "Unstanged
Changes", "Staged Changes", diff viewer and "Commit Message" widgets.
I would like to be able to stage, browse, unstage and commit in
git-gui, all without using the mouse.

I propose that CTRL+(number) could be used as hotkeys to change the
focus between the four widgets I've mentioned.


Best regards,
Birger Skogeng Pedersen
