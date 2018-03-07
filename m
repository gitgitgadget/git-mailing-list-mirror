Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371BF1F576
	for <e@80x24.org>; Wed,  7 Mar 2018 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeCGH0y (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 02:26:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:53009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCGH0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 02:26:53 -0500
Received: from [192.168.1.106] ([88.26.243.156]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb7pT-1f884m0uct-00KkuE; Wed, 07
 Mar 2018 08:26:44 +0100
Date:   Wed, 7 Mar 2018 08:26:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4GM32dP5BfRY7G1ISoWA0MUqklozJyi90ZIK4zFrfqEVfmqqQde
 VHc4fjwqTl2uUBwd8zrGkg2NqzZwT3hXNg0pWWYQwJcbVgsOBcN8us2qdGjbBxIW6QE5MU6
 CBb4H9A2SS1m4GWzWMKPIMzc3CbpzmygCeWxdmNuOAuGyqk2HCcaemeWp6XG7e9ovTUst3v
 g2NXf4PJ1GQxdimVyuOQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:unpMP+qYhT0=:DPxaPBvvh6nDIWUQ5JMkLx
 1RBnWivVGufBeTKgEzMw5GbFClSq5ZNkLC4xiXtymOHGXjvn8Fxq/Co/uiKb9bgHQeK/GRm7t
 bqn05g/fiddpVi0BiUI5/2R23w6F8a1vy4jEDKrx8hWKiLx6WB/7cisFrsIW8E759SmOVLJ54
 g83rRFutSqvAnIf/H43loQyCg5UPz/tbCUyWBVNgXgOtjWS/IRapAIiHBBkr2gohoGRCV4F04
 NJiQK3GTygKOk0JrAvLbCgwlqMpeGcSHKgnxkLEFccnHsDQs+PY2i107CFzaD8lpnZgW7xixn
 MYDNSIIW0LNqTDCiBDFWjZ4LkY8P1AtZqdTdPQrnBLjJfOGrtXvLEfmFW9E90di/O90xPElgw
 0FpTT4MU+oT5D6KKjAd14kqAt1ZLWLzlkKqbJa/wW4Po9BlmDcEhiDXnOZUGLEc5MjlVTHHeG
 5f/IIrSMBd5sbWyZeYNGYYocwQDlqs510jdWenYVQeaSwo/npWkbaBJzHqsA1HHXfMA54qJEo
 Fy3qpqF/gTo+h9f9ihiGSFWd72665xb/ziuTjSA74+9T8lbNwaftbYXzDY0T0F/FiPRZc4E/U
 1e1Cty/wmHTxrkKypIio0bRqG+juKns38TdnJ+6XbAlCcU5UCylcW3FzNlgDdhHrlwgLp0Yu3
 5wqpJVw52hY/IuIuFFBBqvI1LwEK1x7LE+t/Iat27QQRWroDbWYQX5W/Pm5abomy81oPPIsaf
 zC5bta2/QrIhKTth33TYwQlCiHH0Vade0Pqrc0orpwERJA5wYjwFGVKVrqIBOT8JKMhjzJsYp
 s2xoftt5dOf5x+b7OQV+8r2SyKyoqNKnjxMXm33D7MN6GeIZbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 6 Mar 2018, Igor Djordjevic wrote:

> On 06/03/2018 19:12, Johannes Schindelin wrote:
> > 
> > > > And I guess being consistent is pretty important, too - if you add new
> > > > content during merge rebase, it should always show up in the merge,
> > > > period. 
> > >
> > > Yes, that should make it easy for the user to know what to expect from
> > > rebase.
> > 
> > [...]
> > 
> > It will be slightly inconsistent. But in a defendable way, I think.
> 
> I like where this discussion is heading, and here`s what I thought 
> about it :)
> 
> [...]
> 
> Here`s a twist - not letting `merge` trying to be too smart by 
> figuring out whether passed arguments correspond to rewritten 
> versions of the original merge parents (which would be too 
> restrictive, too, I`m afraid), but just be explicit about it, instead!

That's the missing piece, I think.

> So, it could be something like:
> 
> 	merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed

I like where this is heading, too, but I do not think that we can do this
on a per-MERGE_HEAD basis. The vast majority of merge commits, in
practice, have two parents. So the `merge` command would actually only
have one revision to merge (because HEAD is the implicit first parent). So
that is easy.

But as soon as you go octopus, you can either perform an octopus merge, or
rebase the original merge commit. You cannot really mix and match here.

Unless we reimplement the octopus merge (which works quite a bit
differently from the "rebase merge commit" strategy, even if it is
incremental, too), which has its own challenges: if there are merge
conflicts before merging the last MERGE_HEAD, the octopus merge will exit
with status 2, telling you "Should not be doing an octopus.". While we
will want to keep merge conflict markers and continue with the "rebase the
original merge commit" strategy.

And it would slam the door shut for adding support for *other* merge
strategies to perform a more-than-two-parents merge.

Also, I do not think that it makes a whole lot of sense in practice to let
users edit what will be used for "original parent". If the user wants to
do complicated stuff, they can already do that, via `exec`. The `merge`
command really should be about facilitating common workflows, guiding the
user to what is sane.

Currently my favorite idea is to introduce a new flag: -R (for "rebase the
original merge commit"). It would look like this:

	merge -R -C <original-merge> <merge-head> # <oneline>

This flag would of course trigger the consistency check (does the number
of parents of the original merge commit agree with the parameter list? Was
an original merge commit specified to begin with?), and it would not fall
back to the recursive merge, but error out if that check failed.

Side note: I wonder whether we really need to perform the additional check
that ensures that the <merge-head> refers to the rewritten version of the
original merge commit's parent.

Second side note: if we can fast-forward, currently we prefer that, and I
think we should keep that behavior with -R, too.

If the user wants to force a new merge, they simply remove that -R flag.

What do you think?

Ciao,
Dscho
