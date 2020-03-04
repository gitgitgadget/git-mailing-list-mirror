Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A5C3F2D7
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2FB20828
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WfPPrNXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgCDVfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:35:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:59469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgCDVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 16:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583357706;
        bh=t17rHey/p7CqDfByQrx24mLqAFibYlU6WphKMy3oBxQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WfPPrNXxqbqD8e/uGuxAw8IcD7kblVp2sTq1R/ZspiUIIozjnwPNDtqSFkpACqWPe
         7XJtuwZ1+nAGeG/zI64ruOc2kWYuk1WJsO5/ADcky076mMsd6bBIr3JooGUiDQMEJx
         VR9fSeWPr62KUcx1jLOv41apeg2fKfWBjz3ipVTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.189]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N9MpS-1jO7rR3ice-015FKr; Wed, 04 Mar 2020 22:35:05 +0100
Date:   Wed, 4 Mar 2020 22:35:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <20200302230400.107428-3-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+zm8AHgbz5UG0/r7KchUHk+mo1S6D6Mli5+Bo21QPlyC/EQEZl/
 0Pac7YfdlEFq72xVQtSF/3g28raIGHf2Ef1QJ4P3yvwoou0BxcxPAi55E+7pGCKJ8jvNRJH
 VxjLn8KNLBnEOk62xd9FWf/01HPWfGjB83vxhpwX8RD3MmTj/VQv0be76yRUoQbmMWTljSn
 2/Spgxoa1ocYHP0fDaR6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+HLkXpG8x8=:Wgu7br2eEs7QF8DzbFSZoj
 pgmg3f2b7fsXqAY+zoI1r76cwXiv/MrCzdpd6Cs8TTayb2sT4jtllIR5CcKUtLa758iuH45aJ
 woqhkS6vN91J6x/x8wq2bxVejMRWz9IZ1XZqhARxqw85nUJAlwcnVSWB7CWOslNciDMdlhNYW
 QOF6yYJOtELvm0c5dQxXXfZ4qNHbY2wO1fB4jaffY1w6ZEU/YsalAZs3WX/fj9CoLNVqPIPaU
 jhBEZh9BIIhf/a1YHwV6GfsXDUzUBTbUJmb560JhAK0OrKbwTpLcFe3R22fpvzUoS03TY//Nf
 DSxFblBIbnKzfxiQ3LB5BCOmM9qsbHjZTAL136Ebrj9ldrCf0lMNBy+4GEmQJrxvc6QaKrp1t
 Nb8AnfyRUSB52iqqMAv0teW2zJHhzey2F0TUw8F4tnlYTAEw7lLiOrWvE6y/nIwbmuYfWeBLN
 39pP15huOPxJ1Hhx3W+RAjTsBCHFKF5mVLzebZTRpLDrnCwBdJhmISVKyOldi7RUpl0QdzYB1
 jYYOBIbpyiQ4zgWFe38BYOxZxMTclG2QDsKCMUmPQcWiSp47/PN/kflpVAAcxmKfW+nJd1Vao
 ltINXFBknGdCZSFpWJQxse2sExXB/4PJK8vqzHrYHzIl+gUwEb8gjDh/r/ff2n6copuEL8cYc
 Kidn1l86wIm7PGfF7oOaZoiWJmaJba7a2th8GY1eT88MfNdLB/k0UlqS/yBJn8sBB5WzUD7Ea
 CKGYU0q+BAWZtkAWCN0tU1VFPM6GwiDz20zUtxwYNJ6OPRhs9bBmGuIYroc9TM2i6mhul+poK
 aL49OcP4Sskev8qyBtBmEZH6GeKqZ+S+xEMtoxat/TK1byK1otAiKjOXFYJomWknpiPAGXVY4
 EavT21egHNkiqnbDKJPUV9pPAE83AfgNcC1Bv5Fka2hg7nI1kRVbkET4p2gr+6oK27VZYuYif
 xQWdHej3eyvO1kyL17t6CG9zuEOGxiPBT3Rt2/LGj6wQ9Yvyg6HzSIiyxs0wPYSlv3qxsn3XQ
 yuxLdPDmkNhjIfAxImF0cDYLT54k+frYTzY1J17K7ecY2UZ18dulDxseAPQ2B7cDtNWmkXJvR
 mqpUw3WHeLkxvG8vYu6HU/PQ+kG9yCIzQjZV/FTLROc5CdxxYK9iECikYxSZt4O/J7ySif+Iw
 sKUkk4Awqt9u80o5Slx+RiVAWVvKqTiMIUS/8rXFu0WXRUJpX9I4z1tih3NM720d/IsyWO7JL
 yjJpPX7euWavEVvxa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 2 Mar 2020, Emily Shaffer wrote:

>  .gitignore                      |   1 +
>  Documentation/git-bugreport.txt |  46 ++++++++++++++
>  Makefile                        |   5 ++
>  bugreport.c                     | 105 ++++++++++++++++++++++++++++++++
>  command-list.txt                |   1 +
>  strbuf.c                        |   4 ++
>  strbuf.h                        |   1 +
>  t/t0091-bugreport.sh            |  61 +++++++++++++++++++
>  8 files changed, 224 insertions(+)
>  create mode 100644 Documentation/git-bugreport.txt
>  create mode 100644 bugreport.c
>  create mode 100755 t/t0091-bugreport.sh

Hmm. I am still _quite_ convinced that this would be much better as a
built-in. Remember, non-built-ins come with a footprint, and I do not
necessarily think that you will want to spend 3MB on a `git-bugreport`
executable when you could have it for a couple dozen kilobytes inside
`git` instead.

Ciao,
Dscho

>
> diff --git a/.gitignore b/.gitignore
> index ea97de83f3..d89bf9e11e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -25,6 +25,7 @@
>  /git-bisect--helper
>  /git-blame
>  /git-branch
> +/git-bugreport
>  /git-bundle
>  /git-cat-file
>  /git-check-attr
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugrepo=
rt.txt
> new file mode 100644
> index 0000000000..1f9fde5cde
> --- /dev/null
> +++ b/Documentation/git-bugreport.txt
> @@ -0,0 +1,46 @@
> +git-bugreport(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-bugreport - Collect information for user to file a bug report
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <fo=
rmat>]
> +
> +DESCRIPTION
> +-----------
> +Captures information about the user's machine, Git client, and reposito=
ry state,
> +as well as a form requesting information about the behavior the user ob=
served,
> +into a single text file which the user can then share, for example to t=
he Git
> +mailing list, in order to report an observed bug.
> +
> +The following information is requested from the user:
> +
> + - Reproduction steps
> + - Expected behavior
> + - Actual behavior
> +
> +This tool is invoked via the typical Git setup process, which means tha=
t in some
> +cases, it might not be able to launch - for example, if a relevant conf=
ig file
> +is unreadable. In this kind of scenario, it may be helpful to manually =
gather
> +the kind of information listed above when manually asking for help.
> +
> +OPTIONS
> +-------
> +-o <path>::
> +--output-directory <path>::
> +	Place the resulting bug report file in `<path>` instead of the root of
> +	the Git repository.
> +
> +-s <format>::
> +--suffix <format>::
> +	Specify an alternate suffix for the bugreport name, to create a file
> +	named 'git-bugreport-<formatted suffix>'. This should take the form of=
 a
> +	link:strftime[3] format string; the current local time will be used.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index c552312d3f..9e6705061d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -681,6 +681,7 @@ EXTRA_PROGRAMS =3D
>  # ... and all the rest that could be moved out of bindir to gitexecdir
>  PROGRAMS +=3D $(EXTRA_PROGRAMS)
>
> +PROGRAM_OBJS +=3D bugreport.o
>  PROGRAM_OBJS +=3D credential-store.o
>  PROGRAM_OBJS +=3D daemon.o
>  PROGRAM_OBJS +=3D fast-import.o
> @@ -2461,6 +2462,10 @@ endif
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)=
 $(LIBS)
>
> +git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)=
 \
> +		$(LIBS)
> +
>  git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLI=
BS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)=
 \
>  		$(IMAP_SEND_LDFLAGS) $(LIBS)
> diff --git a/bugreport.c b/bugreport.c
> new file mode 100644
> index 0000000000..f473d606f2
> --- /dev/null
> +++ b/bugreport.c
> @@ -0,0 +1,105 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "stdio.h"
> +#include "strbuf.h"
> +#include "time.h"
> +
> +static const char * const bugreport_usage[] =3D {
> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>=
]"),
> +	NULL
> +};
> +
> +static int get_bug_template(struct strbuf *template)
> +{
> +	const char template_text[] =3D N_(
> +"Thank you for filling out a Git bug report!\n"
> +"Please answer the following questions to help us understand your issue=
.\n"
> +"\n"
> +"What did you do before the bug happened? (Steps to reproduce your issu=
e)\n"
> +"\n"
> +"What did you expect to happen? (Expected behavior)\n"
> +"\n"
> +"What happened instead? (Actual behavior)\n"
> +"\n"
> +"What's different between what you expected and what actually happened?=
\n"
> +"\n"
> +"Anything else you want to add:\n"
> +"\n"
> +"Please review the rest of the bug report below.\n"
> +"You can delete any lines you don't wish to share.\n");
> +
> +	strbuf_addstr(template, _(template_text));
> +	return 0;
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	struct strbuf buffer =3D STRBUF_INIT;
> +	struct strbuf report_path =3D STRBUF_INIT;
> +	int report =3D -1;
> +	time_t now =3D time(NULL);
> +	char *option_output =3D NULL;
> +	char *option_suffix =3D "%F-%H%M";
> +	int nongit_ok =3D 0;
> +	const char *prefix =3D NULL;
> +	const char *user_relative_path =3D NULL;
> +
> +	const struct option bugreport_options[] =3D {
> +		OPT_STRING('o', "output-directory", &option_output, N_("path"),
> +			   N_("specify a destination for the bugreport file")),
> +		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
> +			   N_("specify a strftime format suffix for the filename")),
> +		OPT_END()
> +	};
> +
> +	prefix =3D setup_git_directory_gently(&nongit_ok);
> +
> +	argc =3D parse_options(argc, argv, prefix, bugreport_options,
> +			     bugreport_usage, 0);
> +
> +	/* Prepare the path to put the result */
> +	strbuf_addstr(&report_path,
> +		      prefix_filename(prefix,
> +				      option_output ? option_output : ""));
> +	strbuf_complete(&report_path, '/');
> +
> +	strbuf_addstr(&report_path, "git-bugreport-");
> +	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
> +	strbuf_addstr(&report_path, ".txt");
> +
> +	switch (safe_create_leading_directories(report_path.buf)) {
> +	case SCLD_OK:
> +	case SCLD_EXISTS:
> +		break;
> +	default:
> +		die(_("could not create leading directories for '%s'"),
> +		    report_path.buf);
> +	}
> +
> +	/* Prepare the report contents */
> +	get_bug_template(&buffer);
> +
> +	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> +	report =3D open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +
> +	if (report < 0) {
> +		UNLEAK(report_path);
> +		die(_("couldn't create a new file at '%s'"), report_path.buf);
> +	}
> +
> +	strbuf_write_fd(&buffer, report);
> +	close(report);
> +
> +	/*
> +	 * We want to print the path relative to the user, but we still need t=
he
> +	 * path relative to us to give to the editor.
> +	 */
> +	if (!(prefix && skip_prefix(report_path.buf, prefix, &user_relative_pa=
th)))
> +		user_relative_path =3D report_path.buf;
> +	fprintf(stderr, _("Created new report at '%s'.\n"),
> +		user_relative_path);
> +
> +	UNLEAK(buffer);
> +	UNLEAK(report_path);
> +	return !!launch_editor(report_path.buf, NULL, NULL);
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 2087894655..185e5e3f05 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -54,6 +54,7 @@ git-archive                             mainporcelain
>  git-bisect                              mainporcelain           info
>  git-blame                               ancillaryinterrogators         =
 complete
>  git-branch                              mainporcelain           history
> +git-bugreport                           ancillaryinterrogators
>  git-bundle                              mainporcelain
>  git-cat-file                            plumbinginterrogators
>  git-check-attr                          purehelpers
> diff --git a/strbuf.c b/strbuf.c
> index f19da55b07..f1d66c7848 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -539,6 +539,10 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>  }
>
> +ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
> +{
> +	return sb->len ? write(fd, sb->buf, sb->len) : 0;
> +}
>
>  #define STRBUF_MAXLINK (2*PATH_MAX)
>
> diff --git a/strbuf.h b/strbuf.h
> index aae7ac3a82..bbf6204de7 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -462,6 +462,7 @@ int strbuf_readlink(struct strbuf *sb, const char *p=
ath, size_t hint);
>   * NUL bytes.
>   */
>  ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
> +ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
>
>  /**
>   * Read a line from a FILE *, overwriting the existing contents of
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..65f664fdac
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description=3D'git bugreport'
> +
> +. ./test-lib.sh
> +
> +# Headers "[System Info]" will be followed by a non-empty line if we pu=
t some
> +# information there; we can make sure all our headers were followed by =
some
> +# information to check if the command was successful.
> +HEADER_PATTERN=3D"^\[.*\]$"
> +
> +check_all_headers_populated () {
> +	while read -r line
> +	do
> +		if test "$(grep "$HEADER_PATTERN" "$line")"
> +		then
> +			echo "$line"
> +			read -r nextline
> +			if test -z "$nextline"; then
> +				return 1;
> +			fi
> +		fi
> +	done
> +}
> +
> +test_expect_success 'creates a report with content in the right places'=
 '
> +	git bugreport -s check-headers &&
> +	check_all_headers_populated <git-bugreport-check-headers.txt &&
> +	test_when_finished rm git-bugreport-check-headers.txt
> +'
> +
> +test_expect_success 'dies if file with same name as report already exis=
ts' '
> +	>>git-bugreport-duplicate.txt &&
> +	test_must_fail git bugreport --suffix duplicate &&
> +	test_when_finished rm git-bugreport-duplicate.txt
> +'
> +
> +test_expect_success '--output-directory puts the report in the provided=
 dir' '
> +	git bugreport -o foo/ &&
> +	test_path_is_file foo/git-bugreport-* &&
> +	test_when_finished rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +	test_must_fail git bugreport --false 2>output &&
> +	test_i18ngrep usage output &&
> +	test_path_is_missing git-bugreport-*
> +'
> +
> +test_expect_success 'runs outside of a git dir' '
> +	nongit git bugreport &&
> +	test_when_finished rm non-repo/git-bugreport-*
> +'
> +
> +test_expect_success 'can create leading directories outside of a git di=
r' '
> +	nongit git bugreport -o foo/bar/baz &&
> +	test_when_finished rm -fr foo/bar/baz
> +'
> +
> +
> +test_done
> --
> 2.25.0.265.gbab2e86ba0-goog
>
>
