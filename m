Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC541F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI2AzO (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:55:14 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33846 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2AzN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:55:13 -0400
Received: by mail-wr1-f54.google.com with SMTP id z4-v6so5994632wrb.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rQvlqpNtxgQmRcKrGinkrFZbquSTDjLN5pK4OKjiNCM=;
        b=JbPPrfkOxw6bukKCmoflKtNBH+BQogfsPoImqlzzFXfv5pb0lLQkk34H/+46qFZUYv
         beMtfoAEz77C+YVkwqfBpU3JUSWI6waOHC0DqXG3D4JtYuYk1xvj1Pf0Fx8wUd93VVkG
         6dMZpg92ngueooJU+5ERPjgGu2vVYEyZjtyBt9fBdl0LUnCu67ERiKDwOkSMwMTDP+Ej
         nL3n1uKN6ASrPa6sCSXhpybhRt5mwXeglqR6Bz9I5EUutIEKpnI8SlGqTnzpnlYf2Kc2
         N8+PPTYtmUYVqlzeZG5VyTW+pilJGrzt/sr5kpXmzcR66mlsBrceAtWmpMiQsN9HrRWe
         VQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rQvlqpNtxgQmRcKrGinkrFZbquSTDjLN5pK4OKjiNCM=;
        b=W2852vs+jn6TvP/5ZR5/93XbqKXSa+KIL2tCbJl2hJurc0iolD3ElRiFPPHapCdv4R
         KdCUIKiaSYJ2/PZy3aibIUfYyiMhVre+iNN4t7xFkpYiIcO/2nGa1M51XkjRS00pBf+h
         vhS+NdBit/YYFmpxAErL8ICfMVRA6Ng7HuBXK5QBUm/tpw+DQb3k0LcFvudF+geDB1gS
         tTYAI8WV/EMoVScKtiY0dyeVyVIQFICUVCixFm5X6nH3MM4+MootY3f+YbvtA7/0r5eM
         Zb8kXTc0zwOAkHA3Oe/pAggW4bKR9/vCE5MZ4xKemMM10YriJgJaXXYuWARW1nW5SG9e
         vrpQ==
X-Gm-Message-State: ABuFfogPLO2JKC8skQ3eJPV/Lq5MUV7l08Hq6txyBFV0oCee30CLrIyw
        S3v73UlMSzp3Qzz+sp9lDhAzO/AGAXbgMZ/3DoPWR0Ln
X-Google-Smtp-Source: ACcGV62M2QYlawYyLvDTrMLuupAu2q892xuVWfklvb2S8NmBciB/gbXOoV+D3SFobBPuvaVzQVaPrDI1jWeQ2oU3FM4=
X-Received: by 2002:a5d:694c:: with SMTP id r12-v6mr5292297wrw.170.1538159409870;
 Fri, 28 Sep 2018 11:30:09 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Lo <wilburlo@gmail.com>
Date:   Fri, 28 Sep 2018 11:29:32 -0700
Message-ID: <CAOeX3KXASgnyVcZuTAjyXLgnZpeA1FD3XXvSoRd11b9V9jpGFg@mail.gmail.com>
Subject: Request for examples on git log --format:tformat
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I was reviewing the tformat parameters on:
https://git-scm.com/docs/git-log (middle of the page).

Specifically: %<|(<N>): make the next placeholder take at least until
Nth columns, padding spaces on the right if necessary

I found the instructions regard space formatting to be very confusing.
An example would be helpful to illustrate what the proper space
formatting syntax is:

Ex:
git log --format="tformat:%h %<(15)%an %s"

0123456 Author Name Commit message - author name is formatted to be
padded with space to occupy at least 15 characters

All of the special symbols %<|(<>) made me confused to what was
required and what was describing the syntax.

Thank you!

-daniel


-- 

Percy Shelley's poem "Ozymandias" is also a good argument for refactoring code.
http://en.wikipedia.org/wiki/Ozymandias
