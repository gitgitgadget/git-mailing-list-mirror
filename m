Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F3A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfBHTLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:11:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52033 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfBHTLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:11:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4976846wmj.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TPGUwVXm4uug9PLAmZTBEQJsgxiY1JrNvUQA3EjITO4=;
        b=AQYIuQ7bew8oT5s7yhllrupT65UQy06luMF5cCdK5a37EEplBaGHKh6mdvYXE8zD6P
         GSVURt2QtWs6rO+JtA92HFChl7yan5wvTjzIXG4TU0F+MgcZWBGyHKvZXzq6PD0N7PUN
         rHly0jNQ0mi3pQEx3XqbGxs7oyxAz/kn2bPU8X7K7hxVaHqV7jbrzzdHrX+EhUDvdHK/
         kim4R88QqqdT9GcJgZ3r4gyFhRcGWwmxZABuK2feAcQKtl+Fb9W4StPyePKeK38j2jEN
         zvWOJNx07h6JW6yrvGY+GE9+YHO9l2E6TPl7HdqAk09s/HaqPw5iGrHusDjhJnve37ib
         57Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TPGUwVXm4uug9PLAmZTBEQJsgxiY1JrNvUQA3EjITO4=;
        b=hY/M4Oc94nK24m6cbE6GjQpjsE90X4X5XtzDUwi91Px9tZaJal6wFVHKFJO3tK/4wO
         8MZpmDgGV/m/3jUTMByb1uctPllybgK0rcPXOu3/XePJmrxmwORJes93UzjwrDVL8SM1
         BoGgYuo9xJiuAsjm/oC70+ilxw/krEgYqR7l3VcTzrBwbHf2n+CbOSrBmRp5BeoVjrre
         KGDaD3DoHA4ErLpEW/GYjimWuxvPpJdJUbIp1brzFpXDR8IFI2h//9yVOw+A5XE1BjED
         VFQdq3f4k56eSCNSDF6HfdpR4qUIC+yZ6yWbL3zR2sjHKEkH5C1bnnvViNS/10k3mnpS
         F85w==
X-Gm-Message-State: AHQUAuaVLyWX2Ra3EzVMlyN+4oecxohQhAQwZSexxpSp8OgWCGpfCRtF
        3PHJVIXWR6DL0BAk7hZnI+U=
X-Google-Smtp-Source: AHgI3Ib6eMTXuk2nYMzcY1Mg+hnIDZlJ1eyC+yKwDQbL9iMO3AcJVibQd+en9zlBBc/TsKQovAeJ2A==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr52076wmf.88.1549653113094;
        Fri, 08 Feb 2019 11:11:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h1sm4423341wmb.0.2019.02.08.11.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 11:11:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] .mailmap: map Clemens Buchacher's mail addresses
References: <pull.122.git.gitgitgadget@gmail.com>
        <4bfffa2b70b3d31681a7e32721985f143f23aad9.1549620078.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Feb 2019 11:11:51 -0800
In-Reply-To: <4bfffa2b70b3d31681a7e32721985f143f23aad9.1549620078.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 08 Feb 2019
        02:01:20 -0800 (PST)")
Message-ID: <xmqqpns2jds8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We have three email addresses for Clemens in our commit history, two of
> them bouncing. Let's map the latter to the only one that still works.
>
> Pointed out by Gábor Szeder.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.

>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 247a3deb7e..82cd0569d5 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -40,6 +40,8 @@ Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
>  Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
>  Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
>  Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
> +Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
> +Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
>  Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
>  Dan Johnson <computerdruid@gmail.com>
>  Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
