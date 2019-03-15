Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4224E20248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCOPCK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:02:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38700 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfCOPCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:02:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so6535480pfn.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNNM0IkeKznLgd1fGpaj/U4KWCio4ZNJvfMp1UEzMAc=;
        b=qDcxDh1+9KkpWxBol/tBkKXAlBLQtokN/Yy6wAJxX2B1doFdfSoZJ1rpnleg0jYXnQ
         7OjOo2UNa1l/kNdJQnSsBpcKavpFd4TO3STyVHoRF0/Auvpt21by5kUGiiCaQmaRKKXi
         RNWaA/wTKo+kH0O8m7BfBvdsrUNE61hzzjo/Qbt7p0HsTzbhgxAo6mCeHXbPf2fh0nNF
         RSm6Py8FQWR5ddaqJU9svTglMoRQaojcIi4Jc5v9kdEH/tDtkJ7l0tVgDPYhuPWlQNPp
         RyIcLvQTZ9crl+QndGSmWaxtGj2WdlBBnQNvKpNB+uus4cB0Zpu80iFDjW3sq8Ful0v6
         V91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNNM0IkeKznLgd1fGpaj/U4KWCio4ZNJvfMp1UEzMAc=;
        b=V4AtZb65ZYNZp0eRHqbUqLH/9sIQ4Gum5auho67+JQt2BlWaA+K8bpD4zASqYAlubg
         BmDF7ahyUeShFTUWsf3F4WYVmZ5sDwSTvOFpI6ZKcICclJ6NcKx6GGU5Gf6cDeiaGqrW
         BAtBsgv7/if0jxOk11o/MTtQztJGf3bVOoaJsqdDFnzw7h1c2pVdTOJCV7KceyjMS3TW
         ChKS8J3Wzimox12zp2sBCv8Q7HQVt3O34bMpFSfvJpr66I10+bnCoKtN36z1lz68U8Ac
         GgvvfDjzOSHgUHAByknSDiSaoLRQVkn0YeCsSd/GStqIDmJU3XB9MAWe5spFU2hVhA20
         ozCQ==
X-Gm-Message-State: APjAAAVwASHICaffFhuqFYN3E9iXB7MLRmCn57NhNVwv5XUImGST2/Gj
        uof45H1bCc3NB3kNKUCcwUd651LNWpc=
X-Google-Smtp-Source: APXvYqzpvkoPsStOZ0Aglijy+68ibYc+8RFS3JqBF7l39ToE5LB88LreLdkbj77cYCADKZh1xU4a3Q==
X-Received: by 2002:a63:2c8b:: with SMTP id s133mr3832211pgs.448.1552662125532;
        Fri, 15 Mar 2019 08:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:148c:681c:2e1:391b:7734:229a])
        by smtp.gmail.com with ESMTPSA id v186sm4062333pfv.184.2019.03.15.08.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 08:02:04 -0700 (PDT)
From:   jkapil.cs@gmail.com
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, alban.gruin@gmail.com, avarab@gmail.com,
        Kapil <jkapil.cs@gmail.com>
Subject: [GSoC][RFC/PATCH 0/1]
Date:   Fri, 15 Mar 2019 20:31:41 +0530
Message-Id: <20190315150142.20672-1-jkapil.cs@gmail.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kapil <jkapil.cs@gmail.com>


Kapil (1):
  userdiff - support shell script

 t/t4018-diff-funcname.sh | 1 +
 t/t4034-diff-words.sh    | 1 +
 userdiff.c               | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.14.2

