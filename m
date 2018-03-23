Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F9D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCWREQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:04:16 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:46454 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeCWREP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:04:15 -0400
Received: by mail-ot0-f174.google.com with SMTP id g97-v6so13976346otg.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2xmMR9pTwkW1SP6Cvv4y8MIdKphEIOvqsZiPso7SQ8=;
        b=T7U4n8hESqVMBBlmV2gos5XPyLjzGz6vk+uW3GSItD0DCwNyJKyq5qvlOp5YYYppVS
         3G3h+w2giDUPel18Ih++jFUcYojZHCgIoQD8u9Y51cHSeic4RYoqrm9PZYh94/fDs/YX
         zyGaqn1A7NUT2PBc/u//b/DhXgxnCdoRCdB21Za91sU8aqMUteuJaBLLq9jWAV8wrgf3
         3LVFPB/cTe6SOLSeHaJ2bMmTDMX+3dQ5sGEV5KIXewcR8dZ3pY0Fzj92kwbxSkSCifXe
         2JPlnt3umVMMBjWWOZVRLka91HZmyxvtHrPXtCY4gESs4MauWRO9pCQNS0FJb+wRq36b
         iYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2xmMR9pTwkW1SP6Cvv4y8MIdKphEIOvqsZiPso7SQ8=;
        b=S2a8GjrjCBS2FullW0ArlQXZReP1wQCIn3fiDjsWxiBwmxy1VwnnrVMTJzBj7dAB3q
         GlLVGfEolPPKU/pHgf0g0AX48uTO6aB//pEWk8W9u/vXz+NJPVMpHEyx1FGzwUDUALAW
         xyJbBtl/4k0ZsSprDdI7q4o4xy/T3U11WNLs054MtsXyTXyySRwcpg3qbie65+hTlrbz
         nLGSNjqWHKlrjN8PgjueaDIEPpygcrMwQvJeXmYOPY6a3Dy/6mYOaIbg7b/Hh+5qH2KA
         j/CXzLsDrTaVbIhHBtgM/3b2lhvqx6O/77jp5z5ZS7FZWNoReR3meXF2sTp/tl8NQcqG
         E50w==
X-Gm-Message-State: AElRT7GQYQsgikY4OMGFkMsBH/wZCGDU35Vu6R06cWidZl0A+hyrqhVo
        iSGBDjIQNyMM8w/vygS5pCwt+Nw1BlHkIIEel2g=
X-Google-Smtp-Source: AG47ELuwclkM2EHa40jzPbWMmlbGP99BMLiamC95k9S4GiZLqjNBlEpDWepAKbYpOqxfTLZSCp+pJ2yoRHgy8AzSamA=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr20140001otq.75.1521824654475;
 Fri, 23 Mar 2018 10:04:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 23 Mar 2018 10:03:43 -0700 (PDT)
In-Reply-To: <20180321221842.GH18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-11-pclouds@gmail.com>
 <20180321221842.GH18406@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Mar 2018 18:03:43 +0100
Message-ID: <CACsJy8As=iDtLm6GGxbeHB=VDUvOgefrSpBduY=Kq1O3D2x1Tg@mail.gmail.com>
Subject: Re: [PATCH 10/44] object-store: move packed_git and packed_git_mru to
 object store
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 11:18 PM, Brandon Williams <bmwill@google.com> wrote:
> You're marking packed_git
> as "private"...well C has no notion of private vs public fields in a
> struct so it might be difficult to keep that convention, it also took me
> a second to realize that it was only in the scope of packfile.c where it
> was ok to reference it directly.  Maybe it'll be ok?  If we really
> wanted something to be private we'd need it to be an opaque type
> instead, which may be out of the scope of this code refactor.

It's true C syntax does not support private/public scoping, but it
does not mean we must avoid that. Python has "private convention" with
the underscore prefix, no special support from the language either.
Yes having compiler support to enforce scoping is nice, but I think we
can still live without it (Go devs live fine without "const"
arguments, e.g.)

So I'm going to make it clearer that these fields are not supposed to
be accessed outside packfile.c
-- 
Duy
