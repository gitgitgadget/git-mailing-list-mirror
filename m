Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4641F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeA2VJK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:09:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58594 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeA2VJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:09:09 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MSMw7-1eCwLS0IH5-00TUI5; Mon, 29 Jan 2018 22:09:05 +0100
Date:   Mon, 29 Jan 2018 22:09:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <CAPig+cQZTd77oqod8EZbXqroaaYb7oYbXUOW+jWFfRMrOMonPw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801292208200.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <CAPig+cQZTd77oqod8EZbXqroaaYb7oYbXUOW+jWFfRMrOMonPw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bEbxzMGcwp+AY30xwl0mEI8Fw2g7NDH/WXFwUVMQ6OCzEL7zodQ
 vYIEQXMk9QlMsNR0D9ijLPGytS2fGTr6gPxZUHXce0EZ5iDXV+PHe9AgA6xY4N/ToxulzJ6
 yh1nkkanggo/9Z4Yzi4bIfEesLw7hF+Qw4pu5zN2dT/r/4m+tVW8J7EG3OV5LXzxmCqeZTZ
 gRLE5jPYnDMgrEpDrye7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TaWqpnULsKY=:IWygHQnaG7019YDi3VdRz4
 bA0DOvULxxjp99EWMScqAgNbZcVoptk4EcNUHNUv6fiZ6Pkf6dtq41oxECsJXr0DYqlVbv13N
 nElbKoab/HLojvAfshJq95NQaDDfbjoDo5y/DNk/8sboOzIaWuDmgBErdXeW6sRSwZhvYC1dF
 /JuQGKNtGuEdeKVcNsREdNBzDlIh4NtDwkAp5O02o86WX9AUmMQS5palpR4RELfMqZdyoQSGF
 GDwHaWbcweFmG6OxCZ7cgvCWnqfJxzLhZkY8pnzMUgtMQk5mhHKFISu0BQtYcFpmBMgSMZ9ki
 +poK1+iI+hsmKZ4SigbW87LgyK8zs3JgTZCgfpB/5RuKqScDfNxmd8OT/HkMjd8G6totQd1IM
 JwRne2I9zgksg2ByVIPwUi9RLSgD2mCiq/HElAzVT6Cc79MUiwJqlc3s9iqD0qhxVXYKgKYpe
 CNZtXctBBmvn3u2wI3TW/hKyLYelMwraJGLrkp3h1xYx5hnRn6ayqgK1RP7xvcyn22cK/1vSt
 4ujth8V/ZG2Ms9/aLxaeCBmX5WxD3+eRXkU1gxzitUuBtF9vbEkiyTsi4mGyCIhGxbYErQWFD
 K1uNrqy63UlOzYofXP0u3UDIkUruUmCNdf5t7rwjZofWPbZWWXNkDgdGS6pUjSzasZbhdkzrB
 P4VMXxiqpFLLBvyuCz04CxxrQlifWqKUNbQPrq0gTNeLs16M1LwgEdqHCzdC6FBZjbksgbXSj
 v+Ur26Oj/qAbwURtyuHq0/mHmWA8R4Dm9IMQKF9vmk2/mm81BQD6cg6bmCi6HAo3zZQr9KE0p
 NAJUPBo26kwD+AfoS4EF++aRphJ6BUH35qcn+peypP6aSvNJaLMYspu30umg0InRfA/e7lv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 19 Jan 2018, Eric Sunshine wrote:

> On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > [...]
> > With this patch, the goodness of the Git garden shears comes to `git
> > rebase -i` itself. Passing the `--recreate-merges` option will generate
> > a todo list that can be understood readily, and where it is obvious
> > how to reorder commits. New branches can be introduced by inserting
> > `label` commands and calling `merge - <label> <oneline>`. And once this
> > mode has become stable and universally accepted, we can deprecate the
> > design mistake that was `--preserve-merges`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > @@ -900,6 +900,7 @@ fi
> >  if test t != "$preserve_merges"
> >  then
> >         git rebase--helper --make-script ${keep_empty:+--keep-empty} \
> > +               ${recreate_merges:+--recreate-merges} \
> 
> If the user specifies both --preserve-merges and --recreate-merges, it
> looks like --preserve-merges will take precedence.
> 
> Should git-rebase.sh have a mutual-exclusion check and error out if
> both are specified?

Maybe. I welcome you to contribute such a patch once recreate-merges made
it into the code base.

In other words: this would be premature optimization. We're not at that
stage yet.

Ciao,
Dscho
