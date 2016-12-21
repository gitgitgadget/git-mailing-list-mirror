Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400411FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761548AbcLUSBO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 13:01:14 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38909 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcLUSBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 13:01:13 -0500
Received: by mail-it0-f45.google.com with SMTP id x2so58492159itf.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=luMMETw2ofgsG/ze/LO/LKnIB/6EWUxlggLzFeVKysY=;
        b=q2+RuJ+XOzZXckf94mX+yAH3qafRKOxrP7iE2MIzTSUivNWd736tfRh5zR+tCMG2hY
         w7NqmI0wplWT39N7Z2o+kBkuwSu69wDdeKRc+pMTzGD/HdAxyM4wb/pEVTYOzEVfC5+p
         dLgLDGuA7Sp9XueZ9FnJ85YCtMML4EzdfL1w2PrjGasKxi2jfa8xa/GYvKen3JYp0Ana
         4A4OTI+LzdjsmXPjb/qRej4TgM+3F1vYmzEDN3QdwWO5hC0zcTjEkHC+fc02EP690IcS
         uVBcxQ1IEXOF/bRsZGZMby0ZwDs4o4x/FUuEwuy6jUGcjACM8NYIAWju7j/RLlMzjL1v
         7Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=luMMETw2ofgsG/ze/LO/LKnIB/6EWUxlggLzFeVKysY=;
        b=MxxwGJR7fZaZ4ONa1Bed+MlWNVbHr9WAd/SG55rJhk3vEeYxk3FSQJImSD3sefIYVC
         GRCGqBINuKcSNYJkMDS1Hz+DL9XOlFjOQkMxUzyTRcM0x5ZUgzMPxgE994xLIKnB50W1
         CUFSc5b3fzdze6GkpKdgDwikFbixuxruqtY2beUGugtuS9ZNwSjKuQizy3nVEDzk6bJh
         Ct1TEOrlp8IUJLx0nbmtxjOYu0eOKdoHgXCVnmCrZci5F2VL2Lvn2AGre5VUPfYeGs7H
         OFC/qJwYs1mEwhvrPcd6VYUAXZNkDd5kbT4OhjThDXvNrhKzzDRNfg372FpEKNtPtoFI
         A8yw==
X-Gm-Message-State: AIkVDXIbHsiOPDDedFfU4KvusXr89w9BdO/EQZd2laoooxO4VQa+iVtigNhEQgF94aV0F8xrOMe5n3inD6rhHw==
X-Received: by 10.36.101.129 with SMTP id u123mr8791732itb.30.1482343271424;
 Wed, 21 Dec 2016 10:01:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.163 with HTTP; Wed, 21 Dec 2016 10:01:11 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 21 Dec 2016 10:01:11 -0800
Message-ID: <CAM+g_Nt+hrtwX=6wTmbnqKLpJL3zzr++EOrDiYYeMwWY-6jhmA@mail.gmail.com>
Subject: Missing option for format-patch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use `git format-patch master..myBranch` quite a bit to send patches
to other developers.  I also add notes to the commits so that I remember
which patches were emailed to whom.  `git log` has an option to automatically
include the notes in the output.  However, I can't find such an option for `git
format-patch`.  Am I missing something?

Another nice option would to to somehow include the branch name in the
resulting output.  Right now I use either notes or abuse the
`--subject` option for this.

</nk>

P.S.: Today I'm sad and proud to say "Ich bin ein Berliner!" --nk
