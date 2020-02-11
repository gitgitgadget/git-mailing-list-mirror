Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275DC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04662070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kOPn0C2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgBKXjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:39:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:45973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgBKXjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 18:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581464371;
        bh=ojz0mGOTVTzx4zH5NZoniu/G1Sky8FTkLm0UJ7fEXiI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kOPn0C2ccqx0F98Is3HbQzTmY5MQZ7jJIU4er/ENsrkVd32ygqC7WJP9Yy6DiELUh
         ZkgdnjKlXymCruszOxDFzSL4MUkcIBsUqdf56fCuTi6jbsPj5gDC45v8FVSxYKazUx
         MQKRfv0ZqjOl1kzrasM0ZslePwnmdnAeDvtHbKdI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1j4PDY2v0w-003tsk; Wed, 12
 Feb 2020 00:39:30 +0100
Date:   Wed, 12 Feb 2020 00:39:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/ci-squelch-doc-warning, was Re: What's cooking in git.git (Feb
 2020, #02; Mon, 10)
In-Reply-To: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet>
References: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I0LB5epSAFcSVrMLnAbx3uSfkLHlq+peRYTyQDh8C968idLWNuT
 4ZdNs7B2/yaLK6xsa4RKkvWJsLexYLyNp29kBiX+0cX0Lk28nn/z3wAK1HIFXdDkynnwJNT
 zFK4uL7pW1BSnnfW7dPGVyc3G9IGGaSwoIWav48kGxS8SC1dHPS2wowQ0rHhPGx3fHMa0YU
 6VxWP3L18SbUy2kTueE7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ig2z1f6SyPQ=:0Id0TwdF+h4n3FjoqLmKa/
 yfe+AT8M6lgWaDyCeKyEwkdsV1poTleYyWaAP0i3UXmzEY407f2RkvwM3qTCCDreGo+J3Aa8X
 g0V8pDzx5A3PgrqDfuPGljq1g0hBHn1anoikAeEcpOS/mFWt/ku7W3KtYfqb+ZkEmz9JfNs6B
 imKqEScJT7X3gE3OySPrGVlh1B/51GEkGgmWs11iTrHlVP+IRcdpfmzr5P/PA2SsA899xWkls
 R8Ox+AmCj/WZ1iqB/tJMo1f2CJ2wI9VSatI9P5UJyfxF+4u3dECNGaWpMo9UQxC9k23cSoG7I
 5mk3XJ8qzrL4tWzUOgUQnJqQv++VxDqv8NA931HWP/RmGmaqckqJFDhXKl9t1nDrbzRPjspWe
 Sxit9Zv/wdHxWxOdMjQ+NDvWMy/GA7+EjDNcbZvMNph4tUc6HBFMfwNI6ik9/8+alr8WLgqpW
 OzBh/MSXp3GPk04qdP1HFAoFokKoSxGONmIQ+5+gevsxoAunZdK/thjCgk1xE4ICn/Pkq8hPa
 XApt7m5+dl9yOqvOPsrB2+bbmkWF2GMmR1vi6gQu6euEKh4C8gQDtqYQqOCFf20+x7/ufM/TX
 dcazuJC6a5OT6ZGWalOQvYO9bcW2Bbg/YgiVpere9M6tSULp95Ur1zdZktoL/ACIOUBHBXRT0
 M3+Tt7TZDkoSam35+T7fvkN/2y4W+kVptY7oMRneMzAyyeR195Vu4RKjZTMYLSsXMhXdK6pGc
 bnf7JXdo8yD3A38+orw6yeMbIdbHNY6BlsIsGTEUTm2MMH7u5iCPWgw+LmjXYHjNZjYr4ofQp
 J4a9JIk6uYSQAjyIojBXzXnlR+7TRoAkte0dpU+BltcOLEKsjMRpzvdeQJeI6J7CtuHyjOMjA
 FDE2Plio64m8oZpn21eUm+Hy5HhpzBDrykgmuiNiJT1FFPwIUVdxuFy3puq0XPvKaVVJyhVx7
 TaKaDIQipZ5qRXLh5F+IX4NQYEZSKitGBwl2LzBn1er/avwZrs2UhZF/i0nwg3IfNZMdz8Ll+
 nalMgUZsnfbYSr+Y4AF+B2DLmmSsCWdMbQcQv9S4mE58qv5GlvwSopvBOoUZ/NWuBBeOr/R+y
 IUWIbW79wZVP564YNfCbNUYbAXfUB3fC0KwsBwog9QQOrOlJcAqIRWvZxjKg0H1TfrvSH55cs
 BWVm+MpOdo7QfJMcM6rU9vvbm7x7klTdUKGQzGVpDMW4AtKh+8O2b2dEg7W0NVLmEqrzP7Zed
 mh9LbgFVUhuBjMJhQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Feb 2020, Junio C Hamano wrote:

> * js/ci-squelch-doc-warning (2020-02-10) 1 commit
>  - ci: ignore rubygems warning in the "Documentation" job
>
>  Squelch unhelpful warning message during documentation build.
>
>  Will merge to 'next'.

To be clear, this _is_ a warning message, but the CI builds are _failing_
because of it (the "Documentation" job expects `stderr` to be clean except
for some known warnings).

As a consequence, all the PR builds at https://github.com/git/git are
failing (except for PRs targeting `pu` or `next`, but I don't think that
there are currently any).

So maybe we could fast-track this change all the way into `maint`?

Thanks,
Dscho
