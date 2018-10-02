Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6EB1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJBQJG (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 12:09:06 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36339 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJBQJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:05 -0400
Received: by mail-ed1-f53.google.com with SMTP id f4-v6so1442591edq.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZfhHrHm8fiWgB43eb/4Jdt6RED9JjemYHk6AznpDQxA=;
        b=AnkfN5bTuiAudxKncfcos/L/o3JmJVmQz0spOYmvixawwUAvICOMQQPoWo5N8H3i+C
         tPZalvnHt0UaiMxH5t6WzN1AjHU9ZtsVN+Q+TWSHQUboE01Bua8t/NjZfzHKtvm6kssD
         whWpm4Kuj8t9Hc9/VevEPbW2Bf7ZSgSi65aJsWf3N3ToAJpTUJppaDgfKjjAr5NCORan
         88zoEifRJRJVSM9X4UQn/lqgxwtVxoAKsaDcuDfza5ISZW7pBU0fG/QsE/EhG7KhCm1M
         zn/TNWkFDSeyigREK5XwDy3+GWDZ4eIPBetEh7SBT5zfw5Jm3obGnQhvJb7AqlSRGAnn
         L8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZfhHrHm8fiWgB43eb/4Jdt6RED9JjemYHk6AznpDQxA=;
        b=ECAwCoxKq9ilPw5ZO5Tt0zK6do+HcxmWPVtrN3C1omUzzabvA4pjBSIulb8/nhlEaZ
         yazc0TO0Kf3J2I3kFtdpt7sLvh/qUGrbaIsY2KRf3UM8lOlZx86NYEVy1Z1B9zuh6Zzm
         fisseuxI2bRbZNvyHf6WWZl64CUoxjkJVNMkF22LtH93/GPjdBmul95mDoQmiN75p5+G
         SspW/viouAe5ZmrqwpvBlukiKtC4sjVoVfBXuWs7TTrGBBTSGUzM/Y787VLTpQqhwZhp
         pIzlb7gA1WXNHXPo5A/Yx0jn1yvLcxEPXLJ9h2exSUfsUFfqD4lC9Smha2UjKzTObO/U
         WYMg==
X-Gm-Message-State: ABuFfogBhSthU7A9Jx2PhrDTuzH9FbR5TvYUCtpeOf6pruSawIfb9hO9
        qBXjmRyCt+GMAjw+uO2DSO+UMc8OqtBZfqWSSk/reQ==
X-Google-Smtp-Source: ACcGV63KZgL8DZLT90W86+uC/A7fcw1Yk/7tf5m9FoUB7ZD0uOcJ9vIq+WxPE+6fL6F2Gj9+Vac1XlNmU8751jiZ+Zo=
X-Received: by 2002:a17:906:5a43:: with SMTP id l3-v6mr2026689ejs.43.1538472406072;
 Tue, 02 Oct 2018 02:26:46 -0700 (PDT)
MIME-Version: 1.0
From:   Jayesh Badwaik <badwaik.jayesh@gmail.com>
Date:   Tue, 2 Oct 2018 11:26:19 +0200
Message-ID: <CAGiqTF47fu85XCFnEbfMEF96v6U=N_Ferr56qAji4eLuBpyxjg@mail.gmail.com>
Subject: Display a commit in red if it is not signed.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way to create git pretty format that sets the color to one
color (say red) only when the commit is unsigned or the signature
cannot be verified?

Thank you

-- 
Cheers
Jayesh Badwaik
https://jayeshbadwaik.gitlab.io
