Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E5C1F597
	for <e@80x24.org>; Tue, 26 Jun 2018 09:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFZJ2q (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 05:28:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:33527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeFZJ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 05:28:16 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSdz2-1fhkAC2Ljw-00Rbmh; Tue, 26
 Jun 2018 11:28:12 +0200
Date:   Tue, 26 Jun 2018 11:28:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org
Subject: ag/rebase-i-append-todo-help, was Re: What's cooking in git.git (Jun
 2018, #06; Mon, 25)
In-Reply-To: <xmqqin66mql6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806261125330.21419@tvgsbejvaqbjf.bet>
References: <xmqqin66mql6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HFO/4dMNp26T3TqnJUns73pPPB6saxHEEB1D4YUxZbFlJKwavOi
 ++/J9nCU6M4qXOrTcBn/SS/gKTLqKlH5wPexNDYGJ9S4nSSrNqDQTwjB7rGrKuF3oUHcjUP
 g7CJaaisml9iQkMWWN7TFp6IROsFJFIguW2PXwgakyogX5L1AYzLru/NFR+HoXkuByoI2xv
 vyaZN3cJhaw8R13KV/5Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cQS3eiUph7k=:sJsCus/FUnSx/becn017bN
 4s36XMED3a5S+xDflQzIiYCUcGlnFT2LFJlO6uHT4g9aa4P9ihD+7sLaHs3iZ+QfrXCCJCtxj
 x8FG4eJn80+C+Oq5EmRFXzr4Zoh+z2xf+GHBwsu1wNIldQ17N/zoRL0Zwdf4MWR0SwmkWRaXo
 xw06+SjM/emU2LmE1noDGkewhDoLmT2cpRscFytxpddteKucBshH0OD2Ioh+57/blfxg2xyEL
 KocLFRYV9aA1eifX/KAYOYEBlmu6/0cmHv5kXbuqMSutHyOtdpig7wSLmUz1KbSXeT2As882g
 +ECihNn6zOUvJDtB1teRn/C7zQ+dGLRpoC4Wudc1m333ZvklSm3RSSW0G+yg3xzpa4f0Dw1Is
 Kd1E7FgV5fy9sLNn+BxAukClqjgf4GHY8GCu1v4uOnhuuw47Q66CqSYY+tjtM96g7gXdT9CsC
 cTFTKkxphZ/mq2PumlAPqXqTB4xKpWAepEZG9ZlljgGqkiOHnMAKr1hZcVRmrdr4r6t98/Fch
 +HIXp8n7NOisxKLXywBPdPsEwWYEsVinMUrtrjxt2atgF/2ITzubnthhQnj4A3eIyi6lQjD4G
 AcS9uDs/S/wGSo1DjuUcky8KwwN6W51izdnptfFNvCuPTMuuhpHTJzLPuZzIsfLTuiy9pZFKJ
 U3HAescYgzEEKI4+r0LjRuJ11OCSYKC5ag5f77/t4vb0Xqu3yvX0pOEjVWi5hJRTdn6zF3KKN
 Zz6CUVimLGj6Fe0srGtmwfYP6gFNkp/vUAlBI1/Oak5jAXX1m/XF2XSoy23JWq0uVy7InKhNc
 9+d04Vy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Alban,

On Mon, 25 Jun 2018, Junio C Hamano wrote:

> * ag/rebase-i-append-todo-help (2018-06-14) 2 commits
>  - rebase--interactive: rewrite append_todo_help() in C
>  - Merge branch 'ag/rebase-p' into ag/rebase-i-append-todo-help
>  (this branch is used by ag/rebase-i-rewrite-todo.)
> 
>  Stepwise rewriting of the machinery of "rebase -i" into C continues.

I just reviewed this on GitHub (which gives me an interactive way to look
around outside of the diff context) and I think there are two things left
to do (which I mentioned to Alban on IRC):

- `msg = _(...)` should be `msg = N_(...)` instead, with the corresponding
  `_(msg)` later on, and

- to avoid cluttering sequencer.c, and to pave the way for future `rebase
  -i`-specific code, the `append_todo_help()` function should go into a
  new file called `interactive-rebase.c`.

Ciao,
Dscho
