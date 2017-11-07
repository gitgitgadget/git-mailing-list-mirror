Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A62420281
	for <e@80x24.org>; Tue,  7 Nov 2017 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933889AbdKGJ7F (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 04:59:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:65369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbdKGJ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 04:58:59 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTP3-1eWiIe0Smz-00LIJO; Tue, 07
 Nov 2017 10:58:49 +0100
Date:   Tue, 7 Nov 2017 04:02:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 2/8] Add a function to update HEAD after creating a
 commit
In-Reply-To: <xmqqtvy6g5k8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711070400160.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-3-phillip.wood@talktalk.net> <xmqqtvy6g5k8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CafDhQfH0ztaiE3V1lt8/e1UJ1lyB6hiobIS1q6yTeGmhfrgQ+M
 xjztBdqGap1A9fhRd66LZFadCa7QUYKUx9UrG2cxSWDRR5z5ERLs1gE3n7clqeHTQheB+P+
 b/qOHO8t67ooTF9SYrfSgO217uS+e0e0uGUDLmHZS/SeVM6Q4Iihg/ahblieHcSTAKFP/9n
 tejZGD4twZBKpfhV1pYFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:heLNB00sE7I=:uD3exTs4Lvrr3BE4QXTUgE
 E9mPC3Yzj9vT7qOq9qNs1smUjuKJOzA2aS2l2Tkj4S0DFKIIvixZ4jxpKqH7/UiehgCcIW/uw
 k6gA1pRJqAAQlxD3vRqDgsbGWEiQyIpjjo2vTpf9emYL4lIL8u4dgH3COcqexCYc8ZIZdNY/r
 /O7am4ICNjGGBMpE18V9ao2nRZDcBJmlYwvhkdUad8AVO3/lEQIaFa1PgDSyVrzx9mA+OiHv9
 D/Ifp70pMR/5B6D/7gTJhLwbzJUyWLMWE7lymTOrBn2lUyRiI9hg5XXgFyqN0CSTVBrgNtVnu
 3/8RJPItbtfIV3DPU+BlIQpTfovaZVDiQan9si4MZs8UsXx70i/GxE+E/x9NRQ6qZC7HvLVDu
 xQ1A0I4y52jih7lRX93iygc6AZqFWfnBoxBxSh3dIeGFgamgxJ0MbiLb/IbYL/9lCSTnLcAK1
 BPT6a7eMi7WnuuX+Ifiz4kb2ES2Q7VC8/lz1ULVsi9E7+uBmxjMwQiXLqzRqdyWsKmwpgS+L+
 z0FJUJ8nC6/dI6ykKKb6Ru+24EhdX9VO3jcwrPAW7WZ29D+vnWpWmqztZLy0T9tZAR1sGjk5Z
 BB037gWHWcIKEArWO74m6fGWasZV+wnG8gw1tSoiTEBNBGyWc14NPO7XpdecY4vGGv1eAcwCH
 j7pRVRhtlOVZVz96FguNcYNIxn68FRUO3CgAHXYKZt3CONQ5h6jfD/1xvoViEXW5ppJa8fN83
 feZMLX8+Pu2K3UH75IwdHC9bVn84Xz+Cfzf6RY63gLZR+13YmlVKf/MOjEMhdK6iVXYSBtkL9
 XZokan2PRqVA2+tw/atbovfSO+pTpI6DP1MuPW9r0/jLlBurTU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Nov 2017, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > @@ -751,6 +751,42 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
> >  	return rest_is_empty(sb, start - sb->buf);
> >  }
> >  
> > +int update_head(const struct commit *old_head, const struct object_id *new_head,
> > +		const char *action, const struct strbuf *msg,
> > +		struct strbuf *err)
> > +{
> 
> [...]
>
> I however do not think update_head() is such a good name for a
> helper function in the global scope.  builtin/clone.c has a static
> one that has quite different semantics with the same name (I am not
> saying that builtin/clone.c will in the future start including the
> sequencer.h header file; I am pointing out that update_head() is not
> a good global name that will be understood by everybody).

Please try to always accompany a "Don't Do That" by a "How About This
Instead".

In this case, I could imagine that `update_head_with_reflog()` would be a
better name. If you disagree, I invite you to propose an alternative that
strikes your liking.

Ciao,
Dscho
