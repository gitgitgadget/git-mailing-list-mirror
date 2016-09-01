Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E301F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbcIANDt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:03:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:61674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbcIANDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:03:47 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7Xi3-1avBpT227j-00xJmc; Thu, 01 Sep 2016 15:03:40
 +0200
Date:   Thu, 1 Sep 2016 15:03:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/34] sequencer (rebase -i): leave a patch upon error
In-Reply-To: <1472668778.4265.76.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011500340.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <cade51f893ed381ed03718439c7dba3f5dcebba3.1472633606.git.johannes.schindelin@gmx.de> <1472668778.4265.76.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1362406214-1472735020=:129229"
X-Provags-ID: V03:K0:wH7L4wMXPiEiet5tPMgEtQ6f86jRxVcoibWRre4WlCeYBzJEwCV
 clbipp8KjZ1ajCmtnS2Q52yjBMa6SyJJ4TuyOMAhuSzVhv26nISP2P2tNvvT9bYll+pcoct
 1ClQWM6OThurSc47fVmDhe2N2PRycMIha6okjlt0wkbrevAsQuEnMc6TLI4wOOfISNp8JC7
 1ejfXHTRfp8+YJ/GHPIBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Wlz/MtgfY0=:aCHbUXTs1wXmLFU4sBQ8G7
 D5ChNROZfXdoEe/FGlOHlfaa0KVQMn5NO61X2iXyDwUrg0sH+TY25r2TPhJKgyKyOQUDUf1RK
 Y2Sx6rZ76SW4H2e7VgrND30AwkgJoliqOGw7FDH9igNJ/zB06QB6wgGzdxZJRPreo/03HfTVQ
 O+mUS3FI6Zrq4D8kSMuop+IHDSLMXLjgVIPiPXe/94dPyOTeChs1eUBYbdtIkELQ8FLmurZOA
 88QU8KbaZTPuARMqnzfYJMdDrX9TawbzLShoRW2Fbc6rAA9jTnxYBE4tJVvAbqvxPMIWz/mzm
 3Q77DzozZa8ZOx3MbBGPCemtcL4170XbfI7ygw1zdCeqAGfV25ZllHLp7O0P6kXWwxQZcazHn
 BeuBDKju/KkD+/NJ3P09G+6QCbxIstaGZ9EizQJw6bOyHVuW1actxY+4fwjq7a7oFXL9YhrR1
 JuBCMZ1iRn4GBEOEUyAwi0a5EJ2X4X6A/l3eEBR4YXf/DdpHr52cj56E6/5ad57/uX9WX9aZo
 wQJPNdyi08HmDBTTz0p5K4bbebLtcexjPHUfUQADwX/VsFNJGycF+/DBuaa5ZKnK/nvFh1qI+
 BUzWQn7VehjJUKR1xY3FBW9k83zx3PV1NlTFSxNfXkd2TN7G3TBypaPj9dQqbeTZb8+55mQVR
 5yc6frlBlo1SjvuCtQYf41ItYyqMjmqMplJrXgaMqP3u5ySP7krZLGvuJCv6muiBomLuVdnbp
 6W5cpxvQNMieZSkXSF3g2ohUV7jqb6vpnCNPeUzKVsRZB7cflxGOfBuETrjLGoQDBRiRnNlAn
 lPQ19uq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1362406214-1472735020=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Wed, 31 Aug 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:55 +0200, Johannes Schindelin wrote:
> > Just like the interactive rebase, we want to leave a 'patch' file for
> > further inspection by the user (even if we never tried to actually appl=
y
> > that patch, since we're cherry-picking instead).
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> This commit message confuses me. Did you mean s/Just like the/When
> doing an/?=C2=A0

What I meant is this: when calling `git rebase -i` right now, i.e. before
any of my rebase--helper work, a failing rebase will leave a `patch` file
in the `.git/rebase-merge/` directory. Since the sequencer is in the
process of learning how to do an interactive rebase, it needs to learn the
same trick.

But I guess that your suggested edit makes things much clearer.

Thanks,
Dscho
--8323329-1362406214-1472735020=:129229--
