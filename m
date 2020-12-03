Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D520C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 06:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFD42085B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 06:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgLCGag (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgLCGaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 01:30:35 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E53C061A4D
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 22:29:50 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w3so144972otp.13
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 22:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iEiuci42mVh4Z3Bit02ctam0M7HXEKata+u/LakY07Q=;
        b=cLkdHxe1a8wMONOzr5NGuH5/gAAcl9Od6lmfpadFFnTtE5UVSoRwBK1q4XNndHtnJx
         /zr13jiuNHX41qcun2XokjvtincEY4Td9NnPWsU+z7Xd/L3oDUgJvFkNGZVh0nSa8r1i
         2sTwP6bBZin2VwC+W77WkW71DMrbzjaZE8m8fnYcI6ZGg6il0ZAEplDsvretd3nmClrV
         PBvkfgmOJitaZJXc5l9jV/+/urlmbTM3akYbWpxrGrgXHbQP5Zg0tB7e7Vf0DWW6l7Ob
         7V19W0E/W/EnWcZuivCaYpA6pb2tYoeuj5csId6dJrNmJ8ahkBZx81+FK7eozvwX5sEj
         CCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iEiuci42mVh4Z3Bit02ctam0M7HXEKata+u/LakY07Q=;
        b=TnBzAbYjLX/CxbuuOC0KWBCY9Vlq8XDr58PdBtr8hyJTt+q4xnq8bVIS5q52UoRRw/
         S3l1023/8Wdh1I/nQNI04bOkrHKYSs/VGImUrR+6xV4j5Lw6unr2yoYplkUPTovpeaUk
         4a/BY03svgxFin/kbFaNzud/9f0kTkjST845tHNxtX6PpLOx/0IKkGkv/fAyqWmYaVSj
         IlwVGh4ptr7i7jAzcFqILH4bIhcRQry9cjxm0ydibWsnZ6RT+l0ae8jC1xrnDLwtaVNV
         Tf7k0TiC/wA/PQmqRfTsXo4zfnRYl27uFIciuVszOHr9Sscm8wgX8tH6GJXPQ6Sp4yh/
         lIIQ==
X-Gm-Message-State: AOAM532mZN6uZwxNi94XfYn+50Y6DaHl8oUX1Nxy005tU9oTTYlDVE1B
        xg7W/tYrAlQQsAd2oJlQOxXEZMZ+xtzUI0vZe4Ip/N4zZSo=
X-Google-Smtp-Source: ABdhPJxQ8a0NEhBObygJBfl3e9/srml/OBj0PtUhF8QrHY0IDhIMfxLO6vf0BYkni1ucvmS5O/VmGJObGJR3XfjyCtc=
X-Received: by 2002:a05:6830:3109:: with SMTP id b9mr1128199ots.364.1606976989261;
 Wed, 02 Dec 2020 22:29:49 -0800 (PST)
MIME-Version: 1.0
From:   Sangeeta <sangunb09@gmail.com>
Date:   Thu, 3 Dec 2020 11:59:38 +0530
Message-ID: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
Subject: [Outreachy] Blog Post Submission
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone!

I am very excited for working with Git this winter through outreachy.
I have made a blogsite that would include the progress made after
every 2 weeks(or maybe after every week).

I have added an introductory blog post regarding my journey to
becoming an outreachy intern. Do give it a read.

https://sangu09.github.io/

Thanks and regards,
Sangeeta
