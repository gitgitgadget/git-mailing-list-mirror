Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805111FF32
	for <e@80x24.org>; Mon, 16 Oct 2017 11:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdJPLkL (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 07:40:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:57054 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbdJPLkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 07:40:10 -0400
Received: from virtualbox ([95.208.59.135]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0smx-1dF75M0GMx-00v5Nv; Mon, 16
 Oct 2017 13:39:59 +0200
Date:   Mon, 16 Oct 2017 13:39:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
In-Reply-To: <xmqqk1zvuahz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710161334291.40514@virtualbox>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de> <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de> <20171013163923.GA5598@alpha.vpn.ikke.info>
 <xmqqinfiv5u2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710151804060.40514@virtualbox> <xmqqk1zvuahz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yoBqo02+FYG37eeXq3189v4N+a3Pz07h4zETMgIt1VDJJv1Bl5e
 PUb/Yw2/Zqe0pHzjVo3j90XOqr4440msnhkyW+CEhYjh553seDcWXRni7B2DVoUIouFfcXR
 lyg3+Ekvqn0JpYaiFqzSGXggBXlFNn8XazqyDlk2EL+LvjDN+UHu2NWCEUUlJxVf/NdLrJ/
 Ziy2bq7M40yNmdaJmUCoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fe3sie/D968=:Vem2HBDGtMMqvym9nf48UK
 kgj00jh55WucqYEc9Ydaj0EFaEpXUuUbKZJKyhy+p66YczwO9aZF3pA9pSwcoX5rkPEHjLtId
 AfqxSfnlhGEPne0oJfM5s24ruSivqvbIKjNkvRAhrl4kRZ33RXglDbmn07XJ4qd5BeC9JDZlG
 33DWveeeVRblTq2EwrJiqxnWdsxZn8ZXKNvS+XkD16Cb8SEy45nxOTmFDK8u+f3S4LdZgyzUF
 TGxMUQK9ss8ssS7xWpV8BBhdcvc22LHrtfvDpmJEPBMCEPyjD9TCGYg4WZHQ05lbUu1ybKCfz
 1+vOkYBwhY3I33F+CW1xrWV0Qn6ZtJeFcZa0hfCO4Dgy5k6jovSm9jPvGU76KNceREeGiJOVq
 z87dxI49BVEHSFdGmXjTWYBlcMcQ1pyXSTAzFzFT+jVU2Jba1AQA51ZxLN2XezWvZyVRc3AtT
 1bCWv7DhDj0vrsrgBLmrz4UDCITOmHKVadTxl3BNdzECatlePpaedYx/nbDPv62Epcqs/tCxz
 Y7CQuoaTQc2DuuEgNyEM59c7UOhZcEoACvcaqkgT6fwlABV/hUpk9aNK3i+Vt5DDR0Yj64whP
 omn4HwBBbhKQWKrg1ZeDNb4BxzfAPL+e7aTSxYrli1LbxlCKoliHritJJIaq0mvYp0ZQIsrsO
 PuzanlZY2sJ+mhdLX9UHNY8OpHs8sA2sOGExZuYrS/3tzpiK4sJFLDPYeRvxUCzojrEfwcQoP
 bfaQV5ufdQrvY7qKKCm73V2Dh6nNbWgtO0CuV8Cqmnlr5ubQ5mjdg6YVLZD9GxSgMfVOdVXoz
 YnFMHELbGkLLk1d/N/en2a9cgmZh352yYuaLCTZKYspNSDuy1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >> -Also respects `:remotename` to state the name of the *remote* instead of
> >> >> -the ref.
> >> >> +Also respects `:remotename` to state the name of the *remote* instead
> >> >> +of the ref, and `:remoteref` to state the name of the *reference* as
> >> >> +locally known by the remote.
> >> >
> >> > What does "locally known by the remote" mean in this sentence?
> >> 
> >> Good question.  I cannot offhand offer a better and concise
> >> phrasing, but I think can explain what it wants to describe ;-).
> >
> > Yep, described it well.
> >
> > Maybe "and `:remoteref` to state the name by which the remote knows the
> > *reference*"?
> 
> I dunno.  
> 
> The original and your update both seem to come from a worldview
> where there is a single conceptual thing called "reference" that is
> shared between our repository and the remote repository we pull from
> (or push to), and the name we call it is "refs/remotes/origin/devel"
> while the name they use to call it is "refs/heads/devel".  If you
> subscribe to that worldview, then the updated sentence might make it
> clearer than the original.
> 
> But I do not share that worldview, and I am not sure (note: I am
> truly unsure---it's not like I am convinced it is a good idea but
> sugarcoating my expression, at least in this case) if subscribing to
> the worldview helps users' understanding.
> 
> In my view "refs/remotes/origin/devel" is a reference we use to keep
> track of (or "a reference that corresponds to") the reference they
> have called "refs/heads/devel" at the remote, and these are two
> separate entities, so it's not like "this single thing is called
> differently by us and them".
> 
> Stepping back a bit; here is how the description begins.
> 
>     upstream::
>             The name of a local ref which can be considered ``upstream''
>             from the displayed ref.
> 
> So 'upstream' is like 'refs/remotes/origin/devel' in the example in
> the message you are responding to.  Perhaps we can make it clear in
> the description, and then add :remote* modifiers are about asking
> where that remote-tracking branch comes from.  For example, instead
> of these "Also respects...", something like:
> 
>     For a %(upstream) that is a remote-tracking branch, the name of
>     the remote repository it is copied from can be obtained with
>     %(upstream:remotename).  Simiarly, the branch at the remote
>     repository whose tip is copioed to this remote-tracking branch
>     can be obtined with %(upstream:remoteref) as a full refname.
> 
> may reduce the chance of confusion?

Let's take two more steps back.

First, for-each-ref is a low-level command (I do not remember whether our
nickname for "low-level" is "plumbing" or "porcelain" or anything, so I
stick with "low-level" which I deem descriptive enough). That is, users of
this command (and therefore, readers of this man page) need to be quite
familiar with Git's worldview.

Second, the main purpose of this patch series is to answer the question
"what is the default <remoteref> in `git push <remotename>
<ref>:<remoteref>`?" for *many* refs at once.

Maybe it would be better to describe the functionality by describing the
question it tries to answer.

Ciao,
Dscho
