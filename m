Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC23211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 21:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBGVnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:43:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:38749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:43:06 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1gbh4b1vyP-00YUyS; Thu, 07
 Feb 2019 22:42:52 +0100
Date:   Thu, 7 Feb 2019 22:42:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <20190207204910.GB28893@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902072234390.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
 <20190206185520.GD10231@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet> <20190207204910.GB28893@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2I+ghm16ku0xka7jBhFX4nrPbU+/hZnP10TQBMLdcza0w4oUwJX
 KdF7xR3gjWL/3zZIBTfCfR6QChWh6rrowQbDdrfzuANXW29kc3fScsgk2WoprvX+uZcF75s
 srxnVihX8ZNC1w8/COGHZ4v2Z8/MgeURSFhrsA9cR4+HrDDHeGS0LOOuBbHbcl5sTID6v0Q
 7ChJ5Lsg7/wzA3+jV+MIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezfekxNTRdI=:XRTF5dXAeFkCOpWQJ7PeO2
 Xv+nbh4RpJ0RNX7yfOKgmn0fcdGMB5xoTkDOOE4LpFrKE4MbjtubiTSlAuUlIxbgCRN/eeYbc
 BBcPi9bjWV4Lo+LbQ5S+AR6QTjYywLuF04VyFxHzmu5ZcMD7eGNgJbof6inKnOxbXuL2lkF1N
 SU+GGebM6Bae73+9K7JB4fVeQ7YGFL87YndeypC7zKHh2E0NYo48B4zUIi18fGXdZB+SIFE5o
 x0vDxlxw3lvS1SACOh1OrhCGmfxYEPm1zlG9m0UPtQl1CyimgrSojgqBx/r0aguYySM8mp3NA
 Ci16t1NfxEpwjSh7EZ2bOjHXO8lhOUTzJxgRP9EBTdH9/BTbP/tuMX31GGFG/RnoLzjJsYUi/
 rfxupJQPQvOyhNDc/W6qJBxpil12Rv0MXCjeqZTsEPbQJNqf07yJIpdFJyvGbud9aEYS8ZhRU
 /owwPF1n/WpUxjKLCwrz7CY1WSP64DzCvr4xq9JEs1rDccqNad6te0xHJ9fKyvef4QhwC+eoO
 MmrMJrne3QyIeR0fVfkZYQFSjXgw0qYmC6A5czKdQ0vZZ0xbsSq9PBOzg1WBw3ybZtabGs+hw
 btcGfjYruHPBA69UTiq7F7endu4PH6h15WFYH2DLhHIEYF9G5EBslCz3n4zADY4H4K4UqTxCB
 oD1gvFQfgc5E7YCL/eYWPrhU5unWu94CnEAz7z98jlW0DahLxcLu1v51y40XBmKmPe3MjWhfo
 QTN9E1k2Bv6iviBbHL7flEosP2a6e1vm3grm8hfiNblBgBFX9xsZv4LHhA/jtGms6j5Bnu99i
 qdNJgsERlHHnZ/dlCoFZKCXWQaSrA8HsBrfuDnyK1xYgzNJhNVAhbzFO2gNPzS514xshalfZE
 mFroeIi1XmLa1HRJrRN5E7o6KoZtAm5JgE7+AoXK9Rl7mn1Zsgzp4EIFUcsFKzk4kKK/gYW0V
 sbGUEtqbzww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 7 Feb 2019, Jeff King wrote:

> On Thu, Feb 07, 2019 at 04:41:57PM +0100, Johannes Schindelin wrote:
> 
> > > I think this can be limited to the tests that failed, which makes things
> > > much faster. I.e., we run the tests at the tip of topic X and see that
> > > t1234 fails. We then go back to the fork point and we just need to run
> > > t1234 again. If it succeeds, then we blame X for the failure. If it
> > > fails, then we consider it a false positive.
> > 
> > If you mean merge bases by fork points, I wrote an Azure Pipeline to do
> > that (so that I could use the cloud as kind of a fast computer), but that
> > was still too slow.
> > 
> > Even when there are even only as much as 12 merge bases to test (which is
> > the current number of merge bases between `next` and `pu`), a build takes
> > roughly 6 minutes on Windows, and many tests take 1 minute or more to run
> > (offenders like t7003 and t7610 take over 400 seconds, i.e. roughly 6
> > minutes), we are talking about roughly 1.5h *just* to test the merge
> > bases.
> 
> I was assuming you're testing individual topics from gitster/git here
> (which admittedly is more CPU in total than just the integration
> branches, but it at least parallelizes well).

Indeed. And there, I can usually figure out really quickly myself (but
manually) what is going wrong.

Hopefully we have Azure Pipelines enabled on https://github.com/git/git
soon, with PR builds that include Windows (unlike our current Travis
builds), so that contributors have an easier time to test their code in an
automated fashion.

I also have on my backlog a task to include `sparse` in the Azure
Pipelines jobs. That should take care of even more things in a purely
automated fashion, as long as the contributors look at those builds.

> So with that assumption, I was thinking that you'd just look for the
> merge-base of HEAD and master, which should give you a single point for
> most topics. For inter-twined topics there may be more merge bases, but
> I actually think for our purposes here, just testing the most recent one
> is probably OK. I.e., we're just trying to have a vague sense of whether
> the test failure is due to new commits or old.

Oh, I am typically looking only at the latest commits up until I hit a
merge commit. Usually that already tells me enough, and if not, a bisect
is really quick on a linear history.

I guess my dumb branch^{/^Merge} to find the next merge commit works, but
it is a bit unsatisfying that we do not have a more robust way to say
"traverse the commit history until finding a merge commit, then use that".

> I think Junio's suggestion to just pick some common release points would
> work OK in practice, too. It's possible that some other topic made it to
> master with a breakage, but in most cases, I think these sorts of
> failures are often more coarsely-grained (especially if Junio pays
> attention to the CI results before merging).

If Junio wants to experiment with that, sure, I'm all for it.

Ciao,
Dscho
