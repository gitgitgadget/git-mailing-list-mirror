Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08991FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdDCWut (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:50:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:52356 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdDCWut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:50:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1cht7U2CsS-00M7Pb; Tue, 04
 Apr 2017 00:50:44 +0200
Date:   Tue, 4 Apr 2017 00:50:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] Specify explicitly where we parse timestamps
In-Reply-To: <1485481a-f2b3-a0a2-89f6-8f55dc241b19@web.de>
Message-ID: <alpine.DEB.2.20.1704040048480.4268@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de> <7876460edaa85d93b60c0cc1b2f9a715de97180c.1491159939.git.johannes.schindelin@gmx.de> <1485481a-f2b3-a0a2-89f6-8f55dc241b19@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-497804122-1491259844=:4268"
X-Provags-ID: V03:K0:eDil2k371TLOG4zZ+vhBszl22pNSHKUVCKvON/c/2D546vyqME5
 68eDGAW8KtyXUIDiUF4sohAWJpDiVEkulSZaSOsRHpouIT4TAGGJ6usVKECsY2s+spiWORb
 nK6rHj9Mz86eQ5eGS0DyfLb8g08oUDExB219CJO8ljNKvGHa8ZB/2kPMzWEoPHKaWZM8qL+
 PHN5AaNm2WQiknp4PBjuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:twpm8Mb2nDE=:t4IfZ5h98jg/JO0oVhlEFp
 gWuXD0pKq0rnu/GPoddzIbNGh3Lv5udS+nT4kZYrgkyRsJ+g/4GWArwlyDtUQmawTzSn0ATbP
 h/7H1w5ozQGp8SdjeiI3Y5OvpnnHdkaa612IKawwA6AnE2A+7kCokkxRycj+SbJUBQzXLJXXk
 UuuCuSdgZ9kuLKITi2y6mQnjVPPo99OH8aLXIRHCU2uOym4h+4Pkl+0BrnkMb5GjBbA7a1ocr
 qCK5gR6e3Din7bwSzlF/BETEEGa7kt8H6VcuyTUQLZp3zy/9K3CrWDrEf/3NBVlz4i56pIq8T
 R2120GIgWU7oAirMOCdVoj1qfjaWD2BUn/bQAoMEvnUK99/3r/qJzcBlwj3A7C8j7ab/r09Lv
 TGECManuu5zmOnI9lh/6m69JAofM9qJ9gxVoil9tAvRF1cjxS1t+rbP4u5Qeqk6eWxHojxu+d
 +7O6DvztldS7Ziz1BiJX4LjnGNqlM9CyMQvWPDnLZnRknCfxfqWKMdDYk3YwcPCkmyVHXFllp
 UW1Drs7v7CLSAL2/r6qyIJqoXqSF6EGqlxQFSrlOjDDaBr8AUMs3x/9nW4pf4MuqqEToDGEVF
 vsDs2ACnnwpmRFleaCFRSPneDNuvhV94IMSux0X+8Byt39DjSQ9FxS/Q59uW5aQ+ucQ/Bre4t
 8VUB0Z4ZEN8fQVNfgJwI7Bj0ObG2iylqGJwlwL9QsDlWys0xq0kWCdfrutpF2JkdeBnXjwxgE
 +4+sKGXeQHNY1mkDbuNsliXZyryrR6u6tHhUnoMJ/CQAXxbaBGAKEc4LOBnuQSztqN7Mv7y5s
 gIKb5Nq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-497804122-1491259844=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 3 Apr 2017, Torsten B=C3=B6gershausen wrote:

> []
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -319,6 +319,8 @@ extern char *gitdirname(char *);
> >  #define PRIo32 "o"
> >  #endif
> >
> > +#define parse_timestamp strtoul
> > +
>=20
> Would
> #define parse_timestamp(a,b,c)  strtoul((a),(b),(c))
> be more strict ?

It would be more pedantic. But I fail to see how it would be more strict:
once the preprocessor substituted `parse_timestamp` for whatever we
#define'd it to, the C compiler will then validate the calls against the
signature of the real function. That validation will be much more strict
than merely testing for the correct number of parameters.

Ciao,
Johannes
--8323329-497804122-1491259844=:4268--
