Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794B22027C
	for <e@80x24.org>; Mon, 29 May 2017 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdE2Kv7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:51:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:55024 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdE2Kv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:51:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgpmG-1dbCs11Z3I-00M4HL; Mon, 29
 May 2017 12:51:41 +0200
Date:   Mon, 29 May 2017 12:51:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, philipoakley@iee.org,
        phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
Message-ID: <alpine.DEB.2.21.1.1705291247000.3610@virtualbox>
References: <cover.1493414945.git.johannes.schindelin@gmx.de> <20170526031508.24838-1-liambeguin@gmail.com> <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1569139910-1496055101=:3610"
X-Provags-ID: V03:K0:WXirDn58Q+IQIHQrz0sRVN0No+Oiqd8e5R/3RjAmCghKFAVPAJ6
 o81UB3p5oJSWyPc7BpjG9CIUGRW08eV919JQR/OdSVvtvpShfh0G2PWURdXg/9YvkNEC8WH
 U5VXGWsBHe9sXRHN6EWwfxt61s/gKKAzQmFF52fC4Iulw6SWqJDRhWg3sBCKP1xdocBTPKr
 Aclxay6L0gaYd/hB1zbdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lExqtUpgfIc=:RNO0TurgS1tJTPtS5a4skt
 QKEOorJFALOdQoZLuyacXyBplDOLEezYPszZHOJ0VoBZFb9rgj3+Q6sXkr5iT64zX657mv1Vp
 ZanaN6TbbghwZiKnY4UM9AKmUsiEedwRuiitsTm1vIQKtpk5Vrv5sRQiyoEOtnLCvEFZBHB3s
 YXys03/tCs3U+hV8/kqreIbXCUKo2iYvFXq3Sf3Y8yE2URBQNQmJRKkqteti7cW4Eq6320E/Y
 P1XuN05aYVCwPI3QwoGJGc64HqTp9hgDnIAZE360BFpxly9y6Jheqct56WapXctpxJ2/FrTeT
 xFlgX0pdEl33Di9zJukvYE7QZVgN2zF0v3scndza7l6XbmU243DsXDU0zKzNat9HJjWUvi3xI
 FzFPglvs/vzXXUD9Bpejjyt7K1VnuOAraFulAzLPFTZzwcKucYfBXmZQNn+pF79+ICRNZo/q/
 cfHYEdMclGWfY4FBWJJGWySH9InkvphH877jLAdIUFNWHNriu7D5RWo5LSKLIsWA2vbjEmxHw
 3OrN/dkwLozia6AXcGcbpT1tyNCWtuC41F+lzjLgXmZkhfHARr/na8x/syxCt1gyFZM3ik5z4
 ywTscSDPhS1F+U8KKU9hFMl9pQ/eiRxJTLiT4Pjyal+ypsmkA2kkx8XkWN8EWrlMYMCoz+6RM
 2/COvN7TPQlZOL95gXnRVZjColw2DbWujFpSwSOZjs9XcnliGNOmrdkujqOw+w1+BDORlNocj
 MXmyhb4osYLh7H4zXhyEZ4yU9Y8APqdDCdOfBw8ODWPYpZvnTz4XAPwcwwWxwO6UtX3trpEG7
 NWOE6LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1569139910-1496055101=:3610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 27 May 2017, Ren=C3=A9 Scharfe wrote:

> Am 26.05.2017 um 05:15 schrieb Liam Beguin:
> > I tried to time the execution on an interactive rebase (on Linux) but
> > I did not notice a significant change in speed.
> > Do we have a way to measure performance / speed changes between version=
?
>=20
> Well, there's performance test script p3404-rebase-interactive.sh.  You
> could run it e.g. like this:
>=20
> =09$ (cd t/perf && ./run origin/master HEAD ./p3404*.sh)
>=20
> This would compare the performance of master with the current branch
> you're on.  The results of p3404 are quite noisy for me on master,
> though (saw 15% difference between runs without any code changes), so
> take them with a bag of salt.

Indeed. Our performance tests are simply not very meaningful.

Part of it is the use of shell scripting (which defeats performance
testing pretty well), another part is that we have no performance testing
experts among us, and failed to attract any, so not only is the repeat
count ridiculously small, we also have no graphing worth speaking of (and
therefore it is impossible to even see trends, which is a rather important
visual way to verify sound performance testing).

Frankly, I have no illusion about this getting fixed, ever.

So yes, in the meantime we need to use those numbers with a considerable
amount of skepticism.

Ciao,
Dscho
--8323329-1569139910-1496055101=:3610--
