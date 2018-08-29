Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271BE1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeH2RVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 13:21:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:50667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2RVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 13:21:32 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6RmV-1fjdVl2FVj-00yRAz; Wed, 29
 Aug 2018 15:24:30 +0200
Date:   Wed, 29 Aug 2018 15:24:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive
 rebase
In-Reply-To: <xmqq8t4qijym.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808291521250.71@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <20180823024856.GH92374@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet> <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
 <xmqq8t4qijym.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vsu1fUhGQ9lDjUDqMn3Btg+vwv9UL5A+9rL+0/skANeuWx32cMk
 p887DH6me3hbA0rTFMQMDyjWsOk/OYPsVtjNGhVECUrnSizfxZd3fQYsRQPyFSPudE15kiz
 fMyRjw4elMkxBfYAK0/xcuSl1mm7YtEI7BULoFMx/g/42SBnx38T5RULVGssp6yVxYU3BCs
 kX7rfwqqNVyaO3zPPgp4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YZJ85jMXUSE=:PyAHcQs6kZjkgHXPTrJeE4
 EgY9WbZWtgHtP/xSdCt57n+9QmlVY/kxrTH4CBai7bN5AN/ID8z3DgF1yTRcRUfC7lKIcDioz
 8WDHJfX1BfGJVFA176nVUy5aZggVzXGBD9EkTLkCk9O/gKDE24wv2EKyXeShSMkqaGJuExCl/
 TGzKIEfDZ8tsOQEySfnBAaMmxh/H0OnIvL6cHSJgboAf/cMwdYgFhHGaY58E3X971UZIIgphv
 5PiD2X2PkEYnwXcTrZsKEFrWkwux/Q01wGrHQBoA5ypofMDsC2PXSeGQ9GMnZUDeaIMPSg105
 T4Gxyvi+crwmLXMkZja7dcsNk77djgtV7Gx7xhg5XumCJRyqFSPa+kLYqERJzhLHsEBlbXbQB
 VXXBRkqVn93RyOpA9+L3Ne/RmmH3et9Y+NK7/EE3ZtGjVNVzugDrdcZx8hEP/6MiQ5Zyj158y
 /wuL8PA8ww5BNBJ0TUovpiJBRLMXjrJ5ls/jRCI4NrQKNYEgX9offCK+PrG0yk4LkPODRHU7f
 kivF4sIMbsNek8w/9UwkYDtNq5vwLjbBlu4FGeog78STHSVPOLj/WQMeXrnwUhD4x9Nh2P+Kk
 5UeIbb/f2DFi6R4ePs0PKEoFCP/FvyJSmGHn31l+l7KxM52inUazSitbeP8Fr/NVE4t+SGvjR
 GnCyNDV7r/QGJLTppdSiAFfxLrpWsXqHQz1ekfYBQMLsZ4k+tA+ZCHtV0MCqy1CbtbjJA+qQy
 olSAbjPzkD+7PzfvlGnsNlTHHhtPXveO4AigEzVgX97uG0CqeCXo8kJu/LgAzEvEQ2Y/U3bzt
 NMiqI/e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 28 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I do recall discouraging you from including irrelevant rant/whine in
> >> the log message a few times in the recent past, and also I do recall
> >> you never listening to me.  Don't make me an excuse.
> >
> > Junio, I would really appreciate less emotional, and more professional
> > conduct from you.
> 
> Which part is unprofessional?  
> 
> Being caught and corrected with truth immediately after badmouthing
> another by lying may hurt, but that is your problem, not mine.

You did not catch me doing anything bad.

You caught me telling Jonathan about having been criticized by you, for
including background information *I* found relevant and *you* found
irrelevant. And that was very important in this context, as he asked me to
include something that I expected you to find irrelevant, too.

Of course, confusingly, this time you found it relevant, even if it was as
unrelated to the patch as in the previous case.

So I am getting the impression that your critique was not actually
professionally motivated, but very personal. And I do not appreciate that.

I do not need to say anything more about this topic.

Ciao,
Dscho
