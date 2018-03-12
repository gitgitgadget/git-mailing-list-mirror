Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651271FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 10:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCLKhp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 06:37:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:47419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeCLKho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 06:37:44 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt2BW-1eWgR90Rti-012Y2K; Mon, 12
 Mar 2018 11:37:37 +0100
Date:   Mon, 12 Mar 2018 11:37:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net> <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com> <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wg6UCJ3mc4yaKr3YSEfVHdqkl59Fw8bnzOIULRod2G/5d3cDqBk
 SXP22Sta40041f/xUeNwsK909Mj0mnYexmpa+XGwXTQKp6r4kNqeYK6D4YYwy+RxryM0Pax
 SdJO+b8sx4J7J4IUcjHsS8eZJPlt6Nb8TQ1qtCRslAvMLoQOICgHVqk0y1EKLm+l/dqsLNV
 psWCB5Gn3WGTcy6YcfrDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:olWT/qGG4BE=:0tSKwuxqFvYkFNJP13Jfkv
 G7neFni6nwnQaxF1vfm380hCiizlGLTVjYWibjTsPcwr+mxNwDBIpPGvREB7x/rfmn1uU4DdR
 jD3IbZU/XkiZqOChOyKLum3zF1GBH9P5zmz5Fr6J94p+Ebl4BMeTq2HMHp2VR0zL1M7uK1RRY
 hWHHvcLsr4E/lSf0tvkuAL2A0FVB7zihbxssJ8WkuCIk/5KmDYxF/ti63SB66VpBBSF32gnDG
 B+oYK0s2UYVHc+HMAoOyHeXxs5B2yOYPXFMp6SRnM/Np8vc2IngOL4sw813gtgV4hZ4SUwhyD
 BHFVuuaq22PJCyhXhVwe5Xi8mespLcjFzd7JnJcK0I1sN9E2sdahMxBE6D8vjy1vrslSd33hP
 Zdkf+lnlAxFmljW/LvAYHsGf1UGhJxgRCfp2I5rsLXASn8H4rwJ2/CEMJID6p80atx18HYATj
 hXldxLMQgGwGB4UPoYkJi4B8fHcMryAZRyUSuhlEoHyxzJerP4KcWTD7r60qTectSjXIVG+fr
 1vpMACkItCltud4iETjCXmz8dGiCy8zjhBWqPFIdgdeNVGhF6DOY2BxlJUAF5f1zALmsGLsNb
 /yuXzna8DUwhQKv6OzvYm0wjGbnY8fePwtCkGJrIKtU6BCGpd+aZsmzXrv53BVrsn0Vmf/XZq
 olDY+5p7pJ5pUO4kmDzHZBPQ8xeaVN2B4IQqkkbMf0aGMSAkhuPs9VLh3lV1Q4X4idfjr3iC4
 ys0vtIagzv9y4jMYdzl5QgbvYcqMz02AD5eN60zO0AgtH8+NHhfLax2ucSzXtoQzdq685gNlL
 36gT+sQxb+OVHQ84zjZBp+zWLJF8TIZarAWEk2HuDQkn5DE4zO79rW7c6rzn7Br8oRfgL7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sun, 11 Mar 2018, Igor Djordjevic wrote:

> I agree with both of you that `pick <merge-commit>` is inflexible 
> (not to say just plain wrong), but I never thought about it like that.
> 
> If we are to extract further mentioned explicit old:new merge 
> parameter mapping to a separate discussion point, what we`re 
> eventually left with is just replacing this:
> 
> 	merge -R -C <original--merge-commit> <merge-head>
> 
> ... with this:
> 
> 	pick <original--merge-commit> <merge-head>

I see where you are coming from.

I also see where users will be coming from. Reading a todo list in the
editor is as much documentation as it is a "program to execute". And I am
afraid that reading a command without even mentioning the term "merge"
once is pretty misleading in this setting.

And even from the theoretical point of view: cherry-picking non-merge
commits is *so much different* from "rebasing merge commits" as discussed
here, so much so that using the same command would be even more
misleading.

> That is what I had in mind, seeming possibly more straightforward and 
> beautifully aligned with previously existing (and well known) 
> `rebase` terminology.
> 
> Not to say this would make it possible to use other `rebase -i` todo 
> list commands, too, like if you want to amend/edit merge commit after 
> it was rebased, you would write:
> 
> 	edit <original--merge-commit> <merge-head>
> 
> ..., where in case you would simply like to reword its commit 
> message, it would be just:
> 
> 	reword <original--merge-commit> <merge-head>
> 
> 
> Even `squash` and `fixup` could have their place in combination with 
> a (to be rebased) merge commit, albeit in a pretty exotic rebases, 
> thus these could probably be just disallowed - for the time being, at 
> least.

Sure, for someone who read the manual, that would be easy to use. Of
course, that's the minority.

Also: the `edit` command is poorly named to begin with. A much cleaner
design would be to introduce the `break` command as suggested by Stephan.

> The real power would be buried in implementation, learning to rebase 
> merge commits, so user is left with a very familiar interface, slightly 
> adapted do accommodate a bit different nature of merge commit in 
> comparison to an ordinary one, also to allow a bit more of interactive 
> rebase functionality, but it would pretty much stay the same, without 
> even a need to learn about new `merge`, `-R`, `-C`, and so on.
> 
> Yes, those would have its purpose, but for real merging then 
> (creating new merges, or recreating old ones), not necessarily for 
> merge rebasing.
> 
> With state of `merge -R -C ...` (that `-R` being the culprit), it 
> kind of feels like we`re now trying to bolt "rebase merges" 
> functionality onto a totally different one (recreate merges, serving 
> a different purpose), making them both needlessly dependent on each 
> other, further complicating user interface, making it more confusing 
> and less tunable as per each separate functionality needs (rebase vs. 
> recreate).
> 
> I guess I`m the one to pretty much blame here, too, as I really 
> wanted `--recreate-merges` to handle "rebase merges" better, only to 
> later realize it might not be the best tool for the job, and that a 
> more separate approach would be better (at least not through the same 
> `merge` todo list command)...
> 
> [1] https://public-inbox.org/git/f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com/

Well, the `-R` option is no worse than `git merge`'s `-s <strategy>`
option (which *also* changes the strategies rather drastically).

Ciao,
Dscho
