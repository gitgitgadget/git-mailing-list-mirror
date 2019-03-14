Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A0F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 11:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCNLbu (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:31:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:50835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCNLbt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:31:49 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0Np-1h5m1v34rt-001Ofj; Thu, 14
 Mar 2019 12:31:38 +0100
Date:   Thu, 14 Mar 2019 12:31:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
In-Reply-To: <20190313201854.GA5530@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903141228510.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net> <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com> <20190313193909.GB3400@sigill.intra.peff.net> <20190313201854.GA5530@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gUE82s3jDQ7V2AK46dqBqKJ6rA80KPbfIB9LKlF9HZR//75r3Xj
 w5Y1avwwroRM4YnlkycAAB7Su2/Uubd90x+864c4UolTu7Hqlm5yUxxh0S6F5J20RBciTZY
 M1t+1HNwgDYjno/IrDmPRRQLeAfi/cpvCMYZy49QiKmye7/SClzFG4HbHPu8KMRCCpQbuwg
 OjwEZ7rGte9JuK5ANT2oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKh9PCavbxw=:UtYJcp/0XDlnWVBmofAX+S
 ndoxJZdkNiSiQhW3fMoK1BY2lZx6nXoAIt+pWR9uKj2EBe8WzhYAiOivNvp2GBq7WgRf/hAbj
 FdlfkcjSJL+yi6xFpwvvP2//kjuToyEyxeDfyTs20yFzdoqA2TW+wAXBft+cmPkJII0jXomQu
 Dp1D1qj5BdzmioecyyGuTxR533QJXiQSTXJvZzVynCmO6KPIrHsaZA5myikX9JMwSzHF987Ul
 0NlJVu5HoVmSfY9uJ1RHtNQCDrQ2lQ5UyQtNMRwh1BgweN1QBC1ZI+QKGpCY++x9yx/EMIwF1
 Nrf6ActpYHMC5i3mcd/MA9R7+EfrlgMLJjgBucva83GsyPVskuOdXvfgHrWJnJjBqDAd7cOZM
 mAeJ0w7FGSzMQV7tGvAW7WC/OiPTk2JQPDUdVmdkEIpwBiJ4HM0npDvDDOivzMdtA9k5o8zRQ
 3e+wz40JJBtQAx2v+lQjhz/OFIVhlTL9bLG3PuSDJN0lPgB767zXCHtyfMKwFfqCnBNwHgCP0
 EbaigSrHyrSWK7/gh40FmXZ8dyDi8Ad4+AItbVhd9P4xYlR01KeK8r0FpYj/5ztEnAOBuQV5o
 EbQkLx3Omf5MrepRnqv89/gpy/RAYvLwy3ZgcHjtEPSN6B1f81VqY0uG87IkK2ffjr6D7g/4O
 uGzZLxTT6XzQtc6P0lzvU75YZaVjdoM9WU1VzhGUJTe6env2mLBp10MMDoSnqZ9MZUzMx+1+m
 8kuV2qGghgQFCWPnRXg44EC3Vn+9TcajeRJDk/Hk3jvZF8G8lzwB5S8i+E12/tm7ezEvkjWqw
 XQqHxeer/rFBJFHNi0e2f7wy6K678ou9ZK0s4OJyOY0YCBqZi4SzFC1Lk3sVtHQNX/0TTLKT9
 kkZwZLgVsMerHSBXhBDkeNDggcqHg/Ala9Q06O8oCF/u65M1LRJblx76L6okCtOu/RvZZJN1z
 78CvNKXAlMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 13 Mar 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 03:39:09PM -0400, Jeff King wrote:
> 
> > On Wed, Mar 13, 2019 at 10:49:22AM +0900, Junio C Hamano wrote:
> > 
> > > Jeff King <peff@peff.net> writes:
> > > 
> > > > infrequent contributors. And there are a few reasons to prefer GGG:
> > > >
> > > >   1. submitGit seems to still have a few rough edges. E.g., it doesn't
> > > >      munge timestamps to help threaded mail readers handled out-of-order
> > > >      delivery.
> > > 
> > > Hmph, I had an impression that the recent "why aren't these sorted"
> > > topics were via GGG, not submitGit, though.
> > 
> > We did have one case a few months ago, but I think it was since fixed.
> > Whereas it cannot be fixed for submitGit without major re-architecting,
> > because the mails go out through Amazon SES, which writes its own
> > timestamp.
> > 
> > I could be wrong about GGG being fixed though. I haven't noticed the
> > problem lately, but we definitely had a submitGit-related one a few
> > weeks ago.
> 
> Hmm. I guess it is still an issue in GGG. This thread has identical
> timestamps on patches 1 and 2 (and my server received them out of order
> by 2 seconds, so mutt orders them wrong):
> 
>   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
> 
> I do still think GGG has a more feasible path forward on this particular
> bug, though.

Indeed. And it is a bug^Wfeature of GMail, I guess, that it knows better
and ignores the Date: header of the mbox fed to it.

The only workaround I can think of is to introduce ugly one-second-sleeps.
I will do that if it proves necessary, but I do have a problem right now
because my only GitGitGadget reviewer (Stolee) is kinda busy with other
things for the time being.

Ciao,
Dscho
