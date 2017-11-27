Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA1A20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbdK0Wmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 17:42:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:50807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752275AbdK0Wml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 17:42:41 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC8iq-1eSHoR23Cy-008pfn; Mon, 27
 Nov 2017 23:42:35 +0100
Date:   Mon, 27 Nov 2017 23:42:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the
 rebase--helper
In-Reply-To: <20171127045514.25647-4-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711272241590.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-4-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ja+onSqYhh1rMSEWzwvAjTR/LC9oMP2pT1q0YkLIigDbIHfUSbj
 e/XmCjcL6LbBijY2Xv3OSdb/w7H36iSYZV+TZnx13e1Cjugw/GmE8xEHwtEDIRvsiGW0w7J
 reGVyO4w4Qy9by4N0FskICWpcGY25Duw3LxSeLzha8B1Q1O4/yjLss2wY87EW5vI3JhTLEq
 t8BBM/3jzT3LQaH6vsEnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Es4rjblSGlA=:eMyIl893A8gm752kK4tIzU
 rvO4LnzEV54e0nn0szzKu4KpOHXsifFh+aKUBwkEfmKwmCCg4eMm7ZmA1ClcweX5BhgECnNF0
 DvyysEPyGvKhGwuHnj0/a8gsGz5kBtSsjU97SGFmF5LyWtGtjj3gRL9AB412eS1g67eJqdq6d
 NyveP/hJvOjfoY6Qzgr6SbIKgTTO2XM2CKzPVEVY3S4hlGba7CYQXwWgg9kUZc8yRvWcLa2rt
 rYN5AisCm1yhlrJTVNNaVYElMAvP+P1xH8D0H13/5pkyAc1y3NQhAnmuAZxe0aC2jxHB6DJN5
 mWZGRpm07De77y54lcQzh29LCCCp43jbQnhXBwjJx2ZrfRGDVdofULjmJWvXGbzERrHyWyzW6
 rAfnOZrCHPmUlc/+6x6HeY4njF9hbCTEMiUV+ppSatu8cCZMVu1YrfTF0NJs83hU4Id9bNLVi
 OQaNKgUfU0ywjyHWPijopFkomBV+lU5ppsl98uCCsiNzCBKMI4zAl2GJ3rXFeKplA7s/Bnwke
 vu8otL4Ucbd0ExNuUYans+LcuR+FRhLrV9g5MuS3jNZtM6x0uzL+FEnibfDzXWAOvj8qBPFfK
 WxWUvh6k+eHYhL5QW+6gcCCCf4hsRL0XHFZ0DXpzOQAQA2f3HjrlkF4J24BIGkb3gxfplYlht
 raWYVoU6xROurcSaeGGXGYMfnNPWcaN8T8i6tytETQ7F0f0IGgUD8q1kz8NOqRfcHbksbL81u
 i1CAypHm78ii1mX8W2mphhlyRPdFg37ciUIwrIFGuAmDN8t/IFr+qU2Rc1oeEsgd5Rhzif8Bv
 IHjtEWAxBqshdJwnu9m8bwAtybFiuqeS940EKRFtTrRJaqBMKA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

could I ask for a favor? I'd like the oneline to start with

	rebase -i -x: ...

(this would help future me to realize what this commit touches already
from the concise graph output I favor).

On Sun, 26 Nov 2017, Liam Beguin wrote:

> Recent work on `git-rebase--interactive` aim to convert shell code to C.
> Even if this is most likely not a big performance enhacement, let's
> convert it too since a comming change to abbreviate command names requires
> it to be updated.

Since Junio did not comment on the commit message: could you replace
`aim` by `aims`, `enhacement` by `enhancement` and `comming` by `coming`?

> @@ -36,6 +37,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
>  		OPT_CMDMODE(0, "rearrange-squash", &command,
>  			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
> +		OPT_CMDMODE(0, "add-exec", &command,
> +			N_("insert exec commands in todo list"), ADD_EXEC),

Maybe `add-exec-commands`? I know it is longer to type, but these options do
not need to be typed interactively and the longer name would be consistent
with the function name.

> diff --git a/sequencer.c b/sequencer.c
> index fa94ed652d2c..810b7850748e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  	return 0;
>  }
>  

As the code in add_exec_commands() may appear convoluted (why not simply
append the command after any pick?), the original comment would be really
nice here:

	/*
	 * Add commands after pick and (series of) squash/fixup commands
	 * in the todo list.
	 */

> +int add_exec_commands(const char *command)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int fd, res, i, first = 1;
> +	FILE *out;
> +
> +	strbuf_reset(&todo_list.buf);

The todo_list.buf has been initialized already (via TODO_LIST_INIT), no
need to reset it again.

> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);

As Junio pointed out so gently: there is a helper function that does this
all very conveniently for us:

	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
		return error_errno(_("could not read '%s'"), todo_file);

And as I realized looking at the surrounding code: you probably just
inherited my inelegant code by copy-editing from another function in
sequencer.c. Should you decide to add a preparatory patch to your patch
series that converts these other callers, or even refactors all that code
that reads the git-rebase-todo file and then parses it, I would be quite
happy... :-) (although I would understand if you deemed this outside the
purpose of your patch series).

> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> +	if (res) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}

The variable `res` is not really used here. Let's just put the
parse_insn_buffer() call inside the if ().

> +	out = fopen(todo_file, "w");
> +	if (!out) {
> +		todo_list_release(&todo_list);
> +		return error(_("unable to open '%s' for writing"), todo_file);
> +	}
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct todo_item *item = todo_list.items + i;
> +		int bol = item->offset_in_buf;
> +		const char *p = todo_list.buf.buf + bol;
> +		int eol = i + 1 < todo_list.nr ?
> +			todo_list.items[i + 1].offset_in_buf :
> +			todo_list.buf.len;

This smells like another copy-edited snippet that originated from my
brain, and I am not at all proud by the complexity I used there.

The function should also check for errors during writing. So how about
something like this instead?

	struct strbuf *buf = &todo_list.buf;
	size_t offset = 0, command_len = strlen(command);
	int first = 1, i;
	struct todo_item *item;

	...

	/* insert <command> before every pick except the first one */
	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++)
		if (item->command == TODO_PICK) {
			if (first)
				first = 0;
			else {
				strbuf_splice(buf,
					      item->offset_in_buf + offset, 0,
					      command, command_len);
				offset += command_len;
			}
		}

	/* append a final <command> */
	strbuf_complete_list(buf);
	strbuf_add(buf, command, command_len);

	i = write_message(buf->buf, buf->len, todo_file, 0);
	todo_list_release(&todo_list);
	return i;

Ciao,
Dscho
