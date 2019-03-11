Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF63820248
	for <e@80x24.org>; Mon, 11 Mar 2019 02:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfCKCQ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 22:16:29 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33167 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCKCQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 22:16:29 -0400
Received: by mail-io1-f48.google.com with SMTP id b6so2684674iog.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 19:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cYipzmPvuUP3zTQlfcFY2TEY6cy/CU6IkCkFspAO38w=;
        b=ug2BLp4d7Oeau8XYJegFy1aOdSMTPsOuX4QcZ80uPSaR1JkFQCiTQ67PmMXnqBZG7z
         D0URbL/kMHjSPjD9WINFApd66CeGj9gCF2td4fxQnIQuAjY057hBaN0pclaIBJcNoyUi
         cDoiEuG4wWP/GdZBj1g1cEgeCtkwZqZEKFAE4xjgDvS4bbpZ4Q0IcMjrICu/Jq9GnjZ6
         /l9avbxWdHE4Nx8oFoY0grKseEIHwXmjy+LYTs34U4xuYMOwCrF8UGpPIoRkuUowe2FY
         PX6Pc7eBbceLMFXlGncpD1TzWcc4KflrJCIphkjx+s136aIBoQsqHAEUGBEq9QTf8a3J
         xNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cYipzmPvuUP3zTQlfcFY2TEY6cy/CU6IkCkFspAO38w=;
        b=YAuCon5ikLeS1DT2zCrgu62Eju76eYL2+nrhixN36qh/+pEf48Ri0RRHYS2aUnlyZC
         LFKDd9cB16O/H/N00xb+DKbt2S0BAa8qNDxPX/vPuCoyCjrT6EAMkdiajWvDg7Znrdmd
         fwoky4LFspgiLwEr39jYh1CkvMMpjAld1QFTjtvXCLj7xt5nh1xxB6N40aSNCFl4H95A
         IWveSS70DWxsyYtKKyXSRAVz2RGgWZKUc63lNH1drb+IgeA4e1QzRe1yED23dh2Uft4g
         F+9GHHrnolbpq5cGGOgNreYy8n8FDVjSr/r7bLoGKr4I6/9aDJHwU1h2UjZkCWMp5Tii
         zCdg==
X-Gm-Message-State: APjAAAUzQnS9ffm1O4sQc9MxvYfo+LNM6nhEXxQP8mogPmLcRmUmg/vD
        5wgOjQggCFB9VReWbVkxgQZfTy2AZktXHMc3RuQ=
X-Google-Smtp-Source: APXvYqxWOT52CNM9R46BM4TQhb7qL074qftZgz0XU73At9UsaCB5LwUcnMN/Y+f9jkxB3CyKPHe78Jl1JCZEWE8k3xI=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr3072155iod.10.1552270588669;
 Sun, 10 Mar 2019 19:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net> <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com> <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 10 Mar 2019 22:16:01 -0400
Message-ID: <CAH8yC8krMuLkTnLsEAOxW67=aUhB2B9nGkAfsotuO95dd6+qLg@mail.gmail.com>
Subject: Re: One failed self test on Fedora 29
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 10:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeffrey Walton <noloader@gmail.com> writes:
>
> > I think this is the patch for sha1dc/sha1.c . It stops using unaligned
> > accesses by default, but still honors SHA1DC_FORCE_UNALIGNED_ACCESS
> > for those who want it. Folks who want the undefined behavior have to
> > do something special.
>
> Hmph, I somehow thought that folks who want to stick to the
> standard printed on paper penalizing what practicaly works well in
> the real world would be the one doing extra things.

In the paper example, we do. I prefer printed books. Just last month I
went to Office Depot and had portions of an ARM manual distributed as
PDF printed and spiral bound. I don't mind doing extra work as the
special case.

Jeff
