Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694041F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 13:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGJNSV (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 09:18:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:59901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754201AbeGJNSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 09:18:20 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEbYb-1fsViy1c2j-00FmGF; Tue, 10
 Jul 2018 15:18:17 +0200
Date:   Tue, 10 Jul 2018 15:18:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
In-Reply-To: <20180710115344.14392-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807101517290.75@tvgsbejvaqbjf.bet>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com> <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com> <20180710115344.14392-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-512442736-1531228699=:75"
X-Provags-ID: V03:K1:q/SMRbTL//zm+u1hQ1yAyqSwYlGCCBXNZ/+kL1NwUcSM00rCcs8
 Itt6vJ9mDBtXYU7ziLsE1k+hhqdwswyx+1EF+cxH6Q5ZmINx3+FK4yARwaZ1O9HuEY+4VQ6
 AiJ1HIKRwu3lC52BVJZ/llJF3cnL4fbYyRqpiuYjrTYj74HfnMqK7Xdy+f2KExFE3DPIpjO
 ruJzON3a3lbhTBA510fIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9SiN6ZINTbM=:DAfJgfWsSGp80Ci4ori2Ak
 87AKO4b0p3fXNw4ae1HI9Ga102ii8Wkd5Ha9qiq2Gq70LZN4lozxlQlJMw2B9FsyAOGMcvkE2
 cnwkYJ2XjtjhoMJ4y3WVHcbyY82Q4UnWY2MT/sSbEg7QVecDv9WeJl+nkc9QxZwAUtTCcmjpw
 x6a4E3WNBSituaF1abJjiQ3YfgrsJwyat/TmHdrqfhGUNi5IiLf/g0dPdgJGnfNT0q6BkvZQA
 uGETildZr3QoJhflqAAQtvhDOsRl0ERhMDun5YWJ8FB+kZams+M2QUKVCeQ70qlLiyJzMauRJ
 Susnos+4MnpEnUuKPug6XlZGEsZ2W9LcO8PpXKH62J8toK5Hde4ufrHwrOAz/iy5U8tXlomFf
 YpfYTRs5wt7LYyfSIh/AZwm5THvVWnOo26Sm2v3NIDZ2C0iUbmfCt59BuzOfywOzxYFRewaq/
 iIZraZhVe1ITGpFJcw/9U+fO0q1lYuIIGNuoKKqdD2o5XWQwD45UmYa+EfcJFVbraYnh73rHU
 grsVyHm0EKa8MgzmVnX4KmYt8e5QKid57iWZWGcAZ6Cjw1RomNt88q7dQVUUcsHiLsWlk8ysS
 0SMTAFj9SN+imipmMFMl6gCokSczQZbPsERZJbi0V97G2Psb5TnjTyzaxYzqrocCZfY5ifNtN
 QDmCzJb3tsLxX4BH6ovRfSGVq9x61FFLKEoVCAWgYmnMJTcuoOwhFUxOwODkR3FesKsK4FTnF
 iSjWk/teCkvGZrRWZyhVuL/QljrTYKHHFTViNeaCBuD5a6OuWtR8L4dSEIma2o3ko/s7L0ery
 Sw49xPr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-512442736-1531228699=:75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 10 Jul 2018, SZEDER G=C3=A1bor wrote:

> > diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> > new file mode 100644
> > index 0000000000..5fff540a26
> > --- /dev/null
> > +++ b/t/helper/test-repository.c
> > @@ -0,0 +1,88 @@
> > +#include "test-tool.h"
> > +#include "cache.h"
> > +#include "commit-graph.h"
> > +#include "commit.h"
> > +#include "config.h"
> > +#include "object-store.h"
> > +#include "object.h"
> > +#include "repository.h"
> > +#include "tree.h"
> > +
> > +static void test_parse_commit_in_graph(const char *gitdir, const char =
*worktree,
> > +=09=09=09=09       const struct object_id *commit_oid)
> > +{
> > +=09struct repository r;
> > +=09struct commit *c;
> > +=09struct commit_list *parent;
> > +
> > +=09/*
> > +=09 * Create a commit independent of any repository.
> > +=09 */
> > +=09c =3D lookup_commit(commit_oid);
> > +
> > +=09repo_init(&r, gitdir, worktree);
> > +
> > +=09if (!parse_commit_in_graph(&r, c))
> > +=09=09die("Couldn't parse commit");
> > +
> > +=09printf("%lu", c->date);
>=20
> 32-bit builds complain about this:
>=20
>   t/helper/test-repository.c: In function 'test_parse_commit_in_graph':
>   t/helper/test-repository.c:28:9: error: format '%lu' expects argument o=
f type 'long unsigned int', but argument 2 has type 'timestamp_t {aka long =
long unsigned int}' [-Werror=3Dformat=3D]
>     printf("%lu", c->date);
>          ^
>   cc1: all warnings being treated as errors
>   Makefile:2262: recipe for target 't/helper/test-repository.o' failed
>   make: *** [t/helper/test-repository.o] Error 1

Let's also state how we usually fix this:

=09printf("%"PRItime, c->date);

Ciao,
Dscho
--8323328-512442736-1531228699=:75--
