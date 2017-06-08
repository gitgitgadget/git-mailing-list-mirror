Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA2B1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 09:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdFHJHH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 05:07:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37650 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdFHJHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 05:07:06 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so16947285iti.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NPItXgkQia/SPAAx9Cr3E3vD4iC2Qs6yi6f3SKKkhdQ=;
        b=MGGwZyDGfFJKz8R/6gzKORPlwTkC+h5KCcpDDIMrzENGFBuvlJskkT2DgGcDlBbIyz
         sXn4gVwdZ7YU5DD8HmJnENYx5mMcuRSFqyHc9fjlhX29FmV+14y/U7hnnskfadv0i7rf
         IVhOdvY3r3Kv3qVEd885YrpuFtOGEfb9Zn8dfEuSYPqE7xdIDxFq+Rhw1Nw1vhiSp9lM
         cKehWje2TWIeDGOlWugX89jQFHVXzK6tjF8QV/XZohM6DgWsNl8ezjj1g+ddJsik3Lz9
         YmQusTYgskOH+vNYIil8XOA7Wlzs/bDOBQKsPPR38X0I8hbDsSPFUbfm0x36LYSbVD7Y
         FTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NPItXgkQia/SPAAx9Cr3E3vD4iC2Qs6yi6f3SKKkhdQ=;
        b=VMGfcc/n+mEwZmrk7QXnn/kxrMHuS5bq5Tck/EnmiBI1WLs7Cv/y4KLCu5xYtKdrXS
         rnbqE0K9jYdci015obxLqZZWUfFJW72NdcS75JZDFKeauv7FjJ26urOkwJynzRLh5Lj+
         pBwGLbPBn1iWFm0H44OsAFL/PcxlEZeLIyQfHi8xwjithg8n/GcG4G3XkE6OE3bGRqHv
         U15F04C44qnKCO84M+pOdphvUVqtwMP8cFr7B9D+/LrV8Ue7k8RsnfSoswWR4NngnAt4
         OKMQQ/EHDg7FFHtqwz/l6D3sql6LvMAwwE6wKsBOXLasw4gBo3EtYn8NdrjZdc/rnavN
         nryA==
X-Gm-Message-State: AODbwcAiruk+2JTJSrCQQmOvFYIAfj0I7+EohgKizQGZZMVUpdBsr3Fm
        O+xU8ajvSiNDm9ewubhSWnNAt8U1RA==
X-Received: by 10.36.120.66 with SMTP id p63mr4389955itc.22.1496912825671;
 Thu, 08 Jun 2017 02:07:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 8 Jun 2017 02:06:25 -0700 (PDT)
In-Reply-To: <CACBZZX5wr2k0+i-0CKde_P5key=b+mh0jf47D9oJ449j=MohSw@mail.gmail.com>
References: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
 <CACBZZX5wr2k0+i-0CKde_P5key=b+mh0jf47D9oJ449j=MohSw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 8 Jun 2017 05:06:25 -0400
Message-ID: <CAJZjrdWkqNVLgZ5KYQ33zjO25raLhAHGxqPezjUsQ692wKTudg@mail.gmail.com>
Subject: Re: send-email: Net::SSLeay failure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I should've been clearer. Currently send-email fails for me
with this error:

SSLeay.c: loadable library and perl binaries are mismatched (got
handshake key 0xdb80080, needed 0xde00080)

I thought the undefined symbol stuff in the .so could have been part
of the problem, but I guess not. None of the fixes that worked for
Liam worked for me either, so I'm not quite sure where the issue is.
The closest I've found to a meaningful suggestion for the error is
that Perl is relying on a library built against a different version of
Perl, but I have no idea what library that might be.
