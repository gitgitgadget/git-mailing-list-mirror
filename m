Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5251F462
	for <e@80x24.org>; Tue, 28 May 2019 10:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfE1Khh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 06:37:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:42729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfE1Khh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 06:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559039853;
        bh=RuKvWTgfkmtVW6yqDw9DCMLgLHaNndUDVU+b/jBkw+Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gtumrnR21EL2Mzkq6IpCZ+q50rIaAHrGiArQLhdI7aarC/mt2g4JyRuJnVcUHbGZy
         D8FRGMF00cM4usv4BEy1mzF95ZBzLz/P8hdaWVsoHpNqwN7XwN4HEVsb6BIpy0jNV8
         G+rSlZsbvuFxEz+YbnFFk1guBzEA3Py7OvbastHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXr3H-1h8rOc07kt-00Wkt0; Tue, 28
 May 2019 12:37:33 +0200
Date:   Tue, 28 May 2019 12:37:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     avarab@gmail.com, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little
 projects
In-Reply-To: <20190520182353.22221-1-matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.1905281235280.44@tvgsbejvaqbjf.bet>
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20190520182353.22221-1-matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z5um8ze9bgGt8VyCfaXmrRDUJDYPQCnEmHLVVQsxzaWL98BuK7P
 I0OMNJeq07q+A3p0N7UTe5SeH7VLY9PHrk/5DxSOXzKnyF/z/69LChwSLix9GxrBU4V8df8
 XM+KqDXxZ+rwHInZxTTWVChOi+Rt8RMn001oRDukZNnzLTXLbgI4Rqttp9lJ6Nz6oNCTgcM
 6qfMu+HIFd/YD2oo353pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JP37Q5mktX4=:EX/LiM/TG7X0KJ9CfRVB1Y
 U9QO3luQmQ5MGgv5d+JQeOGC0KU9RMauyQ/g4QL5+gpkw2/nXYjak68UbyZMHq6gqC3R5s69D
 CSicqJSL5yO567O6+GsMw5ESk4Tm8ES/GMCGS8oicMwZgTXPW+YXb5GYQi7eSAo02FKMvdi1v
 fdMFtblaJ6+y6XGwQz+y2ODnQAy05JI4RNoNOSFVyozqEw1vAbA8w8bhjSS0NAE5QjFZGNc9A
 NagmEKCeRXykDezfij1ARWoDb3cLSQSWaXv6hx8Ly6DNpoWK6NoOwQi9RHlqXAKK9RzFfP5Sx
 7Ae6IjfQ52iI6C+XlZzIcDEgIuIAOPrvb+4AUR17gKPnw0TFlt3Fh2w4zcCNK93KY59Vjmh4h
 PneFw6ArpP1WKGQQCMOGKKSyrRW5NYpMBXGgeDREoMQc52OquUpfhjDgdj8JAOImSdMh+o9IJ
 i6Wlbs6lCMIOWrdd5qYx1/iDVKk3jvSOlyGBGBo6nbKdKaVa/xEH5sGsmP/2CgG0OMHcNJHyx
 XK1gs+J59iV7X6SSSGIJ9/gJrfsavuhLCwlHANep5EaSeQK4wBPuj+HaOFZfECDR1r9LPuLFr
 jC8gt38xDNXno03Nje+Kz9IYOUMHR9MHnQg2qph1B/YrfKrfD/3SPslNm8KScQPgKbqmXnmSB
 ItfC0UaYf/SZUCRepLVHGH2pJesEesyYhY2+7PaNepFcyL4DU4a+ZSv+8K9XpvoaQbtEBRQQj
 WEpcZ/3gpKbclAj8SPCilGSpiSpHqo35G2lAx+KPBijSwec4iYv5t/4ydGelhWAjuYmFip4G/
 Zy/BxseJYKXdORXP64lzXnaIvRb2IuOfTqYvR+fPjRLRo2hVvaazWo1Jq+3+C3XldcOegiaBj
 MgTyBbCdVndHwsH4wXMl+rmwiU6+/ToF8ZZaQPopMgZ5yQIa2O30+ZHFS7Z2+SuZXRf9dwdP7
 ZKBXTmj9uf9OyDQ2Nirb9yRny0Y13DlbgeKihwhtB2ThofHmeesBV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, 20 May 2019, Matheus Tavares wrote:

> > Give "rebase -i" some option so when you "reword" the patch is
> > included in the message.
> >
> > I keep going to the shell because I have no idea what change I'm
> > describing.
>
> I have the same problem, so I wanted to try solving this. The patch
> bellow creates a "rebase.verboseCommit" configuration that includes a
> diff when rewording or squashing. I'd appreciate knowing your thoughts
> on it.
>
> As Christian wisely pointed out to me, though, we can also achieve this
> behavior by setting "commit.verbose" to true. The only "downside" of it
> is that users cannot choose to see the diff only when rebasing.

You could of course add an alias like

	[alias]
		myrebase =3D -c commit.verbose=3Dtrue rebase

which *should* work.

However, I am actually slightly in favor of your patch because it *does*
make it more convenient to have this on during rebases only.

Ciao,
Dscho
