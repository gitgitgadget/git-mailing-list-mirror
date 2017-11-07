Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7A3202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbdKGOK1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:10:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:58115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755406AbdKGOK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:10:26 -0500
Received: from virtualbox ([95.208.59.171]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1elgFM2xyU-00ZyI7; Tue, 07
 Nov 2017 15:10:18 +0100
Date:   Tue, 7 Nov 2017 15:09:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 8/8] sequencer: try to commit without forking 'git
 commit'
In-Reply-To: <1975badb-7728-45fe-3e8a-8755d85da89a@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711071509120.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-9-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1711070203230.6482@virtualbox>
 <1975badb-7728-45fe-3e8a-8755d85da89a@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wt2Of6Gpn+xASqAkcDbA73ma1yxtD7od4ulcOT8keUAV+y/kr1i
 jairQga7prVpJ9CCBUd7km19ovGIdKE+50Dw88xeaAtgX/sI0D1Qp7WPtsOveU6nZVY+8mo
 t9aTDK0UMDPzzB66f/aqj4yLzdT9TAt+Lpeq0x/uiGvwTuIiguq0jK++bjcd9IwCOg1AFLn
 sGbmg17i1JSdJzFbFdOcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ldYsT7KMHHU=:Vg+dhnxM4xqQwRPPW3eQFB
 8qw/Dh4cdbCCzY6X0iMUOrq4e42B7PathvjKh4HN8i1dVZpRe9KJIFl5QEx2Jaq8cHeu71M/5
 LmdG8MEk1wbF8OQ+I4kehiegdCOngcbT6EPDL3wXPTH06OxDzADEP5tl5l3loF1P2ZcmzF+pf
 L9KNUmIlVLT5+tPvHGwrmj4rspHA0BuXwixlvmoSAivI9bDCx0R+pRZiDZ44h06LrcFqHjQQv
 K3fbiA7irTsx6o/mlqLWJxjxKMqvgJCRlvrj+YC2z5oRtvcBUemcjTKd0e1qrdYQzScPo3bZH
 6DqchiDujILwnHSmTb4jA8/Z1qF8A75zaKlMLc0pYuJkjR5nS+oW+SWHXhtDDFz/KOXShrHEb
 8kfpyyx6d4x6ESeqf87SiAN9oYnftbm/QCarlIOZb8MvQI4U/GAhivh9pq5grn71snj4YF20s
 bv1D4MPpW8k8n9xKDo36Wo8rhMKAwU5oI2Vfe1HUCwvayGdffFxExZJd7g/JbwwpiH2pzfB4M
 zP+VLVuAIvXiP7yq8VImWXcemygrPplQtrDHd1JjYWj8yNDLGsNeKPUvyiIhdKEhTNfmjbitX
 0pOituvksChWuHmgorapWHou04WLZecEPw4Ggf7Tm9QQ2tJZYSJ+kV14N5NLoJvAtcEN8amhV
 thm5aMfQk7HXqf37bh6Q7lQ4xNgokvNkOn5SMED+7SIMSzf/dkpU71u4ubn+Lc7bEQqG+ZDMv
 tml+VvNi7f71W2TI0H3F7iMDwe9hEPuAc60CpZGZcg4HHSsFNoAFy4WlMPqY0NH57UAUoE/lM
 SzHgrvzIKS4eRxg43xiZDlEU0++lDT7mlDlxKAulDOjo8UoNHA8xOq26emLw50tiE1DT+5t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 7 Nov 2017, Phillip Wood wrote:

> On 07/11/17 01:36, Johannes Schindelin wrote:
> > 
> > On Mon, 6 Nov 2017, Phillip Wood wrote:
> > 
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> +static int try_to_commit(struct strbuf *msg, const char *author,
> >> +			 struct replay_opts *opts, unsigned int flags,
> >> +			 struct object_id *oid)
> > 
> > Since this is a file-local function, i.e. not in any way tied to a
> > process exit status, it should probably return -1 in the case of errors,
> > as Git does elsewhere, too.
> 
> It returns -1 in case of error and 1 if it wants git commit to be run.

Ah, that explains a lot! I would like to ask for a code comment above the
`try_to_commit()` function to explain that, so that future me will avoid
confusion when staring at this code. I would also like to ask for a code
comment at the `return 1;` statements, saying e.g. We could not commit
in-process, caller should try forking `git commit`.

> >> +	if (flags & AMEND_MSG) {
> >> +		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
> > 
> > Git's current source code seems to prefer to infer the array length; The
> > `2` is unnecessary here.
> 
> Right, I copied it from builtin/commit.c but I can change it

Sorry about that. It still would be good to change it, I just wish that
you had better code at your fingertips to copy/edit ;-)

> >> +	if (commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
> >> +				 oid->hash, author, gpg_sign, extra)) {
> >> +		res = error(_("failed to write commit object"));
> >> +		goto out;
> >> +	}
> 
> Looking more deeply, this can die in write_loose_object(), hopefully
> that is unlikely. git am commits without forking as well so I think it
> is subject to the same problem.

Yes. We will have to address those die() issues. But not necessarily in
your patch series; as I said before, this mess is not your fault.

Thanks,
Dscho
