Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697A21F42D
	for <e@80x24.org>; Mon, 21 May 2018 11:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEULfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 07:35:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:53717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbeEULf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 07:35:29 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMkDH-1fS9bx3GWt-008XLB; Mon, 21
 May 2018 13:35:22 +0200
Date:   Mon, 21 May 2018 13:35:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 0/2] Test improvements for 'sg/complete-paths'
In-Reply-To: <20180518141751.16350-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211334220.77@tvgsbejvaqbjf.bet>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com> <20180518141751.16350-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1124237994-1526902526=:77"
X-Provags-ID: V03:K1:cYJJ9qwXwDm5+ERdWL6O6ghO6CavUSKxH9uAa9Hck3Ih2fHIDPf
 xGE1vovAIrL2N8K0wpUUY2CtOwFNlz7ltu9o7SPBIK/aQGo3zD+621/sa0bYS45kz1sKjVs
 t2yLkvIBzctIPf5aW9SDYvUiuQllCIZyZYzp3JtbZvghP0HzUIHmU+IOPelDxVQGg9o7Au8
 hcOrEuRIGo8mXzIS2fYiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WP4X69FhSbQ=:zFDCvtJLA3JdThYFncFPLK
 kPqGZjUMTnrrI94NqfBoJ2BQsIstmFwGn7hByI0SyEgD6934SRXTNJ37z3FjCQwjZbfehvYUV
 XaykQlU7kB1WGmIOnjtXUcVq5cDk7z/TkRryY1o8HzvHBH3DNcUpIpukEV4DB/2cycQGZoxy5
 hK/D9axZco47HXCWfOTTZCdc6uhcO9RZBoy3nK6lQGStdVWhpaNS+U4WY3ui/QTzl+puUXXFn
 cY8bxZE7AHQEHSViovbJlHGRhLe5QkUJ7FaSQGXukdSpJmMjaa/0S3/9oGZW+3PTpC/th348J
 vIANasquEtPuv9FoOSyGuvtoCdp0jWU393Fkuu9GflIU6py28Dqrzb93frDcFMdkzh+r/zTkx
 U29QGJdjFKpuGL4hcxq9H91gvzvaxxJALwqLGNwmbyyko6COW5NT+7OmM4EbR5sRfwaCXARau
 VXkl8AORJK/MSSrgsPRIXB20R9BTGE74v8a2zC5e6QFt9crLnYltxdon5FoKqSRi7UP4cMxgx
 /7qaocTYN0ES0mvSZX/SlXIIG+kWD1LrFhKDIEY026cY3KRa8I6WcKcJyLvv8SZxO9mQjU+4o
 QKewsbRTapGlduV7LM9BJRugugL9a7bTu9kYaGRY35ySwErQXwVx0gpXg6yxfdxpc9yFaFBS8
 p8V2zMEIiBi2BlP4CgBx5NXAk16lPOeVelBp66R0qvSECVu8PcJ9BlXFjyfJsueMhOSHidTU4
 R1hxzbQ0XMx4pjxfFuT9fi+Rvht9QPOZWZA8nueK15JvrdyNFgXbLMl/88BNLdmJgWlDqwGzq
 DqBy3m7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1124237994-1526902526=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Fri, 18 May 2018, SZEDER G=C3=A1bor wrote:

> > > So, I think for v2 I will rewrite these tests to call
> > > __git_complete_index_file() directly instead of using
> > > 'test_completion', and will include a test with spaces in path
> > > names.
> >=20
> > Quite well thought-out reasoning.  Thanks.
>=20
> Unfortunately I couldn't get around to it soon enough, and now the topic
> 'sg/complete-paths' is already in next, so here are those test
> improvements on top.

I can verify that the weeks-long breakage of `pu` on Windows has been
addressed, probably by this patch series.

Ciao,
Dscho
--8323328-1124237994-1526902526=:77--
