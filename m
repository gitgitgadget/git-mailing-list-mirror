Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A872027C
	for <e@80x24.org>; Mon, 29 May 2017 11:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdE2L0W (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:26:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:58800 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdE2L0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:26:19 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McPvw-1dWyBd47Hc-00HgYf; Mon, 29
 May 2017 13:26:10 +0200
Date:   Mon, 29 May 2017 13:26:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 10/10] rebase -i: rearrange fixup/squash lines using
 the rebase--helper
In-Reply-To: <20170526031639.10790-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705291322150.3610@virtualbox>
References: <6825a2bb46f43687af0565e4d38224d472932203.1493414945.git.johannes.schindelin@gmx.de> <20170526031639.10790-1-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KLwIQnRjpvbh3NA6EbzFFE+KN1YCZ76T6nzwEqzYCBNDnd94Qnm
 AR/icBYZwRwba0Rxlp+n8dkzakuszcqOGzap7uEgJc7nRHemZGUCyzZOJa4nsHvT0/CLyhq
 A0heBY61ETfmVtSuFsCdxgmf4aIhCgUn8ComhH12lKh5TMzDO6Fd/je67JlweJSqrgH0Eig
 wX6HP/IT4OVCemamFb1rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77olI7HM/IE=:H+qAW/kXehmu55AYe9koB/
 1hTX1QgQ55GklkLdq/RcmQ8l5v6dRLxOm/H6/iTEYPi3B6fPwEzwNqKEULg+Sy3iCM3B/LdXj
 VWFCIJ51erfjpSVCv6gv7ynVcPY7pzA3GJn0Fah5/cVfhS71llSGAB/ge4VQR/8jLz9/QdkdU
 sUH6x+Fdx5swOnfnYtCO8IUunfYkc3FZtLdSyF/H5S6b8i8uCfh6wA3USqsY1ZC1Bw0BxZcNk
 yqcGlUMY7nFFlaeXBGNvDuTe9hyl4nu631kPEglSetj5mPf+XIyoRavK+eQULqFfTud6ayUqX
 Std0uSRit7euRALPzlKzNZvC/80l95rKoT/nEtS9GPuC+Bvdby3hh8ASU7A1YxQidiHPvtUCU
 FwbK9SsTVzI6Y6XKV6/3Ve0QLaE938YSMTr/3RCN6hWMV5CCLEu0cFNLs3/SmjLG+L35QaFDp
 Wx/sEDNVWyDLVDOwFiEWBqfQCQMpdfe+GwFJK5BPIyYYhnC+x0MxtWiJEFqIULq98tGh6YGcq
 lVA1aDWrFEIb/L4SW+1bQX/J4JZSuX4eFO5bWblMDOi///+b6zbqqfk4veZ36rZsMQ1icaPDj
 ujrwhNobHJVxcwdinR8dtW0yInd12cz+YbopS4UvYnaCjzR9+7YRZyVnqdl/AEYx7jksWPGIy
 lj/07xIp7Ll56gxPGB/l3qrpgq8mjRxAqR+bRxLxArB6sMPZetAbarMAbzRHtwfGuOJc6/KKm
 r8m1VLAjEv9nOClWIjwYH0c4DjhEZ8e5Mxm8Imotf35ScRKBDYaYl7f9/BCSIancM1qgW/X7u
 UxCWHjs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Thu, 25 May 2017, Liam Beguin wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> [...]
> > +	if (rearranged) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		for (i = 0; i < todo_list.nr; i++) {
> > +			enum todo_command command = todo_list.items[i].command;
> > +			int cur = i;
> > +
> > +			/*
> > +			 * Initially, all commands are 'pick's. If it is a
> > +			 * fixup or a squash now, we have rearranged it.
> > +			 */
> > +			if (is_fixup(command))
> > +				continue;
> > +
> > +			while (cur >= 0) {
> > +				int offset = todo_list.items[cur].offset_in_buf;
> > +				int end_offset = cur + 1 < todo_list.nr ?
> > +					todo_list.items[cur + 1].offset_in_buf :
> > +					todo_list.buf.len;
> > +				char *bol = todo_list.buf.buf + offset;
> > +				char *eol = todo_list.buf.buf + end_offset;
> 
> I got a little confused with these offsets. I know it was part of a
> previous series, but maybe we could add a description to the fields
> of `struct todo_list` and `struct todo_item`.

You mean "offset_in_buf"?

Sure, I can add a comment there. I would like to keep it out of this patch
series, though, as the purpose of it is to accelerate rebase -i by moving
logic from the (slow) shell script code to the (decently fast) C code.

Ciao,
Johannes
