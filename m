Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A8A2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdKUXFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:05:46 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36022 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdKUXFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:05:45 -0500
Received: by mail-lf0-f68.google.com with SMTP id k66so16071155lfg.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TQe928QygVgKBUwLTLK8qu8mKL2BBTte6If1XZZmkOM=;
        b=RZXNygWKwNm3xEwsA7tCvfdhs1DrCQ/MgZZa+qoLkPyUHn1PP2g4gk/5ufMEiWSAxm
         01x8vFl+1wMLLDGQYnzXefGCohtMeXfM3ctix1AIuAJMPGBkPMe9UukcX5RIJU5R326/
         TrXNyWRtTT4aCZUMzeHmgJAXDMuufvfUiCmAggkoIaC90krRdZf5TaqXxR5Bp9f5d2a3
         BSccaMwdcjKxb0mgwcBYb80u0Od8fMjYYLwGKk8IUy/a3Qow7QJeWd5hJS/MFOwhgkjI
         rucZpV7PaOxvmbm3xHcvpLJApw0g6aI+mKwLBoyn2zwnWf4AjdpG++uduyirZmh4utB/
         4YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TQe928QygVgKBUwLTLK8qu8mKL2BBTte6If1XZZmkOM=;
        b=lCTp8cyCCnznHEVRWL0TljqWVnDt4kZ6pG37NiCSplIm/O5oPYPjgVeexthGa0i6HV
         AnzVGkk4ULidl2GjNqXcmWHLuvgDHglrsKnjumunFaPgxTeq9QmZPGhSaodTV3W4dnLL
         yH2+NE+X9737TXwTUBsQpvNfT7cI+jD27RzcaTN6lbOQU445W/mvspATu1a1/iJcZAQ0
         JiRbr5Hy3E7OURiDNwUlhPv+HAuu9OpmPsZwnnZ9LxNIzAKy1/YVstB3gjl/ccRqTLNi
         cJyHA6gNBdY2Zme35N4FxKCW8vgeCF2kal0FkU1wC0wnyDztLqRDpyS1CrTYvjBG1az6
         2wnw==
X-Gm-Message-State: AJaThX4hl9/QIOxLRi2AJiasZ7cnHdzMSOcoLUnvZ6wvqq8ml9IenDOb
        8Z6gHjv1ZM1mfboeS8Qghqbg2QuDothrcrBYPmOXJXwd
X-Google-Smtp-Source: AGs4zMZGAl7+G8odlx4C14wqUKNNSwWjZUR1IVwxMK658knXOyar40ZuWvf3Ti8bq7CSYDFQozlIsHTV7Sw5LCTgXvM=
X-Received: by 10.46.21.87 with SMTP id 23mr6298485ljv.107.1511305544195; Tue,
 21 Nov 2017 15:05:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Tue, 21 Nov 2017 15:05:23 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 21 Nov 2017 15:05:23 -0800
Message-ID: <CABURp0pxYiwrpvT9E_jpvZKDMOUVA9e7dUhARfKEQymWzUwtiw@mail.gmail.com>
Subject: doc: prefer 'stash push' over 'stash save'
To:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `git stash save` was deprecated recently, some parts of the
documentation still refer to it instead of `push`.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8be661007..056dfb866 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -175,14 +175,14 @@ create::
  return its object name, without storing it anywhere in the ref
  namespace.
  This is intended to be useful for scripts.  It is probably not
- the command you want to use; see "save" above.
+ the command you want to use; see "push" above.

 store::

  Store a given stash created via 'git stash create' (which is a
  dangling merge commit) in the stash ref, updating the stash
  reflog.  This is intended to be useful for scripts.  It is
- probably not the command you want to use; see "save" above.
+ probably not the command you want to use; see "push" above.

 DISCUSSION
 ----------
-- 
2.15.0.471.g17a719cfe.dirty
