Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E51C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 22:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiGNWGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiGNWGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 18:06:39 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BD6A9D1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:06:39 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id p81so2592539iod.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :reply-to:content-language:from:subject:content-transfer-encoding;
        bh=jdY3TnQA4nw4REEOosabPy+dPLJAAl3DtGGvPl5iOZQ=;
        b=afnNLnf8G9JZLhj6eWsY0Ig3Z8aFqk5htAhJ2Na3MaDJxQ1RzLEE3rTv/yee/iFVyY
         FVQyvFmwCPR6n4LvvACN2IY8NPCOq9+GgG6+0zGWtJfkTwUU0S1lYiuxXxdTjXORT+Y7
         eF85rGiiWGZshcaFzVtl1OFkHf0ITWdImLwSfbE2F+2V1o6rGypKo+rzPn1RWOXQk6Yk
         wFHu1guURJmIYkdeZMX8im8gAY9l5Wu8lL7Q1RGZY/mmn3RofIMDqNDOy1MeIK1GBkFE
         s9aj7IRqk7WNReqSF/5iM2twwbkDhZXq2O5Wp4eLWdrlRUwBRDkqt09Do4kXeUALn9KS
         CK9A==
X-Gm-Message-State: AJIora8z6G6xxUTpYTY3XdlKNxeSD0fqkBCnnIJqmxoWd2o7qiPAYyMb
        dIPLVo8cgy/Vh2ISwkvCHtm0oXyWooo=
X-Google-Smtp-Source: AGRyM1sxWVib/EkqYrSP3IjpjMN7TVll4vic6K7W80+L3hNztGP03fc5vzY+yvLTq+H8DGrLJwZbQQ==
X-Received: by 2002:a5e:c807:0:b0:67b:8403:458f with SMTP id y7-20020a5ec807000000b0067b8403458fmr5517150iol.3.1657836397997;
        Thu, 14 Jul 2022 15:06:37 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id d68-20020a026247000000b0033f3c03a59asm1202131jac.42.2022.07.14.15.06.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 15:06:37 -0700 (PDT)
Message-ID: <2e592944-edb8-2d49-981a-8ad220f97e82@kinzelman.com>
Date:   Thu, 14 Jul 2022 16:06:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     git@vger.kernel.org
Reply-To: paul@kinzelman.com
Content-Language: en-US
From:   Paul Kinzelman <paul@kinzelman.com>
Subject: moving a repository question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I barely qualify as a novice on git, so my apologies in advance if this is a
stupid question.

Is everything that git needs stored in the .git tree?

In understanding the big picture...
Is there any reason I can't just move or copy the entire .git tree
someplace else if I wanted to move or make a copy?

I realize about the clone command, but wouldn't just a straight
copy be easier (in the vanilla case where no branches or anything
complicate things)?
TIA!
-Paul Kinzelman

