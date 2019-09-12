Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C836C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 06:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfILGI3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 02:08:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43559 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILGI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 02:08:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id d5so22398660lja.10
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AA6YEXRNSzpP4Y4u2W9kTJxHTv3O+/acCvNW0zREik=;
        b=W+DbPrWJzoMslPzb/vBjkejJhS6Iy2qvcgMYWQPPRzhUWNvwZ/KSNCg3Xo5NDMIo68
         yFq9izzH+KOEwmQhKCPuU2Wm468Iv6TTcCK4OPI7BXx7roD7D+vante6DUTdNXCyAbm2
         OFyIQi0CbXtGdVPJWq4CapNxkIq69IrStz/VjxzV7c68Yab2IBHT4IW/OsYMF4aWXvtk
         DHL5vDezSC5VHklXsfFLu4/pZKhSUeDL7qdKI3f20G4CsWiuu8GPtQWz13+A1u6eQ80d
         AXhS+FEXPbVq+30yyCEZSFl8m35gthbJRtJ35Enae6WGTk2KMcYDxGtklDI65wtrlV6e
         rMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AA6YEXRNSzpP4Y4u2W9kTJxHTv3O+/acCvNW0zREik=;
        b=JwVwTR4plOBfyAeMd5SeAmMbquERq8iNSEar6jEI+UEK4cEDuMM9QxA1i4YBfm/sXY
         P/lMSA5WB2GJE8RyHWWrNUC97GU9+eUZFaX0hB97ABpvVHEQDZWIGSyQVUaGOzrfJPt9
         zP/QA9JbqOpdaZ61d0CoF+zr1nw9tPhyCV4VrJDuZ+vRAqHCjcoG00iQoBkRIa/6SNfI
         4G5mc9+MOCUksXRUY7pbGDS1biUfzZb0E28vZggoYP8qDLrcNGDqiNiLmrE8LUQggbRJ
         l/KhMxOjjiOOEUDi3vPyWFejQkzSAH2nDiWkBwqx+/tKpDni90Eq0leaJS6X5rexkNZo
         8Nyw==
X-Gm-Message-State: APjAAAWdzyMCMFoX0JNPuueAGObLyeYT69Bx9t+Fi+jiW0r5sYG7JhtU
        sWwpUMsC7z5mCLZ4xvJPqTx8++i/uTofJi4LyFM=
X-Google-Smtp-Source: APXvYqyZ/XVyijgFm0tu1HkGvZLUThvb4EvwuUCIPmSK5Wa5P0eC4zLYujxqkZgBy0Xp6m1whyxJ0d0zsCWIihVOOk8=
X-Received: by 2002:a2e:8785:: with SMTP id n5mr21380881lji.210.1568268506617;
 Wed, 11 Sep 2019 23:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
In-Reply-To: <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 12 Sep 2019 08:05:55 +0200
Message-ID: <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Wed, Sep 11, 2019 at 10:55 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Also, I notice that the bindings for other letters have the same
> function bound for both small and capital letters (IOW, same behavior
> with shift held and released).
>
> I don't necessarily think that is a great idea. It is a pretty common
> pattern to have, say Ctrl+a, do something, and Ctrl+Shift+a, do
> something else. Just want to pick your brain on whether you think we
> should do the same thing for both Ctrl+e and for Ctrl+E (aka
> Ctrl+Shift+e), or just bind it to Ctrl+e, and leave Ctrl+E for something
> else.

I just tested what happens when you press Ctrl+e while Caps Lock is
enabled; the Ctrl+e binding is not invoked. That's probably why other
key bindings have the same function bound for both lower- and
upper-case letters, to have the same behaviour with/without Caps Lock
enabled. With that in mind, we should probably bind Ctrl+E aswell.

Should I create and send a new patch?

Birger
