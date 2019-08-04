Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235D51F731
	for <e@80x24.org>; Sun,  4 Aug 2019 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHDQNo (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 12:13:44 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46471 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfHDQNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 12:13:44 -0400
Received: by mail-pg1-f169.google.com with SMTP id w3so1208241pgt.13
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:message-id:mime-version;
        bh=3j/9V9Eg1plAFYvxbf9RMdDGjG5SzBUPGz0CvP/VKnU=;
        b=XAJ27f6uvn/IRb7EtmfTToYjPFhmYpNjSfXcCaKyUJx/aA1yRlK+9en8pUg1yoS/dY
         WGCylcna38MkgrsSS9SdS6oaBUcrCKm/03JmZrdLsS4MCZMKIM0jR4r4w2ArMYah3r7N
         aCOj1efBGtCqOCReh4NZ+QHuseJjAI1EtAWFf0oUpuOUGm48zb5KC6ZIuI+PYxWH0CPG
         ScHc0mxcK9HyRrSP91MbQT6gYkV6q2353VcPM305GI6hDW8cL6a/PjE93Fdga7W0VJmD
         odWQmcRukH3wocE0cq3Jl0InPqv7btqtm41qqwHKJOFkz0ORopPU0RyCAg+OhC/Kc/aw
         +OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:message-id:mime-version;
        bh=3j/9V9Eg1plAFYvxbf9RMdDGjG5SzBUPGz0CvP/VKnU=;
        b=rpVxkS9lfKwX/Vwy6FdbSdMXvWHdVifGa97P41we6uruk19nyzm/E/yg17II8N+ccM
         GGfl+MFpeM92ovk6Yr3ODzua0ooBRmpHpgtKZjH9xMs76NGERTQJtQQsmYblZGKIYmnP
         GCW7URemKTkLmDhl283ZyxlBrbUeYDVH68jQPfvF5NjkSNrVm67SYTiBaQyvHzH/tyUY
         u4zpgiXh/JQY2SnRfQb9i7hBmOJuSAsfK28RJVNfEF+LZxnvmYM4fY1RurLxV5PUxA+9
         y6Jc1BeeOPHphAJl9m46glEuqrgC+s5cmfX/97HSeHS9SUgovNrj3bi2owhncGTl04b0
         hMpA==
X-Gm-Message-State: APjAAAWehSoTLg37/s6segyN2F5JCDUAOVr4ZEu4jb6Eww54/sh3xkyw
        OXvF6gp2ghbWVaZQX8XE5hfNo0VJQbs=
X-Google-Smtp-Source: APXvYqwIUDKXHJDTIz07srVYdLbOjv1RDZjzhg9feMoU7XuVvKn6WylLh0LuDYWCmO4OHZiXLyhZ7w==
X-Received: by 2002:a63:f048:: with SMTP id s8mr103546849pgj.26.1564935223019;
        Sun, 04 Aug 2019 09:13:43 -0700 (PDT)
Received: from [192.168.1.34] (c-24-130-165-243.hsd1.ca.comcast.net. [24.130.165.243])
        by smtp.gmail.com with ESMTPSA id f19sm118344299pfk.180.2019.08.04.09.13.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 09:13:42 -0700 (PDT)
Date:   Sun, 04 Aug 2019 10:13:36 -0700
From:   johnywhy@gmail.com
Subject: Default Clone Dir?
To:     git@vger.kernel.org
Message-Id: <1564938816.2622.1@gmail.com>
X-Mailer: geary/3.32.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,
Is there a way to set default clone destination directory on linux?
Currently, seems to clone to the active dir.
-thx!


