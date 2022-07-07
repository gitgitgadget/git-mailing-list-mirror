Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DCC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 15:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiGGPf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiGGPfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 11:35:54 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63F26575
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 08:35:54 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so14284632otk.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=l/ogfIpWQOVjEn7TUGuZcsYooIk4ZJcpNMwstd+EGss=;
        b=pjACmt7mhaPVnkAaRLhCIUrHY/ewulcbNeZtHezgwAT2h8vjsFeqXv90mKeS+56Tx+
         /rdVE1n2qfppviW2YhbPaGqFGO8z/8JbD0DN7t/cpg8gfPkZybP81vQvFGf3SrusRZcu
         z9z2GkANsqwnuQcG2Zk95am9YHbUw4Mm4HjeWdJfANiGyq2mbwjWrXY0yw3Fsca/1nY7
         gjIzHNjONa1h6splXvuwMcf3M9/3ezABa8fYphVjC3q016xh7ZyWnMdzutXE7nxUQisu
         nhMk/sprA4+xVxp+ZwxKAoVyiuoJDQUcHjKwLipS7qEJJKV/pVFcPOL5GQVTiCRgcaff
         RnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l/ogfIpWQOVjEn7TUGuZcsYooIk4ZJcpNMwstd+EGss=;
        b=Ih3AkmF3n5NyvGM9FYYykbsGwh8auCLN0gYrAB01+BUOovAluYnsD7xpEKyEK6XEnJ
         xs/knP6F1IROXAV37GaI25UfBtk4iWmSM/gaWXdju+VN0FJ3XJiO9c+Ta2EKMXGIHxYb
         vfQFe8iyEEtqqsuzjqQOXIXhj2heWGHyHpltq69uE1AqZk2T4m5llwTfTAnWc2RApnHn
         +iVON4MZI3oAD0UpJxxr15yXK3d2GYFmKSeHCcQ9rtb6EE9YTaMLK786KxK0bHlbGUfO
         t4O8cvTfQ5o4OYFBM+B9O9I7YjrPb3odB3hHkvLM8FlGDQ887O+YN2RF5n4POwleWiht
         D9VA==
X-Gm-Message-State: AJIora/JTK/aUs6twic/tCwI9p2kDJbBmNb9N777IpLj5IMnO18dTUzj
        r1zUc0J2NAHqn3GgFndNhJz+lnm6Ww4yGEwe5YIPaFT551g=
X-Google-Smtp-Source: AGRyM1tcwnT/q6RWOZEvsh5PUrfuzlrgN2rrVcAPK7foHRVAag7WwTZmZKl0fW59re9bef7hHxdEY99qTR2lvx2I1vM=
X-Received: by 2002:a9d:6c04:0:b0:616:e2c1:4a57 with SMTP id
 f4-20020a9d6c04000000b00616e2c14a57mr20917927otq.190.1657208153649; Thu, 07
 Jul 2022 08:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>
Date:   Thu, 7 Jul 2022 17:35:41 +0200
Message-ID: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
Subject: Suggestion to rename "blame" of the "git blame" command to something
 more neutral
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the change of the default branch name from "master" to
"main" to use a word which has less negative associations,
I suggest to replace the word "blame" with something more neutral.
Maybe "annotate". That word seems to already be used at some places
for this Git feature.

Best regards
Jonas
