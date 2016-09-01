Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BF91FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbcIAI2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:28:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:56891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbcIAI2M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:28:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEFIm-1bulZD2zM0-00FR43; Thu, 01 Sep 2016 10:27:55
 +0200
Date:   Thu, 1 Sep 2016 10:27:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sverre Rabbelier <srabbelier@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609011027210.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
 <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608311233440.129229@virtualbox> <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6N0dax7GLu+7zgC5EtuEf5IkzDVNwXJRWDikF8LWsrr4+pBCE3O
 Tt/w+qYsBoXBJpdJBxMEoGZ+HJeojv3ccqPvsGh2oJLbcsxdwpWZ5naXnd1962U6Pgq9VvW
 gMHJ1juugLK8QZ8QHMDZkmPOynPGGXRobaiRx70u/dydMNDDzRo7iYnCo85L19y2lmHa3vn
 4b7v3spapx+fxpx3xp1tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mi5/Nm4LPj8=:9QC8rRoq7auc1ASylmBREY
 2GNUTuDOg1XNEpR8i7O2uKeuVzEbJtK69HRhepTnh/W7TK53ENSvA07qbleuR0/Y9W28rwu9Y
 KCriXBPDFokGFlF1OsuRcsowmxyMVe+G5K9F+SR+qZ8iDhRF23Z3yTCRTITrOIChasH5ihPVB
 BNo6tAg7cOWKuFZddUxtYwm2ATJXwlUGo8n3YnI/biYLJ6oF8dCQuGBoMbJFHijOCRLuYZZs3
 xtt2o9Id2WoyulUGDUM0BZjkSN5v5rtDn+9uMKlixdMnIHTW2SjKwi3ptJqV4xYXV2Bji++JI
 67xbLLoJ3wrcaOa4pTbrOtKEoraZEhIyAYPAXYCGgPpLylzqewn4s8Whgi0FDxLjR8lvY1CwI
 VG5R694uwQuqYxDWjJXfrRLF2ut8N/K5yCmCPs+b7MSpnuDsMwmRE3mTO6FHHd4RxI6o5vuFl
 NqLyBSgG+aY/Z+0KygvMGskV470cMHNprESRfv//9rg9pq+xEtIEjDkm72r5egVeHhDklXN6F
 Dz1xbjf9aXBxaXINPIZ8ty4BS91QjrGHN3Tb3zyb/S5mHrONOp+n/Voolo3n9VeGrvEmc+fL0
 pfN4YXMqYzFrR2LBluy8P80MMlAc46jWGGjP3Efj07ZdmQc66c2MB0zhglg8Umxa8HM+Ec3C0
 DMCU7ts9MiKTep28vrQval8Lcy1sdVyvJ/Kbse0CHnwlDgFVie76XXDPwk1MWh7tbX3i5fz10
 AkNA40iyTsDUE4UXEVTSOoHDmymMG+267eNmjuRmoIwYKcRD9POyBQFnv9/NEP4NUqR3rVlrQ
 nbY8Xk2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sverre,

On Wed, 31 Aug 2016, Sverre Rabbelier wrote:

> On Wed, Aug 31, 2016 at 3:36 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 30 Aug 2016, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > > > Hmm, interesting. Your approach seems reasonable, but I have to wonder
> > > > if writing the pid in the first place is sane.
> > > >
> > > > I started to write up my reasoning in this email, but realized it was
> > > > rapidly becoming the content of a commit message. So here is that
> > > > commit.
> > >
> > > Sounds sensible; if this makes Dscho's "which ones failed in the
> > > previous run" simpler, that is even better ;-)
> >
> > I did not have the time to dig further before now. There must have been a
> > good reason why we append the PID.
> >
> > Sverre, you added that code in 2d84e9f (Modify test-lib.sh to output stats
> > to t/test-results/*, 2008-06-08): any idea why the -<pid> suffix was
> > needed?
> 
> I can't really recall, but I think it may have been related to me
> doing something like this:
> 1. Make a change, and start running tests (this takes a long time)
> 2. Notice a failure, start fixing it, leave tests running to find
> further failures
> 3. Finish fix, first tests are still running, start another run in a
> new terminal (possibly of just the one failed test I was fixing) to
> see if the fix worked.
> 
> Without the pid, the second run would clobber the results from the first run.
> 
> 
> If only past-me was more rigorous about writing good commit messages :P.

:-)

Would present-you disagree with stripping off the -<pid> suffix, based on
your recollections?

Ciao,
Dscho
