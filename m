Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E074207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165712AbdD1PNu (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:13:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:51081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162804AbdD1PNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:13:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb7lL-1dN1Nx3mAt-00Kjod; Fri, 28
 Apr 2017 17:13:39 +0200
Date:   Fri, 28 Apr 2017 17:13:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281711540.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704271607550.3480@virtualbox> <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3HXz222883mYr1iwj/juZDbD4qYKV0iDG6XWy3pzRsOC7ZAv+qo
 95aNXrs8nWOlowBecQoQSG93KLPBd+TVwlQ7zw9sVM7FCrg58O6l42iURjeo/gBTLHkymbB
 eSxIvrUViGC6p+t1zTRqj7PyLdSIiA9bbx196OpIKj+nvIZgRtv1iXV9RSsHrLMcGG4ptOT
 KgTPf/DQ8cwm9ydUIUEAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nnMgfH7fRXc=:v80R2lO/L2kYWeqAmGtnkS
 oX/bygjf83CtkhrZ4e7ag+WFjSpvh4NyGZ/6ZKufIu4IVdpJGVkys1hUFa5c0H1pZV3ky7JnL
 bs9ANreb/RmbpXUHCttH3obBi9Yyr93/Nz9wfkTnwc40Nrd725reVgg5jfv6UrOe8UYlp4s3q
 VGw13R5dlN4Ae3TgNH41ZPL04SuLA5RYkIA5Dr9B/Fd8BpFlHKvrCdYKXs/GW8CkBorvSHmy3
 cVlT40kiuRiDrg8gLPqfd96huxeRoh1l/msvAdu9tBsINXVOAmGcLRZqG5egN6hT2xmGAaJA3
 9ncqgCvrA7aRubNandJ8dmcL5zAba0CYDvyE/+Lo/IkVeDK8lQwz3ZKktSeLWZon7P2trE6TS
 g2QWCTGAf8X+1ONGkPRbI8+8gu07oUTTDssI0cfmoviICXvtG1BDaNIsD0bbwO8g8WOEF3p4Z
 fvPi5fHtHTKJkHEpED7P8oWwqTMnCga7JjVuLV+WdFlzo/Xt2bSu6XUVrxrJJKdsY8IEPv1X1
 TpRn2imsvI3sm0JdO0G5JkDmiY3VKZ4DB4RnOjRcr7lhMjVYvF+1Q9KWHnOf1MIUzt1Yy/J4k
 3126gs9SJo3LRs2Bn0d0FECIuQNHi9SqWS/DwbTV++e5ysTdKORgGtH/fYuW0nTPl4RYWH2Kl
 ghLjnPQ3clUdZ4mJf83fFZrwq5T1jQuLAkzdFq8CTVBXDkGzd8SvG3qKOwIp7PzWMGQcBDswA
 7ubXRDO0gGZdpsrR/t0d5uSG8EHlyTZPc6zhmmiDFlAbR146Wt2DIbJh/VeqBF/zsCQwEdLHC
 NzWI3od
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 26 Apr 2017, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > diff --git a/sequencer.c b/sequencer.c
> >> > index 77afecaebf0..e858a976279 100644
> >> > --- a/sequencer.c
> >> > +++ b/sequencer.c
> >> > @@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> >> >  
> >> >  	strbuf_release(&sob);
> >> >  }
> >> > +
> >> > +int sequencer_make_script(int keep_empty, FILE *out,
> >> > +		int argc, const char **argv)
> >> > +{
> >> > +	char *format = xstrdup("%s");
> >> > +	struct pretty_print_context pp = {0};
> >> > +	struct strbuf buf = STRBUF_INIT;
> >> > +	struct rev_info revs;
> >> > +	struct commit *commit;
> >> > +
> >> > +	init_revisions(&revs, NULL);
> >> > +	revs.verbose_header = 1;
> >> > +	revs.max_parents = 1;
> >> > +	revs.cherry_pick = 1;
> >> > +	revs.limited = 1;
> >> > +	revs.reverse = 1;
> >> > +	revs.right_only = 1;
> >> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> >> > +	revs.topo_order = 1;
> >> > +
> >> > +	revs.pretty_given = 1;
> >> > +	git_config_get_string("rebase.instructionFormat", &format);
> >> > +	get_commit_format(format, &revs);
> >> > +	free(format);
> >> > +	pp.fmt = revs.commit_format;
> >> > +	pp.output_encoding = get_log_output_encoding();
> >> 
> >> All of the above feels like inviting unnecessary future breakages by
> >> knowing too much about the implementation the current version of
> >> revision.c happens to use.
> >
> > You mean that the `--reverse` option gets translated into the `reverse`
> > bit, and the other settings?
> 
> Yes.  The "pretty_given" trick is one example that the underlying
> implementation can change over time.  If you wrote this patch before
> 66b2ed09 ("Fix "log" family not to be too agressive about showing
> notes", 2010-01-20) happened, you wouldn't have known to flip this
> bit on to emulate the command line parsing of "--pretty" and
> friends, and you would have required the author of that change to
> know that you have this cut & pasted duplicated code here when the
> commit is primarily about updating revision.c
> 
> So I am very serious when I say that this is adding an unnecessary
> maintenance burden.

In that case, I would strongly advise to consider redesigning the API. It
is just no good to ask for a change in stringent code that would delay
compile errors to runtime errors, that's just poor form.

And if the API allows settings that do something unintentional without at
least a runtime warning, the API is no good.

Ciao,
Dscho
