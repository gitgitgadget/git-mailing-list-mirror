Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8107E20958
	for <e@80x24.org>; Sun, 26 Mar 2017 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdCZNl7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 09:41:59 -0400
Received: from mout.web.de ([212.227.15.4]:62781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbdCZNl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 09:41:59 -0400
Received: from [192.168.178.36] ([79.237.59.215]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lb7vN-1cTZED2yuv-00ke08; Sun, 26
 Mar 2017 15:41:16 +0200
Subject: Re: [PATCH] pretty: add extra headers and MIME boundary directly
To:     Jeff King <peff@peff.net>
References: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
 <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
 <c5591beb-8cb2-dc19-7820-c8b9c68aad15@web.de>
 <20170325211149.yyvocmdfw4zbjyoi@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9d31c27b-fecb-ac1d-2b3f-8227c93862c2@web.de>
Date:   Sun, 26 Mar 2017 15:41:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170325211149.yyvocmdfw4zbjyoi@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JdLBQL8d8dc2ch3NJcLpcS/DTlTIthH4A5icOAApsFnom3VZO4O
 u3234uH7Wyd1Xk5Evkm4iUQ6T0KP+ikHxvB497EcEoKbrs7w/EM3laEMy159mUXs3BhCzBF
 nwFsDg0usUek16k0r9y772fIsMR9dbcCHh/DmxLBKzipiv6HAEdMb9iqAmQg0gaguv6O05g
 W1m6ppLneDxWay9ABOCcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YYbl7oyRur4=:t8eNpIbiI0V2SAuRwhP/ZK
 uJvcq95rg30gD6p1x8unXWnftb32ZORHO+sleTTE7avogs2v57AmpWw6vZTdkxqHDP4ZBCNeI
 rTHoJGl0PuuMXI7e8AQ3h6j/0kWMBhhdCGj8qO72NXZ+Lb0yHkNlbPYTd1h4vnRxNZg1JeY5D
 4Li3fyQdH74kfq3oYhqv5euXDJZtE5AFIXMqwj514o1vF+laE3xHyCFFniZ02xeXzfso/A9AO
 uh8VZ16lrw/shdovYyAL+83jcfiwJtf6w6DUJQp1tcTHN2KA4JLBDWS47Lw/ZK/EVIKyVDuam
 pxbpxIycahcsDYmIIF3GCXMEuXwwjHdt0Ba+obh9NwxCY4g5YIuYWwmWquKb/aseOVLgELx4U
 F0bTaTPuUd9ejmqN5bMa3tixenyMtE6EmAO2HzuD1AiDQdNqZ/IxHnogumPlfiwItF3lP5PAO
 TQwHqc8rjyXcUkDUNQ2mX3yeok5m3t4HiU96f1F8XZCyQMxdCaghSpT0BRtG0i7RD46bblDW7
 Plcp0VeWk/8rwEbjPagzMfzSwhvX4T29jFSoTkb/4aK1gSxAKDQAQ3hp9Yziq4590tFE7WwR4
 7gxv7Dbqjv5bo8JndSbnnBgdLRzNeRZ9i4+RvGcTCuuHQb8hLJ+4ZoOq/DTx1OnT8MZd8P6a2
 XRnprW0ziqdS0S2NbiHCwZSnE8OER43aDgYbok8xgRRLeSwr4r8zP0PnhlixatDc+Yf7TseXQ
 /OkJpzEINHXeAfcdHe64z0ovJMjqP9wnNwZo+b8C617522yA+kL67EPEKRfPoLh4/N935ZGn3
 cpjo2ma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.2017 um 22:11 schrieb Jeff King:
> The most correct way is that the caller of log_write_email_headers() and
> diff_flush() should have a function-local strbuf which holds the data,
> gets passed to diff_flush() as some kind opaque context, and then is
> freed afterwards. We don't have such a context, but if we were to abuse
> diff_options.stat_sep _temporarily_, that would still be a lot cleaner.
> I.e., something like this:
> 
>   struct strbuf stat_sep = STRBUF_INIT;
> 
>   /* may write into stat_sep, depending on options */
>   log_write_email_headers(..., &stat_sep);
>   opt->diffopt.stat_sep = stat_sep.buf;
> 
>   diff_flush(&opt->diffopt);
>   opt->diffopt.stat_sep = NULL;
>   strbuf_release(&stat_sep);
> 
> But it's a bit tricky because those two hunks happen in separate
> functions, which means passing the strbuf around.

You could have a destructor callback, called at the end of diff_flush().

> Anyway. Here's my attempt at the callback version of stat_sep.
> 
> ---
> diff --git a/diff.c b/diff.c
> index a628ac3a9..d061f9e18 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4819,10 +4819,9 @@ void diff_flush(struct diff_options *options)
>  			fprintf(options->file, "%s%c",
>  				diff_line_prefix(options),
>  				options->line_termination);
> -			if (options->stat_sep) {
> -				/* attach patch instead of inline */
> -				fputs(options->stat_sep, options->file);
> -			}
> +			if (options->stat_sep)
> +				options->stat_sep(options->file,
> +						  options->stat_sep_data);
>  		}
>  
>  		for (i = 0; i < q->nr; i++) {
> diff --git a/diff.h b/diff.h
> index e9ccb38c2..4785f3b23 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -154,9 +154,11 @@ struct diff_options {
>  	unsigned ws_error_highlight;
>  	const char *prefix;
>  	int prefix_length;
> -	const char *stat_sep;
>  	long xdl_opts;
>  
> +	void (*stat_sep)(FILE *, void *);
> +	void *stat_sep_data;
> +
>  	int stat_width;
>  	int stat_name_width;
>  	int stat_graph_width;
> diff --git a/log-tree.c b/log-tree.c
> index 7049a1778..5cf825c41 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -348,6 +348,31 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
>  	}
>  }
>  
> +static void show_mime_attachment(FILE *out, void *data)
> +{
> +	struct rev_info *opt = data;
> +	struct strbuf filename = STRBUF_INIT;
> +
> +	if (opt->numbered_files)
> +		strbuf_addf(&filename, "%d", opt->nr);
> +	else
> +		fmt_output_commit(&filename, opt->commit_for_mime, opt);
> +
> +	fprintf(out,
> +		"\n--%s%s\n"
> +		"Content-Type: text/x-patch;"
> +		" name=\"%s\"\n"
> +		"Content-Transfer-Encoding: 8bit\n"
> +		"Content-Disposition: %s;"
> +		" filename=\"%s\"\n\n",
> +		mime_boundary_leader, opt->mime_boundary,
> +		filename.buf,
> +		opt->no_inline ? "attachment" : "inline",
> +		filename.buf);
> +
> +	strbuf_release(&filename);
> +}
> +
>  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  			     int *need_8bit_cte_p)
>  {
> @@ -372,27 +397,10 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  		graph_show_oneline(opt->graph);
>  	}
>  	if (opt->mime_boundary) {
> -		static char buffer[1024];
> -		struct strbuf filename =  STRBUF_INIT;
>  		*need_8bit_cte_p = -1; /* NEVER */
> -
> -		if (opt->numbered_files)
> -			strbuf_addf(&filename, "%d", opt->nr);
> -		else
> -			fmt_output_commit(&filename, commit, opt);
> -		snprintf(buffer, sizeof(buffer) - 1,
> -			 "\n--%s%s\n"
> -			 "Content-Type: text/x-patch;"
> -			 " name=\"%s\"\n"
> -			 "Content-Transfer-Encoding: 8bit\n"
> -			 "Content-Disposition: %s;"
> -			 " filename=\"%s\"\n\n",
> -			 mime_boundary_leader, opt->mime_boundary,
> -			 filename.buf,
> -			 opt->no_inline ? "attachment" : "inline",
> -			 filename.buf);
> -		opt->diffopt.stat_sep = buffer;
> -		strbuf_release(&filename);
> +		opt->diffopt.stat_sep = show_mime_attachment;
> +		opt->diffopt.stat_sep_data = opt;
> +		opt->commit_for_mime = commit;
>  	}
>  }
>  
> diff --git a/revision.h b/revision.h
> index 14886ec92..46ca45d96 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -156,6 +156,7 @@ struct rev_info {
>  	struct log_info *loginfo;
>  	int		nr, total;
>  	const char	*mime_boundary;
> +	struct commit *commit_for_mime;
>  	const char	*patch_suffix;
>  	int		numbered_files;
>  	int		reroll_count;

Hmm.  I'm a fan of callbacks, but using them can make the code a bit
hard to follow.  And void context pointers add a type safety hazard.
Do we need to be this generic?  How about switching stat_sep to strbuf?
fmt_output_commit() requires an allocation anyway, so why not allocate
stat_sep as well?

---
 diff.c     | 7 ++++---
 diff.h     | 2 +-
 log-tree.c | 4 +---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index a628ac3a95..a4afa8eba2 100644
--- a/diff.c
+++ b/diff.c
@@ -41,7 +41,7 @@ static int diff_mnemonic_prefix;
 static int diff_no_prefix;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
-static struct diff_options default_diff_options;
+static struct diff_options default_diff_options = { STRBUF_INIT };
 static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
 
@@ -4819,9 +4819,9 @@ void diff_flush(struct diff_options *options)
 			fprintf(options->file, "%s%c",
 				diff_line_prefix(options),
 				options->line_termination);
-			if (options->stat_sep) {
+			if (options->stat_sep.len) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				strbuf_write(&options->stat_sep, options->file);
 			}
 		}
 
@@ -4842,6 +4842,7 @@ void diff_flush(struct diff_options *options)
 	DIFF_QUEUE_CLEAR(q);
 	if (options->close_file)
 		fclose(options->file);
+	strbuf_release(&options->stat_sep);
 
 	/*
 	 * Report the content-level differences with HAS_CHANGES;
diff --git a/diff.h b/diff.h
index e9ccb38c26..6a537df1ab 100644
--- a/diff.h
+++ b/diff.h
@@ -116,6 +116,7 @@ enum diff_submodule_format {
 };
 
 struct diff_options {
+	struct strbuf stat_sep;
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
@@ -154,7 +155,6 @@ struct diff_options {
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
-	const char *stat_sep;
 	long xdl_opts;
 
 	int stat_width;
diff --git a/log-tree.c b/log-tree.c
index 7049a17781..cd4f363d9b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -372,7 +372,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary) {
-		static char buffer[1024];
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 
@@ -380,7 +379,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			strbuf_addf(&filename, "%d", opt->nr);
 		else
 			fmt_output_commit(&filename, commit, opt);
-		snprintf(buffer, sizeof(buffer) - 1,
+		strbuf_addf(&opt->diffopt.stat_sep,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
 			 " name=\"%s\"\n"
@@ -391,7 +390,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 filename.buf,
 			 opt->no_inline ? "attachment" : "inline",
 			 filename.buf);
-		opt->diffopt.stat_sep = buffer;
 		strbuf_release(&filename);
 	}
 }
-- 
2.12.2

