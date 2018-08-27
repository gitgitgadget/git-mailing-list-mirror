Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D569B1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 18:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH0WKE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 18:10:04 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45521 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 18:10:04 -0400
Received: by mail-lf1-f41.google.com with SMTP id r4-v6so12720332lff.12
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooCJ0Zpu8QsTAbUXWJvR1DDbTX9zQK09Nw2n1VQ9AeE=;
        b=DEMdD+VtE9ifx7cdOuD+QOOGFRlypBI3UXfmlKSQU345FWwlg+LzBFOnk7UtHbXyg9
         bza8nKOg9S1tbECnNiBW/pHkVTEAM3QR9s9p5gQlLeUyARDqlM6g523PmXiZxaSfKEcU
         4k78rz6K/4b3HOakcYbFsEafIhRmOKE6o3Xv08wex7GIV/g8vG0Uzx0GfIc7B1wvcO+x
         rnlSQY8sV/o95l0svB4G67j+0LtfNbxtbRLBfkkx5vgybzItPidbhuykNpDkJD4tKZPn
         iA93VA/cv1iCDQe3empkIeXV+0PgzDf4HJ3pbOWAmO8FJeGRfDE6y2xJxhizRXO14Ogj
         SmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooCJ0Zpu8QsTAbUXWJvR1DDbTX9zQK09Nw2n1VQ9AeE=;
        b=Q8XKxbtG0zQ0tq3RfZzsv+mCoKUR1K0/mWqMOs8lNNEiBNagySTs38oHfFhouZuu/g
         LevV1Ssvov2naGriaA594oUToeIoePECtUEl7CEpahgcekevDIqCvwGtTMwrh3AmxPqX
         Yjo8NgkbPaHcmTSfhV2GFwk/U+TYUpS9dNMzsVGxRZTMnuFGylpa2ydLj0CDC9K34e5B
         0F9Ua/TmI/WD4PiARrncjKAXieTrviu5BkdDtJiDpndrIotS5LW5c16d4ytprohrPSVm
         Pqo+Sqj/qARgmPxV7kG04wMUXuxcX6qzE+AcQfxlkeoN3fLdbFCW9bUJ1y7zcL7cvKjD
         Acyg==
X-Gm-Message-State: APzg51D4l6tPe+TM2Bf7z3Nf8LeYOmczzgPkR6IYylvlEXQQKqnoD5ZJ
        4HxDZdO/wvf9+94/8ypL9OqNUuObTwgaFQ==
X-Google-Smtp-Source: ANB0VdYhPhzBchPszHCMzFTwXSRHgL7Pxh7st+33qfekCt7enbNg20cevhu7qDn837BCD1hZG/iiWg==
X-Received: by 2002:a19:115b:: with SMTP id g88-v6mr9051572lfi.57.1535394141394;
        Mon, 27 Aug 2018 11:22:21 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id s74-v6sm2792824lfg.79.2018.08.27.11.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:22:20 -0700 (PDT)
Subject: Re: Automatic core.autocrlf?
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan>
 <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
 <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
Message-ID: <293f37cc-3978-125a-25e1-0baef35420be@gmail.com>
Date:   Mon, 27 Aug 2018 20:22:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-27 19:32, Andrei Rybak wrote:
> 
> How about just using unconditional includes?
> 
> global.gitconfig (synced across machines):
> 
>   [include]
>       path = platform-specific.gitconfig
> 
> And two version of file named "platform-specific.gitconfig", which
> are not synced, and include only code.autocrlf setting.

Robert, in this setup you might also want (just for convenience)
to sync files "platform1.gitconfig" and "platform2.gitconfig", so
that they are available everywhere for editing and can be copied
into local version of platform-specific.gitconfig at any time.

