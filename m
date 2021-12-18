Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ADEC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLRAuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:50:25 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:49714 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhLRAuY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:50:24 -0500
Date:   Sat, 18 Dec 2021 00:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639788621;
        bh=5aiWLHE7A0Vgy8kbiAuhlP8KIU0sNNfmvhSa88SuENk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=MafQuf49m5Dz+B25TKQY10FjRI6VQSCVan9N+hlDE3eBzZ73XELIj5au1Hm1Th3zB
         NoRGm26t7ojYKZ+hBiRSSIBQfNnTgayu3F0RN0rKfDEKCgbgbInbylbzDDZ4RkJIWI
         J0ZFL0LrKl+7mGF72T6sdS0Dl8AtZwbJx+JV0s/JBzMV3JIMyd75RGXN1Qk3aVIneO
         LlEpKZC+PvB5WoakxMrY4Aya3uif+OvDRW/dcezSMr9mzoe184hmtKxn0dEMbRBccv
         wFU5vyz+QQYfSNdF9iOdWLyt02BiKLgQTU4p43JN2e5Z6QWEGGWp35qR8ebAncqOna
         mGKaY91Y5lWAQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <NcaqpHwXfrPNnhzTamuF_xESMQUHMdzLNbHXKOJY59bkJdsT63Nk4PksqQXfqygUMO0EZRFBJeS90r59Tvt2I4kXH69TSe3RwQRXQThxRRA=@protonmail.com>
In-Reply-To: <xmqq1r2a220u.fsf@gitster.g>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net> <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com> <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org> <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com> <xmqq1r2a220u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, that sounds reasonable, Junio.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em sexta-feira, 17 de dezembro de 2021 =C3=A0s 21:24, Junio C Hamano <gitst=
er@pobox.com> escreveu:

> Jo=C3=A3o Victor Bonfim JoaoVictorBonfim@protonmail.com writes:
>
> > > I suspect that for most algorithms and their implementations, this wo=
uld
> > >
> > > not result in repeatable "recompressed" results. Thus the checked-out
> > >
> > > files might be different every time you checked them out. :(
> >
> > How or why?
> >
> > Sincere question.
>
> Two immediate things that come to my mind are lossy compression
>
> algorithms (jpeg pictures?) and compressors that do not necessarily
>
> produce bit-for-bit identical results (e.g. gzip by default embeds
>
> timestamp unless explicitly told not to from a command line option).
