Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99A120136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934360AbdBQQx3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:53:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:60888 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934066AbdBQQx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:53:27 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUI8w-1cn3Dk269i-00R59v; Fri, 17
 Feb 2017 17:53:14 +0100
Date:   Fri, 17 Feb 2017 17:53:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2 2/2] rev-parse: fix several options when running in
 a subdirectory
In-Reply-To: <xmqqo9y9lvqk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702171749180.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <cover.1486740772.git.johannes.schindelin@gmx.de> <9242ee9717dcec95351b356070102f198eeb2537.1486740772.git.johannes.schindelin@gmx.de>
 <xmqqo9y9lvqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:de9qLykukEGxWd9YgG7TfIOzhERdxigCNryc3HO6YV4FNvAa0Gn
 7eohnSeXp9eXUcqaS5wouIuQYB1hIjEHYLLfmIb6snJvfWYR4xjrglrddVA1bMqn8kMjNsN
 dndtTsCJwwkuKBswwt0pZ8u1bs2SqoB25t+q4SReRubOIua2yKZ9BcBdUpQgGzzoh9m4iUU
 PTYN3gRwezScS46BR+fOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z6psQ/TLYMc=:DfSeLgTNRUGB6Tr3KMhT2/
 Ioq1qQvaGb5PioFew9kNsULqK60uDQLR24sm1r8NgWO7j8z2gNlTLt911kD6TqiLZrjPqkN4Y
 5Bg3sP56qyJjSpkZbE0PbLyFP6+FVn5hltqcQQdcy682jRnJHIL9lWGo2twwPydfPzMfZ4Qmn
 C2uZ0yPMuGi5Ic6/A7/S47+WzViqI/EzGwZm42/wCtJ/lwbsaLBQPqMfqmf9k9obgJzGEJYV1
 kJKLN+BdxTbNR6EEakp+83vcmGBo4o1GFnbi0t2KlrKGHMV9hOHoQQgo+Qb5MG+yHfKuxLVdI
 7IGD6t7gtxrUr50zysa0CfAGgLP3OsYt/KYpClOcRf+pOrJ7Q6YdtPCfkGEoc+8BJtJMjLHOu
 YEO3qd8WNQPOD5Jhjx8OKysas2bMEbU3mUj2Rxzkh9/vFccu/DtdYpxSlJVH7C1e1mqdNtYRP
 ShM8BP6QDG5Guf2tcJ9yNLjEZxT4+KnkMc85Bw7QbF0g3zTo0IAk+RPyRNmGEzUYRlB2zJJ5g
 AkRFAlIIGjS+2IlATqZnb/WeR1fo96td3xOXCfgszvvwlDC7RnzGidGkI9nARKm/G/S0A2x/C
 +2Tp82U3Yk0Qi20+IuZPxemkhD0HwR703dzjDNcuJcZEBUBJLSFkQzI28Xcah5tPWD1UA3oc/
 83V1K3QBsaM5pzKxZeMoEa0QNz0xmFmu47uPF75JnoLATymoO2BscH0BSe+EbDgu77TXfaFDG
 yML30l/AP+zpfGiitowxBw0TUwS7+I6jntG9PVbCYxSdynaupDe75l31Bqa0goMaqwBimOQvq
 TZo+w9o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> > index ff13e59e1db..84af2802f6f 100644
> > --- a/builtin/rev-parse.c
> > +++ b/builtin/rev-parse.c
> > @@ -545,6 +545,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  	unsigned int flags = 0;
> >  	const char *name = NULL;
> >  	struct object_context unused;
> > +	struct strbuf buf = STRBUF_INIT;
> >  
> >  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
> >  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> > @@ -599,7 +600,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  		if (!strcmp(arg, "--git-path")) {
> >  			if (!argv[i + 1])
> >  				die("--git-path requires an argument");
> > -			puts(git_path("%s", argv[i + 1]));
> > +			strbuf_reset(&buf);
> > +			puts(relative_path(git_path("%s", argv[i + 1]),
> > +					   prefix, &buf));
> >  			i++;
> >  			continue;
> >  		}
> > @@ -821,8 +824,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  				continue;
> >  			}
> >  			if (!strcmp(arg, "--git-common-dir")) {
> > -				const char *pfx = prefix ? prefix : "";
> > -				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
> > +				strbuf_reset(&buf);
> > +				puts(relative_path(get_git_common_dir(),
> > +						   prefix, &buf));
> >  				continue;
> >  			}
> >  			if (!strcmp(arg, "--is-inside-git-dir")) {
> > @@ -845,7 +849,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  					die(_("Could not read the index"));
> >  				if (the_index.split_index) {
> >  					const unsigned char *sha1 = the_index.split_index->base_sha1;
> > -					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
> > +					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
> > +					strbuf_reset(&buf);
> > +					puts(relative_path(path, prefix, &buf));
> >  				}
> >  				continue;
> >  			}
> > @@ -906,5 +912,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  		die_no_single_rev(quiet);
> >  	} else
> >  		show_default();
> > +	strbuf_release(&buf);
> 
> This uses "reset then use" pattern for repeated use of strbuf, and
> causes the string last held in the strbuf to leak on early return,

... which cannot happen due to the lack of an early return...

> which can be mitigated by using "use then reset" pattern.  I.e.
> 
> 			if (!strcmp(arg, "--git-common-dir")) {
> 				puts(relative_path(get_git_common_dir(),
> 						   prefix, &buf));
> 				strbuf_reset(&buf);
> 				continue;
> 			}
> 
> I'd think.

This would not release the memory, though:

	#define strbuf_reset(sb)  strbuf_setlen(sb, 0)

and

	static inline void strbuf_setlen(struct strbuf *sb, size_t len)
	{
		if (len > (sb->alloc ? sb->alloc - 1 : 0))
			die("BUG: strbuf_setlen() beyond buffer");
		sb->len = len;
		sb->buf[len] = '\0';
	}

There is not a single free() statement there.

So the "use then reset" scheme would leak *just the same*.

> You'd still want to release it at the end anyway for good code hygiene,
> though.

Which I do.

Technically, this is not even necessary because all of the cmd_*()
functions are immediately followed by a call to exit(). Wasn't that the
genius idea in the early Git days, that we could simply get away with
sloppy memory management because the program exit()s shortly afterwards,
anyway? ;-)

In any case, I adjusted the commit message to clarify why the "reset then
use" scheme is correct here.

Ciao,
Johannes
