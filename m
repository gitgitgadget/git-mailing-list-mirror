Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF55D1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 05:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeBHFqv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 00:46:51 -0500
Received: from m12-18.163.com ([220.181.12.18]:38579 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeBHFqu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 00:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=vfFIS
        4j1gbFavX3DeipG57IvGZXOZWnT4XAtc0NK0+M=; b=mcOgNuE+WPBVPZng0wWBi
        i+ErlQJ0d681OgRGI5J5mRSAWgo97u/c5cgHh04BTTR+2T1PPJd+nUm7mH69/u9A
        O+JptbhJ7WmX0Qw7+QyOyhXctfOkoPi12/PROfb9S4GLDP4rsD7016WNcFpUfF5V
        JaLNkAu9POA/b8/d/zLi6k=
Received: from [192.168.30.222] (unknown [118.187.28.42])
        by smtp14 (Coremail) with SMTP id EsCowADHmogE5Hta+gitGg--.51064S2;
        Thu, 08 Feb 2018 13:45:40 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] send-email: error out when relogin delay is missing
From:   xiaoqiang zhao <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (15B202)
In-Reply-To: <20180207234359.31493-1-sbeller@google.com>
Date:   Thu, 8 Feb 2018 13:45:40 +0800
Cc:     sunshine@sunshineco.com, artagnon@gmail.com, avarab@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, mina86@mina86.com,
        mst@kernel.org, pbonzini@redhat.com, viktorin@rehivetech.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5979434-8F78-496C-9364-3663FC3670F1@163.com>
References: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com> <20180207234359.31493-1-sbeller@google.com>
To:     Stefan Beller <sbeller@google.com>
X-CM-TRANSID: EsCowADHmogE5Hta+gitGg--.51064S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7NVyUUUUU
X-Originating-IP: [118.187.28.42]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiOwTmxlXlcO1yoAAAsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> =E5=9C=A8 2018=E5=B9=B42=E6=9C=888=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=887:43=
=EF=BC=8CStefan Beller <sbeller@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> +die __("When a batch size is given, the relogin delay must be set\n")
> +    if defined $relogin_delay and not defined $batch_size;
> +
=20
According the code, maybe you want to say =E2=80=9CWhen relogin delay is giv=
en, a batch size must be set =E2=80=9C ?=


