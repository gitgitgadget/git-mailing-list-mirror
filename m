Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F7EC433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiBFKD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 05:03:59 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3007C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 02:03:57 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id A97B619F574;
        Sun,  6 Feb 2022 11:03:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644141836;
        bh=PGPn2zsJkgTa8PgxMW4UWF/yZpemXIWMDqvdGiLvXdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF/5/tBDFRlcenxD+ZJr7VKrgVB0cHgPHuyVa+b6xe/WdhnX/na1QJwyfRLj5j9rR
         QDmCpzkV8f88MzTLJKzg9RyksXQX8yKTNzJitAGMYSRzodk6jKLciYqokedT3gJ1HJ
         GQwyQS6ULsmJoRo5ZW7SjBKILGh8QEED0+dGF5hhuvEcnX/OY8vdBac9vgNNQJM4uP
         hXqMPeNFIKz3ja00WccW9d1OSezuIVCcw83LSMP6Tsx2i70mQmLOQIcb0XODbwciH4
         iKXH5bJFDDwr8SysAPOkTr1bTsdagM4xZhwVdsBKWxzDdJy6y/qDjiZNV/ckWTgO1k
         KEz8C6j4xcbgg==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ja/i18n-common-messages
Date:   Sun, 06 Feb 2022 11:03:52 +0100
Message-ID: <6114905.tHSIdXRuFm@cayenne>
In-Reply-To: <032852b5-0cb3-4515-592c-9433930946f3@gmail.com>
References: <xmqqr18jnr2t.fsf@gitster.g> <7408402.9NgVXbFLuH@cayenne> <032852b5-0cb3-4515-592c-9433930946f3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, 6 February 2022 09:12:08 CET Bagas Sanjaya wrote:
> On 05/02/22 19.18, Jean-No=EBl AVILA wrote:
> > Bad news: this implementation is already crippled. For instance, callin=
g `git
> > commit --fixup -m -c` would first bring up:
> > "options '-c' and '--fixup' cannot be used together"
> > Then remove --fixup and you get
> > "options '-m' and '-c' cannot be used together"
> >=20
> > This is because (according to the code, I don't know if it's really wha=
t's
> > wanted) the real logic is
> > Exclusive ("-C", "-c", "-F", Or("--fixup", "-m"))
>=20
> I read that your intended logic as 'options "-c", "-m", and '--fixup' can=
not
> be used together', right?
>=20
>=20

In such case, in a perfect UI, I would expect more something along=20
"option '-C' cannot be used with '--fixup' and '-m'"=20



