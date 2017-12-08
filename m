Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2551FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbdLHSvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:51:05 -0500
Received: from mout.web.de ([212.227.15.14]:65184 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbdLHSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:51:04 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBY4U-1eFA0a2GrW-00AUjz; Fri, 08
 Dec 2017 19:50:58 +0100
Date:   Fri, 8 Dec 2017 19:50:58 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, ashishnegi33@gmail.com
Subject: Re: [PATCH v1 1/2] t0027: Don't use git commit <empty-pathspec>
Message-ID: <20171208185058.GA13088@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <20171208174633.9903-1-tboegi@web.de>
 <xmqqpo7p84vz.fsf@gitster.mtv.corp.google.com>
 <xmqqlgid84io.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlgid84io.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:0rbLWe23eIWXOcnhsudiNIeSQR2Hp14k3Zwq/eEw/P+nntZDGSB
 UtC8inaZIP8yyeyTCCdgrr6Pyaz3Wco8epvYKHMYRtpAZfMEaN/ve1o8r0TORGwYXfq142Z
 z+Q5q/Dy3kL4uvuWvD/xjtzCaJ1TP+03gq37yfGdIE4jUMyLpCrDx0OBEYHaDUEDzAlH9Od
 Sd6j2RbUJJMyDMryTlwnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6xDa4ISDig=:VC6XZxGaWXicnb09kY1mP8
 9uQXFI4Z5Yf+sWvU9vRPLT2lQQUK/MeeTV2pC2aFrbhgT9QUhMwYBgxHGpQ1Npr8vPDJtwcjP
 YFMFQ2XR2x/UFMd5eBpxjmbzt3H9gW0vPX+0vkQfcAhJ497KKZfcQwoNM8MzjxIiqxlsXXlUC
 qQUatRqir3LKGQyqVE9+BclG4TrnD2aySHuSPeFsdGBdP5sg9E5jRchfl+ch9gnXp61GiSp57
 yvJKkpWzdpFoqHrtRo8wvcvQ5w1H/ICNmGheYwstmFVPSuwZT/iELWxu4EQD6aFkXvY26N9of
 8Fh5E6Tujoq+Gesh5w29MZAinTcxlRohBJLSAvXwHZulxU+6kfRiNlLbqYRk2Wqzl0BQUL0Wa
 esed1cJtilHAmGk6B2Rea16+8QKFK0mAawCXPA6nufWo7xTlivwx7QMuXNm8MwuE+dYzFlJZE
 ZkMRLPTSOgMQpuVlIaKXWdwXo4VAMG18NduvYunPfTHVuHQvlPCHVwjJfAXGMCVM8qTePcHsR
 Nvx0WsNdw7+gLm2E+aVdZ+yKdVWYRhWiKuQAi8IF1umTgKqZbo+uVqmCyzQW1mfvM1kDWR+mI
 SmqbA96m9VbejRIhxYtIDwRqx9tLdZQNOhPW1Mqk8Pdj8XJR2b6SeOdafk7tlwuV4RcdmxuCf
 RriDfW/YJw0QS0Nzg+j8WlZQY65i4fqLjnYeXsXgKZg156RkdThfQwqIyexqqMa3BQ/qFVPx8
 eWUtVSmgme/3PQ6BufSEMLtneRv34SynFhFD18loAcbSKd3v7o2H+H/JTwYynu/i7Z7GFnwN0
 8mVvROQ+A78VgMe9KfwRCB9ct6uZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 10:21:19AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > tboegi@web.de writes:
> >
> >> From: Torsten Bögershausen <tboegi@web.de>
> >>
> >> Replace `git commit -m "comment" ""` with `git commit -m "comment"` to
> >> remove the empty path spec.
> >>
> >> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> >> ---
> >>  t/t0027-auto-crlf.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This looks a bit strange.  The intent seems to commit all changes
> > made in the working tree, so I'd understand it if it replaced the
> > empty string with a single dot.
> >
> > I also thought that we deprecated use of an empty string as "match
> > all" pathspec recently, and expected that this to break.
> >
> >     ... goes and looks ...
> >
> > Indeed, 229a95aa ("t0027: do not use an empty string as a pathspec
> > element", 2017-06-23) does exactly that.
> 
> OK, I think I can safely omit this patch, because
> 
>  (1) when 2/2 is queued on top of tb/check-crlf-for-safe-crlf,
>      because ex/deprecate-empty-pathspec-as-match-all is not yet in
>      the topic, an empty pathspec still means "match all" and
>      nothing breaks; and
> 
>  (2) when tb/check-crlf-for-safe-crlf plus 2/2 is merged to any
>      branch with ex/deprecate-empty-pathspec-as-match-all, the topic
>      already fixes what this 1/2 tries to
> 
> Thanks for being thorough, though.
> 

Sure, the credit goes 100% to you:

commit 229a95aafa77b583b46a3156b4fad469c264ddfd
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Jun 23 11:04:14 2017 -0700

    t0027: do not use an empty string as a pathspec element

My brain did just assume that this had mad it to master, sorry for the noise

