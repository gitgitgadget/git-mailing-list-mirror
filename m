Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD2F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeHOANa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:13:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42324 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHOANa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:13:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id y203-v6so17325818ywd.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqBBcHyguZtk33/GW3HDtqAsHO8+fhsPTgslfdcgxjQ=;
        b=WODq2/5EjBAYdZkU5kDwKkn1bjDOyfrEkaDg54WNWtUX0m9Bj3TsuMb715bNpo+0V6
         l+JUJ3qyr22ZWEgT3E2AGaQvnVTExK50ORhk4GD81iNUMMFurVZ3uzcPSXMJXWiBGMdL
         625ZFRJd0unGqgMTIzpCpbEoTIjZVoDSpJXPUR/BompQQbg0b379HRK3QKu8llV3GGZk
         zOHcyfOIP41iNsCv5uvs27hah7f+3r3stR4m3f/Ez7mvAJXben393JIdXUCTlL6ClY8+
         jic55nKdr3UOZmySaQye/DiUCciL7cbnx9g218dRgVqz7aACI9BIegLhkJTPNWIEwtoU
         tVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqBBcHyguZtk33/GW3HDtqAsHO8+fhsPTgslfdcgxjQ=;
        b=K1Y4WAJFkkSE1eMo04/8f/iYHZch1KyRup9/aRfIGUqybvJEQVTuxTTdEAebxgnya+
         g2hYpPr6VLJqEB+NMab79C/BCC0gvdrVj95EsFlkOIjH4Ggb1xkgyoy2zZqJHs8oSqob
         /C2Xi/3ZE0fHamsdaU0DXxuUPJJ+XFo4T4fwE/RTFskndDWjmiK1JbitIoJLyyXY1NgG
         2yJbXaVDo+jHgTxmC6EBiwdNspCLlp15SkO4AR+rJlT4RYil9Pv9ELBPG6CvU1I23tSN
         V0wGzZDBOZKMSGsgffbzroP4dLTUDsrHwiZ4K8XLRECYlPypZb6+6NkTygsj22+Dk9Rs
         j9aw==
X-Gm-Message-State: AOUpUlHYWLs2j/4yZYNSBKOYUHMWGskoTBJY9sluO8IqCHSfh3AlS5Ci
        3ueo4JQSyW3tJhrBZrKDxdiujy+zPx51p7Nl534kHg==
X-Google-Smtp-Source: AA+uWPxMoT53U8j3qWu0DMDjOmNfb9scdWaUmdz63vNMH1eU/3EGOTchzGzIlSpBkzEOkodnE7s+K12TSYSddayB/gg=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr12359831ywj.33.1534281864797;
 Tue, 14 Aug 2018 14:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
 <xmqqva8cy85f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva8cy85f.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 14:24:13 -0700
Message-ID: <CAGZ79kbaNegk6kFD2Ks2S1ejd9f-8mLB2E_xNr1B3iQkn2EVPA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Resend of sb/submodule-update-in-c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gist
On Tue, Aug 14, 2018 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Thanks Brandon for pointing out to use repo_git_path instead of
> > manually constructing the path.
> >
> > That is the only change in this resend.
>
> Rcpt.  Hopefully this is now ready for 'next'?

I don't know any reasons opposing its progression.

So, Yes, I think it is.

Stefan
