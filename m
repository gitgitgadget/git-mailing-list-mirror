Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA9E1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfFSRPV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 13:15:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39125 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfFSRPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 13:15:20 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so257933iod.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7r3D8N9+jTrZ/B7G3viPMjefv2d+UgHepkAZaOWTPME=;
        b=SLoX/ILrTakC7a0GAW7LzxQdXLHenpzIaFUFcBaMoILC35SFyy74Ji1dW7/lvriCaj
         fgMsfnByU5/qFXw+ywSfn+Ee/GE0Z/tmgYrFlNi96vIcDRpRbFGfmQaQI3dS9w0qGkvw
         O1yHRA59U5zyq3IaWSmaQ9xP/dUt+tkQPKkDfDKj34LHTfwwkanrTExewMMzWm4AEzWB
         CSJJef/ju+85bDPnguBOY3O+MGLppetEhnd3ttIUBsb9GdftZ5kSv0j3u6jAlTpisKW2
         xGFAXoU3Fob7CwanSUWQdAtMl51WkMIqxSJ1eF4t4LZuDEmvC1nERgKIJsapjDDFba13
         K35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7r3D8N9+jTrZ/B7G3viPMjefv2d+UgHepkAZaOWTPME=;
        b=juuotd+ubFOOeXnMqln9epNLZZpeo/08Y3HxcYkMxHCk8vIoZh1vnKEhqAAZhO3Mxv
         ex2cIaFJKOIKXY5AU2928aAZRFkyhmIFk7Dxaca92v6/3W1ixHLxgF+4vpLV1UKI/5gN
         0FgaryKb8/a3ko426B/lXcdMsJ89YLHIYwkAs3znw02+TfAeJuMPG4JvKxawKlNB3zrR
         Uv1GIx/dnK6ajobN/3X3/WZHgViFCh5PP3aIguZkF0UJWSXkJPzssrFMShGvSr55bW+4
         oiz1TXTJcbh9WGejtx0/eWeq3lRBGTPFMSfUdLX8LeX+4smn0McFLGzV7p4wDqQmMWxn
         a/nQ==
X-Gm-Message-State: APjAAAXlU+qC/AbY0uuZqguRti4nu2NHdmCLVR8azLipRy9wFNQwGRQQ
        W7LgObKTaBWEkCCQyMa0o3rv/DtW1I++LozQ8P7l6Gm6
X-Google-Smtp-Source: APXvYqzmTjdoyW0TxPWUWvnuwInA+cBQ4qH6Y0MDuaKb737nmhkJU/hR5wthjcECKvoI8ayg/w3RFGqxUyVVhXpIAhw=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr13287733iof.162.1560964519635;
 Wed, 19 Jun 2019 10:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
 <CAPUEspi-G7abt-zuLbw0iuyXN0gtrM_6Vy6d+9f-=6FpRsoV4A@mail.gmail.com> <nycvar.QRO.7.76.6.1906191316210.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906191316210.44@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 19 Jun 2019 10:15:08 -0700
Message-ID: <CAPUEspjJe1n0sTG292YaHU+qBa4yLrEw2G_6Fd1U5Af=f9JRAg@mail.gmail.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

while those two changes (from DEBUG to DEBUG_$foo) are worth doing in
their own merit, I am more inclined to consider this as orthogonal
since by your own description[1] the right name to use would be _DEBUG
(with a preceding dash) and that would obviously not conflict here.

the only remaining change then would be to drop the -DDEBUG that gets
added to your BASIC_CFLAGS

Carlo
[1] https://docs.microsoft.com/en-us/cpp/build/reference/md-mt-ld-use-run-time-library?view=vs-2019
