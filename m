Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A1320209
	for <e@80x24.org>; Wed, 24 May 2017 21:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033786AbdEXVsw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:48:52 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33584 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033727AbdEXVsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:48:51 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so147683747pfh.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pX9oT76YF2PWhD7i9huhb/KvEdK745NkWRcs6IRwBs8=;
        b=QpAw7h6S9x06ZaEPJM+7Nn7Am18npAwIFS3+uJ7gnzEd400OH2dCfSPkZaIcbwKukT
         PfrNxecGvt8WtwUqZbPhn63KpJgQ/gFdFL6q+QyM8qe8/2y5WDFSG+JYGo9hTl2aa9Sg
         S/PdYWep/PSaSl2eeVxsYElN6vyxvN4lC1ud5vxxbqb6bDwiSxUETV1rxUa7vCRWxFPy
         Mk7xpm66KkziSjSUurItOEyqXw2BZ1hqgIhldEDD+bbsORWgHHX4y3DWctvi+iyT2dwm
         r9ykaFs3n3t+/9u7Fje45zpID5DOB16gLoMEa4nqftitUsXGZ81FcVh1c4cLwhe577Pe
         l17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pX9oT76YF2PWhD7i9huhb/KvEdK745NkWRcs6IRwBs8=;
        b=mX3PfH5mQ97ywyUy3Czvjd3HGTjBy+cx/AeLJken0okDkr1wtwC7iSepKhcvJyVPWq
         r4+iN5KVVEHVAjFFET1ouRjO9SRxjmO8C+q6wqCLvzzOGJeqzdZ+nlp0mhX/s0sL/43Y
         1DJDJArvomlWtMwMfPBiGrNEJkXe1krJi9wGhGNdxUi+wg2iLz01Sb4bKMvmOyOJRPpj
         0XtWDSeUxzgbQFu1416anXGEpaYgsb+J+BJbpCLBtZPG+jWGHIFqJs1DtgvXK1nTYQUJ
         eUV+JSK1uuOg/FTa9e8AY8Z8Lw97iVDtfuCAsQbJCzb3v2Lw/b1cSUjeoRsTWiZxwb2r
         rZaQ==
X-Gm-Message-State: AODbwcA9yZuRj9DmTayDYSm36cQGAu0sjk3ldtDJjhGnaOdnNADaLY9i
        sRwPZoUiFG7xddPSAGumirisZHULCwa3PIA=
X-Received: by 10.99.126.92 with SMTP id o28mr42459243pgn.63.1495662531128;
 Wed, 24 May 2017 14:48:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 24 May 2017 14:48:50 -0700 (PDT)
In-Reply-To: <BN6PR06MB3475A0F44B37A82175E86871EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
References: <BN6PR06MB3475DCD7A2588E3EDBE07E48EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
 <BN6PR06MB3475A0F44B37A82175E86871EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 May 2017 14:48:50 -0700
Message-ID: <CAGZ79kbN_cW_TMOs08ePqAMLqNTxP--sU9XUS2k40nBgJGY3PA@mail.gmail.com>
Subject: Re: Sama/Winbind AD Computer Accounts Moved
To:     "Thompson, Matt" <matt.thompson@ttu.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 2:46 PM, Thompson, Matt <matt.thompson@ttu.edu> wrote:
>  I realize this is a Samba support list but I'm curious to know if someone may be familiar enough to render a guess.

I think the primary purpose of git@ is different than samba support. ;)
Wrong mailing list?
