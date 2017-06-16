Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC9320D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 11:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdFPLes (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 07:34:48 -0400
Received: from sonic312-48.consmr.mail.gq1.yahoo.com ([98.137.69.230]:37160
        "EHLO sonic312-48.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752450AbdFPLep (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jun 2017 07:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048; t=1497612884; bh=Hr1y6AHxwEZYUG6Pf7QuNUMGXJJSi757AXz92LNXr1w=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject; b=jG4Xk1Kude2qyv51Hiygil1OlPnyM1psZmSw6RgmV5oMeoGOCS+jFoGilmPXyULClxrqYSk/Mb5B6Qs8VVClob1kj+HIezXoIdIJw7yU5xJJDKtqr/Tdc6JPvC8eVBEvcQn7ViKyzJqYyujOp6lach2kIvXFUSdvT8Fj+/CXdd9101kGznanSAXH/eU9Ec2oBEWyoZhvdsVmAUoYY81YWcVk99heSYrMWWWgI9n95t3q/8N8chcp5tVkAxSlvuMSpO3rdMapQ3IgOsW6e0W1M4ZgT1W0dW6B1y9x48t2S4L5YuY3cA7MaZUTTr+vhcb/Rj37CKbWA777JW997zaA7A==
X-YMail-OSG: djl2m1YVM1l7VWWgEvyU8ONsIptMs3l6xp_twpcqKGSNtv0n1wCbWGUrXLeh_s6
 .yvwPayoBrUueZMo10W66rHKXwRvDOpW8CGaOoZeWnVW7ZhObN1GT6XLAsCQI3lLl4GDEx.Vw9fM
 x67ugJ8Cx78auvrPMJkIJzP9k58QAvIgki4oranbB7mM7CMFceEuJtxC_G1puc.hWrav4fVtxVVs
 4VH7i9SPZeiB4wa9jh..fz9zfqISKWihSCNmkHBHoZX6u1jpMb_O_mVpiAH_LPt6xVe4ewoPBstU
 RxcPSH_ZEG988J6uLxLJY.8cUIG8HnU0XEToKBHkM0PTexpkSu7E4kkkKabJLT7b02HYK4ci0A0Z
 ySIcOJC1NNmk3nTJ.khOkzgh_e9aI43qgdQvWCSz8GovTCpgG9OVB1_O1aJh1GjgjDiBmAGYbKFV
 WcUyPRQtLswlVRtwbgHReTTXmT6fu4gzp2AYBy2dkN17nKThyUozcKxwvNOdGjpsiBw5xD0xa1gd
 pL5MbbmbKev8HIifzZbW9bTW8gIFJUT.AKUs7OGVciQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 16 Jun 2017 11:34:44 +0000
Date:   Fri, 16 Jun 2017 11:27:39 +0000 (UTC)
From:   =?UTF-8?Q?Cl=C3=A9bio_C=2E_Felix?= <clebiofelix@yahoo.com.br>
Reply-To: =?UTF-8?Q?Cl=C3=A9bio_C=2E_Felix?= <clebiofelix@yahoo.com.br>
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1466340834.14042132.1497612459300@mail.yahoo.com>
In-Reply-To: <20170616063031.mxx72dlg5ccc3vtq@tigra>
References: <905919609.12947564.1497527369339.ref@mail.yahoo.com> <905919609.12947564.1497527369339@mail.yahoo.com> <1527808373.12987632.1497527566906@mail.yahoo.com> <20170616063031.mxx72dlg5ccc3vtq@tigra>
Subject: Re: [BUG] GITK don't show unstaged changes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.9778 YahooMailNeo Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If this is an intentional change and not a bug, then gitk has become less u=
seful to me, since I've always used it to do a quick review before committi=
ng. It's easier than using bash. Sad.


:-(

________________________________
De: Konstantin Khomoutov <kostix+git@007spb.ru>
Para: Cl=C3=A9bio C. Felix <clebiofelix@yahoo.com.br>=20
Cc: git@vger.kernel.org
Enviadas: Sexta-feira, 16 de Junho de 2017 3:30
Assunto: Re: [BUG] GITK don't show unstaged changes


On Thu, Jun 15, 2017 at 11:52:46AM +0000, Cl=C3=A9bio C. Felix wrote:


> Details:  https://github.com/git-for-windows/git/issues/1203=20
>=20
> Version with bug: 2.13.1
> Normal: 2.13.0

Attached are the pictures for those who doesn't want to browse that bug
and dig them up.

Basically, the idea is that Gitk in 2.13.1 won't show that "Local
uncommitted changes blah blah ..." entry above the one representing the
tip commit even though the `git status` command shows them.
