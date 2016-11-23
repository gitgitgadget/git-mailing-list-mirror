Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026121FF76
	for <e@80x24.org>; Wed, 23 Nov 2016 11:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935840AbcKWLlI (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 06:41:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:57614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935296AbcKWLlH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 06:41:07 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHso5-1cAKEP3VNN-003beT; Wed, 23
 Nov 2016 12:34:08 +0100
Date:   Wed, 23 Nov 2016 12:34:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] difftool: add the builtin
In-Reply-To: <20161123080850.GA23742@gmail.com>
Message-ID: <alpine.DEB.2.20.1611231210380.3746@virtualbox>
References: <cover.1479834051.git.johannes.schindelin@gmx.de> <7aec571e1b0773ca80ea25453d2650af6a18e095.1479834051.git.johannes.schindelin@gmx.de> <20161123080850.GA23742@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rC8u0sN55nLPb5M3KahNSuIuu4Q7ST2pVTAMu8ScE50rYEvEYTw
 s51n6xE6kdtYcVRBFWsadZG90yN+BX+OW3V9tvxdqLw0h5JaX3cvc+6AqHdBvVFdGX8NRMH
 ZG3dM2GWiGye3LWSevpv+LaOei1+sAGRsECd+9rqurC5JSOqR2jdy7E5Gaq7zZQKV+NoeLz
 rda2yoXBj0NEOhUIesZMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RsiHsv+XWcA=:pT460Tyf6xG9J++VRkk9UC
 1BlVbaoIFyIvwhMAPABD94ICdtpeNoXankq3eeeSQfkLg/8Ipsnb6OhowLHL157QB6ophujQr
 h0m86h4f9cdBrpUl2AJKXDdHZF0zX1H1tMjns2JyHwbHcAhxc9c3Oe+TSRYGoI4UPNemTjyr3
 7uV/4m/PLQzE41i4slPwmcPsSYji+IEnb8Zf6kgJ0W86py23oEEVe7svn011vMEPOCIzp9e6h
 sH1teK3Fd6VCKmdhxoNwpNOuC9qKwpp5b8Oho2XmEa7z4GJphjOQrweI7hu4pmtIY+oXW/xd6
 Z5Dz1+CCVOTJBxvHefLUCe56+AiAB4F4kbsYPDJLNxvbOH6CxB1VefEjWCsxTc8Qi+A+2vJxv
 vwj5CJ1xp2RFRzvmAsb2YcppquYy6EsJ8DqOejdJsMN9tX1+8PECYGuAX2Q2B3bSBTTh+RyMp
 IAAmzcJCAB/e7QTanoJEEx+qY3gnvtrDbnTeXGJpwTXXeoIuUSJJfTWHCT3CTbATU0MxNPykD
 wTk6oQXia8s6xB9Tv3nXJ1yU/hKnwwLuASAdDPCIzTyRL9kx3+9C2XyW1FgB6fZJdxFFHpcbz
 GqzUyuiByHYNY4Sdvfo/+W0iAuWKMiRJwmwC6x8h7DP343Cja2zDPyHDldRyN8oZl2+k7peKS
 zQH3WyTtuOt3QI7d87GgXXGoIyeuJALoIrJwTi8T3fR+SV2fnXLn4Gtmu26OwQTzDSH8Oz2sX
 wPrpSS2fCKeodVQwAv7xUx5r2FV+CgkvKSXYtnAjYFbujTm8CZ79J4sne7IycmnRIveRlurct
 CbtPSDR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Wed, 23 Nov 2016, David Aguilar wrote:

> On Tue, Nov 22, 2016 at 06:01:23PM +0100, Johannes Schindelin wrote:
>
> > +static const char * const builtin_difftool_usage[] = {
> > +	N_("git add [<options>] [--] <pathspec>..."),
> > +	NULL
> > +};
> 
> The usage should probably say "difftool" (or "builtin-difftool").

Ah, my dirty secret was spilled. I copy-edited this. *pours ashes over his
head*

> > [...]
> > +static void changed_files(struct hashmap *result, const char *index_path,
> > +			  const char *workdir)
> > +{
> > +[...]
> > +}
> > +
> > +#include "dir.h"
> 
> Can this mid-file #include go to the top of the file?

Yep, thanks.

In case you are interested: You probably guessed it, it was left for a
later clean-up. I worked a bit over the last weeks on getting Git to build
in Visual Studio, to be able to benefit from its quite nice features (I
was always a fan of Visual Studio, long before I started working at
Microsoft). I used the conversion of the difftool as an excuse to make use
of this myself: I did the entire conversion in Visual Studio, reverting to
the old, tedious command-line driven workflow to fix the bugs identified
by t7800-difftool.sh.

> > +static int run_dir_diff(const char *extcmd, int symlinks,
> > +			int argc, const char **argv)
> > +{
> > +	char tmpdir[PATH_MAX];
> > +	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
> > +	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;
> > +	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
> > +	struct strbuf wtdir = STRBUF_INIT;
> > +	size_t ldir_len, rdir_len, wtdir_len;
> > +	struct cache_entry *ce = xcalloc(1, sizeof(ce) + PATH_MAX + 1);
> > +	const char *workdir, *tmp;
> > +	int ret = 0, i;
> > +	FILE *fp;
> > +	struct hashmap working_tree_dups, submodules, symlinks2;
> > +	struct hashmap_iter iter;
> > +	struct pair_entry *entry;
> > +	enum object_type type;
> > +	unsigned long size;
> > +	struct index_state wtindex;
> > +	struct checkout lstate, rstate;
> > +	int rc, flags = RUN_GIT_CMD, err = 0;
> > +	struct child_process child = CHILD_PROCESS_INIT;
> > +	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
> > +	struct hashmap wt_modified, tmp_modified;
> > +	int indices_loaded = 0;
> > +
> > +	setup_work_tree();
> > +	workdir = get_git_work_tree();
> > +
> > +	/* Setup temp directories */
> > +	tmp = getenv("TMPDIR");
> > +	sprintf(tmpdir, "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
> 
> Maybe snprintf instead?
> 
> getenv() won't return anything longer than PATH_MAX for most
> users, but users are weird.

True.

> > +	if (!mkdtemp(tmpdir))
> > +		return error("could not create temporary directory");
> 
> Mention the tmpdir here?

Sure thing.

> > +	strbuf_addf(&ldir, "%s/left/", tmpdir);
> > +	strbuf_addf(&rdir, "%s/right/", tmpdir);
> > +	strbuf_addstr(&wtdir, workdir);
> > +	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
> > +		strbuf_addch(&wtdir, '/');
> > +	mkdir(ldir.buf, 0777);
> > +	mkdir(rdir.buf, 0777);
> 
> Seeing the perl mkpath() default 0777 spelled out this way
> makes me wonder whether 0700 would be safer.
> 
> The mkdtemp() above is already using 0700 so it's ok, but it
> might be worth making it consistent (later, perhaps).

Ah, of course! I stupidly imitated other `mkdir()` calls elsewhere, but
they refer to directories within the Git worktree...

> > +	/*
> > +	 * In directory diff mode, 'git-difftool--helper' is called once
> > +	 * to compare the a / b directories.In file diff mode, 'git diff'
> > +	 * will invoke a separate instance of 'git-difftool--helper' for
> > +	 * each file that changed.
> > +	 */
> 
> Missing space after "." in the comment above.

Yep. It was two spaces and I deleted one too many (we are so way past
actual print, where the two spaces may have made sense...).

> > +	if (dir_diff)
> > +		return run_dir_diff(extcmd, symlinks, argc, argv);
> > +	return run_file_diff(prompt, argc, argv);
> > +}
> > diff --git a/git.c b/git.c
> > index efa1059..eaa0f67 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -424,6 +424,7 @@ static struct cmd_struct commands[] = {
> >  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "diff-index", cmd_diff_index, RUN_SETUP },
> >  	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
> > +	{ "builtin-difftool", cmd_builtin_difftool, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "fast-export", cmd_fast_export, RUN_SETUP },
> >  	{ "fetch", cmd_fetch, RUN_SETUP },
> >  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
> 
> This isn't alphabetical anymore, but it actually is if you
> consider that the final plan is to change "builtin-difftool" to
> "difftool".

Exactly, that was my thinking.

> If we want to minimize that future diff we could name
> cmd_builtin_difftool() as cmd_difftool() for consistency now so
> that the future commit only needs to tweak the string here.

Yes!

For the record, this is a left-over from an impatient attempt at avoiding
problems with `make` overwriting the Perl version of `git difftool` by the
builtin version; I had originally assumed that a list of builtins was
generated from parsing git.c or builtin.h, but it turns out that the
BUILTIN_OBJS are actually responsible, i.e. the file name.

Fixed.

Thank you for your review!
Dscho
