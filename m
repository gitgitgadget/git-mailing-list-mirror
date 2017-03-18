Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF2D2095E
	for <e@80x24.org>; Sat, 18 Mar 2017 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdCRSwK (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:52:10 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36802 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdCRSwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:52:09 -0400
Received: by mail-lf0-f48.google.com with SMTP id y193so43366868lfd.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rSo9hPwGV5ZcFNiQdYqfJgQal8jaELRgqkGkX+n0hNw=;
        b=XENBikSqbs8F0fw/Iklp/VY/GbSda+3EDt4eM4Or81CDAxgjS+xzJ4ryg84zZjatVr
         bx7HFxC52cCi3FqhuUvOPp+zjnM1CdU2Vu7GHzqi+45AmkJ7YHOhuSeMFI/YoQzlkeON
         ME9QYdsIwUASAnbsWa5mcdsyz12wZRn3HpOrModvMquIiOwRGEAkYbU1xRQVXMzPCn6N
         sxA0tE1dGw2rrrnk0PqRYzUzgTPZzh1vIILUzB+zRtJOn40YifwZRtpUZs10ewOcj1EO
         Tf5erf/UsHIxYl4f9ri4lPLAtX6aGETi0aDoG97lIZTPoP1CpIR0Pd1Zm4owNQOeWope
         s7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rSo9hPwGV5ZcFNiQdYqfJgQal8jaELRgqkGkX+n0hNw=;
        b=tcLZQrnNqVudqbc4vZ2NtBKpRNfC6QURfhCalinz4W09uTNZWbeQDoucIBBabhR0WY
         DD+6QIh1fKqonpT30ffiaCfUyQNeElxKSgRD3EEGHnqW7NX3l3YsUSFdDWXXvmpNJjvT
         ZoXu/DSoi2nPBPSeMBP3ocR84Et21rzm/OcSALfychUnV61OZ1uDvw4LzBqWjGgSzDHj
         Fcwrj/tJULmQ8uAwMjul76/XyCX7K5feKcFfEyeXY0FVARdtnZL9/s0eVVUhCSYE3H0P
         j8Y12++IqbF1k+8R0ZwiexMS1nt0BE0rtR5wLr5Ua51DTcgySSOTaxogy8x4ZeRpf/eR
         11Tw==
X-Gm-Message-State: AFeK/H2NG6LoHqmOmUNkz9ukchSi41PW+5UpNXxFmOas6d5yZiNBLBObgQMK7MKM9sa0hA==
X-Received: by 10.46.87.14 with SMTP id l14mr7094918ljb.93.1489861276821;
        Sat, 18 Mar 2017 11:21:16 -0700 (PDT)
Received: from [192.168.1.26] (dbf73.neoplus.adsl.tpnet.pl. [83.23.31.73])
        by smtp.googlemail.com with ESMTPSA id b17sm1982407lje.13.2017.03.18.11.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 11:21:16 -0700 (PDT)
Subject: Re: Is there a way to have a local version of a header file?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Lang <david@lang.hm>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
 <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
 <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
 <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <35e8ef4e-9a72-28e5-6797-99ad639de591@gmail.com>
Date:   Sat, 18 Mar 2017 19:21:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 18.03.2017 o 18:08, Ævar Arnfjörð Bjarmason pisze:

> There might be some way I haven't thought of, in particular maybe you
> can use gitattributes to define a custom diff/merge driver that always
> reports no changes, or some ways to (ab)use the index to make git
> ignore any changes to the file.

There is `git update-index --skip-worktree` (originally meant for
sparse checkout), which you can use to kind of ignore changes to
tracked file, in a safe way (though sometimes annoying, when it
prevents stashing changes).

There is also an existing solution of a hook that prevents commiting
files with passwords in them; I forgot the name...

HTH,
-- 
Jakub Narębski

