Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8AC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiBYPEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiBYPEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:04:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3E18462A
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645801437;
        bh=NeE9FyxvssWJUy5bMvKsfR7FglpJ5n2/hZqSFxnSCg0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NWuq5U2+zAqWPW1L0M+T4DFkcBMwP9BzAqlGTB39nTMg4/6hmpZoyjkUeMPNKBXPf
         xfH3loD9iX/fHZXLkIvW6/SAIufrENnZDiM0MVO45Ecd5PkWnuWyEr7+/NkO9KSou8
         qjgXtg/4Y2lybhjhxPeoRo0Bht4bIpUvgD5Lw9Ok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1nSGq42JCD-00DVXH; Fri, 25
 Feb 2022 16:03:57 +0100
Date:   Fri, 25 Feb 2022 16:03:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Julia Lawall <julia.lawall@inria.fr>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
In-Reply-To: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
Message-ID: <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com> <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet> <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1687200457-1645801437=:11118"
X-Provags-ID: V03:K1:s5ntb5VsLNKSNojXg+N/+x2yMHxWS8FysZL6UoDT+S1QjOoFDNM
 ImrHj/jN50UKGPFp9ngr/xAB0q70GYVBou9QUKd0KpF+pwJtHiXreyDNQcEXstgIc54UEEm
 bXalHW4MBvuUMispSi32vsDSsChY73BZigQlbiBEFANlIguT2HzBScuGD5wZQ3l7ZAZDVvR
 DkplhiEkOdnT+CLpSuiRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q5Ik57tstAs=:40eb6fueA/mjwERCyqL2PF
 vaTXJzM+h/wHdfon7iSeb5w6fRGeoTB2fyyc2gUY2yRRnXX1j48GP3qBmZlm59aPTY53sdbKl
 eHjuoAh3Z5XTc8R79uOJ02psmqn1ic2Ol9jY48jt7Y9va85kA6VeGcHSee3gLTZI5QM4XPVC4
 /uvuqcOcsJjx5n7MulN8rKVwIzc7bdNRjWG4OMZaFpyj1Ayi3bR5ad97BF/bVaCFv7SE7r//k
 LXcP0+TuaEhob0KmSsezlIseKU0Im3MmE3/X7LTOlFpE9JRJXcEiaHeqadQ2ZKiLGCD/18F4m
 ATm90sArArG4PRDKYJhME4jHgKtAtX2DBREBk/Aa9qeHnZtT/otinJT+91Ckrj6u7yiK2PYnv
 kWcV/XiU7l0gBXA+5pB+trpwK9YkhZ69DDEkklYYzTGGBhx9nKfAzvUNeHKrOZ3qDT5MHZgBl
 N0Oz3Qr1olipJF/m80gwLrVg1IkthJEHHQ32PRHrUbscJIX4Q2DjiME8hT0M98bwWJ1CbgpG8
 bfhNgkMJ9FYgwbnEncQH0Oso/AlADkR9WKcE2T5nSaW5sIF5RHOQRImb/5s2p+im1qn2M4I4U
 0hWVuQfXBH3XFBPVtfNu8E42pPqEFGulI/Sa1ZGwFyxmtW970GqAOGGbuS0YlidPAD4GlC9L3
 QVEdvS3cldQWNiVbTeSYBrVxHA2zkErXk2VI0v8ipPBiJbSeFvhb45apYlYoERzQjcjOmx0uN
 F7eu6+vvjhqjUbD7yRCqBhnEviddK5hRPby4Lsu6eOcuB3lpLP/pJHmEFtjYYwZJj9iJ4VfSu
 HWMIiQwWVagBFr8Rl8iIM4h2PoGF4ilYHk7p4Cy/VVOef7ICm4HUagPQ/+Upt2Y5XU6IAR7rg
 7ZN+fsh6kcoLrr6FtNTkJj5nbHm/e0v9XxeqnUjdgryhgAHXF7XyM8ezCTVOOZmqouv/+VIsQ
 E5WN2vzhydx7FxRSR6UGYQkhZA2U99rRiIp4rXzURG0VpWNtrynz/7bjRn5zh45XC6oRQtMo4
 LVOYG7insxzwJzgXEym08tuqlf29+d1dZSY381hOYJjh+foHR5OO/o6ONWOHLZheAyhXI4oGj
 BbbvNmsjzDdGE0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1687200457-1645801437=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Tue, 22 Feb 2022, Julia Lawall wrote:

> [I]f there are some cases that are useful to do statically, with only
> local information, then using Coccinelle could be useful to get the
> problem out of the way once and for all.  Coccinelle doesn't support
> much processing of strings directly, but you can always write some
> python code to test the contents of a string and to create a new one.
>
> Let me know if you want to try this.  You can also check, eg the demo
> demos/pythontococci.cocci to see how to create code in a python script a=
nd
> then use it in a normal SmPL rule.
>
> If some context has to be taken into account and the context in the same
> function, then that can also be done with Coccinelle, eg
>
> A
> ...
> B
>
> matches the case where after an A there is a B on all execution paths
> (except perhaps those that end in an error exit) and
>
> A
> ... when exists
> B
>
> matches the case where there is a B sometime after executing A, even if
> that does not always occur.
>
> If the context that you are interested in is in a called function or is =
in
> the calling context, then Coccinelle might not be the ideal choice.
> Coccinelle works on one function at a time, so to do anything
> interprocedural, you have to do some hacks.

Right. The code in question is not actually calling a function, but a
macro, and passes a literal string to the macro that we would want to
check statically.

I did have my doubts that it would be easy with Coccinelle, but since =C3=
=86var
seemed so confident, I tried it, struggled, and decided to follow up with
you.

Thank you for confirming my suspicion!
Johannes

--8323328-1687200457-1645801437=:11118--
