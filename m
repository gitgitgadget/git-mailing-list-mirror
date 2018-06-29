Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA781F516
	for <e@80x24.org>; Fri, 29 Jun 2018 02:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030345AbeF2CK6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 22:10:58 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:57078 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030327AbeF2CK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 22:10:57 -0400
Received: by mail-io0-f201.google.com with SMTP id n11-v6so5686514ioa.23
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 19:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=WQr9T66FEbhK6pZCIZYM+1QV+ZGw09FGrcpqz1xdViw=;
        b=B9jCIAXjVS6VQ2GWLFXski9ezszdcpT2wWLBNetzp+AtywGQLE9XWDuD8MhNFOQuW4
         dR31UjpCxpDN2Rf9zTyvIOJjqJIHYlFpEjlgXNVJ01yqiobenObphmMdd8aq1KTSzYL3
         XeMFEr5BTIuu1CR8Bis9IyhgiS4W8rWgw80OQeLkT8Y5e2WuZT/CSRnYA5/0Ih/ExE1v
         tqz7Qf12uOpimzEGXhDldkFKPHtjiS2zUob6KButa7GoKFac2wYlCbvEbV5iuUAoD7kn
         BCQAUybr6RpHNE2jQkF1XCurMVN0dFfzj4pxGKR7XvTeJO/IpSSK/U6iQFVVKN9N7DSY
         /5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=WQr9T66FEbhK6pZCIZYM+1QV+ZGw09FGrcpqz1xdViw=;
        b=keIH361iBDOpKHfi3ipdIlGdF7RGPcrssbJ+8npyvcYGNtHo5zQJWatLtccEyvuP8c
         YgXsQgdkYai8FUsuPf06qzDNluHZx3fohUSD6JkM4oN1oP1hdgyAofBSOa5wpuf6CBlK
         WSS0DO2sRH0NQFZHo7Sxh96fyCxjKEyGy3kw2Kh7kuLiBIoaqBL/gBAP38baTKMpEW1k
         vY4kv22H7uqz6jeHDke77mFictiADWYQQED19GzdR9ZSz6u0JEgJj4wXaivv/I5nhdSx
         /s+mygg6xSf+N3G4tppiqPk+bKtYOZ9rZcjalvhmxWQyRFkM8TMKRA/WscJawPQVz0yY
         wnjA==
X-Gm-Message-State: APt69E1iAAABX3NrycoiwDvbYI21OeXB5Xq9CNHtPJtCQBJREkR/Hy8g
        ka402s8672qLHl9IOUcLw8mz4nUubrBqjrek3UHZiE4CsNLozhakY7LqszQNPB1f7V+IMq23SYD
        JiT0sbAcje8VUcQ9PHApIdKH7L+AwllulvVgKacLJseyl6NC3o7I+CHkw1fci
X-Google-Smtp-Source: AAOMgpfxrRw34AX7p8M/gWf7yRhqB6C4lkJrwiGg99RCEDaoEoeJhCsHrCINwKNL1bNWuhxNPM3+Ea7/++D8
X-Received: by 2002:a24:cf46:: with SMTP id y67-v6mr123167itf.56.1530238256438;
 Thu, 28 Jun 2018 19:10:56 -0700 (PDT)
Date:   Thu, 28 Jun 2018 19:10:49 -0700
In-Reply-To: <20180629021050.187887-1-sbeller@google.com>
Message-Id: <20180629021050.187887-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180629021050.187887-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH 2/3] .mailmap: assume Jason McMullan to be the same person
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the years of contributing to open source, I realized the world of
open source is smaller than I originally thought and a name is still
a pretty unique thing. So let's assume these two author idents are the
same person.

In 10813e0d3c7 (.mailmap: update long-lost friends with multiple defunct
addresses, 2013-08-12) we learned both their email bounce, so asking is
no option.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .mailmap | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index f165222a782..ff96ef7401f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -82,10 +82,7 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.li=
nuxdev.us.dell.com>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
 James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
-# The 2 following authors are probably the same person,
-# but both emails bounce.
-Jason McMullan <jason.mcmullan@timesys.com>
-Jason McMullan <mcmullan@netapp.com>
+Jason McMullan <jason.mcmullan@timesys.com> Jason McMullan <mcmullan@netap=
p.com>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
--=20
2.18.0.399.gad0ab374a1-goog

