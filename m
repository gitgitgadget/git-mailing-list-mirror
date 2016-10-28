Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E61D2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761194AbcJ1Om6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 10:42:58 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36670 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761128AbcJ1Om4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 10:42:56 -0400
Received: by mail-ua0-f174.google.com with SMTP id 64so50147407uap.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=PbLGLh03xF9vAmMZVlSCZHMGmjJ301BqNkxWnAvKKYw=;
        b=u28qyAU8c3ZI+pL9HKElbkR6L6cTjZ9LG7iTaKLvhSDOAp/VD4coXxF+x4B4I+dNlt
         K9xQaLIe7LkkDsV/Rn08Ubf6Hc5hitpSo8odCLxWwgsaEGc6SV2YFZeALvITHdUwLRhe
         GQn7G/O0Gg5rx1J9CNjkYKx8j5glKX5cbmBtkKHUeb0PhCwELMCCLgjJqPAQ6B1nUPL3
         3fXH4ppnHrSf39L7RXurGqoboMzlkUjmdz9jSGP3QCQOavfN5OW/axIRMJdN4VXVh/sW
         a/+EnS6Ok18BMNSKOP8u4WM65lw6NHKdRDD7D+VGV5mcexNua+cDQmc1QNap13haWNoW
         efsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PbLGLh03xF9vAmMZVlSCZHMGmjJ301BqNkxWnAvKKYw=;
        b=IYT5mkqRVOfaFah6NFRrFQscwtuOuW+7R2IY59P1QMVIiwF45NciAf6NSVIoOVbLDP
         zyqzs5nFiG9oHH2sSqF5cuJ3T6iXGS51kKLE78SOdVx3B3Ajl24fQFP691Sdu9bZQ+AQ
         5kaRMzgqv5CJrF1Wo+P6+KFpdOHxoxDaa1IUWkTq4HxLekLAM32NAqPlYBoIxIOrvgCL
         ZDp96cSlAoRignT2ihApqZMxjTQMHkmCNv4SmNOP6zyMvHT7yqzVpVRhuPjZPZe3iYUB
         cPt8VxrXLblKR1imLVnPI2tnpIbkjEI8FWFcY3cdtS0dEima3JNUtMR7DUsYQXLBAG+A
         k9zA==
X-Gm-Message-State: ABUngvcA6mY9fwR+zyWtlrSZ8zV3p3XZbcCB3bVQi2+H9AkaaVambwo4PYDT6k3Ojqv4XgoN8vTA9Oy0HKyVDA==
X-Received: by 10.159.32.193 with SMTP id 59mr10678338uaa.147.1477665775022;
 Fri, 28 Oct 2016 07:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Fri, 28 Oct 2016 07:42:34 -0700 (PDT)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Fri, 28 Oct 2016 17:42:34 +0300
Message-ID: <CAJtFkWtys_Mm_dHQTRuWd+hnxRUfJ21vradAvBZjOzEbLP=uTw@mail.gmail.com>
Subject: Git crash course for SVN users - which of the 2?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I googled and found these two official-looking results:

https://git.wiki.kernel.org/index.php/GitSvnCrashCourse
https://git-scm.com/course/svn.html

Which of the two should I use? And I'd ask for the other one to be
deleted so there's no such further confusion for other user.
