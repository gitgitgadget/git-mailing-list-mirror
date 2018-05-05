Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852E9200B9
	for <e@80x24.org>; Sat,  5 May 2018 19:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeEETYr (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 15:24:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:44877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeEETYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 15:24:46 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lhf3N-1ebuXm2aLR-00mpUp; Sat, 05
 May 2018 21:24:39 +0200
Date:   Sat, 5 May 2018 21:24:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Subject: Re: [PATCH v2 0/6] Let the sequencer handle `git rebase -i --root`
In-Reply-To: <CAGZ79ka2SmfA_ZUA2MjuqSwb=gUphbRxp=NQgj5AcqvMiePZFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805052121090.77@tvgsbejvaqbjf.bet>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de> <CAGZ79ka2SmfA_ZUA2MjuqSwb=gUphbRxp=NQgj5AcqvMiePZFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WgzErsPGW9u+hs+vqY0pnnk+E/8/w2Gb1JT1icWCSvJg8G1fTew
 6fY6WXt5bEVPk8Ypi/z/EJWMDjcUa5eh1W1hOCbIP4mwQQkb+n/NXiPxwfI8ExG71kdKiJl
 /SWRxnDfoesESWAN6CCGIzn4yGtgKWQNDTwU8/kWHZPZkk7Ewin7YWTtbiVdp29xypPCbxv
 pXyE1yy2GwTrUnvTvhd9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V0vMiRItBy4=:xEJMF21nDKbM0QY0m0zTRK
 YQ8qHgnsw5nxFGTyMy5qnMWJ5JDJUiNrNGr2vc1VqTI/Z8rfrELrqgnH4mwl/MjOAeG8UCr7+
 tU91/gboLRpm/pCv3j1UpsksC2ZRDgWQeTrNckwnD85tIwgnMCSWG5HuzqVn9Y4XHC8p8yB5r
 ZMdTgXWaRnhsHW0M8D3uNnS3xMFLAo3LrlpKke/ZRbUEnn6r/vbdXwaVFs/m9/AXTNlkbfaTr
 XGERGP22azKfPyTj2Ef5OXpt+6SFLvQIsJPokh/Bpq71W7t8T1dK890lwVi/7b4qArdYsdYBW
 faRc4XynCVbJE3KPZmHv/HWFFgPaj/4ZrvG8Nha8GFX86bfiX1bCwgFdmepwMk4TrXlngP2VL
 W8iRctMQmTB3b+rktH+Ovc4DLYNQMiO7ybm7UFoYh//7cgk1R0FSg7ymYnNDQnCYSb4MiSaXp
 axLcYHKFSjVEAKDAobhClMgM7xxDcuf0OYPhgnAKe16phpWXdpw5FaIMo865Sne+ZIXd0ZHnm
 z71WMX6JJeL7fsKcr2fdobDIm1iYcupmK6UeTOGcFJ2eiT9bzmdiFVoY6WvrZxIxhQRK08FHy
 sZn+bZHlHIYkbiFa96UiwNEv3fh5PoxeNJF43bEk9Lhl1ClA9mvG+zPkoXvLRwGCFrlKYcfpO
 afo2yjmTraQUMx07jkDnInbCkhg+P5jag7yK/nIQNXtH43PqvPrh8sm/yflYsQBGSSdbZ5Vt9
 LCnLBJMvHHE8SC2EpGT4r7S81FzqwC9YXDrmx5P4naOihxO5XyMIFFgetV7kQsoywhGl9XoFF
 xERh4S/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 4 May 2018, Stefan Beller wrote:

> > Branch-diff vs v1:
> >  1: 42db734a980 ! 1: 73398da7119 sequencer: learn about the special "fake root commit" handling
> >      @@ -54,40 +54,50 @@
> >         return NULL;
> >        }
> >
> >      ++/* Read author-script and return an ident line (author <email> timestamp) */
> >       +static const char *read_author_ident(struct strbuf *buf)
> 
> 
> I like the new way of read_author_ident. Thanks for writing it!

You're welcome. After sleeping a night over it, I think this function
might also benefit from a new name: extract_ident_from_author_script().
What do you think?

> >      @@ -159,7 +169,17 @@
> >       +/* Does this command create a (non-merge) commit? */
> >       +static int is_pick_or_similar(enum todo_command command)
> >       +{
> >      -+ return command <= TODO_SQUASH;
> >      ++ switch (command) {
> >      ++ case TODO_PICK:
> >      ++ case TODO_REVERT:
> >      ++ case TODO_EDIT:
> >      ++ case TODO_REWORD:
> >      ++ case TODO_FIXUP:
> >      ++ case TODO_SQUASH:
> >      ++         return 1;
> >      ++ default:
> >      ++         return 0;
> >      ++ }
> 
> The switch case is not as bad as I thought following the discussion on of v1.

Yes, it makes things explicit, and it is not too long a case-chain.

> This series is
> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!

> <off topic>
> During a lunch discussion I wondered if the branch diff format could lead to
> another form of machine readable communication, i.e. if we want to add the
> ability to read the branch diff format and apply the changes. Note how applying
> this diff-diff would not create new commits, but rather amend existing commits.

</off topic> (which BTW is not valid XML)

I do not think that it would be a wise idea to detour even further from
Git when exchanging patch series iterations. We have a lovely way to
exchange commits, after all: `git fetch` and `git push`, and for times you
cannot agree on a central server, `git bundle`.

Ciao,
Dscho
