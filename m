Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469E5208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 09:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdHXJsG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 05:48:06 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34024 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdHXJsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 05:48:03 -0400
Received: by mail-pg0-f46.google.com with SMTP id q10so715717pge.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dnF1IRb2670geNeduMhkuqCpx3eK+FczxQ4a80MHbJc=;
        b=NlR2cY4xzvwnEVGBf963U0W5L6wpjp6R3sc5oYqt+SgHSYuVfgv4SccEDXPW/W8k+o
         qilW3K3vB9eh7RJE0gnU3b4ThYQTeaME37x5Efj8bpdCnPB+eE20JT+6P1oz/w9HFe3A
         h8P5dQB7qampi7oRP7kJP+uL3q4FBxerP8dtuQCqgZJneaeyaerS/BOvuwWGyEkMUJnl
         O96WhPv/FgSB7j/GzQpWpLb5CngYgNtnkqC7ORRPREPrHeWH8elCO/N+nOZdHME3ar2Z
         E+yDw4buZXPIqghY/v6mdaodTFGn9tE5VM1zHpfTmQSmJD0Er5zGokL9P02aqZSHjXiK
         fCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dnF1IRb2670geNeduMhkuqCpx3eK+FczxQ4a80MHbJc=;
        b=oGQ+g4I4CuxqSGDLo/BtlU/AZAV3VfUsWCsEtKA33vxx5t4OSBzkKtv/rwo3xGC1W6
         lXoAEuwNXjc9Ojlx8XJYRBnY/k5iB2N3F5FI+2SbdVEfrCXda1bVO1N6n8xJ9FX76ovN
         PJ1j0lagJyUDYTbXHKjvnjTKRrYmmbNxa1+dlhjb/tyyC6X1VAI1Agz+1mr1/D6zJ/pg
         6XN8TfhaZJjI4ynRtEBOb0bvpuBmZNHCAM9PgugcDA4UmUXMaKdiJfO4VI5pmSP0GZ45
         +oXEqJgMh5c7XMZZN7WHTI3e7+N5cH58gJf86efVHGQgA7bUvs0iZ4//TY8oBhPf8txu
         gNeQ==
X-Gm-Message-State: AHYfb5iBCQi6JaNuBENJrIOMGX9Z60CRYcfZXaKjlgDF4K9WkXUTA+OM
        FnR8eev2ZXk2qRph/dnYnHC4iZ6yEg==
X-Received: by 10.99.98.65 with SMTP id w62mr5955977pgb.362.1503568082986;
 Thu, 24 Aug 2017 02:48:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Thu, 24 Aug 2017 02:48:02 -0700 (PDT)
In-Reply-To: <CAJXxHvXqbwdyW0U=KQ_iRoZg1zVpKr1vchXp7+8eR8ZE2qUGdw@mail.gmail.com>
References: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
 <78619186c5d587de768f3c5ff033dfeb97bab645.1503494617.git.martin.agren@gmail.com>
 <CAJXxHvXqbwdyW0U=KQ_iRoZg1zVpKr1vchXp7+8eR8ZE2qUGdw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 24 Aug 2017 11:48:02 +0200
Message-ID: <CAN0heSoNvGqH35KZhFft=oOECw+6MMBJKVW0BjF4Z1S5TR9HWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] treewide: correct several "up-to-date" to "up to date"
To:     STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 August 2017 at 05:51, STEVEN WHITE
<stevencharleswhitevoices@gmail.com> wrote:
> On Wed, Aug 23, 2017 at 10:49 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>> Follow the Oxford style, which says to use "up-to-date" before the noun,
>> but "up to date" after it. Don't change plumbing (specifically
>> send-pack.c, but transport.c (git push) also has the same string).

> These corrections all look great (English-language-wise). :)

Great. Thanks for checking.
