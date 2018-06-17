Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8423F1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 11:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934175AbeFQLhh (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 07:37:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:42451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934183AbeFQLhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 07:37:36 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2cDB-1gKY7H14Nh-00sMKy; Sun, 17
 Jun 2018 13:37:18 +0200
Date:   Sun, 17 Jun 2018 13:37:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
In-Reply-To: <20180614151507.GA6933@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com> <20180614101342.GO38834@genre.crustytoothpaste.net> <20180614151507.GA6933@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KIxVWzUVCG0IwHzR0o8XIMGA6Hia3YPwWiwXLDceOZOzfuLkajh
 KM1BZQB5jszH7rw1/m5u+h/SxwauQM7DLgTyzwGWSDGzNDOlxxDqXplvWeuWQUXlRlFB28k
 g4c0KvKLzIj15POWVePwBfJ94WcJnzf01l9o2wYgoVflr+9jpcShr4KA20/hJMIkgBV8YsV
 cyQV9Ahv98KyZsbVLIN4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WBf1THHl2R4=:EfHOvpREdpxNMPlieeojag
 IJW74nKtE4pAsYVVyQm8z67ieG18oYs89QcFhKlcRkibp8mD7MYXyIbJXEJ5UBJBfqJkkoDmh
 4RhhZh20swh9Xil4pKBtEtiJ4lcYEmzqpf5HtSAglrsFfi6BWN8z1EqAKSyFeO7t8G8rAeo9N
 CrtFh4KU8UiE/5UgsR0/mo3d1AJwXKGaj0fOu7tiS5OrXblKuAO8PiUVIyQAp2PfBCFYcnM3x
 oQFBf1ORLoozh4JvOVZnj+JwGRhHaIzguSb7e1K5fhFdzEOKtaY7GOZ0OsvCX8bJr6RZIOOWL
 R6413JfugqRAnUDNC/R0kISnnEnm/9EjxQtZNqfSPCodYQDWtZqvAIcDV3uCmvgX3oLBnhurB
 7Pqreegl8EJUNi1G+swMfyKKin6HrkFZHlZXlvy29mvnmOP9qGy4uV1R2kmszN6C90c9WgJRv
 01+L7PTSHukIvpU6scz3g8vUhONNXT0n989vrSEKiWqqlHuBkL4PNk9FZtEqQUuLe9kIFMHUM
 0gbpI/f09Y/nc+B5u/cUW20xwdecmFl1JxfwMxDexhq/zTYJCPH39W30JMT4EQ8QnXUcZ5yIs
 x6swypIiBl1T7EHNlM4fni+FvV4I3fZLcttIcBhOE8GqLHhrnD0QE4lzBp1ZivDYLZSK7stRv
 vfPtM6nomLH0HDcuhhP7jNOvjhF0zKOzIxqqrYi9cs7lbiVBPkd6wUFInxhs4ZlZWsJVh5NEh
 svycimeepaJ/mH/1QIMR00QXLIZERjAMbwk4PM13YNqhe9b8WW758zhES8lA4x9+QYRmERLU2
 gvnYXQ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 14 Jun 2018, Jeff King wrote:

> On Thu, Jun 14, 2018 at 10:13:42AM +0000, brian m. carlson wrote:
> 
> > > I know that other git server environments like github support that on
> > > client side by allowing tokens to be used as usernames in a BASIC
> > > authentication flow. We could do the same but I am asking whether
> > > there is also a way to transport tokens in a standard conform
> > > "Authorization: Bearer ..." Header field.
> > 
> > There isn't any support for Bearer authentication in Git.  For HTTP, we
> > use libcurl, which doesn't provide this natively.  While it could in
> > theory be added, it would require some reworking of the auth code.
> > 
> > You are, of course, welcome to send a patch.
> 
> If it's just a custom Authorization header, we should be able to support
> it with existing curl versions without _too_ much effort.

Indeed. Because it is already implemented:

	git -c http.extraheader="Authorization: Bearer ..." ...

To make this a *little* safer, you can use http.<URL>.extraheader.

Ciao,
Dscho
