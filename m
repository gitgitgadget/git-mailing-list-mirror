Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E549720964
	for <e@80x24.org>; Thu, 23 Mar 2017 16:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdCWQXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:23:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:52996 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdCWQXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:23:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3RZI-1c05Lu0mOm-00r2Rb; Thu, 23
 Mar 2017 17:22:58 +0100
Date:   Thu, 23 Mar 2017 17:22:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
In-Reply-To: <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231716320.3767@virtualbox>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mfo0v7HqbOjaODcsYW2/8fOZ4tmvHnpDVj359cBN5fOFwPtQMu0
 MfPrQ3c8eq7RqQ3NTm6maHomsXUZzuzoN8fVhit206BpK5BPTWe75pF6ICWXwPdIjkW2JJi
 1hfA740Jlidqvjm/Ryv1JdQWXpgco1Y6LVmLwSSDcFRwihVJ4SpczsPc7y4ck+Pl9r80eu9
 rKizZjlPyLkhreNio3sdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pl9XcSNO1js=:Io3mH2RT5HarGxD8GxEeuf
 aKljtK9v+cc/7wWhlmSrgJV1KIjZ7Wr+h//B2TGh1zQEzS9tnn3HrZQcvyXZDZBVWMm5N/MDs
 MySWvZNzXM/7704O5A7gLu+3uxg93Os+ghnTNmQHKv9LN93VZhvf1DfM2DDvrtEYzct0IGiKL
 /qKy8dW6Qx+dhO/rSOMzD6xCpQCsONUr5ruBsro5Bw8OtB44mi6pzZM6qnxhughYK99fZkrWJ
 /vh6CvbjpHHG44LThegnqtbgdI0oLdgdALgbLP0K5Mja6Cvk4kisUwK5OgXdFBFD10iLJAmoF
 y9snx6IiNxxIK0DzxBS+eTBO6x5JSGD8VnVcilliUhJseIsyr3swK54CsapKZ92bFe2DlLjxa
 Qy1oIpamNzWyubGPMawEtLT2pMhRuAf3KlJXv+v80qw/cfu4mP5vnD0UyRLJAombLG02arTbq
 WxMXZ3EFDnxlAo1uR5/Q99aSPSXN9k/anH9KS2PB2aCFmGII0ti7icnFVkTT2eyWhVVJmgKSi
 9YpYHtbcKbN0tJeeJgIceVHyDDfeXPrKODn1JtLuCRo8t1LZgAojpayHrRjhxgyMeg6tznL66
 Moou7vj08q8O2iDIsHk7NiIXg4w3o63lskMJBz1P6wTmDWlZJWHlwgKtVWw8Gdb2jFOoW/Oc8
 h52TUttTp7ZxX2yWAFYJwtKO/Xmhns09A+EAyYhlUNWg4HyIjqqR0UdeJBcXmpFmPLFGfZJb2
 hYl9zPA3nP4LmOFfN6XbJFPtStrc00QCOzyYUPWh+n6ic6dwMuofrMzeaxVTy0V11fDN6i6vl
 0iHAImIW8u67k0kLOKyzU1hoI4qDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Mar 2017, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > Therefore, we did the following:
> > * Johannes Schindelin set up a Visual Studio Team Services build
> >   sponsored by Microsoft and made it accessible via an Azure Function
> >   that speaks a super-simple API. We made TravisCI use this API to
> >   trigger a build, wait until its completion, and print the build and
> >   test results.
> > * A Windows build and test run takes up to 3h and TravisCI has a timeout
> >   after 50min for Open Source projects. Since the TravisCI job does not
> >   use heavy CPU/memory/etc. resources, the friendly TravisCI folks
> >   extended the job timeout for git/git to 3h.
> 
> The benefit is that Windows CI does not have to subscribe to the
> GitHub repository to get notified (instead uses Travis as a relay
> for update notification) and the result can be seen at the same
> place as results on other platforms Travis natively support are
> shown?  

Almost... Windows CI *cannot* subscribe to the GitHub repository, as only
owners can install web hooks and give permission to update build status.

But yeah, you understand correctly: this innocuous change (along with a
ton of work I already finished on my side) allows us to let Travis trigger
Windows build & test and to attach the log in the same place as the
Linux/OSX results are already accessible.

> > Things, that would need to be done:
> > * Someone with write access to https://travis-ci.org/git/git would need
> >   to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
> >   repository setting [1]. Afterwards the build should just work.
> 
> We need to make sure this does not leak to the execution log of
> Travis.
> 
> For example, in https://travis-ci.org/git/git/jobs/213616973, which
> is a log of the documentation build for #1335.6 ran for the 'master'
> branch, you can see "ci/test-documentation.sh" string appearing in
> the log twice.  This comes from "script:" part, which is the same
> mechanism this patch uses to invoke the new script with sekrit on
> the command line.
> 
> I am expecting that no expansion of "$GFW_CI_TOKEN" will be shown in
> the output, but I've seen an incident where an unsuspecting 'set -x'
> or '$cmd -v' revealed something that shouldn't have been made
> public.  I want to make sure we are sure that the command line this
> patch adds does not get echoed with expansion to the log.

Right, typically there is a way in CI setups that marks certain strings as
secret and whenever they appear in the log, they will be blotted out.

> Is GFW_CI_TOKEN known to be safe without double-quote around it, by
> the way?

Yes, it is safe without double-quotes. I generated it using:

	dd if=/dev/urandom bs=20 count=1 2> /dev/null | base64

> > Things, that might need to be done:
> > * The Windows box can only process a single build at a time. A second
> >   Windows build would need to wait until the first finishes.
> 
> Perhaps instead of accumulating pending requests, perhaps we can
> arrange so that Travis skips a build/test request that is not even
> started yet for the same branch?  For branches that are never
> rewound, a breakage in an earlier pushout would either show in a
> later pushout of the same branch (if breakage is not fixed yet), or
> doesn't (if the later pushout was to fix that breakage), and in
> either case, it is not useful to test the earlier pushout when a
> newer one is already available for testing.  For branches that are
> constantly rewound, again, it is not useful to test the earlier
> pushout when a newer one is already available for testing.

Yes, I think we have to use some kind of "skip" status if the build failed
to run or finish in time. But I thought that the "timeout" status would
fulfill that desire...

Ciao,
Dscho
