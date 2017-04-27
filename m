Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A52207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937599AbdD0OTC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 10:19:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:51820 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbdD0OS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 10:18:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tof-1e0dH51jbt-00xvUA; Thu, 27
 Apr 2017 16:18:46 +0200
Date:   Thu, 27 Apr 2017 16:18:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704271607550.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lxfwr7dwvTj2Oozduv1D+OAj+J98m1BcrpT/2oY5Cx+ytvLjAFd
 2IdVFbw+0CIo2INdywEflPp69MItx7RzY3Or0yK5knIFXFxd/EzFlKU4wvKvww8aEYkHwV+
 ndq5G/d7dUiVteNkzLJIgS1PAzmYEg5lKSTgWSuYzItPuZEkiyvYKa2gYBLxx33Rtzqo2rV
 B9tBrcQrdC0FNdFVbP5kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vnGgKgs2MgY=:GfCo13ktS2lljfcHqFpL6Y
 m6JKnaWyP4blT78lIwHlboqYGvf+NXgWnzRtzhNW8oVHtzg1C1uzuCWYWZdpNVfCaKg614fKH
 I9eq9Z74AVG121WZcyrtC0jkLNLGqDN3jCPZ/zCk1Q0uzxfzhJjKNOI8CxjAnjs0HdoJb74jw
 I//YEfUC6fpXM253JXcakDMRRgZuLk/VehMAi6tl0hJMQWNnliIokB/6WgNBQfQtvzU36HAFh
 x1CGzwLVyjIrkoPk1jiWe4rtGlA97ChszbrliCgIHYZgf3crxI8K+cXLJU9RKAZV6k8AGpTKO
 PnSE2B6iW/MQcwfCWfNsdZl4CwmxZiGyEuPyS2KbOZz0FwGVmojZ1n8e6b6iicGCupydJk9JE
 WOKcBSvm7teWetXcUG1NnolnaY7oEGMphkfiJaUlcccLujq0T1qm5zkTLNVg8vKTzIKE+3YEi
 MkgZGD3JrJOoLU4UwkUa/9gNuLRw5aslj+QPxwJ6WLxRZoWoBA797pAiokBFfnosyaSzv1UUs
 lWZEsoX2PKICqOJVyVf9+lltQrSDH4A/5Vyg7SfsT/X4jodYWuk2AbVY05c0Bn3RxU5epHVBY
 umzegqf5s5PHf31/fXZS2PmE3F7ToYnZTo9kc6IljsXpctAi3p5vJDLcyTXtHYP4ZZ4NTpKWK
 WAXTMwpy70fDypyDYhsy6zwRHs9BWD9fn7QqfoCh6cJIwXjyl9+ozkDt4MLjYDix/LMzOyS6c
 aiS9gYE/8D33bY2but49Slt5fh2DIKo2iq5JIw3rN3K5bPnO155KqMmksxorkXj7AcV0UAuzS
 90ic0oy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 77afecaebf0..e858a976279 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> >  
> >  	strbuf_release(&sob);
> >  }
> > +
> > +int sequencer_make_script(int keep_empty, FILE *out,
> > +		int argc, const char **argv)
> > +{
> > +	char *format = xstrdup("%s");
> > +	struct pretty_print_context pp = {0};
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct rev_info revs;
> > +	struct commit *commit;
> > +
> > +	init_revisions(&revs, NULL);
> > +	revs.verbose_header = 1;
> > +	revs.max_parents = 1;
> > +	revs.cherry_pick = 1;
> > +	revs.limited = 1;
> > +	revs.reverse = 1;
> > +	revs.right_only = 1;
> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> > +	revs.topo_order = 1;
> > +
> > +	revs.pretty_given = 1;
> > +	git_config_get_string("rebase.instructionFormat", &format);
> > +	get_commit_format(format, &revs);
> > +	free(format);
> > +	pp.fmt = revs.commit_format;
> > +	pp.output_encoding = get_log_output_encoding();
> 
> All of the above feels like inviting unnecessary future breakages by
> knowing too much about the implementation the current version of
> revision.c happens to use.

You mean that the `--reverse` option gets translated into the `reverse`
bit, and the other settings?

:-)

> A more careful implementation would be to allocate our own av[] and
> prepare "--reverse", "--left-right", "--cherry-pick", etc. to be parsed
> by setup_revisions() call we see below.

Oh, so you were not joking.

Part of why I think we should stay away from shell scripts has nothing to
do with performance (which would already be worth it) nor portability
issues (which also would already be worth it) nor requiring contributors to
know more than C (which also would already be worth it), but static
typing.

What you are asking is to do away with the strong, static typing (which
would show a breakage pretty quickly if that part of revision.c's API was
changed, therefore I think your concern is a little curious) in favor of
loose typing which would demonstrate breakages only upon use.

That is the exact opposite direction of where I want to go.

> The parsing is not an expensive part of the operation anyway,

... but why, oh why make things more complicated than they need to be? The
revision API is an API, yes, an internal one, but an API, for crying out
loud.

> and that way we do not have to worry about one less thing.

Not that I don't mind no double or triple negations, but no, not this one.

> > +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> > +		return error(_("make_script: unhandled options"));
> > +
> > +	if (prepare_revision_walk(&revs) < 0)
> > +		return error(_("make_script: error preparing revisions"));
> > +
> > +	while ((commit = get_revision(&revs))) {
> > +		strbuf_reset(&buf);
> > +		if (!keep_empty && is_original_commit_empty(commit))
> > +			strbuf_addf(&buf, "%c ", comment_line_char);
> 
> Presumably callers of this function (which does not exist yet at
> this step) are expected to have done the configuration dance to
> prepare comment_line_char to whatever the end-user specified?

Yes. Just like they have to take care of discovering the .git/ directory.

I guess I kind of fail to see your point. Of course the configuration has
to be read at this point... This is an internal API function that has the
same contract as all the other internal API functions: you have to set up
and configure everything needed to run the API function beforehand.

But maybe what you really wanted to ask is: How do we know that
comment_line_char is initialized correctly at this point?

If that is the question, I understand your puzzlement, and it is easy to
dispell: comment_line_char is configured as part of
git_default_core_config(), and initialized to '#' before Git even starts
to run.

So we're safe here, as long as the default config handling runs. The
intended user is obviously the rebase--helper, which runs git_config()
even before parsing the options.

Meaning: the code is safe.

Ciao,
Dscho
