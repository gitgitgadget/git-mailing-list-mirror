Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F6A1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfAZSsy (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 13:48:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:39705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfAZSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 13:48:53 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlYrb-1hMFj709UV-00bNQb; Sat, 26
 Jan 2019 19:48:46 +0100
Date:   Sat, 26 Jan 2019 19:48:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 04/21] ci: inherit --jobs via MAKEFLAGS in
 run-build-and-tests
In-Reply-To: <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901261938210.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <83b92a87e7698cee1e2c44252b934ad436d75a90.1548254412.git.gitgitgadget@gmail.com> <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D0gQ+yYKmpBDYXN3HtKBZ4Y3HLkNO/AEH5DgZbLjwwJnvVjPAQV
 ui/odcS9UQVduXLy2xJKmD8iVuA1tHDSwhHN1wNxiJoSaPLIfyW5uHlb3xkCWf4NfPJ4W8h
 ODHqtCfTlErf7K5xR9utBXFbPrLd8nrrpjgmdWLDUunydv3OCNzZTQtTX1SWaG/hqqQRBGM
 1Ws2QJe67u7lJTtGuzRzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:luX1zTYflNM=:OMYvDhWiPj29YVhs8pv2PD
 OEnk4ChL8D3FPcgvBW0ttQHhFFJVOWA1axQNuJ9774vSNO0b+eaurtOYEjJJtKTBHwtzVxJ8s
 v58fSclqlmKIkUUAZIB750kH4RJ5lpZS50tUYhDZPNbt+lS42t2/kiZmCdw0LcQ0gRlEzKudY
 /2tFBaztoSbBOd6lV7oENPdaVCqKFPFJIH/G4js8KKTE5TMqmZbTUiyBGOU6Zi+fODSkTxYFl
 boZdnBKQkQXT/Lx83ZbLldR/r8Kn3sUjUm5xr0fsNndxOFAL22wP0ajj7z0IphCRZ4Moqs+uo
 namUxP9Km5a9+40PqvLrkunvP+mgGu1DDw5QxIA35+oPpj2Dd7y8CSfYhtPbpJtYyR0m6SyGB
 DNumLBKDTtN3ipDQ0EaZoK8P3ztWP9vLhpZ/hP1wwAAUqCviu5JzH8c086i+c6++yFJeE5k9z
 tlRCPqqHN2vtffLSndMGDueoOoZ3jfia0tOk43mQf7alWRagu4sDJ9HPatSK9BLXCV60h9ADw
 PdWQLIjQGrqPdqUzq7/eUxHAvdGjBeOvtybiJaJ26H7N1cOYk7IIKLHYupg/kIWdz/kAnP8X+
 uqCIimilRKigEd7U86Foensj7ZAdlgOvCEN1/B6H/3JMGSZjjmHiuYZ9L5zYqyoLJ6rWeSUiI
 Sg2RrTlOWFIuQzTxG4bd+zZUuKOoUUfDwKjN/qw3+2eAgPn5oLBFSsnT+8LM/IQyDckg9qRwd
 PnvL2NJEP2Vc/dnivKaiefftoMxRRrzUvQhOBFtQlN+r837czF1dJ0Iqtg0ET3Pi66V1CJSwa
 Sla+PZ0tFhj+QVfjX2sJv9ixM6zNEA6lPHRbyeMG1G/ey4YKahIU/nJh/dU6VJDE2Y702tEAr
 jVLIdFYp61rtARnB6RDY7FBiqpqSMl/u3CuI6eD8WuuUD2vfjMlQiYkz+h7Oj5+PMfiZ0rq5f
 TdK0vQaFJYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Let's not decide in the generic ci/ script how many jobs to run in
> > parallel; it is easy enough to hand that information down via the
> > `MAKEFLAGS`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index db342bb6a8..80d72d120f 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -7,7 +7,7 @@
> >  
> >  ln -s "$cache_dir/.prove" t/.prove
> >  
> > -make --jobs=2
> > +make
> >  make --quiet test
> >  if test "$jobname" = "linux-gcc"
> >  then
> 
> As there is no assignment to MAKEFLAGS in this patch, is it intended
> for this step to change behaviour (possibly with the intention to
> add "default 2 jobs at least under travis" back later in the
> series)?  Not that it matters too much, but it is unnerving to see
> that the proposed log message promising "it is easy enough" while
> not actually doing so, without expressing an intention.

I was under the incorrect impression that Travis already configured a
MAKEFLAGS=--jobs=<n> by default (I got fooled by the GIT_PROVE_OPTS
setting that configures that --jobs option).

But the spirit of the change is still correct, I would think, so I made
the change more complete by actually setting MAKEFLAGS in the
CI-specific sections, and by removing the explicit --jobs=2 parameters in
the scripts.

Ciao,
Dscho
