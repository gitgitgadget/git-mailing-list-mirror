Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MIME_CHARSET_FARAWAY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8111F829
	for <e@80x24.org>; Mon,  1 May 2017 06:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947005AbdEAGEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 02:04:35 -0400
Received: from m12-13.163.com ([220.181.12.13]:43627 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166069AbdEAGEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 02:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=eiw8H
        QsMZIsDPB9BRn0AC1MbQmmw+cc85qh3/CoU8eE=; b=e/HV9GNBlLfx3MGM0AIZT
        /hijyr3Ww+rBPqe0V1E1LXC0zSPYp7hBAxQCJOw163xhkwb2t8hhy7PsiaqYreLQ
        wwJry1Kw7mpYexe1aPpcP8Rc8z8EUf2d8uQWj/+KzMhzF2wReYa35lpx7n7CUNA7
        w5e9h2z6g4vAjnad4XB958=
Received: from [10.196.99.141] (unknown [117.136.0.229])
        by smtp9 (Coremail) with SMTP id DcCowAC3VFDBzwZZaRYwBg--.13037S2;
        Mon, 01 May 2017 14:03:46 +0800 (CST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 1 May 2017 14:03:45 +0800
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com>
References: <20170429122632.7122-1-zxq_yx_007@163.com> <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-CM-TRANSID: DcCowAC3VFDBzwZZaRYwBg--.13037S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUySkVUUUUU
X-Originating-IP: [117.136.0.229]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEgLKxlZX2tBTDAAAsI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for your reply , Junio !

> =D4=DA 2017=C4=EA5=D4=C21=C8=D5=A3=AC09:54=A3=ACJunio C Hamano <gitster@po=
box.com> =D0=B4=B5=C0=A3=BA
>=20
> here.  We need to find a better name for the option.  Perhaps
>   "--batch-size=3D<num>", "--max-messages-per-connection=3D<num>" or
>   something?
>=20

--batch-size is ok with me

> - The code seems to do the "logging out and the logging back in"
>   dance without any delay in between.  Is it something we want to
>   consider to add a small (possibly configurable) delay in between?

It' s a good idea to have a configurable delay.



