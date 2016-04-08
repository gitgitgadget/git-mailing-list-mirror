From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] log: allow --graph and --show-linear-break used together
Date: Fri, 8 Apr 2016 19:43:38 +0700
Message-ID: <20160408124338.GA30174@lanh>
References: <3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jkt@kde.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 14:44:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoVlc-0006QI-RT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 14:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446AbcDHMnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2016 08:43:42 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36803 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413AbcDHMnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 08:43:40 -0400
Received: by mail-pa0-f47.google.com with SMTP id bx7so58240540pad.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GSZYZSrdRXQGgkDzBFUZO8nwbtS94Xe948KfueYcACM=;
        b=NuoQVkxCE5FhmLETkaB2clgmAgDmmX2HOvIlwg5kxFJoa5zIVB19G2ePpjKVVZLxGT
         Y/BnPPRdfPRW6b8+54Yqlrf965ugsmsDlAbZG2FU4uwziRpymuMPx4NSNze+IT82r0Oo
         dXue3wr0JmJBfNjDi3+VwdJzdggxiRAlMEQxhG5a1NTrSKPzpY19ehM9Oy2pKQS4Qpcc
         9XwXFLZlYcdwCvY7rInSvQ+pXRKrfWiUuEmsN/AfPaiHKAnCvW0eWjoKzJncDKu0d7rI
         ze8/zJ6bxrcU5tkN5oKMJxNQ9DurhcbsYDcFpO0ljEyGs+h7HclUf7UDlMOgCPXU3roB
         W9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GSZYZSrdRXQGgkDzBFUZO8nwbtS94Xe948KfueYcACM=;
        b=lov4JWK0TqYSlm+XOtzge+Lj/y7g/nK/Ve1NsWEVUH8sjVcQwaMjOf6jfon5RyIu0w
         R7y84ai1bEapevW7zprWo7eUce9Ws2qDZ8HoePfdwvjakgztpXV6tOMmsqlcIOMmbdnE
         vuAhIxFSU9iz8/fdKOX7gt1DeZQpGP4UA40e0FMzX5lyPYhXEQu42arnsvhgslc4vhBi
         v2okwlcE5EVuCDixKYLqnZwtA1rrzhtH2T7GQTgo9cnibJnPa6KM0ymMypJ9s/pgCybk
         khsVB7qxV/fX+S3ybXbE6FsFimpRz/5RU23LmDZwRTdj6ph91l28mGsxWtewGhqQ30Nx
         FiQA==
X-Gm-Message-State: AD7BkJITp+KdwsWvw9q3BHaUKILLjw6wb8F+M5lndmxGUwju6jqrB7Z05yiBUAJEErYD/Q==
X-Received: by 10.66.119.177 with SMTP id kv17mr12628581pab.124.1460119419250;
        Fri, 08 Apr 2016 05:43:39 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id vu5sm12962426pab.43.2016.04.08.05.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Apr 2016 05:43:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Apr 2016 19:43:38 +0700
Content-Disposition: inline
In-Reply-To: <3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291031>

On Fri, Apr 08, 2016 at 01:21:07PM +0200, Jan Kundr=E1t wrote:
> From 1ac6bb7c31652835d3d046c82e423f0cea6e0904 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Jan=3D20Kundr=3DC3=3DA1t?=3D <jkt@kde.org>
> Date: Fri, 8 Apr 2016 13:06:31 +0200
> Subject: [PATCH] log: allow --graph and --show-linear-break used toge=
ther
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> There was no visual break when --graph --oneline was used with severa=
l
> history trees with disjoint parents.
>=20
> The original reasoning given in commit 1b32decef was probably that a
> graph already conveys enough information to indicate that there's no
> parent-child relation between these two commits. However, this is not
> the case when a single-line prettification of a log is used, in which
> case the commits are displayed on top of each other with no space for
> that graph line to show the separation.
>=20
> It might be interesting to change the actual printing of the break_ba=
r
> to print fewer line breaks, but this simple approach works and is IMH=
O
> not that bad visually, anyway.

How about something like this? It does not break the graph, which is
probably better visually, although some may say breaking the graph
_is_ better in this particular case.

I also try to fix the extra blank lines in --oneline mode (with or
without --graph). That's definitely an improvement.

-- 8< --
diff --git a/graph.c b/graph.c
index 1350bdd..deafdd4 100644
--- a/graph.c
+++ b/graph.c
@@ -1226,6 +1226,14 @@ void graph_show_padding(struct git_graph *graph)
 	strbuf_release(&msgbuf);
 }
=20
+void graph_show_vertical_bars(struct git_graph *graph)
+{
+	int saved_width =3D graph->width;
+	graph->width =3D 0;	/* no extra padding */
+	graph_show_padding(graph);
+	graph->width =3D saved_width;
+}
+
 int graph_show_remainder(struct git_graph *graph)
 {
 	struct strbuf msgbuf =3D STRBUF_INIT;
diff --git a/graph.h b/graph.h
index 0be62bd..5e55425 100644
--- a/graph.h
+++ b/graph.h
@@ -91,6 +91,8 @@ void graph_show_oneline(struct git_graph *graph);
  */
 void graph_show_padding(struct git_graph *graph);
=20
+void graph_show_vertical_bars(struct git_graph *graph);
+
 /*
  * If the graph is non-NULL, print the rest of the history graph for t=
his
  * commit to stdout.  Does not print a terminating newline on the last=
 line.
diff --git a/log-tree.c b/log-tree.c
index 60f9839..61d7cbd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -858,6 +858,22 @@ static int log_tree_diff(struct rev_info *opt, str=
uct commit *commit, struct log
 	return showed_log;
 }
=20
+static void show_break_bar(struct rev_info *opt)
+{
+	if (opt->graph) {
+		if (opt->commit_format !=3D CMIT_FMT_ONELINE) {
+			graph_show_vertical_bars(opt->graph);
+			putchar('\n');
+		}
+		graph_show_vertical_bars(opt->graph);
+		printf("%s\n", opt->break_bar);
+	} else {
+		if (opt->commit_format !=3D CMIT_FMT_ONELINE)
+			putchar('\n');
+		printf("%s\n", opt->break_bar);
+	}
+}
+
 int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
 	struct log_info log;
@@ -871,7 +887,7 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 		return line_log_print(opt, commit);
=20
 	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		show_break_bar(opt);
 	shown =3D log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent =3D NULL;
@@ -879,7 +895,7 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 		shown =3D 1;
 	}
 	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		show_break_bar(opt);
 	opt->loginfo =3D NULL;
 	maybe_flush_or_die(stdout, "stdout");
 	return shown;
-- 8< --


>=20
> Signed-off-by: Jan Kundr??t <jkt@kde.org>
> ---
>  Documentation/rev-list-options.txt | 5 +++--
>  revision.c                         | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 4f009d4..c5e487c 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -807,8 +807,9 @@ This implies the `--topo-order` option by default=
, but the
>  `--date-order` option may also be specified.
> =20
>  --show-linear-break[=3D<barrier>]::
> -	When --graph is not used, all history branches are flattened
> -	which can make it hard to see that the two consecutive commits
> +	If the history is flattened, such as when --graph is not used
> +	or if --graph is combined with --oneline to produce a compact
> +	view, it can be hard to see that the two consecutive commits
>  	do not belong to a linear branch. This option puts a barrier
>  	in between them in that case. If `<barrier>` is specified, it
>  	is the string that will be shown instead of the default one.
> diff --git a/revision.c b/revision.c
> index 8b2dfe3..809c43e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1864,6 +1864,8 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
>  		   starts_with(arg, "--show-linear-break=3D")) {
>  		if (starts_with(arg, "--show-linear-break=3D"))
>  			revs->break_bar =3D xstrdup(arg + 20);
> +		else if (revs->graph)
> +			revs->break_bar =3D "  ..........\n";
>  		else
>  			revs->break_bar =3D "                    ..........";
>  		revs->track_linear =3D 1;
> @@ -1993,8 +1995,6 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
>  			unkv[(*unkc)++] =3D arg;
>  		return opts;
>  	}
> -	if (revs->graph && revs->track_linear)
> -		die("--show-linear-break and --graph are incompatible");
> =20
>  	return 1;
>  }
> --=20
> 2.7.3
>=20
