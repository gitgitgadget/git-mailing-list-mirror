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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5723F1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfICSNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:13:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43545 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfICSNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:13:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so6026282lja.10
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/D1Bpz21umkdog81SX5fsADytcU4cxvzhWkf4CC+b4=;
        b=bRWDs2/GIUJPh1tNd5gXkiydGPWJVj/soztfiz1ienT1SkaTZm3Hzt14Oj2geqAixw
         yNaaMn9aSrfCzmQf4FIZFDywHhofjuZWK6HIJdEqj8zuGx2RpM4ZkM2F0fDbiccxOPqr
         R6yhuVnYqSVbrjLeCUiAmRuML3cB9/AQ1sE58eH7871Xfp9hxQ50CdZjqQMbFtoCDZoP
         u8inKmlotOt3oUVWgMAEhQBLM/3eKRlGbMPq13hpvlDnV7N0c7JeBfhi3+7M7kygQMuG
         i47cckMDri0qzRht5i7+PLQm/4n5osIZ/7PV6uU+qf6jCp+Fg8FAiV+oyZY6iGTSJm0k
         ZRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/D1Bpz21umkdog81SX5fsADytcU4cxvzhWkf4CC+b4=;
        b=EzVr/dne+Q/YCugh3a2h16uTRFd/zVBk5vI4BM227eYPQrnXS137tx9xtUGXvpxGUT
         E/P2qOUYx699a/jwlNnPmAiUo/IX7VL7qPMBx+X+1GF9fJaLTYqlgOIu7Da1c4gqcXA8
         4oc66rjdT8b+glcM+jWKcG6oZXzMDYNcJUVHmzQ+MwOF546gXYqwxMJyrSChuU7+g7jM
         rW0BiS8IJzLMcI4kMmabyQrY0F0dQVp5uh/nIsiFyyIuYURSnqG9sIjMczam2bJWTiTb
         ME/g5YNPyCmuh7C3+KlQtUn3ns7l8fho5YVCWGnQQQo9CzmVV8xzlE6Swhkxqp2xffNP
         +hGw==
X-Gm-Message-State: APjAAAXTUdjG6FgEjCKf7fz7CTPN7J+YmaVnQP1S7fY5ibMKFxlB+oS2
        FXizbW8RaHZUC8N1CAW6BKucvYhoOEl7ONfb+15Ag86zmFo=
X-Google-Smtp-Source: APXvYqw9cLts1ADw4+1WphgT3Qcyok6nJNlGhGzTtzrdnS2AUPWmyPMTtMLEGgshmtRfoB2b98RekjFShx5g60Ek9Pw=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr370635lji.26.1567534394607;
 Tue, 03 Sep 2019 11:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190903144536.8935-1-me@yadavpratyush.com> <20190903180704.11812-1-birger.sp@gmail.com>
In-Reply-To: <20190903180704.11812-1-birger.sp@gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 3 Sep 2019 20:13:02 +0200
Message-ID: <CAGr--=K4cEjWD4q14M63Muta3X=YSKff4sebH64AKGKWT7+--A@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: Add hotkeys to set widget focus
To:     Git List <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(Sorry that I hadn't used the proper version in the subject before,
I'm new (as you could probably tell already))
In addition to your changes, I removed the unused ui_workdir variable
and modified the bindings to be ALT+1/2/3/4.
Shoud I have listed you in the commit? Or did I do it according to
your suggestion?

Thanks,
Birger
