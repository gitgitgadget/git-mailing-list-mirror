Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AF01F404
	for <e@80x24.org>; Fri, 14 Sep 2018 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeIOAXb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:23:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:36749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbeIOAXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:23:31 -0400
Received: from MININT-6BKU6QN.attlocal.net ([108.198.118.51]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LtmK9-1frVO82x8P-011DM6; Fri, 14 Sep 2018 21:07:38 +0200
Date:   Fri, 14 Sep 2018 14:07:34 -0500 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <179314eb-774a-bc98-4a41-f79ec78c8466@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809141407180.73@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com> <179314eb-774a-bc98-4a41-f79ec78c8466@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MJrg0PzEwD6n0y3N9uEjBzqZD9oUkVZqfDEs/Vuw/aNjBYht0El
 IHWHHTHU5Zao3alCvMYGdeE0imAPhOInQybs+WJS4Z7H3vZr7oPOAokcxszvF4dt+UW3OKO
 tfOsKU+NLqbQ+8d664kOyzByM1P+/qgaamj+jNcpufhYH5oKmDaudXHAh+B5X4YC821Kvon
 wlUM7YAXnSZpuOhIB9tXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dD4Q2T23a0E=:AoNKV3kFpkFjN+zRkd9OzH
 9wSo6jHxGjSFOL8LgixZ5/G9d6lbXVKfgefv3VusS7GYpTmFo3ZoqfSf5sbJWf29rPcPz1Ftn
 4CchXb1C31w5i2B4R9+6tlRUsZm3GBN0KEaUF811HupsI+iAlP0hFoGUPXITUZFvrV1zdfJ4P
 He8uumZGAt5M2xNSlc2pEQdz04HeyfVi1BL95qPsLrYSCT5hVYNMf0EYEVUAKU/QUVTaSDEx0
 y6Vwe4UFGmfZ/AbzMsIieH5Hb0/kCLI3eI2kXhZx/ZD9Rdv82zte8XkngOia+Pk/2mO+c60AQ
 Ba4O7oCcRzPIPC5iY3ZT3DmolvTK1re1amwVioMkzDCnMLrYnTaxf5obJbl0vQUOXb/fMVX9U
 rziXVwq7GXJaUJCyRNUXwnohgwvtnfoQnzFtgM9LzbbF/ZyThacz2QANg60H09Y/Vo5l0hIkX
 lzqYsqsZoUMVrP/NSjr/KjuoOrm6s6MBJ124OoLBfV/y3HVAN+5+hEIuYOTsQaAujosDjT8N9
 bMSCgyRWaz+r68WREgZ91LI4M2V6s7qtlsvK3Vq0HoTZ5q5hXBhVMuSA62hrU2Tb+olBr1J52
 1flUHgJNQWCi4Gw1t7h65KR4dXqow4qT7tgOLehwtyCC5qDQFxZsm7yffvqMp10Gf90jVyXRj
 DwhSknpNkakSMsFMFG9XnzqsxIel/EV/YChBW7RynIbtCLPNKxxz5RE1dJ7nmigpYkdHY4YnV
 VV33MaL6WyadcXx1uJoGMl50TiTXowdBfh9zktYWEcHm4xKLCLe3sZgwYre/cGBhmJPWgQbYU
 clUfSgrWxjXQ+PR3wIkKvWMqNIpbDiDH+EQEAqwGniG0PZMQPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Wed, 5 Sep 2018, Sebastian Schuberth wrote:

> On 9/3/2018 11:10 PM, Johannes Schindelin via GitGitGadget wrote:
> 
> > +if test -n "$TRAVIS_COMMIT"
> > +then
> > +	# We are running within Travis CI
> 
> Personally, I'd find a check like
> 
> if test "$TRAVIS" = "true"
> 
> more speaking (also see [1]).

Good call.

Will fix,
Dscho

> 
> [1] https://docs.travis-ci.com/user/environment-variables/
> 
> -- 
> Sebastian Schuberth
> 
> 
