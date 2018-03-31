Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D7E1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 04:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750796AbeCaEgM (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 00:36:12 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:45617 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeCaEgL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 00:36:11 -0400
Received: by mail-oi0-f41.google.com with SMTP id 71-v6so9100497oie.12
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NcX1Qkm/CIrKgO3Zf3h15zOLC+8TRn8zGQF1SEitJG4=;
        b=nTRvPTv4XOSVMGNbfT+ylqmi4uZyjKSIZBZKYiaT5hiqRtHLIU1vJwA5qGSGT5k+/B
         IVnLngjD7Ebxn82661zNMhssQWlhxwWQoYd9LGPIbI+YU+0z/uX1/UUZVCO11LOBIirg
         2b1+Qksfp6hEEuadmrTCn7ZXuwTnPub6KPJKmKm67bhw+Nh9zsPq3SuVbQZB1APSIdrP
         8zI0OqOGzuiVur+wK/FZpdwn7nFpF5x8AMrAgz0Aj1dbAkbj2UD2okmoac0jqTznWytB
         dLj4jcrP1JFy0anxEeLiT+OaZMHIlewPsoA5+MhO7vj1fIvU5hovLVItd+1s7IN4HXRN
         qO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NcX1Qkm/CIrKgO3Zf3h15zOLC+8TRn8zGQF1SEitJG4=;
        b=rQWogclHmzTwn9wO8LKihPHlSGia3qhS8jp9Q5NTz8x5XTERa7KFuArgFkHWh3NvSk
         Y3Kou0mifm8MYa7kx7oIyA0fK9k8v0o9RBNcwRI562JhFr/9g28eaM42W/uKyCnwoUUY
         KQ4UykTQN4UktaFSk79xNHtyL4fG7MrQwuQeNtPj1WFncNLm9sCv0NDUGcPwmIpci/2G
         gwAEeZ2RWj7s7Q7qGZ0YVFu1VhsI3/0yRZgUgFkU+cUJweDrRucV7BsH4Utg6wNIlVVL
         hRFWtyM8FNKIuq1pCH3EBe6ajtEnsOsIvPW52U16EmNUZxuuQJA7HyhtFnLnUxOOSiQn
         EBnQ==
X-Gm-Message-State: ALQs6tCb+PdDfaZWsvJ9rJvO9IEvFfNGPv2Q56ps0xmkGkulStNtTS8+
        SxM39QRO+qEyK5NdWp1oW33RrwXDYD+efRBev7c=
X-Google-Smtp-Source: AIpwx4+75bRaGH7L/fbiDvogkakDrpPDS2so4NNUf6tqSnEMNyRrM3ZGsM4lwzQDDbeZh7+a08ZF4rqMIxmsQ7CKF+M=
X-Received: by 2002:aca:f141:: with SMTP id p62-v6mr858117oih.56.1522470971290;
 Fri, 30 Mar 2018 21:36:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 21:35:40 -0700 (PDT)
In-Reply-To: <20180330210416.GH14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-11-pclouds@gmail.com> <20180330210416.GH14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 06:35:40 +0200
Message-ID: <CACsJy8AQ7yRK65rYqMkR+QJn2KUJ=Y+9E_=k3aBU78xF=LBQjw@mail.gmail.com>
Subject: Re: [PATCH v7 10/13] pack-objects: clarify the use of object_entry::size
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:04 PM, Jeff King <peff@peff.net> wrote:
> The subject says "clarify" so I was a little surprised to see code
> changes. It looks like we're just avoiding reassigning on top of the
> value repeatedly, which is part of that clarification. It looks like a
> noop to me.

Oh well... I was counting on the new name (in_pack_size, which follows
in_pack_type naming convention) to emphasize it (and the new "delta
size" comment to point out where in_pack_size contains a delta size.
-- 
Duy
