Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CB81F437
	for <e@80x24.org>; Tue, 31 Jan 2017 12:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdAaMFp (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 07:05:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:50537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdAaMFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 07:05:42 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFgxF-1ceFeW3TBl-00Ec63; Tue, 31
 Jan 2017 13:04:09 +0100
Date:   Tue, 31 Jan 2017 13:03:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
Message-ID: <alpine.DEB.2.20.1701311302310.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301643260.3469@virtualbox> <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org> <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1335668246-1485864249=:3469"
X-Provags-ID: V03:K0:d+DdZ/R8TIj2lrhrxDZOvPRkrxmwdfuFXpg7B4R4BW0IECokxqV
 abTwykmC5ntgoUoIIhYcwxuyYKRGkf4I99Q48B1PrntxReGdOfeEEVnvSShF2JiqhSTa9cR
 /JsDphF8eoMbAjTugN/9i+UYCi4e+JCwSgfLT3FYIpfmt96Y/D8n4mUFr95MFkxDnt48bYW
 sT/GmnO+4tHC/PcIULdbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SMg3LXO39SY=:5UOhpKm/OWWvSuCX8u5jhU
 evwQDWYI70wfzt+xLn0Vj4Gr6zZNSMPI6QMFB3lMi/bKJyAhQPvMUT7+SgTcTDAaBg73raA+B
 HGOuddyX2fYYNXuxREfpzEubolvbjfGCjtSSVwKzEJaLP8toc0LTbRZ823TzT73JTKj93Sy+d
 d0qu/0JoqEcZyxsFX+puhG3K8yw4xMuagElkr977qWeHAmzwqXIaenaUf32ioHkqccNxIyfvn
 WPA9KYITL6kfXzH+vzzLiZru3UK5B1oGsIQbiXwhFYCmmO19GbfCedJtgpaWIS3C9WFIsmPks
 mCDdsjl8LRn+TB3aee8pcvIsvsg7AB9arIn+NIG9DZ4E1YeB7cluPEFhnN9kxjRUSqREul5ke
 zXORKSpr3DQ6EtNUQt9oadKdVwe0wwGJseQosLfqgcsu1RV2qOSsC7ncXMOt7t8VIUXcg7iBC
 +AlgrakgnbOPR9xiD7U+40YM88vvyQ2dqQx+LFwdEeRzc3V/CRizl2hcqqg18YcUl2yt94esd
 03vEH2xiqxO6O9dK3gxZku1N/TTsbQe3mDiWrGVzeqvmoDgof+hBB//c22JJCjpu44PImAaEw
 wZluTJcze7V0EP3IwIYjEFILBPl+QCz0gmvZ4RGEl9P0z5Yq9OvDdux46BH1/40RAd0zj3CVw
 hXfiuO2o1Bjt6fvKWDg3T+rNGHRsjkU+kJj5F6FWedeCNljPffKXV9TWxwjik0lUupXMO5c4G
 tZzXHtwco+ggRPWyG/ajJeEI3QDV3R974RoySlMT+uEscr62s3RGEHniNqTa/A89SX+jU20i9
 o1phKsCfz5DY9UIX1RMtrYa629r/Thq1Si2ocZbzvZc/hCSskd/FZXf3r1oZy4xGd+k2kMMCS
 LMSnJU1+X5rmMzOF7j2ksNRDzx5BG8+Mq2ZlCsMPt+IigE3Iy6IepViNUYa2VlAcwqg1l2VRF
 3QKj5v4tSlx+pfY1QA78Bg7cztdNT9cfF+4XL2DGBz1EXZUE/I6SlAAafIX6zlOYYW2CvPvoX
 aO6xIDLCqGR29TUZI1+fxow2PSVDrnlTYUHQPR5LlOS9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1335668246-1485864249=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Mon, 30 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Am 30.01.2017 um 22:03 schrieb Johannes Schindelin:
> > It is curious, though, that an expression like "sizeof(a++)" would not
> > be rejected.
>=20
> Clang normally warns about something like this ("warning: expression
> with side effects has no effect in an unevaluated context
> [-Wunevaluated-expression]"), but not if the code is part of a macro.  I
> don't know if that's intended, but it sure is helpful in the case of
> SWAP.

Thank you for clarifying.

> > Further, what would SWAP(a++, b) do? Swap a and b, and *then*
> > increment a?
>=20
> That might be a valid expectation, but GCC says "error: lvalue required
> as unary '&' operand" and clang puts it "error: cannot take the address
> of an rvalue of type".

Okay, now we know what the tool says.

I would like to take a step back and state that it does not make much
sense to support SWAP(a++, b), as it is confusing at best.

Ciao,
Dscho
--8323329-1335668246-1485864249=:3469--
