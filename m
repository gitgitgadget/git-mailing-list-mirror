Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E7C1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 08:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKMIzW (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 03:55:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:52379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfKMIzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573635316;
        bh=hgyAeYxNLzoxCpzgZOv1HdU+zN5uG0stU4jXHib/7hY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PLyIQgJ/IRq+doFe9T/lCHpjTr/36MbJ2EoZdarxYqmlNR+HPQ7pwdbIM0wbsB16Z
         RMmMlQVN7h1aOIfHHyr8T6JlC5KVqDVA7gc/0I6VjTjpm+rr2WNp6NaRsuT8uda2AG
         EBhssKwpADl0Z2C4IowhwMe13f+6sLEgvx45bZUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1hoJuo3SRO-016tqV; Wed, 13
 Nov 2019 09:55:16 +0100
Date:   Wed, 13 Nov 2019 09:55:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: mingw: use COPY_ARRAY for copying array
In-Reply-To: <35123410-245b-0e3f-7227-94c293b57182@web.de>
Message-ID: <nycvar.QRO.7.76.6.1911130954470.46@tvgsbejvaqbjf.bet>
References: <35123410-245b-0e3f-7227-94c293b57182@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-201272607-1573635319=:46"
X-Provags-ID: V03:K1:OJdz74VvDNI01xR6IxP5eE5vbhl08gZJPnjsU1MBKR5JKqVmwBa
 nx89DKluJmv4VoIwFgEleQaSQVrVamz+5GCIcJU/kPjl12Wkwi4yzTtnh/v0lyyfEwcysPr
 3xXeYM7QOmm2T10/BGCj4/pY0oeMIAYnTaqEJRcT8aAGnmk5dpiXeNf2jA0dR82iXf8mG8Z
 3ErwLhXUhqlUMAlrSXuoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTDdKUBhWzA=:KwtJ+qQiC07yfq5Tdjb3Ei
 iU1kKKZJRd77As7Mx6RVQ7fUVxEUedOvWXHIAO2Xko4sv/JzD98SrSJiliygortcW+PHHwRuO
 IAUrByd9brY2rexJQXQPS+eL7Ep+4wPX2Iod1RTbEO81PXt09rIyvpaTxnTnRqnD5Uh/Mp0QG
 R7zAHijEKF3iP5BeLMIuvcd6WVE7+vmiFhu67uCspiQ4ivQ2JSF+bx9BzF9Mxkcmy6J2Cu9+W
 9ZvUoAQokXAETlBkCsN9RcrSF3enKjRFUnT8//D6HrJD0WMwfx7idgreQuG7kVcSH9MVBSC4w
 v2WocAUoOQfRjY19nP2rK1NRN5kE4rsf4OehI+YOH7q7bPqVpl8vvWUeYGUc0nWfZwfFEfalv
 RvG+Qte0VV/uPindT2PAD5RhfOh/jEYHtEdfQSO9ucAA2u2mtGmCL6CEENOemJ4SiS6NCoGsW
 BKzhGFGJ9mNSlMTbUhDHwNs3ox+wKu8J6HNW9nqHJjBK3ajjPDfV9vFntk4RdanomhMaWV1ML
 bZtvUTcm79Wu8/x74HW/sefKIEXV/Y3aBkYHuuUCPYhObdMTQoZcj2X/OuAl04pOuzk+ik2gi
 OAJKJREvjI+I+MRfRPyRfA4m6sJHo4U8Epwx+gP0Ue96RRKzs/SMSnRYjx/cB2maijAQRzc/G
 rRB+Bj++97b3kLI+Lq83ZhEmVzlRM/8E8yl71ASWWmWFodEjxpDoXjkAJrVRwSUefOdATqaOf
 LvhHyHwB1f2JddgOR/hGH2oZWgtAKhiLivS9ZxTlzRnxSDE6Tpry40qA3AeLNgTi2Ul/D9TaQ
 ZZOPbm5Ff9LtQZgYePVyS7EYMUYHaue3Mz1g0JipFBuQqT5WYMo8aY35zB8r4sqK1RxgpOosT
 zPcThpH/T+WR62qg31pW3NedSgL8azYjc50JXX7ANOljY1rX3ymWlycL6isgIZRxVai1LT2pJ
 l+aLdS8aE8M+J26m4z7ditbdKq+r7ydxSA5rdfC3PbgzY8TJQ+QvdVviTT1gU9iyPwo4rnhU0
 qTCrFKZEC+CmS+19r1i5TxElmIjs5TwsPPyOC11emiUI5/nPwdJSkF8KQSM1+hChRmpW6zfgX
 YvoYdkm2o34AlXMOb8Z38lGEuWsJKo/KASz5d/KXroQM62Jk8DmGyToZxf/roanIbZRQ/fOZV
 XEI4ozTc/y4Ne4JzC7zX2x/zKovS3/murlI1NOMOFZPZtC+AEN7e3ZSQKd6wMA3qjfKyuvKnn
 nTzpjCiXa9u1I9Bdmjeh3sMnZDRFm6HpO23Ab2EmNLwi6OSVnHVhKLZq7Ge8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-201272607-1573635319=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 12 Nov 2019, Ren=C3=A9 Scharfe wrote:

> Use the macro COPY_ARRAY to copy array elements.  The result is shorter
> and safer, as it infers the element type automatically and does a (very)
> basic type compatibility check for its first two arguments.
>
> Coccinelle and contrib/coccinelle/array.cocci did not generate this
> conversion due to the offset of 1 at both source and destination and
> because the source is a const pointer; the semantic patch cautiously
> handles only pure pointers and array references of the same type.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Looks good to me. Thanks,
Dscho

>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index fe609239dd..2f4654c968 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1566,7 +1566,7 @@ static int try_shell_exec(const char *cmd, char *c=
onst *argv)
>  		while (argv[argc]) argc++;
>  		ALLOC_ARRAY(argv2, argc + 1);
>  		argv2[0] =3D (char *)cmd;	/* full path to the script file */
> -		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
> +		COPY_ARRAY(&argv2[1], &argv[1], argc);
>  		exec_id =3D trace2_exec(prog, argv2);
>  		pid =3D mingw_spawnv(prog, argv2, 1);
>  		if (pid >=3D 0) {
> --
> 2.24.0
>
>

--8323328-201272607-1573635319=:46--
