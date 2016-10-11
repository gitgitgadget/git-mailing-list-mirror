Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D0A1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbcJKVjY (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:39:24 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33808 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbcJKVjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:39:23 -0400
Received: by mail-qk0-f178.google.com with SMTP id f128so8163613qkb.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kbmhYZMIctC2qD3dw581rFZUXy/b7KikcnSS5TIgC8w=;
        b=or6f3j55yJ5TiSLjHPu6TZSv7tG0WzCEjQzzfiUMWFtpFWMrTyZgFQHp/Rscafai7m
         1+Ka3ijV1mtaZmFE1X79QFCj+Zx+ursvj7H2jDtmUwOiZIv4Lfu/z+msTJMarusVwoCH
         NYlLQRGlzujwMihzlXCxljOlzj6MEg2rbI4ysK79tDATXCFJV7AFdh8M+DfqKWJ/6Uu3
         Q0j+OfPRnH7+N5nJCmi9WShGsCiw7ieWckHxqVbkQku18M+jmwuVnKdt7WYb4t80n2SJ
         bJDjPWh6Xp1G4Ynz3IkoDq5yEdLfEs8yKvNnKehvTD8TVqrFYIUuZ9o3YUlY/3RgUyAZ
         02bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kbmhYZMIctC2qD3dw581rFZUXy/b7KikcnSS5TIgC8w=;
        b=JqzE5VvsyzMA+i5JAOWO/naCV56gfj92e+m1dSWZARFivUVqt2L2rsDJU47lFJMtqF
         wQueMIwKNFmvwS+EBVb1+Y8C1lDbZJ9cK+ccIyb90O78AWAIFXJOu2Fam71sqGIzz+Kb
         4ZX9C3bXi7lP87LTZU8w38623FAoxcSlkr9ufW8aGkVvoxyQ5OttbgGTXmjrC5/z3imm
         ZR4d5pro+y19amfYo/FOaYh0Eq24D1YpdHJdm+abW28v+EsUtPeJ7HEze5ezZwzRte8R
         1L4/iy86y7pZbvr2iSNIX2j5aCMuw6xj+hVzqRT2LBv3Mue+PKvaX+FYac1SmMQRJ7qt
         crBw==
X-Gm-Message-State: AA6/9Rn/r588f4mneolGeQ3ugISBuWO0ELXg1PpSw3xuO3QLS2mhGWFXODSdW96zelJAoOBhTaWX7dgspRgcWSA5
X-Received: by 10.55.36.131 with SMTP id k3mr5092788qkk.86.1476221962625; Tue,
 11 Oct 2016 14:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 14:39:22 -0700 (PDT)
In-Reply-To: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 14:39:22 -0700
Message-ID: <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
>   (merged to 'next' on 2016-10-11 at e37425ed17)
>  + submodule: ignore trailing slash in relative url
>  + submodule: ignore trailing slash on superproject URL
>
>  A minor regression fix for "git submodule".
>
>  Will merge to 'master'.
>

Going by the bug report, this *may* be more than
minor and worth merging down to maint as well, eventually.
