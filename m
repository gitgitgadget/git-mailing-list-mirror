Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA28E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeGLNIu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:08:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:49357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeGLNIu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:08:50 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7YF5-1fxjPQ2FNP-00xKcn; Thu, 12
 Jul 2018 14:59:15 +0200
Date:   Thu, 12 Jul 2018 14:58:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] merge: allow reading the merge commit message from
 a file
In-Reply-To: <xmqqbmbd1l7i.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807121455130.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <9e2c1fe83178f7047d8f2aacaa961381a4894081.1531312689.git.gitgitgadget@gmail.com> <xmqqbmbd1l7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LTSvbmu7PQdnvfzLfzYOn1bTrH0NZkLwp2RMjVXWomRD+JnMvzF
 l81TTg1wQJmvTVmmZYDJjt+92Z9vtqclMsW8h+wHQm9hYQQqXEgxXPSxeO+YHEt15tOAKCt
 TEBX+WgafKYc25y8fGLzKepx6bCTim3KT4oGTozpyaVVV7lZwydgyuG0VOCPYE6VDSIiTEM
 s+BOhnMnoWYRvfgLoxIGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cIT7lEZAoFg=:oIEHtaKO7SWx+u1WM0lQ0e
 CPj7UwNZCOFoCdV1trPtVvH3Zce9bpK3yG3t4QFh05jk7TOWHCFAz/mI6oZqS8/fvKsq0PLFc
 CLvAFSzB6qE1UPoRnYp/w4R6vlPWBkcEPFjcOthzqf7/dgzYbboJDmoYcocWhwl6QutJ9AA9J
 sgbtorXVMqlGL/ILsGeAuqFZBlq4K75UlRaWyc3YFzWVd5pr7vc0HdGy+YB5RTByGxT+BWNFo
 htNqrblgoB5o5uo89LD0+TAodqscW51hNYqJEb/cJZXKf9NaTzqVKFaxNYswYFnqTc4ciJDaJ
 r9sQL7b9YdARmz0mqruE0T1wSaixGytwHMcxAsC6K6VNxR0zFcMVhGKGE5gHDsOltiPHgNjOP
 5VG/qN3sO5NOGKPB48uKf66xNbyYoejB7dVRp/6ZDA1wIKgEe4UTwhZm/hCC+7vIZaIa/Idx/
 za5bZg7ZZMj6j3HHT0V6VD/cfd8FnGWBwKmtaqJqEjrTxxA/1/DDlRBlA9ktsemDfoZRJQxOj
 Zs0dbQvKypiTPK/ZmrHPM20ikyqDJyqBAVRv+fmxxam096Zc0RmFJQRkLdq3wZ1lqpmu9tkmQ
 sNH+li9GcomltnJFZlr13IZdjWGPIu5LUpvZTZSpBkTjJRuz1qON9VZCRHpZpESWgBaqIzsgm
 0e35sN9qS4x9MdoSwFt3/01pZLhyOV6xgncARFjBlZfQXtQeE9NNoIuHWqX/jtH/kMsFail7W
 NrP2FY3vunD40MCsoQkKSX8KzArnKaGbfn3gZS0qIit70XB1ZSIVQRC0vL3BfQMyyzHm4tNVC
 Qlk/rO1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Jul 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 4a4c09496..b0e907751 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -111,6 +111,35 @@ static int option_parse_message(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > +static int option_read_message(struct parse_opt_ctx_t *ctx,
> > +			       const struct option *opt, int unset)
> > +{
> > +	struct strbuf *buf = opt->value;
> > +	const char *arg;
> > +
> > +	if (unset)
> > +		BUG("-F cannot be negated");
> 
> The message "-F cannot be negated" looks as if it is pointing out a
> mistake by the end user, and does not mesh well with the real reason
> why this is BUG() and is not die().
> 
> I understand that this is BUG() not die() because options[] array
> tells this callback not to be called with unset by having the
> PARSE_OPT_NONEG bit there.

Okay. I would have appreciated some sort of indication what you prefer
instead. I went with "--no-file?!?"

> > +	if (ctx->opt) {
> > +		arg = ctx->opt;
> > +		ctx->opt = NULL;
> > +	} else if (ctx->argc > 1) {
> > +		ctx->argc--;
> > +		arg = *++ctx->argv;
> > +	} else
> > +		return opterror(opt, "requires a value", 0);
> > +
> > +	if (buf->len)
> > +		strbuf_addch(buf, '\n');
> 
> Do we assume that buf, if it is not empty, is properly terminated
> with LF already?  I am wondering if the real reason we do these two
> lines is to make sure we have a separating blank line between what
> is already there (if there already is something) and what we add, in
> which case the above would want to say
> 
> 	if (buf->len) {
> 		strbuf_complete_line(buf);
> 		strbuf_addch(buf, '\n');
> 	}
> 
> instead.

True. Thanks for the suggestion!

> > +	if (ctx->prefix && !is_absolute_path(arg))
> > +		arg = prefix_filename(ctx->prefix, arg);
> > +	if (strbuf_read_file(buf, arg, 0) < 0)
> > +		return error(_("could not read file '%s'"), arg);
> > +	have_message = 1;
> 
> A similar question is what we would want to do when the file ends
> with an incomplete line.  With "--log", we would be appending more
> stuff to buf, and we'd want to complete such an incomplete line
> before that happens, either here or in the code immediately before
> "--log" is processed.

This is what I inserted here:

	strbuf_complete_line(buf);

> > +
> > +	return 0;
> > +}
> > +
> >  static struct strategy *get_strategy(const char *name)
> >  {
> >  	int i;

Thanks for the review, and especially for the suggestions how to improve
the code.

Ciao,
Dscho
