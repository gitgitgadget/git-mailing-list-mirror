Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA8B20444
	for <e@80x24.org>; Wed, 11 Oct 2017 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdJKRrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 13:47:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:49658 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdJKRrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 13:47:00 -0400
Received: by mail-it0-f65.google.com with SMTP id y15so4024597ita.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RbUPLGPp17RCshR/vcTFMmTLBHXzCeekeNOWR996IGQ=;
        b=ghmmEAFZqxQZlaJmHgH5zrlRovUbkt+b02rJEUYn8rMRrhLK8jAhN/WKYyNZQ6bxwU
         X9JzfvEweMmY1NeBxrWxUr8qQ6/XDiSGnOBowUzAq5HGjIB2qjsVrD6UmwcVNHC8L7St
         UFU1SlN8Y5gIw+4ro7r3qlDQJga1mLxZlvsirc96jtS95CywCcEjV92Ujl6huR5sCOia
         y9BL2RqCDmm4GLaQWnmw9qw1ebk9E2y2UmMccc80EAhLShkyrppg14T2+5Juamop4vDH
         0MIwR09Ot34V+YRLHUf2C35+bJO64BAurkuZNOsJnt/1DoqgfknyAgdEhmIV9BV5DH41
         UyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RbUPLGPp17RCshR/vcTFMmTLBHXzCeekeNOWR996IGQ=;
        b=aeidnkUyHXuANAGuG/mkST7G2JJOSDVGWmn6q+ZVvBbllJ2b+bkTNCdoBzrzaPPLaP
         Vdw8IMJ0ixX9atThg2na5Q+zxl/wrG+pE4SsWMSTvqD5ldzFZwowp8S3UjXxcLGTocMc
         kquA6qpZwJjHz7P6r4+dvZq4B+Ns68ZhQjNc2akq1K97j5L47e8FGCFV2FUjqb6DWpN+
         iyUxGzyH+z8arVc8rAdF3Wm0pGcyrFENlIbys4ocrs3d4JYcVepqC7OgSgoM9s4fbWnX
         Pf8RWKDA+o5Hrm+KSIzFW0tEBG4BwxPNk8rAmIDMGdZSKx2ZQiSFDRhKRH5qLj47ijQ2
         VKaw==
X-Gm-Message-State: AMCzsaXmCdSSof6MjNri8Vmm1RorOJ1tZq+k6xUcv90ss21ZGDZhBIuH
        ppakM3fnKuRn5/6OEV0VDRWQe9REsbqqoSK3CdmTXhst
X-Google-Smtp-Source: AOwi7QB91uDIyrwwWmlvgh/f4hh9I67AzHa1wziUHCwr+8MccybpYofwUUXQV5uBX1zJXSk4pqPVMBZ2vcWkklUimrI=
X-Received: by 10.36.203.129 with SMTP id u123mr480365itg.107.1507744019685;
 Wed, 11 Oct 2017 10:46:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.145.215 with HTTP; Wed, 11 Oct 2017 10:46:39 -0700 (PDT)
From:   Ayush Goel <ayushgoel111@gmail.com>
Date:   Wed, 11 Oct 2017 23:16:39 +0530
Message-ID: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
Subject: Unable to use --patch with git add
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.14.2

What more details can I provide to help debug this?

-- 
Regards,
Ayush Goel
