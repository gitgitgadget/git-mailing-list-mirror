Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22CDD2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 12:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbcF0MPC (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 08:15:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:49581 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcF0MPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 08:15:00 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LhkiL-1bdNuT0bjt-00mqoW; Mon, 27 Jun 2016 14:14:40
 +0200
Date:	Mon, 27 Jun 2016 14:14:40 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
cc:	git@vger.kernel.org, novalis@novalis.org,
	Junio C Hamano <gitster@pobox.com>, kamggg@gmail.com,
	dturner@twopensource.com
Subject: Re: [PATCH v13 21/20] unix-socket.c: add stub implementation when
 unix sockets are not supported
In-Reply-To: <20160626120928.14950-1-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1606271413350.12947@virtualbox>
References: <1466914464-10358-19-git-send-email-novalis@novalis.org> <20160626120928.14950-1-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1987397178-1467029682=:12947"
X-Provags-ID: V03:K0:I35JZrlwkg3bsXfHiHW//meePDsT8pNcXz42PQJRNwDFgPdtvNg
 dWb33M1UBtHN4mNNPFKjRFaXvXZHsrdleCXCa3uWIY3Z8L/AW4xNmFiLnBLF8IO0CJIWR/g
 RWaV8kD4mb36PGsCNZPAw6/aJCBTg+ODZDo6MJxsN4nyp5tFNhpmRzdkYXxkC8QXlbGxDSD
 jhOBvcJmaQg5JOB9O4yYQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:U5JfJ9D0gV0=:nw3ZCgNGBx3/YYNfwlRJ2M
 jvp1oUhCjB+uxwCrNh5VmRlfE4ginH5hhDZbE2zjM47D2RPSg9WiSkYFtjUartqUPAj6m4UyP
 9VIS51rzRHj2gzCRn8wmuVdSo76LkUDlm8z3kWZamiXKuq5zcDT72Spl0q7eMqiY91sVA4UQq
 rXglqPkPzWE0/xhH1nJbjxXq8nsqww+oTWpvtIEuafG9/1BV2/Hq7S/32SOk8wTU1A86+MKZR
 zhhH4NIqqUzf0Q7w56fZOJkMh7Nq/YkGxepCC2zWlBPVEmR0UMokFav1KrGqkqM87gxHZcH0e
 F5gBlAjVD/Q+Y17gEiH1rRGt9KLUSNo7sknFg6sR6lMzdxuvDbz8sc3SOeKCK81BA/EC3360e
 n2vj7cFhSOHw9P3oQ1esip5SXFVDeSfv7upevRwY+WwkarsAmQhnaKsBlmnG499/ItgLQY7kX
 IomPg69Uq3aGHbgPu7sqp9AgkycLrF89b2sMUZ0e1lkYLRO4KIFE55sHABzfQrlWyOgbr3exJ
 eu61vKfjDiQhp+yEnlSoMhlttQoqkPsfaXUht9QWcPbnPw+Fbs6EZjbb4cioFGeXudNZOPTqi
 IRsW7mwyMaeEyLEA1d1HO3JhUOj3axo+7KGB/Z2vOmmGxmMOeGR5Q+VtzZsLcaacLGHJb9lF9
 JrukxjmAIBo3yVZgpdTugc5yW+uy7OYgO33p27kWMaoMcMSngXHkt2eAMIC/A/j5ION0GHvxI
 mhFhWtR7y1qJaPFKzu6WUmZNpvAjuwRBcFvyOn8O8BkTHS69y9eqztJTm62/EMp9RS6KO1qUS
 j8YFhCR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1987397178-1467029682=:12947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Sun, 26 Jun 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This keeps #ifdef at the callee instead of caller, it's less messier.
>=20
> The caller in question is in read-cache.c which, unlike other
> unix-socket callers so far, is always built regardless of unix socket
> support. No extra handling (for ENOSYS) is needed because in this
> build, index-helper does not exist, $GIT_DIR/index-helper.sock does
> not exist, so no unix socket call is made by read-cache.c in the first
> place.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

Heh, I made something very similar (although I did not update the errno as
your patch does): https://github.com/git-for-windows/git/commit/919cb1d79

Ciao,
Dscho
--8323329-1987397178-1467029682=:12947--
