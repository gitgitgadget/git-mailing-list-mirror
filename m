Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97F22023D
	for <e@80x24.org>; Wed, 17 May 2017 00:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdEQAEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:04:43 -0400
Received: from m12-11.163.com ([220.181.12.11]:37319 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdEQAEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=CA54b
        XSN4qYo3D/p3Cv3FkHL49heAiI8etUplWrVyH8=; b=d7sAz9i4bYwfDPlEi95Ez
        MwEAGmS0GIoZ+PVGbNRw/Alcz5xg2h2VWgU7fCO5pUbA9h2v4Wr7B4BHfQF8C35G
        uJF1DrwJ7jEjLrVzuJ6x3KJrl9NWnYvQS5YSONLmh6pEJHaUjIpAtkifzLRYspDE
        0mQSt7RkrGvKOZFQIKy3so=
Received: from [10.202.100.8] (unknown [117.136.38.235])
        by smtp7 (Coremail) with SMTP id C8CowACXpBCCkxtZiOg_Fg--.63116S2;
        Wed, 17 May 2017 08:04:19 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <CACBZZX76ZYc=BXoAc+stKu+6c7M8CY2V+z4Mg86Y9y9GqmC5dw@mail.gmail.com>
Date:   Wed, 17 May 2017 08:04:18 +0800
Cc:     Jan Viktorin <viktorin@rehivetech.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B8174EC-E774-49FF-AB8A-2B8372AACE2E@163.com>
References: <20170513015726.20281-1-zxq_yx_007@163.com> <20170516141014.6e8487df.viktorin@rehivetech.com> <2BB8B551-01A6-4470-9370-5B1A03EB96D0@163.com> <CACBZZX76ZYc=BXoAc+stKu+6c7M8CY2V+z4Mg86Y9y9GqmC5dw@mail.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-CM-TRANSID: C8CowACXpBCCkxtZiOg_Fg--.63116S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU22Q6DUUUU
X-Originating-IP: [117.136.38.235]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEAXaxlUMBjSBgwAAsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



=E5=9C=A8 2017=E5=B9=B45=E6=9C=8817=E6=97=A5=EF=BC=8C01:43=EF=BC=8C=C3=86var=
 Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A=


>>> Regards
>>> Jan
>>=20
>> Thank you for reporting this=EF=BC=8CI will take a look .
>=20
> You just need to initialize the variables you're using, see e.g. these
> existing ones:
>=20
>    my ($quiet, $dry_run) =3D (0, 0);
>=20
> Just do the same for the ones you're adding.

Yes=EF=BC=8Chas to be.=


