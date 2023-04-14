Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844BC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDNMCW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 14 Apr 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNMCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:02:21 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 05:02:20 PDT
Received: from kautler.net (kautler.net [85.214.242.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CE13A
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:02:20 -0700 (PDT)
Received: from mail-oi1-f180.google.com ([209.85.167.180])
        by Masters-of-Disaster.de with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1pnI8A-0006CD-Ln
        for git@vger.kernel.org; Fri, 14 Apr 2023 14:02:18 +0200
Received: by mail-oi1-f180.google.com with SMTP id x22so331457oiv.10
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:02:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9frXoiMwFdr/WDDcog6wMWUvAjTegDCI/qkO2tyieTrXDFxVZzN
        puycG3LOYSNYBWFAIYtlgx3ykiCaRE+9KphgErA=
X-Google-Smtp-Source: AKy350Z8V6hDja4NXIxR5ppm5HA/MlXTD3e3T9X9H6enLsy3sHvmXlt+JhIvG4J8R2ajh4XnPe57BwpLB6vAgAzVPbQ=
X-Received: by 2002:a05:6808:b31:b0:389:2b9b:fe5f with SMTP id
 t17-20020a0568080b3100b003892b9bfe5fmr1279018oij.8.1681473732094; Fri, 14 Apr
 2023 05:02:12 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Fri, 14 Apr 2023 14:02:00 +0200
X-Gmail-Original-Message-ID: <CAKChYSr-ry2ewX7YkC9k9H8LrkHoSonx5Mcmz+n5OyxinH6t1g@mail.gmail.com>
Message-ID: <CAKChYSr-ry2ewX7YkC9k9H8LrkHoSonx5Mcmz+n5OyxinH6t1g@mail.gmail.com>
Subject: pathspec completion missing in Bash completion
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

if you use bash completion, pathspecs are not completed with existing
paths with 2.40.0.
So if you for example do `git add -- :^<TAB><TAB>` or `git add --
:^a<TAB><TAB>` you do not get any suggestions, though it would make
sense to complete the paths there.

Regards
Björn
