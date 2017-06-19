Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7719C20282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdFSJqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:46:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:61646 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdFSJqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:46:22 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVBq-1e1ydA17tq-00gVYX; Mon, 19
 Jun 2017 11:46:06 +0200
Date:   Mon, 19 Jun 2017 11:45:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
References: <cover.1497444257.git.johannes.schindelin@gmx.de> <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de> <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com> <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
 <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1MSAnZAQcGnLdcd9wMyije6k29QAbV8h74iAiJHpTgpBY8gIav+
 TK6PcNYkiZ0ROBDKYKkK3o7LJwdGMd8/ufGBXMuzr0q0LnlvJB7LufDd5RBeJeLlk3RreVl
 ILecj0vGJl8hmehzcBIzTa/KMboW9dxZ0VDQy0/CDstN9YGkgcmOTTxbDBCQtbq+iJ0AZ7o
 PwNX/WfaqtMeB0Sm8rsEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tmEjqm4HNeA=:bz8DaPncz1plhaevcO0Ocb
 9lJ6YRAmEIHN4jSvjUMtkwbrlk92/VVmGI8fpgxhpRyUtcBFsCXDZ/iUDLfvp2NAJUTMJzwvl
 w/fr2hlG/azFtPJywPAOcP7cUC2nfP1GrXYPH/B5P7BMWLI6V1RBtcv+aDo2/Abc06MWnqnx5
 HAKvQyvEwyolTEk0J+ikZeVS7s+9X7XNma25Urw/Khk56jiLCtOXhLRfPb4UMM+OlxahMAwwO
 e7WMjTrwYN9X2qVI4rxr4PBF+uHTzicqQeTX6ggzbYJ/kmFyJNE65zwODmZr1RQEKsjRUrdIm
 Dld6MWgr+YMbGuDukVwRZtEI5kjc7Z+pG9SzZUgDW6X0IBvC5RVtb2dk70/bqIjK/MbeX9Jc4
 DsB03Q0FABsDtYkVvn+L+M8TQk7hekRcaAZRZLN6+sOqmF+WROTtI2DA5eWvjuVeyzqNYSBvR
 7OmmB5F+0erFxNIO6J7jD0k7oD2vo6l6A43iSWhveft+gJOqv8hlC3znaqv/MFFxBhh8qQdj2
 0TlQFPHLAGeI/VOQ74xLwwdLgOpoklBs6P/wdxa8jZ8oOI1IR50I9nC6EXgx5VSBFISs7pWdb
 hNK7x6Mtr0Pci0GXgLb7JLXWCDqqH0W+050Ym3ON5+HONLMwFC6QomMDmidH+DlYy9SSCsGM6
 O+vVksayGUHAzgfe5vc54Feb319V2LXwWdYFV6xtYVgKFyyxPe1xqNv1HYxpVqNSXR6bCBylz
 0DVtIwisUeIp9PDgT1WmCCzKuAzIpWEzvCUopH9/1VwE1Je/yJ6qF3tdAh/RQ4xF739itQ2lP
 NCgvgwE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sat, 17 Jun 2017, Liam Beguin wrote:

> On 16/06/17 09:56 AM, Johannes Schindelin wrote:
> 
> > On Thu, 15 Jun 2017, Liam Beguin wrote:
> > 
> >> On 14/06/17 09:08 AM, Johannes Schindelin wrote:
> >>> diff --git a/sequencer.c b/sequencer.c
> >>> index a697906d463..a0e020dab09 100644
> >>> --- a/sequencer.c
> >>> +++ b/sequencer.c
> >>> @@ -2640,3 +2640,110 @@ int check_todo_list(void)
> >>>  
> >>>  	return res;
> >>>  }
> >>> +
> >>> +/* skip picking commits whose parents are unchanged */
> >>> +int skip_unnecessary_picks(void)
> >>> +{
> >>> +	const char *todo_file = rebase_path_todo();
> >>> +	struct strbuf buf = STRBUF_INIT;
> >>> +	struct todo_list todo_list = TODO_LIST_INIT;
> >>> +	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
> >>> +	int fd, i;
> >>> +
> >>> +	if (!read_oneliner(&buf, rebase_path_onto(), 0))
> >>> +		return error(_("could not read 'onto'"));
> >>> +	if (get_sha1(buf.buf, onto_oid.hash)) {
> >>
> >> I missed this last time but we could also replace `get_sha1` with
> >> `get_oid`
> > 
> > Good point!
> > 
> > I replaced this locally and force-pushed, but there is actually little
> > chance of this patch series being integrated in a form with which I
> > would be comfortable.
> 
> Is there any chance of this moving forward? I was hoping to resend my
> path to abbreviate command names on top of this.

We are at an impasse right now.

Junio wants me to change this code:

        revs.pretty_given = 1;
        git_config_get_string("rebase.instructionFormat", &format);
        if (!format || !*format) {
                free(format);
                format = xstrdup("%s");
        }
        get_commit_format(format, &revs);
        free(format);
        pp.fmt = revs.commit_format;
        pp.output_encoding = get_log_output_encoding();

        if (setup_revisions(argc, argv, &revs, NULL) > 1)
	...

which is reasonably compile-time safe, to something like this:

	struct strbuf userformat = STRBUF_INIT;
	struct argv_array args = ARGV_ARRAY_INIT;
	...
	for (i = 0; i < argc; i++)
		argv_array_push(&args, argv[i]);
        git_config_get_string("rebase.instructionFormat", &format);
        if (!format || !*format)
		argv_array_push(&args, "--format=%s");
	else {
		strbuf_addf(&userformat, "--format=%s", format);
                argv_array_push(&args, userformat.buf);
        }

        if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
	...
	argv_array_clear(&args);
	strbuf_release(&userformat);

which is not compile-time safe, harder to read, sloppy coding in my book.

The reason for this suggestion is that one of the revision machinery's
implementation details is an ugly little semi-secret: the pretty-printing
machinery uses a global state, and that is why we need the "pretty_given"
flag in the first place.

Junio thinks that it would be better to not use the pretty_given flag in
this patch series. I disagree: It would be better to use the pretty_given
flag, also as a good motivator to work on removing the global state in the
pretty-printing machinery.

Junio wants to strong-arm me into accepting authorship for this sloppy
coding, and I simply won't do it.

That's why we are at an impasse right now.

I am really, really sorry that this affects your patch series, as I had
not foreseen Junio's insistence on the sloppy coding when I suggested that
you rebase your work on top of my patch series. I just was really
unprepared for this contention, and I am still surprised/shocked that this
is even an issue up for discussion.

Be that as it may, I see that this is a very bad experience for a
motivated contributor such as yourself. I am very sorry about that!

So it may actually be better for you to go forward with your original
patch series targeting git-rebase--interactive.sh.

My apologies,
Dscho
