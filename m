Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A2420281
	for <e@80x24.org>; Fri, 22 Sep 2017 08:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdIVIfG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 04:35:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:65412 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdIVIfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 04:35:05 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LhePx-1dZVC32kT3-00mpvU; Fri, 22 Sep 2017 10:34:54 +0200
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
 <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
 <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
 <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
 <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
 <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
 <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
 <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
Date:   Fri, 22 Sep 2017 10:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:i0jzcVTihijbKCy5Qy03iU2K2K2C1X8d0R5aFN8/Dwt9IceZMYA
 DcStPTsOsJcu/VmaEkfw5iHq1y7Ado8i5cQRkTWBiVqxOjma8uWZX5bvxkRf3SD65//Gn9h
 PTcA7HwxWCjNY4RxahXkQNouog7puimOrguJm52QoczzsxjuWT+L9g77DV09pGBnD3vuwuQ
 l7HpLtbbTf2hYnKnOsyxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kgFIU3r7JJU=:kSLX6fU4Fwba81qk7ihamC
 t96pPkFfrI2Jq91OWcA3FXk6UswfFuiZ/Gt3oAWCtU/joQKQbgJVEUBoIwbuJtlkP8A5ORIPu
 X9IMNfM4Yt2OGAcGXCi8A2weF3feyOCWU0MnXlm561466h5b41aqiAJaJgEimyiHKgUEfEccm
 3jDBM5h3KW8PhpG/LZxzIxUz4GUMVzxJBMiDXzSPytsWQGI0eteH6JwquGyWYYf0i36d1amcv
 UIYmpgqak/QAKICAPYlfpktJZq4prA6McJtueDtu8x0XrHLlC6IB6PcTaDSf95/iV2oVKzoDo
 jQthCyRNECGSy0c2KumYnrqpQRKorx+SoX+C1aYJiZldmG+fQOpetN7mBsHX8cwEz5/vCZEIL
 IUp3ohXl7zW9eMeWk89dhhGgLhAcoE1eRBesMItKCAGMHLRg+CNneutTJvEaEbn26cdi/Xzw7
 h6KI+7omSG+oyBTWoOtE51NTgAmo8GtTu1lEsy8Mcnuu1eJuMTopsi3itQB10Xe7v/56+u7Kb
 kWic0YIcNlYyRUBP87hK86drKeoVzuAfP4qzkqqFrmllc46vg+vPTFr+fYynsaJ9CC5b+QDp6
 VzJFJHIJvn1joPcHjNtR9aAMS7b8LS3gxPX/XAsQ/oGVLGEtb6T8qTv2NXPz2141ikNGhX9SO
 J2BDgI19eKWoHzgfQp+mjBn92m7n3ZiI/o3XLqPxxNIvigH3DYuhEcNaO6ryAx/1Z0AicYm6n
 Zqak3DMj4FZevoR8Wf2DVxjmoxJBHJGY3Q1XvFSSxYk0nWak6+zhjP0wfno=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 22.09.2017 03:49:
> Michael J Gruber <git@grubix.eu> writes:
> 
>> Also, I'm undecided about about your reflog argument above - if we leave
>> "--fork-point" to be the current behaviour including Jeff's fix then the
>> documentation would need an even bigger overhaul, because it's neither
>> "reflog also" (as claimed in the doc) nor "reflog only" (as in the
>> original implementation) but "historical tips as inferred from the
>> current value and the reflog".
> 
> Even though things like "reflog only", "reflog also", may be
> something implementors may care about, they are irrelevant
> implementation details to the intended audience.  "The bases that
> are not in reflogs are ignored" _does_ matter, as it affects the
> outcome, and that may be a bit too strict a filter (which this
> series takes us in a good direction to fix) but what the readers
> need to know is the real-world implications of the choices made at
> the implementation detail level, and more importantly, what the
> implementation is trying to compute.
> 
> It is a documentation bug (with or without these patches) if the
> current text gives an impression that the code is trying to do
> anything but "guessing the fork point using historical tips".

I'm still trying to understand what the original intent was: If we
abstract from the implementation (as we should, as you rightly
emphasize) and talk about historical tips then we have to ask ourselves:
- What is "historical"?
- What is tip?
- Tip of what, i.e. what is a "branch"?

If by "branch" we mean the moving branch ref that it is in git then by
all means, historical tips are the values that that ref ever had, and
all that we can say is that this includes the current value and the
current contents of the branch refs's reflog (which may or may not be
"complete").

Note that this notion of "branch" is completely independent of the DAG,
whereas by definition a "merge-base" is a concept that relies on an
ancestry graph.

If by "branch" we mean everything that is "on" (or in, think
"--contains") that branch - and I assume that is how most users think
about a branch - then it is not clear at all why we should focus on
"historical values that that refname had", which is an implemenation
detail in itself (branch refs is how we implement the branch concept).

Especially, it's not clear why we should exclude for example a commit
that is in between two commits that are in the reflog ("historical
tips") of a branch that has been fast forwarded or reset (-A, then fast
forward to -A-B-C; this excludes B from the list of merge-base candidates).

>> In any case, for two modes we need two names for the options. Maybe
>> --fork-point and --fork-base because in the loose mode, you may get a
>> "base of a strict fork point"?
> 
> Perhaps.
> 
