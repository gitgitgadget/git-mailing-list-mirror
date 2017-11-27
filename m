Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1274E20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbdK0XEx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:04:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:54137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdK0XEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:04:51 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbsV8-1eaZtg1mIo-00JFhy; Tue, 28
 Nov 2017 00:04:46 +0100
Date:   Tue, 28 Nov 2017 00:04:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
In-Reply-To: <20171127045514.25647-5-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-5-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:whAYitveRrEJzQjX+uzxBbSh+BVaR3xCn2N1wLvw19WLL4a1dv/
 y+/xuvzS4DYv+RFq0xHjfrnl7XozO3EIjBlWFESN5pzhJodZ319Bstj+yAlXy7VFdjH+wWR
 SGnNqpH6bDYPxmAuSx4VetHE1k6gDSU0UjM8eNpp0FSuIJqOOYKc27Fec0sNWkE5JufZREc
 Lm5IFM5pDjhaPauOu0Lfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q25ZxovzAlc=:MfGxPUTmYNTVGesUUrMB60
 yf1ECayA0dno1lt5aErMWzDlgnveMFsx57Dr1qGjqVHC/3OOidNE/TPGuNuxnjQgRUllEe4QM
 4AuGpZtln0e5csmWwetcQYobZUG5QeRPg4M+NmxThhKrGuFAgpeRpuvAIGR8/YPlWGTmTydFh
 omw7GlJM/XWV2qO+TCU+O8wbeqG1wWomGdaRiLfpHLdrV96FTdyP5mIlOp8gqvSia8OXxgLxu
 aQjhCsAkzjHNv8gJiuVBdGIeFA+pNOLZVE3tvDXR3UXQ5DbdAdrQWLcmT+vqMAdS+ZbCz/zk0
 qAl+speKxjMBgOO5Rf+zxesyf0OM6j8uI3dyEQMZZhE2+lpomA+CkP/sYIxnyJsleaCA8ZTKx
 Sz4/RdMKZOCXt3/xI5YLYC6y1e0ghJeRL0iPnTvYxcosX3wS2CUUijhYXt/Ki5TGfkLtNPu7L
 FoTvIfY8OrhUJjYKXekCI2cgBdiXHR9wAqYo/tKANv2BAHsFKSu2nOnGnmhsNltJJOPeLrKI5
 BDewLenH4QWA4OPJSXnzaHfADQg+u+h3KktrFgw1VBGDk++Jmpi/qWSNYdwsOPboiOZwDPMV5
 /4QBbSdfK0ZLsddIc2/RX6Kf5BgHv+vDh28GOowC/7NNItP7od5hhiL2tZfLwp7epTTZSf55K
 gKvXHGyfoDyGt04jBsyH9NRbNWSS87k+oy2F25WLlnBckRka5B6RWQMqHgDRi5Bue2NICf9zz
 SKIep2gbOnGs4L3nu9d0F6HM0Evx2IBa7oymXvwQd+WUpMa6s81Xd0mK4MK5+LWUBVi1nALM9
 FyVRiB4TryKG5/UIJJVkkQ/dRRFm7aKruOYBGJ/xsN/jxTo/VQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 26 Nov 2017, Liam Beguin wrote:

> diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
> index 30ae08cb5a4b..0820b60f6e12 100644
> --- a/Documentation/rebase-config.txt
> +++ b/Documentation/rebase-config.txt
> @@ -30,3 +30,22 @@ rebase.instructionFormat::
>  	A format string, as specified in linkgit:git-log[1], to be used for the
>  	todo list during an interactive rebase.  The format will
>  	automatically have the long commit hash prepended to the format.
> +
> +rebase.abbreviateCommands::
> +	If set to true, `git rebase` will use abbreviated command names in the
> +	todo list resulting in something like this:
> +
> +-------------------------------------------
> +	p deadbee The oneline of the commit
> +	p fa1afe1 The oneline of the next commit
> +	...
> +-------------------------------------------

I *think* that AsciiDoc will render this in a different way from what we
want, but I am not an AsciiDoc expert. In my hands, I always had to add a
single + in an otherwise empty line to start a new indented paragraph *and
then continue with non-indented lines*.

> diff --git a/sequencer.c b/sequencer.c
> index 810b7850748e..aa01e8bd9280 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -795,6 +795,13 @@ static const char *command_to_string(const enum todo_command command)
>  	die("Unknown command: %d", command);
>  }
>  
> +static const char command_to_char(const enum todo_command command)
> +{
> +	if (command < TODO_COMMENT && todo_command_info[command].c)
> +		return todo_command_info[command].c;
> +	return -1;

My initial reaction was: should we return comment_line_char instead of -1
here? Only after reading how this is called did I realize that the idea is
to use full command names if there is no abbreviation. Not sure whether
this is worth a code comment. What do you think?

> +}
> +
>  static int is_noop(const enum todo_command command)
>  {
>  	return TODO_NOOP <= command;
> @@ -1242,15 +1249,16 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		return 0;
>  	}
>  
> -	for (i = 0; i < TODO_COMMENT; i++)
> +	for (i = 0; i < TODO_COMMENT; i++) {
>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>  			item->command = i;
>  			break;
> -		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +		} else if (bol[1] == ' ' && *bol == command_to_char(i)) {
>  			bol++;
>  			item->command = i;
>  			break;
>  		}
> +	}
>  	if (i >= TODO_COMMENT)
>  		return -1;
>  

I would prefer this hunk to be skipped, it does not really do anything if
I understand correctly.

> @@ -2443,8 +2451,8 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  	strbuf_release(&sob);
>  }
>  
> -int sequencer_make_script(int keep_empty, FILE *out,
> -		int argc, const char **argv)
> +int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
> +			  int argc, const char **argv)
>  {
>  	char *format = NULL;
>  	struct pretty_print_context pp = {0};
> @@ -2483,7 +2491,9 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  		strbuf_reset(&buf);
>  		if (!keep_empty && is_original_commit_empty(commit))
>  			strbuf_addf(&buf, "%c ", comment_line_char);
> -		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> +		strbuf_addf(&buf, "%s %s ",
> +			    abbreviate_commands ? "p" : "pick",
> +			    oid_to_hex(&commit->object.oid));

I guess the compiler will optimize this code so that the conditional is
evaluated only once. Not that this is performance critical ;-)

>  		pretty_print_commit(&pp, commit, &buf);
>  		strbuf_addch(&buf, '\n');
>  		fputs(buf.buf, out);
> @@ -2539,7 +2549,7 @@ int add_exec_commands(const char *command)
>  	return 0;
>  }
>  
> -int transform_todo_ids(int shorten_ids)
> +int transform_todo_ids(int shorten_ids, int abbreviate_commands)
>  {
>  	const char *todo_file = rebase_path_todo();
>  	struct todo_list todo_list = TODO_LIST_INIT;
> @@ -2575,19 +2585,33 @@ int transform_todo_ids(int shorten_ids)
>  			todo_list.items[i + 1].offset_in_buf :
>  			todo_list.buf.len;
>  
> -		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> -			fwrite(p, eol - bol, 1, out);
> -		else {
> +		if (item->command >= TODO_EXEC && item->command != TODO_DROP) {
> +			if (!abbreviate_commands || command_to_char(item->command) < 0) {
> +				fwrite(p, eol - bol, 1, out);
> +			} else {
> +				const char *end_of_line = strchrnul(p, '\n');
> +				p += strspn(p, " \t"); /* skip whitespace */
> +				p += strcspn(p, " \t"); /* skip command */
> +				fprintf(out, "%c%.*s\n",
> +					command_to_char(item->command),
> +					(int)(end_of_line - p), p);
> +			}
> +		} else {
>  			const char *id = shorten_ids ?
>  				short_commit_name(item->commit) :
>  				oid_to_hex(&item->commit->object.oid);
> -			int len;
>  
> -			p += strspn(p, " \t"); /* left-trim command */
> -			len = strcspn(p, " \t"); /* length of command */
> -
> -			fprintf(out, "%.*s %s %.*s\n",
> -				len, p, id, item->arg_len, item->arg);
> +			if (abbreviate_commands) {
> +				fprintf(out, "%c %s %.*s\n",
> +					command_to_char(item->command),
> +					id, item->arg_len, item->arg);
> +			} else {
> +				int len;
> +				p += strspn(p, " \t"); /* left-trim command */
> +				len = strcspn(p, " \t"); /* length of command */
> +				fprintf(out, "%.*s %s %.*s\n",
> +					len, p, id, item->arg_len, item->arg);
> +			}

This hunk changes indentation quite a bit, therefore it is a bit harder to
read than necessary (and the resulting code, too, as it is more smooshed
against the 80-column boundary on the right).

How about this instead:

-		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
+		if (abbreviate_commands && command_to_char(item->command)) {
+			const char *id = shorten_ids ?
+				short_commit_name(item->commit) :
+				oid_to_hex(&item->commit->object.oid);
+			fprintf(out, "%c %s %.*s\n",
+				command_to_char(item->command),
+				id, item->arg_len, item->arg);
+		} else if (item->command >= TODO_EXEC &&
+			 item->command != TODO_DROP)

i.e. test first for the short and sweet case that we want (and can)
abbreviate the command, otherwise keep the code as before?

Ciao,
Dscho
