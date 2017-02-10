Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738E21FD6A
	for <e@80x24.org>; Fri, 10 Feb 2017 16:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdBJQMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 11:12:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:53746 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbdBJQKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 11:10:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1csvHP0Jrb-00JbK5; Fri, 10
 Feb 2017 17:10:20 +0100
Date:   Fri, 10 Feb 2017 17:10:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Arif Khokar <arif_khokar@hotmail.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <alpine.DEB.2.20.1608241509200.4924@virtualbox>
Message-ID: <alpine.DEB.2.20.1702101707060.3496@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com> <alpine.DEB.2.20.1608241509200.4924@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-875194820-1486743020=:3496"
X-Provags-ID: V03:K0:9zdHvuCKKylpTZ6VEMNdqaz0oF4V3aHUtYXkKJ/5S0/xqrVjHO4
 pDXJKd53PGiXbIRN+Lza0899DiaZHEsIkFotGj96TKj+sz5Hz2XQOZR5PPXt2MIK6V9J1/l
 Y1RkRyPtP3EH37pnqgwe8MC+nnPVYdbjUbTbw0gO7orOCxmfBJPUzRIXFYuVsnTtoj7gWFI
 3qRFfciCa116c0cXYL/UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X7vyUnO7RbA=:Yo4ISRAsP1ZBLxLiP20zvi
 e+FJ7eoSJANGsl4qCgDLZ/oFCD6PE+a9J0+lGqPmyHGoa5/u3Hv53tGLKvll363+m6MVP0Ht6
 JYAiCzEDXAC8p6gUBZ5C2yxAxbwKN5koTnAOgooNfe0OgFtL5lIwzP7n/CT3UwaMt5BVcrmb2
 0QljDVRWwzGyJv2KBcS14q8bkBvJnqitiZPHYRLv01i8BpysyY+zE8pFoVAh6HDlodzb315pw
 /fFgFz9QYTd1oWx6twg2NMP0XRqBh7tlSYl+eNTebePDNo422mMA4rVGQl+OoA+Hg0+Upj9gL
 ulYX0bPlHitNPkcRBmfyuJ7qpUV5nbLKJep9GBK28AOiXjXDrPdOfbtCvKvdXt+ye902a8dRl
 iwOhOm/eagPQ3jlPUoGuLOouBVXimPD4zh1UQ9UjZjvP3ri8iZ2yUjR6Eci+lkoNZeENpNVDa
 0Dv/xfyMuP5N/amSv0kNJYsv1lmYhGkX7ysmnxuKSo2L7M+b5dWSSd+ge6BTMm/jOWRr4IBUY
 q3DBGQR8BrpineF3jhJX1MsqAJKvnspgOU+ClzIyZnA/CNg/enAeE9v3bXIt5iiVGTVzTFUb8
 KKBxTa6gs+pkYdolBeLNdZlBDhXNPYrW3BzjSTdtNhLqbYobsXeRPq9eg7fUrwmF2Ebmu+1VK
 h7djxF/LQl+P18kQT+GFla7jQSxheknAI+w+GgngozPfCovtqeuHPRm9n+tWv6bmn9d0EfULp
 Cci9lco0QthFNSGi5u0ySlwvYNq7rDml7z9Wwne/eRPsaZvB3ZIu3OvPPoEIpiBYR+wKKtqVx
 9t4KueIUoi35U8U8kWRBse/p5k1Lz9Pey8PacHZQA1XFyhWRlroJ9qiWyDueNWJl66NR73Koc
 0Ybx5r70YFStrRYO5R6OXV1pmI9CSTg/oaSx6kQxmie7Rl7CMybNz4klHPJN/A1jeyP9xgkVm
 mxroSfDd1VhQO6k5ihpeEpbuwoqwPtA8so8mAj96eg+zmWiW9io8pMa9ajAfuTdicaDEevDB8
 uwla/zOps+Vit5JNUPLBUSX7hwYZKtD1b8F0WsA0PsM9amqPSeQPIZKmifej+c4ZRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-875194820-1486743020=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Arif,

On Wed, 24 Aug 2016, Johannes Schindelin wrote:

> On Tue, 23 Aug 2016, Arif Khokar wrote:
>=20
> > On 08/20/2016 03:57 PM, Jakub Nar=C4=99bski wrote:
> >=20
> > > But perhaps the problem is current lack of tooling in the opposite
> > > direction, namely getting patches from mailing list and applying
> > > them to GitHub repo, or Bitbucket, or GitLab.  Though with working
> > > Git, it is something easier than sending patches via email; it is
> > > enough that email client can save email to a file (or better, whole
> > > sub-thread to file or files).
> >=20
> > Given that public-inbox provides an NNTP interface, couldn't the
> > ARTICLE <message-id> NNTP command be used to easily retrieve the
> > messages in a given patch series (at least compared to POP or IMAP).
> > Perhaps git-send-email could be modified to include the message-id
> > value of each patch in the series that it sends to the mailing list
> > and include it in the cover letter.
>=20
> I am no expert in the NNTP protocol (I abandoned News long ago), but if
> you go from HTML, you can automate the process without requiring changes
> in format-patch.
>=20
> > Then a script could be written (i.e., git-download-patch) which could
> > parse the cover letter message (specified using its message-id), and
> > download all the patches in series, which can then be applied using
> > git-am.  This would in fact take the email client out of the equation
> > in terms of saving patches.
>=20
> I recently adapted an old script I had to apply an entire patch series
> given the GMane link to its cover letter:
>=20
> https://github.com/git-for-windows/build-extra/blob/master/apply-from-gma=
ne.sh
>=20
> Maybe you find it in you to adapt that to work with public-inbox.org?

Oh well. That would have been too easy a task, right?

As it happens, I needed this functionality myself (when reworking my
git-path-in-subdir patch to include Mike Rappazzo's previous patch series
that tried to fix the same bug).

I copy-edited the script to work with public-inbox.org, it accepts a
Message-ID or URL or GMane URL and will try to apply the patch (or patch
series) on top of the current revision:

https://github.com/git-for-windows/build-extra/blob/2268850552c7/apply-from=
-public-inbox.sh

Ciao,
Johannes
--8323329-875194820-1486743020=:3496--
