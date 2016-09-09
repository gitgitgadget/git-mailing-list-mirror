Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B07F1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbcIIObg (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:31:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:55237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbcIIObf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:31:35 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGBB1-1bndVm2iVL-00FCN2; Fri, 09 Sep 2016 16:31:29
 +0200
Date:   Fri, 9 Sep 2016 16:31:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the
 script
In-Reply-To: <54cc3d11-6384-b666-3103-4e56a399ba6d@gmail.com>
Message-ID: <alpine.DEB.2.20.1609091631070.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de> <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com> <alpine.DEB.2.20.1609011608440.129229@virtualbox>
 <54cc3d11-6384-b666-3103-4e56a399ba6d@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1336630692-1473431489=:129229"
X-Provags-ID: V03:K0:lZ3VNkCj6i1BSGhGK3w79rm2BlSVQElBHejR1fYsNjAFLrC8Aql
 Bpzl6lw+9KVk/HhN772IH8h6ThyruDVnYzJGEsSGxDCbrLLnWYf5l8hadutnJ1sAJpmBUFc
 Febl0xqf3/8hFlB4D353+Bze+MPoKnDpi6NqURvo9kfbuG6D4+gvhAGAw4tAfJ+3hTHkT9t
 sn6DDNbLyz/pfUSEyp5wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dPBdeHAqg+A=:SnWPE5vEpwL17Afu0zQJJV
 wgWBrGxAdqfgIoQL5C0/HVhHUvxdqHTc0p6o30ZpTRAuGNMJvWTbSzGNNOIOnZwjBgplLDV4C
 /2IOBPs7lxEzKW15gr1qK2HwWdaB6jNUL9rYmaCJFYdjjvvqAh6mpjj0BPGVCuBS0ajNHY4cE
 MnNCNRFWhRzlriY4yAuG0utcmqIjQ1lmUlqtCg4V1nF5I+H9ebl41uFeFUGEzyEhI/J5+F+a8
 17wFjZomvDi+AHxbaYlccwvNfIH/txsORRZQWnZlUOzPsbJhMzH9wZtbjsNhxVb6KdcENCwN7
 TalexUWobNnuAhFSgeGbZe4rk4cuGPucQ0QxiYRcvh3ObmT1XS2G7uRb/W/pn9DQdULswxVAe
 djayr7WoBvSAmqEY2UK4/BCR0euUpIYXOamWTgP0/RReGD/TNWMQvrsIyh6hbcH2b0PMGhMDf
 rGsmZLRZyYB1urv7UmQEyNbvfdCc1dbugPD0jXIfrLdFj6aK57Qn7yNRcf5rsHOQz5I3lChCN
 nJfDEkVCemwtfF05gKbBB9+OD0AlKoT1QEKfNgoU5T+CxzOFd/7SE7Ut1Cso0gScOLR4yWz+B
 eCF9Ip1+cl0DRSee+lanCerPOjfhG2jMfvZ9ZOVQ5wIQl+htRh/ZeqxyKQlJ5ZyZGiggQUbmU
 EdyPd58I56KFkbqJLb6VqpWczR08hQqAgQeAxRZz8518SJaasjJRDjKCIOlvPJoRMTHKhOHzn
 OvOVEOe/5Zw6sgm2wxBTsiaZczXhPbNSUOB8JCkyyfw0W0pd0c+1pkz+JLkAxb2EvunqkiO7D
 AFisLd6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1336630692-1473431489=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:

> Hello Johannes,
>=20
> W dniu 01.09.2016 o 16:13, Johannes Schindelin pisze:=20
> > On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:
> =20
> >> 'bol' is beginning-of-line, isn't it (a complement to eol)?
> >=20
> > Yep. How did you guess? :-)
>=20
> Wouldn't 'beg' and 'end' instead of 'bol' and 'eol' be easier
> to understand, thus more readable?

It is just consistency with the code I inherited: sequencer.c used 'bol'
and 'eol' before.

Ciao,
Dscho
--8323329-1336630692-1473431489=:129229--
