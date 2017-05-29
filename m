Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A73B2027C
	for <e@80x24.org>; Mon, 29 May 2017 11:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdE2LUv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:20:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:55330 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdE2LUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:20:50 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUTSJ-1dP1bQ3Obb-00RLPV; Mon, 29
 May 2017 13:20:31 +0200
Date:   Mon, 29 May 2017 13:20:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 05/10] rebase -i: also expand/collapse the SHA-1s via
 the rebase--helper
In-Reply-To: <20170526031530.29162-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705291302160.3610@virtualbox>
References: <6cf1bcd39672474230b179a3d12c5eeab353ae0c.1493414945.git.johannes.schindelin@gmx.de> <20170526031530.29162-1-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+5JqRRHfUT0ukX8PN/Go/DfhD/Fil1fplzYtfIKb3JiAhdUpghj
 nxd0pl2rIbgJd9P9t7K73cGtoSYBuyvNqPlAG2X8T4USfQz9ow48o4U04hi14fKNXe6T2Ne
 oMhyntF33pNUJrE8ljQNCtiubrCNmqG9CsswHaAWOMlddp3SWttVgmJaFmk3L70i6DE22+0
 +tmpqWlnMa9WmaoTddNkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d6o2uIrr62o=:ZiyhxALZ4rP1pTivQYY+9e
 th3R+tXlyLOjkFMmkiXycLsMnHy45SYKFftcdhZ90rYJUFCtkyr05MZasXQTpOtK+rGN19iMI
 8u3RjrI+iJ9Cb36ao9+QSD4GJj40BGvHUVVPdP6mHQ36+nTGrw/gvfL2sJylnv06Fk02VHaZz
 tJzbfCm/buV3r2J1JVUztI5ueGehct/M098/UpY3wgSj+BxdsCAo0fdCNDTznf40MUz8plPBW
 J/NykW1Cesc0kwlkpBMpTaW1PGJ0H0Gai4J2SpL+dXWASzozrmjHSUZQd4GWyEmM5qGOMLslC
 z7vNklSmdMg0qpDfDyKSg837Nn1zsL/Vv3cHBY/JFkX/jwg4ZSVH2OVd+fdcee6Uwspj8dXUi
 2PycD2xp9sX85I3wZFRBLMqMN4AI9ap8Ja0j50eO3+5sqX2vjYKwwNR5jfyNTdgJylKwnpFlG
 +UihDJhKDUkPgk7ccG5BjRU4RdmyoanYel+yCCiqMSCuv4MAOz+AxSl9GXrOMoJs5XiTF5Inu
 WJKsgl2ZdevWRWUsTv+5O/u2WeYcMeKcGAj43/rbR0RxbQRHAo0LYu8ODD8XVk7Suj2Q/yWwr
 GCrqBZINXGKWBeQqrUH2s+Dg2j/jtDeR5U7topJzHeb1J9NqaQyUREywj5tNAvmWe3+YNJjYV
 T/udwjrlgwdMzfQsDvG2uT6UitYGKUQ8V0Gw6odgSfb6DWwIAXLTcpKfDS4nMfje8XVhsQ6ES
 L6dQTYJnkFV1NPoNgYKtp5r/6S+W2XFViCMEX7kaC323yQVTOESBVDaBLGnas1Smibl7HlXtE
 GUM8ZEV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Thu, 25 May 2017, Liam Beguin wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> > index 821058d452d..9444c8d6c60 100644
> > --- a/builtin/rebase--helper.c
> > +++ b/builtin/rebase--helper.c
> > @@ -24,6 +24,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
> >  				ABORT),
> >  		OPT_CMDMODE(0, "make-script", &command,
> >  			N_("make rebase script"), MAKE_SCRIPT),
> > +		OPT_CMDMODE(0, "shorten-sha1s", &command,
> > +			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
> > +		OPT_CMDMODE(0, "expand-sha1s", &command,
> > +			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
> 
> Since work is being done to convert to `struct object_id` would it
> not be best to use a more generic name instead of 'sha1'?
> maybe something like {shorten,expand}-hashs

Good point. You suggest the use of "ids" later, and I think that is an
even better name: what we try to do here is to expand/reduce the commit
*identifiers*. The fact that they are hexadecimal representations of
hashes is an implementation detail.

> > diff --git a/sequencer.c b/sequencer.c
> > index 88819a1a2a9..201d45b1677 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2437,3 +2437,60 @@ int sequencer_make_script(int keep_empty, FILE *out,
> >  	strbuf_release(&buf);
> >  	return 0;
> >  }
> > +
> > +
> > +int transform_todo_ids(int shorten_sha1s)
> > +{
> > +	const char *todo_file = rebase_path_todo();
> > +	struct todo_list todo_list = TODO_LIST_INIT;
> > +	int fd, res, i;
> > +	FILE *out;
> > +
> > +	strbuf_reset(&todo_list.buf);
> > +	fd = open(todo_file, O_RDONLY);
> > +	if (fd < 0)
> > +		return error_errno(_("could not open '%s'"), todo_file);
> > +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> > +		close(fd);
> > +		return error(_("could not read '%s'."), todo_file);
> > +	}
> > +	close(fd);
> > +
> > +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> > +	if (res) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unusable instruction sheet: '%s'"), todo_file);
> 
> As you pointed out last time, the name of the "todo script" can be a
> source of confusion. The migration to C could be a good opportunity to
> clarify this.

True. This was simply a copy-edited part, and I should have caught that.

> I don't know which is the preferred name but we could go with
> "todo list" as it is the most common across the code base.

Yep, my next iteration will use that term.

> > +	}
> > +
> > +	out = fopen(todo_file, "w");
> > +	if (!out) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unable to open '%s' for writing"), todo_file);
> > +	}
> > +	for (i = 0; i < todo_list.nr; i++) {
> > +		struct todo_item *item = todo_list.items + i;
> > +		int bol = item->offset_in_buf;
> > +		const char *p = todo_list.buf.buf + bol;
> > +		int eol = i + 1 < todo_list.nr ?
> > +			todo_list.items[i + 1].offset_in_buf :
> > +			todo_list.buf.len;
> > +
> > +		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> > +			fwrite(p, eol - bol, 1, out);
> > +		else {
> > +			const char *sha1 = shorten_sha1s ?
> > +				short_commit_name(item->commit) :
> > +				oid_to_hex(&item->commit->object.oid);
> 
> We could also use 'hash' or 'ids' here instead of 'sha1'.

Absolutely!

Thank you,
Johannes
