Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B4C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiHAVaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiHAVaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:30:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291845050
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:27:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h28so5432839pfq.11
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc;
        bh=gA9Xe7/gb6qoXM+qKaJkLna3xyGfjfPAmEsvY+c8keQ=;
        b=EyWyzbVdKo6szlGEpXCrNUcDrbypbYUSndmWaXqvkBCZnF78OlNvrTTHZ3qOcY325q
         /BMP9jJ0kDxQJ6qtqyGcfE3qkroyDDMw+eP4wIa/QvGKDXwLmFKVzUmlsYEfv9kwAJtZ
         qsBkmHvGiNrvsYupYG0qoCXsA5Q1AEQshjYO9DsjC3JgMZLXTUrkJZ2wdBGEKgm7Z17+
         DIu9ghsAoixTEWX5gRdt9FjczCAKfkbL3rpK6XUoxjd65YziaoDnD0QplszONxtEgkhW
         7FH8SQX9/E8OYMxHBk9Z7JYuTZPtJleI3MsigHYXF15O4Ha2kQfhLrScsXsIiyoCTppR
         6XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=gA9Xe7/gb6qoXM+qKaJkLna3xyGfjfPAmEsvY+c8keQ=;
        b=t/MIv2NqOLUjhJMTmHvRnuw7ES5T5O09wU0gbSfH1zTDyN4EQ/tbfeQBZ2l9MBkHpY
         3z0c3HlMf38q5SqghDGlRTmygOr4KZQkd0FExJaC5kr2t01eC/lw1iH/pJTSzri/ex/H
         YeWCqLkoRIVVeF/Zgn8eWzGiPXQDxvuhLdwOXzBuBK/fPAH0bxxUqRCpNVddHKWLfrGl
         ZgZW0Q05tk39Xru2AIoVGeUt+1x1+/cJzrfWLblc9q0O1+pHnf7z5+WuFCKuz/l6ikr9
         +imMKIZs+7GAsuFm63+0akrtBiNVDuBzxO5YIe7bqquI/GijkRsnd6RBUD2vVkv+L+f5
         DGrA==
X-Gm-Message-State: ACgBeo1HDJKuPVPstGXHyX3RkvJkdeNl0mYflDMOLoKugBHGNuOt2+1m
        /4tKrOQXp3Zp9BrASwjWLkUwUGHEF65PBQ==
X-Google-Smtp-Source: AA6agR5WlctXFiNzFjhreVoVppFLXQYRHUnNbW+m67hTDKGDdsjc+vJ1Y/nhW8anL6ABLA0WvhDjBA==
X-Received: by 2002:a63:9041:0:b0:41c:2111:4fd3 with SMTP id a62-20020a639041000000b0041c21114fd3mr5220720pge.73.1659389256453;
        Mon, 01 Aug 2022 14:27:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:35f6:95c4:4aad:4cdc])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b0016d2db82962sm10125357plk.16.2022.08.01.14.27.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:27:34 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:27:27 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Subject: Seeking Review Club nominations
Message-ID: <YuhFP77WE0faN9K7@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm looking for candidate series for Review Club[1] for this week (Wed
Aug 3). An ideal series would be around 4-10 patches (depending on
complexity) and would be in need of reviewer attention. Please feel free
to contact me with your suggestions off-list. Also, let me know if you'd
like an invite to the event.

Thanks,
Josh


[1]: https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
