Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCA41F462
	for <e@80x24.org>; Fri, 31 May 2019 20:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEaUXJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:23:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42943 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfEaUXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 16:23:09 -0400
Received: by mail-io1-f67.google.com with SMTP id g16so9291456iom.9
        for <git@vger.kernel.org>; Fri, 31 May 2019 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IU6Fs5EoflZPyRpNS2UvMPKQFby1iqnT4HtkP0gTyNA=;
        b=I9tqoCsdSSK1n1bV9/Z+th7O1VqfmEEmCrH/47cyc4q2C1TkaV0w2/8EiZsjWPu4GA
         8Ds4msNHr8RFk7Qa5+HzqZYO1PDMs/AKz9ot9BWZ0C1CfM9n0IMFdhSosTUIwLGW7IaG
         aJClcW5RXlyKKu+YQIE5E4n3NgRHNnf5UGR9DZh8nQ6Dc1tN3ZFPTNN2hA1a/VbVy/7D
         csiKWkAU37BN/Ifcy32ZrsbjJp/8cOy+BerYSzzbMdSs0YaxynQhECZ09F6Be152ntbj
         kwPzvcttykfnhShxeniianwROQRvDAsXQtfEsP4dgVove9GmCIVAZ7zBSPNKv1BMk1sU
         w7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IU6Fs5EoflZPyRpNS2UvMPKQFby1iqnT4HtkP0gTyNA=;
        b=Xi14WM22LuMmsDn9kpFfnWn5DfTdrMnpI68ETdVnnr0op+guc1BfmFWx6uU3ZiWdBz
         YxzranGd40Z2VEjoTwhe7WzrBXod2M6f4JDAacVOOFJNie0b24SZJernaulYWnx86HMz
         5cEGLqWJ0P8TBKJnFO4SaHz0/rMOazYUypzOMrXoCGAxc7xIV7MaG98sRuJn8gAfMNNh
         ZggqN4kkKGprQx/psINUaNP72p3dxveq1Sc2EZyxF65tW4AfYCuSaCAAGP/OqTokI0YU
         T4VJNKTMmyL/RXeNhewym3WzAq/hPp9sY++u8Hd1L5Z9qqNK1WC+EpMxWnqk0GkClex6
         OVWw==
X-Gm-Message-State: APjAAAXucz8U5bD04i9s7fBrK16sHbUgJiNTmlUREUKBXvVmyNxC2irB
        RtDtgPHj/gPjI4wIRdbfXjfR/ovq
X-Google-Smtp-Source: APXvYqxjGDaYGRazaQXVx+FO5Jq9TUkhchcEW8FqoKXajarepbSQ7OEAVHsbFQdB4hwDKSJuF+gr7w==
X-Received: by 2002:a5d:8e0c:: with SMTP id e12mr8704797iod.31.1559334188133;
        Fri, 31 May 2019 13:23:08 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id p63sm2406913iof.45.2019.05.31.13.23.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 13:23:07 -0700 (PDT)
Date:   Fri, 31 May 2019 16:23:06 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] config/alias.txt: document alias accepting non-command
 first word
Message-ID: <13d9ddd3541e3815078c4853c6f7c25cddd89126.1559333840.git.liu.denton@gmail.com>
References: <cover.1559333840.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559333840.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One can see that an alias that begins with a non-command first word,
such as `loud-rebase = -c commit.verbose=true rebase`, is permitted.
However, this isn't immediately obvious to users as alias instances
typically begin with a command.

Document the fact that an alias can begin with a non-command first word
so that users will be able to discover that this is a feature.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/alias.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 5425449a50..f241f03ebe 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -7,6 +7,14 @@ alias.*::
 	spaces, the usual shell quoting and escaping is supported.
 	A quote pair or a backslash can be used to quote them.
 +
+Note that the first word of an alias does not necessarily have to be a
+command. It can be a command-line option that will be passed into the
+invocation of `git`. In particular, this is useful when used with `-c`
+to pass in one-time configurations. For example,
+`loud-rebase = -c commit.verbose=true rebase` can be defined such that
+running `git loud-merge` would be equivalent to
+`git -c commit.verbose=true rebase`.
++
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
-- 
2.22.0.rc1.169.g49223abbf8

