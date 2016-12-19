Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A171FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760929AbcLSRdo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:33:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:56100 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760343AbcLSRdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:33:15 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1cMtQq2Vig-00H5qv; Mon, 19
 Dec 2016 18:33:06 +0100
Date:   Mon, 19 Dec 2016 18:33:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 14/34] sequencer (rebase -i): update refs after a
 successful rebase
In-Reply-To: <xmqq8trfsmvr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191832450.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <596e3cf410a339c3212eea76394fe49be1c05ef8.1481642927.git.johannes.schindelin@gmx.de> <xmqq8trfsmvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:04a1ChIZ7IhiZcEWu9vl2UAU0jjatyzGpB+fjSbk4WGaXr49svd
 NScI9+Kyp4/ONCGoPgBf+7B2P2vy+d1oxCnsO9jpFfWE2Dq4+oWypvmCAdZzQhARFEZeSyF
 ZvH54c3UZEYFP52u2kGIa+hInEBSVS5FYVxJcAbBKGuGJh6hVtBEszxbYldEdDX4zmUZ+LL
 kLUo80atqPjDtjulPg9ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QqM2XxfqQxE=:BQQsYbo6n+hb5DXsj4P2M8
 6JA49ecNSdOwHMu08BkKUVi6t6WPDYtP1LjtN+xj3JkO0YIO0olSjxp09BbxBi6HnCaE2pRYd
 BRs5xNM4Bi5JlAnb43SwVZShQRyUGrcxZFsFdv8pVzD0Iw++HUXwp0gBH4UPvGBQnHgSIkpT2
 /cbnLqfaSUVkUk6GX/WcAlQRQ/gDFy32lZ55hqCG+bJ+/dQog1ckmtJl39Kz46BPaQMIb/u5B
 aLqbj0vg9neK29MwlndNO1D+kQSPincysvxBCWoMdRgXrl7v5eddKhmj54iDUcH5uIJFS6ysQ
 N2r90vO8zFHsROekvOXdehVIFJhiG3kb8D4NEyRyvQpayYrRf2dzz0eZ4Wm+fXUIMrx83daDB
 Qve0Yj5TeegzNLZYrSC0HjYpp82VIthbGyVOfCB4yFdW0BbGbTN7zqfJ9TyU+fhdCZlfHdKUW
 wUnPKu4/AprlemQ0OTfkc2k23l24z1yUiiAnEzc8H7QP0133ueIBTmIAvoo3tYglu61CNEunC
 VtfX9GnRR6i57sji1DsfFYQNayt/uOTXAcBFmEdiAZwiKQwvi53BA1lSDLOjmpSvVe9Y8YhA8
 Agod2ZxqvZBLg+89+0kmrM8ix1CRIRBHdBPgDaX678ZgtThHSUkBlsxkFAnjyI8Gth39ZNeOF
 CQkA1fjmIBgmb6gyyRx3bTHqs48Wy5uNwEL8Hr+0mhQ959ujwLf7265yblvzGfKQOfnmRne/y
 vX/Z3CEqpaoYvtg/VU96C/6zuSM2wY8dxDy6mbCwq3FGiZgRFTpEg9VBcaj804I5KhjKwh0xE
 6wlbrBD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > An interactive rebase operates on a detached HEAD (to keep the reflog
> > of the original branch relatively clean), and updates the branch only
> > at the end.
> >
> > Now that the sequencer learns to perform interactive rebases, it also
> > needs to learn the trick to update the branch before removing the
> > directory containing the state of the interactive rebase.
> >
> > We introduce a new head_ref variable in a wider scope than necessary at
> > the moment, to allow for a later patch that prints out "Successfully
> > rebased and updated <ref>".
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index a6625e765d..a4e9b326ba 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -100,6 +100,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
> >  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> >  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
> >  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
> > +static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
> > +static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
> >  
> >  static inline int is_rebase_i(const struct replay_opts *opts)
> >  {
> > @@ -1793,12 +1795,39 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  	}
> >  
> >  	if (is_rebase_i(opts)) {
> > -		struct strbuf buf = STRBUF_INIT;
> > +		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
> >  
> >  		/* Stopped in the middle, as planned? */
> >  		if (todo_list->current < todo_list->nr)
> >  			return 0;
> >  
> > +		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
> > +				starts_with(head_ref.buf, "refs/")) {
> > +			unsigned char head[20], orig[20];
> > +
> > +			if (get_sha1("HEAD", head))
> > +				return error(_("cannot read HEAD"));
> > +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
> > +					get_sha1_hex(buf.buf, orig))
> > +				return error(_("could not read orig-head"));
> > +			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
> > +				head_ref.buf);
> > +			if (!read_oneliner(&buf, rebase_path_onto(), 0))
> > +				return error(_("could not read 'onto'"));
> > +			if (update_ref(buf.buf, head_ref.buf, head, orig,
> > +					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
> > +				return error(_("could not update %s"),
> > +					head_ref.buf);
> > +			strbuf_reset(&buf);
> > +			strbuf_addf(&buf,
> > +				"rebase -i (finish): returning to %s",
> > +				head_ref.buf);
> > +			if (create_symref("HEAD", head_ref.buf, buf.buf))
> > +				return error(_("could not update HEAD to %s"),
> > +					head_ref.buf);
> 
> All of the above return error() calls leak head_ref.buf; in addition
> some leak buf.buf, too.

Thanks, fixed.

Ciao,
Dscho
