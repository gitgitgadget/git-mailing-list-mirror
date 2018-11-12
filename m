Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6641F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeKLV7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:59:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:54157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeKLV7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:59:40 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4Wwq-1fYkfL2pbg-00yhVc; Mon, 12
 Nov 2018 13:06:31 +0100
Date:   Mon, 12 Nov 2018 13:06:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/2] avoid unsigned long for timestamps 
In-Reply-To: <20181112084031.11769-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121306050.39@tvgsbejvaqbjf.bet>
References: <20181112084031.11769-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1971771908-1542024391=:39"
X-Provags-ID: V03:K1:X3XvLs3RaBpUjdQTracqK4qJLEabj4kQ5RCIjNiWaFY9zO6uwKK
 /rEl3wlfqbQvrD7ChbIH0oQILDB3GS6a4VPTs4Z7ps14hG/k7WJ4LBbnx5GNLp5DLKLph5Q
 q1S3JUm/+At1JbHex/9FpAOrCmIdUsPQ7TScdUHl5d8sNzSrBt2rNj72paALf+Cue9dyDaq
 cb4nM8AhJ1a3fCXta4pMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RFBiAWcYRAk=:z8UyHtV3byvb41ugzXrbzy
 JRkFdG2TuASwU8qYpcdCxdYURJWLnPF112AWgiDVNNoVVjeSLdzV67DiAKU06oOmnbnfh2JJm
 CUUNFKrshEl051OO24RiJr7cefHGeayPfnlV48kn1wZL/bhvTxGrgznS4//604hvYa8AWu0H8
 NujrfyikPGp4+QmxXX3uGYBeKILV/RAY8Q475rY2lVyk298rx3sKv2h7zQabVJe1ttco9sdRM
 HjHjjxrrMN7ekZyMSoKA/PYPQ/jtbFZ307Twdlt7POPdB05RmYvFhkQ5vhZWXYLtNoxg19Y3j
 Qzcl0/2MJri3iI+l2X6p1DnsIU/Hmys94GMWk7UMN+qK2oWClKAeTmiLcTnEvOGm1YLF+fDzf
 +Mof7lVH6fj0rh9vvl3u/KJUO76UTyjxWvcMtOE8ru/KvleG9F5frP5zSATTYl+xD/sxrDRip
 /EbAGAazdyc7mgcT5P0n+PDDfIGviNgWAv0C/TPPqLmjsIgd1thEgnjilSnd4/NuvCuUD45ey
 0dZUJO+zJJScN72tFBGAn8AtJUQL8UVEMAZavQfbi9Q0qlYpECFU5ZnFw/hbEZt6X+czuqdUT
 RUVlKEQ3ZyVsiYwUxFwJ7rtMK/wThiaoGcD/FPqTdhGiMw8Q+T5O8zoF7yiMnBd3STGQryR5/
 RkDrs/6sAywvtP+/YRg29xLxJn3DuEH8rILOBg5QYAUnfRApB+rPg2weSELrGuU38ehVs4OuA
 mfCZZb0+1Rcl1HyTD6e1U7E6QagaYtKOhEEwirD+d3D0F8uSN6PA9Z8RQZaoPmxllXTzOl3Ed
 oJmMZfj75M7PvFOyJM4CjjYQZdPwNdfA9AQfAXC6RgQWVX+iq/EPm2hE/4V5ZpSBSOJbx1HiK
 jXZkblRLi8i7DHsfNU8RN1yTB8HC3gdnloZuDQ/SpQY4XHMNoN8wQgy0DSjSSxAYgAP+g2OTG
 leccarj5ZTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1971771908-1542024391=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Carlo,

On Mon, 12 Nov 2018, Carlo Marcelo Arenas Belón wrote:

> specially problematic in Windows where unsigned long is only 32bit wide
> and therefore the assumption that a time_t would fit will lead to loss
> of precision in a 64bit OS.

Both patches look correct to me.

Thanks!
Dscho

> 
>  builtin/commit.c | 4 ++--
>  read-cache.c     | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> 
--8323328-1971771908-1542024391=:39--
