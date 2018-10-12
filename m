Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C771F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeJLXE4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 19:04:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:35561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbeJLXE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 19:04:56 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LztHH-1fY60T4AOR-0152Pw; Fri, 12
 Oct 2018 17:31:51 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LztHH-1fY60T4AOR-0152Pw; Fri, 12
 Oct 2018 17:31:51 +0200
Date:   Fri, 12 Oct 2018 17:31:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3 2/2] rebase -i: introduce the 'break' command
In-Reply-To: <xmqqr2gv9ryx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121730360.561@tvgsbejvaqbjf.bet>
References: <pull.43.v2.git.gitgitgadget@gmail.com> <pull.43.v3.git.gitgitgadget@gmail.com> <d44b425709d11eed833558c8bedfe4aeaa230e24.1539350061.git.gitgitgadget@gmail.com> <xmqqr2gv9ryx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jA6go0ehzLgI49gVjXLOjHJ8RNl3egeD7m7oPo9aPq1wHu5Eup4
 raYVgWJI1USpiYHqRGtNXN+ZIrllHaF/YxAX3df/jHOMqyqhu1ccS13BzeJLDYGSztYfpus
 8Gyz87UTtN8JsqTHcfR4cMHU+k23bZoFHbH/cCa5+V7EJkByDnd7KpW2yQF36VPYwDHo20U
 Wh07ASjE4u7YXZGcyYNhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RZRsHi44meY=:pBiAbcEaJJTFSDoIs85U2l
 SihXBL7yPEf71KK0TECiC2gLLZhzqlapAisRElTrUy5UpuwEjDkLT+rPUa1fU99RJInyUANWe
 5+ORXdavaSAwThcRblAuAdEimdWCo61OAnS7OjVEw8WbgNssQJY3EpkClsdv+hp/TYSVW6VUX
 z5VT1kKV4CMZMIMajexx9qB0s9KKlNdZ7WuY+mBZuszUMnu2rLquC9JtE0Zlab30ikfeCDyPQ
 yrH4rs1JMNPsaLEEzZVNT3qSwj9H55/Cpi8Guitor8COOndrHVXvIqk1PZlhFFtzqugUA5cYa
 OKSeig1dt+i7eUFJASTm8SfsX2r/qLRTC4s2dOrXk8kzmoOFA4I4SNXlCrDJo8qwFjtn5M1mH
 uK69w+nd+muWV8na2XsK+9v/MnfOiEYZJdhdy4VAfcGML15rxjdKIcvaKTmr37Q4sqC4c0joU
 mEONudwO1ChW5skeCLG0il79GmLuk3ru0cpgT54T6YFL3VisIchUq3QMYR2rlUleXNYWAutns
 VfrQiBI8Ztyao6mRzeYkqMTxfd4KtVXujCdbCr9cQJ/cUNu3XYd0VUiFeGRrpRlLHwOsVLR0d
 68Dyur45PX2LstXiNPmBbUc2Yr6mViKnORMlKdA2wsO5NJ8g0654SyzBOGLxFg6V/4NlEAdNe
 mKeaXSS2YGUMaL8q9wehom3Zzd7jreGsa5fYiAZ9ZYewvOJZ6rsAGhfLV7OO/df5bUuQu601P
 2+oco6ZNV31iHZzpUyBjDTKlKF9EOMD6/HN/zq9/u3qRFMZLjFjmtUnoE2xv1y7baunuBXd+e
 0yCJCgEquywo3E9y5OEG94EKOuRh1fXZvLFEJEzOy/HCdqrXis=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > @@ -3293,6 +3312,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  			unlink(rebase_path_stopped_sha());
> >  			unlink(rebase_path_amend());
> >  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> > +
> > +			if (item->command == TODO_BREAK)
> > +				return stopped_at_head();
> >  		}
> 
> The earlier one had "break;" here, which broke out of the while()
> loop, let the control reach "if (is_reabse_i(opts)) {" block after
> the loop, and the block would have noticed that current < nr and
> returned 0.  So from the point of view of the overall control flow
> of the caller of this function, there is no change relative to v2.
> The only difference in v3 is that stopped_at_head() gives a useful
> message.

Well, I should have called out this `break;` -> `return 0;` change, too,
as I think it makes the code flow *a lot* more obvious. As you say, I
relied earlier on the next loop to return early, but that is not what the
`edit` command does: it returns out of the first loop, too.

> 
> Good.

Thanks,
Dscho
> 
> 
