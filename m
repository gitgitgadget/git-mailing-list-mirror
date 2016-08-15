Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC021FD99
	for <e@80x24.org>; Mon, 15 Aug 2016 06:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbcHOGRw (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:17:52 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38895 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcHOGRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:17:52 -0400
Received: by mail-wm0-f43.google.com with SMTP id o80so84215035wme.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:17:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+aiE/4VPHEv88TaGPAAHSATm/NQTx+nWKXrmJRgNHJo=;
        b=zXPxt+R5LC1dheWs04CNskYmiB9r5fQRUwfCf3MNda2tcguwguLurppR+/OuUOtirT
         kS+V/ApXhImmOkNfP5r6LusgwFor8S9Bc92Wxj1PMxxroAaATHePWTRs7ZGTwTohpEm8
         EPqmMy8L2f95+sQMtuGiwhasZqBpdlgXWt4DAygEIwfBq4fw9w2LZTgJXqXqBgNWDWpd
         B7dgxwO7O3VMS/kXc+mIFK1aVGOlJlY0O1TlaJMY6tk/8RftC6hD2PYcbpkaGyMtZlyW
         /CtpcR266OIJM1btYzmlxoDKnONx5ky42wDyLYrDUtJed5xj9VTvz7wRG9E7lNykASn4
         bHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+aiE/4VPHEv88TaGPAAHSATm/NQTx+nWKXrmJRgNHJo=;
        b=jstE6387e3Q+3bdu30bkHAuIDTH0g4LGcnxgGIiAyYnfcgFbIylIzzUaS5FusGsVwh
         IFo58XiZMdkIOf6si+wJM9XdvTNyNBX7s3erotratkzaMI5ftSxg3o8ZSC3k9r2cfmhH
         Ac+op1/H+bNRxHsSAuWYCStqAydG3iiEC2h1XKPDL0naR9Rh8PLezDkCXJf4czauwmbb
         3CZ2oOcEnzFk/ILaJWxw/PmVfWjlldKxlfd8MzpMKYPM6iuSpGfQwgfZg7zpKQrpe1Ko
         5YOYzLLi6hc/gEHoaRnzjw0SfWni5Dyxr0Y4e1sUs3FPKOjY+wjc2CCrJ2E+D53DugPA
         gK8Q==
X-Gm-Message-State: AEkoouv2Vh4JPlBw4F8p04HSyr0x/U9cWgjnDUf2kC6ULM2w8Sb7HhB47D0C3EkX9cnyH/6PHhenoXsK/WICyg==
X-Received: by 10.28.88.144 with SMTP id m138mr12157322wmb.79.1471241870450;
 Sun, 14 Aug 2016 23:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 14 Aug 2016 23:17:49 -0700 (PDT)
In-Reply-To: <xmqqeg5rkqy6.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <xmqqeg5rkqy6.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 15 Aug 2016 08:17:49 +0200
Message-ID: <CAP8UFD2mfa2hNDknEt=bsbXVn4xSSiyVYz94KL_JPbD66QrfPg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 18
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> You can also reply to this email.
>
> I am not sure that is to be recommended, as that ends up going to
> the list, but anyway, these
>
>  - Michael's "finding better -/+ assignment in diff using indent
>    heuristic"
>
>  - Philip Oakley's updates to revision range notation documentation
>
>  - Kevin Willford's rather clever optimization on internal patch-id
>    computation that is done to exclude already-applied commit while
>    rebasing
>
> are interesting/noteworthy topics that may want to be covered in the
> discussion/review section.

Yeah, these are great topics and I would be glad if they could be
covered by someone else ;-)
