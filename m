Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF9C20958
	for <e@80x24.org>; Mon, 27 Mar 2017 06:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdC0GBb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 02:01:31 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:37932 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdC0GB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 02:01:29 -0400
Date:   Mon, 27 Mar 2017 07:55:19 +0200
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-Mailer: interia.pl/pf09
In-Reply-To: <xmqq1stj4kmp.fsf@gitster.mtv.corp.google.com>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
        <xmqq1stj4kmp.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: 178.36.22.46
Message-Id: <kczrpegpzxhedtxmjptr@skdf>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1490594120;
        bh=YIc8C6wecmMOs/1Ve6tncfG0dPwbvUvP4DU9xTe0CNU=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=DHjCFsOxhBFi6UnoSjiR4Up2rpZQohWl7uYtSf/ppswwaXJwGNAfkJd5PiMI4fxx6
         v/MHWtQlY4QbtIm8QQBVdGv2EX8KhOMSR8R/6SY5/oSaQF+/EaC/Kc9o2BYiXLEHZB
         ATrEHm2Pb/CnaaqL0AQ7bjMS2iDR+3NL5pDU2XzU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Od: "Junio C Hamano" <gitster@pobox.com>
Do: "Ren=C3=A9 Scharfe" <l.s.r@web.de>;
Wys=C5=82ane: 2:40 Poniedzia=C5=82ek 2017-03-27
Temat: Re: [PATCH] strbuf: support long paths w/o read rights in strbuf_get=
cwd() on FreeBSD

>=20
> Nicely analysed and fixed (or is the right word "worked around"?)
>=20
> Thanks, will queue.
>=20


Is this patch going to be included in next git version ( or sooner ) by any=
 chance?

Thank you, everyone,  for your attention to the problem.=
