Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA504207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbcJIOmd (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 10:42:33 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36536 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcJIOmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 10:42:32 -0400
Received: by mail-lf0-f42.google.com with SMTP id b75so77824663lfg.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ObB8n0uscZxqXDtONMqEhJp9wjEGYn1FPMtoPvd+JU=;
        b=PSrTuQoNIXisas8CaO2Tg4pwtsiZ5Y3vnU2MJvZREFeELQAHMb1M8msemdcjw/vH6+
         oBJGaG97RAG/H7t0+67A4HJ7rgg7OwPeifdqboR1RfyqGhWAqPEtEUueHHQRpfKCY2Lu
         QC/eevlo6jhfbnkajC2hFZKtDqal9ZxpCZBhpYxsDW3LuloF93tPsT2nwg3e111TlREj
         cygz/7phJju1zvGXnyH72YuWFCeQHh+PMaSCArPevnsiS+mA2WQ1e4JuALG4u9sWoxVH
         CwsJgZ6NtRUQgyxS0vjJl3yuWUIkinZ7Nr/sfn2Z9sitx6aXs+eUqwIExYx9BS4flKB+
         i3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ObB8n0uscZxqXDtONMqEhJp9wjEGYn1FPMtoPvd+JU=;
        b=PKY3tS6+ik5jz1sPBh3eqG6lvytTNuzzKmJtQBlS9N5JjSi9TpNWiBO/V8I8q3Hr/J
         52jYsZMCf47sRWQfItbvovyPnTL+m5g+SNdcAVrARsWW1I8ihJSjuYLCu02l526PfFM0
         V153I9/ie1UncqnHV5/ILEEntAxI5hryjucWFIXdBBKMu9grvh/7TLFwliXAkx9/0afh
         GNzLgEyrCM6oS0u86WIn6noKog3/cGM0EEHLGp9fjJu2Oksh5rR2XXCncKOSPMmqXNnF
         p+3DmYQ3Po4NVsTJTaf4+lvcR5/0mit6WICLjocVkbm4DcxDpuNfkChLTH4ICrz3kCy/
         krrA==
X-Gm-Message-State: AA6/9RnW1Ps+Y6PXaEoJsfzoF0IwZenbeW+8YpyGMx1+1ll2a5gUhvnEXQTeYkVoCKcrWFgMnr7j7PsWy9MMyQ==
X-Received: by 10.194.235.165 with SMTP id un5mr24259101wjc.200.1476024106477;
 Sun, 09 Oct 2016 07:41:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.143.33 with HTTP; Sun, 9 Oct 2016 07:41:45 -0700 (PDT)
From:   "venv21@gmail.com" <venv21@gmail.com>
Date:   Sun, 9 Oct 2016 16:41:45 +0200
Message-ID: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
Subject: Problem with submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I want to report a regression.

After cloning for example https://git.gnome.org/browse/epiphany with
git 2.10 and running ./autogen.sh I get the following errors:
http://pastebin.com/93AunRhu

The developer told me that it is probably not an issue caused by
epiphany and I should try an older git version. I installed 2.7.2 and
it works perfectly. So I think theres a bug in git 2.10.

Thanks and regards
