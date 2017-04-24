Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75787207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164600AbdDXDrr (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:47:47 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36750 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164558AbdDXDri (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:47:38 -0400
Received: by mail-io0-f177.google.com with SMTP id p80so57344003iop.3
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dInxtpK/4YasmiSPUZVwvCkIDiwTJDvv8nH+lVMw+co=;
        b=NnO++dN7T6OKXFNPC0pLzjHS7cfhKmMOJ3tWyCWDRgMbKVfi5NHnOnBmIkFG5riRc7
         /Z1ZTYoyIdUZJ39V6aahf2R9VS5i+n24K86XlNaodCOvMkm5wbFOTSc7h1pevXPGTPyJ
         nZcZ7UuFhstaXLtsxsqKQdyoP92fYrHtS4SJss0LdEMZ65RlLuwsfvLiJZ5RLMsTZ0Ih
         4Zhi2OL0NPPGO+MX6roP572wn5ULskTXs//0A5omUNsC7yAwt8d4EoCHIs8hvbUTfW8B
         1NhIg/6f4hoNft+zhI+KZM1eDhariFpFRcLs00pfjKPw0XEIAQtTSX8ofY8pOh6l3QSh
         w9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dInxtpK/4YasmiSPUZVwvCkIDiwTJDvv8nH+lVMw+co=;
        b=kQbsJX21+n+FcOHDYx7JkhOLPWTRLTA2Nq8bHo6B7j+T1hgAEFsB6RT48f63FF5MHp
         UXMN10cRpbiPb7AN/wa3RxPFHICnRidtF4OdzFJ1aoyorPS86oqBLgWxTbTWjM844do9
         s0AHA5Z/KEfO+6hUjKKdPaT1dO1Td/19r6IgAHeL8SFScp7rEf149CiheF4lwIRoFgQz
         dNE/1wizD1LxbewIPJ68AM8Pn1vCOL5aGngaWCgR/H/7eEnPSD7uF0tJdLm+u2NXGinb
         36P1rJNLaxR5UVVVn7ULUhrOfVr1f4zYqZznQMGUIudSMBipuvly9W9wEKJG7jnC3aPO
         yPNg==
X-Gm-Message-State: AN3rC/4nZ9R/amiVlZgG97ezqdJDYntssFhm9ovm6xg1gOa9gT3Hmb+y
        oEQmRqusa/TGxKCjkaEOKyMd3+jfd14W
X-Received: by 10.107.8.136 with SMTP id h8mr5591271ioi.134.1493005657267;
 Sun, 23 Apr 2017 20:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.90 with HTTP; Sun, 23 Apr 2017 20:47:36 -0700 (PDT)
From:   Rm Beer <rmbeer2@gmail.com>
Date:   Mon, 24 Apr 2017 00:47:36 -0300
Message-ID: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
Subject: I suggest a new feature: One copy from files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a several directories with binary files datas that is discard
by .gitignore.

I recommend make a new .gitonecopy or .gitonelog or something that
take the directories with only 1 copy of last updated and not take
history of files in the repository.
Maybe anyone found other best method for apply this idea.
