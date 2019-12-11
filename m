Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD1C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82615206D5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="ZnIofhLS";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="ZnIofhLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLKB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:28:42 -0500
Received: from fallback22.m.smailru.net ([94.100.176.132]:43418 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLKB2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 20:28:42 -0500
X-Greylist: delayed 3139 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 20:28:41 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:CC:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Date; bh=5yBosEB2ldSSPZmcSEc1FbH1Y8hfb0edDU6l+jcn7b8=;
        b=ZnIofhLSGnarI4GNuvgmznMhWMSu7omZdWZrJCPlXvXsqpYaoUvNY84DKlcRwn7hlITzvdm22Kefyi+Xq6GSKRqpDs2ITGAoQCotbQw67aXw67q9Ce3eMaOrAJkr0cr4mXTjcYeDUDe8f8vS8G74NR2CKExCGjc31iGsxsHSntU=;
Received: from [10.161.22.24] (port=48560 helo=smtp54.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <kolan_n@mail.ru>)
        id 1iepzJ-0005gV-37
        for git@vger.kernel.org; Wed, 11 Dec 2019 03:36:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:CC:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Date; bh=5yBosEB2ldSSPZmcSEc1FbH1Y8hfb0edDU6l+jcn7b8=;
        b=ZnIofhLSGnarI4GNuvgmznMhWMSu7omZdWZrJCPlXvXsqpYaoUvNY84DKlcRwn7hlITzvdm22Kefyi+Xq6GSKRqpDs2ITGAoQCotbQw67aXw67q9Ce3eMaOrAJkr0cr4mXTjcYeDUDe8f8vS8G74NR2CKExCGjc31iGsxsHSntU=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <kolan_n@mail.ru>)
        id 1iepzC-000172-Os; Wed, 11 Dec 2019 03:36:15 +0300
Date:   Wed, 11 Dec 2019 03:36:12 +0300
In-Reply-To: <xmqqeexbrffe.fsf@gitster-ct.c.googlers.com>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru> <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com> <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com> <20191210205056.GA14079@coredump.intra.peff.net> <xmqqeexbrffe.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license?
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
From:   KOLANICH <kolan_n@mail.ru>
Message-ID: <8E1DF461-094C-4BBD-9F8A-575A45ED051B@mail.ru>
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2E17AE4FBB8DCD5A279F9D4B0C28A6DEEF688BCB05C26794D735BAB88EB1AB255C191B75660E600644D6555807B26807752C7DC8D19D8AB9AC77A06E522078DAD
X-7FA49CB5: 0D63561A33F958A5A299C50361B2DD73FD345EF5291A43B5D1C46974DC82F6EE8941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22492AA437DA6D0FD5573AA81AA40904B5D9CF19DD082D7633A063753DB72453AD9A3AA81AA40904B5D98AA50765F7900637D2C6F5AE34F7A4E5EC76A7562686271ED187B4DA314F1B5535872C767BF85DA227C277FBC8AE2E8B875DE86EB28C123B7E906E3727204FE835872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: A36CCA5E968A4DC96657DB7F7E6A9ED03CF0DCF8AC1B58E2166D42D05A940D8115634F2D3208598D813099610F3EF9D23DDE9B364B0DF2895C73AB06C8DF2F26327D77830F209D78AE208404248635DF
X-Mras: OK
X-PR7D5YW: DF2ZY7JUP
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDCA9256AF7A639AAD2EE2D16D473AE7728373E406096F16A43014C54FF4B30FA2C
X-7FA49CB5: 0D63561A33F958A5186EDF39BBAF0675737D0ED146521041FF650BF36608E5878941B15DA834481FA18204E546F3947C062BEEFFB5F8EA3EF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B8C7ADC89C2F0B2A5A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249B665D0F56924861A76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B1656590379454B663AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90054EBC784E05B222904EF3525F77511EC8EE2D16D473AE772884D8E182A4425033813099610F3EF9D23DDE9B364B0DF2895C73AB06C8DF2F26327D77830F209D78AE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> spend the necessary effort to comply with the license as a waste of time=
=2E

Necessity to treat so called free software with a technique invented to de=
al with closed-source proprietary software by companies enjoying their wall=
ed gardens and vigorously protecting their walls integrity in courts is a c=
lear sign that there is something wrong with the software=2E I don't beleiv=
e that free open-source software should to work this way=2E
