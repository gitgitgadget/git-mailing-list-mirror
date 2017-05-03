Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556631F829
	for <e@80x24.org>; Wed,  3 May 2017 15:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdECPP3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:15:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:55358 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdECPP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:15:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV6EP-1dZF8Q0hS9-00YRWC; Wed, 03
 May 2017 17:15:15 +0200
Date:   Wed, 3 May 2017 17:15:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 09/21] blame: report error on open if graft_file is
 a directory
In-Reply-To: <20170503101706.9223-10-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031712530.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-10-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-602379474-1493824515=:3480"
X-Provags-ID: V03:K0:QY13MpoxHT0CGv2fp4uGMLcOQUuhbZOIw67eEewiaRylYPaqx1W
 M/rFSB6z9LI0aNCFPONSCaC2qgDQ8/HDIpfyVFySj9LAygvZfXzUTWF1vOgfyjznAWZ5K8Z
 m9PoJLehG1kwXw0gLGm4HylStvu2fZC0QQ0YH/Kw853k5TSbv2zbEmcqISv0l99tCObMcPi
 6n/bPjIj7QPaMYXwuBy5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9W4Lft9ebzE=:rIvG0uXUMAK3GrNxZfKWT0
 kFVsNmiksVPBETvfNpqguPIMYhNfbnCNwfPXoU4ilJB6xbgF4Ek0h544h/lkEwg6dKjEX1E6A
 linRYqWEYyBNFMlS+doqkmF8RiUaZ7Sf9ALfiSpTKnO+CAFNT7oAZevfHvhPjhOqaliLMh5kp
 LqkAyEyhOr4wHSO3ADV6pKnr1URu0jNydD6eGrory812uvtvEba+BmAXw/YqeqLdfcP0jbpUt
 GrvXhMqIimqVZ6a2m8dQNMgKA7y6lEWPwqKtFYkvHTeFR0dkh8MfAHk8NG9+4g0E+71ca64oF
 fpPJZ84FMmC806Ed+s5tdGFTSoGMhHLopQvTC26ulzRCROdc0C1+tHBIRf2Ep2SE1QpIUtmyR
 lB0I32USKoLZXSGr3R02elR7KL8nQ2sH1GJV6vSg9BSGsgUKKriDzHM6g+8Ywn+OKKF1lv5ps
 oNqHgTT6bLJKBGdspUi1pmGwahD96ljzIun3ZyP28JJ12ZGL/5Yey1B/lrMcGJN1zjeAEl3Iz
 5aI8r8+xRn/YibPdqBgPGD90p+lor7e7GBcKKE93vSpvadB4p8lfTfmcXrtgLM+onsG5KElAX
 ftqZfkS/YN5lQtpOemb2tQod1xf8LvVQBKvpxr/hrNTMiXSpB9gAUQ33qKjULG1O3k0FytJm2
 qP8WdwdRxPge1tMxEtJs7Zn2RBLIoAZ8n8q6+Ju2R7m4sKDXVEB9QyimSm0gMRnE6lKIfX40f
 8AcvBN/p6zxnLxYg1TT60Uh3EIAA1hN6+/ttdVjzwA0tteB6X8fWhtpe8hcm77wqFkIa+0uR9
 WNRJL+E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-602379474-1493824515=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/blame.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 07506a3e45..1648b396dc 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2071,10 +2071,12 @@ static int prepare_lines(struct scoreboard *sb)
>   */
>  static int read_ancestry(const char *graft_file)
>  {
> -=09FILE *fp =3D fopen(graft_file, "r");
> +=09FILE *fp =3D fopen_or_warn(graft_file, "r");
>  =09struct strbuf buf =3D STRBUF_INIT;
> +
>  =09if (!fp)
>  =09=09return -1;
> +
>  =09while (!strbuf_getwholeline(&buf, fp, '\n')) {

This is an excellent example to demonstrate why folding all conversions to
fopen_or_warn() into the same patch as introducing that function makes
sense: I had to close this mail, find the mail with the patch introducing
the function, verify that it returns NULL as before, close that mail, and
continue this reply.

Oh, and I do not think it is a good idea to introduce style fixes in the
middle of such a large patch series. It's a bit distracting from the real
meat here.

Ciao,
Dscho
--8323329-602379474-1493824515=:3480--
