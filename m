Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E600B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeKMC1P (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:27:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:43381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeKMC1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:27:15 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0yaB-1fUXvT1635-00v6WD; Mon, 12
 Nov 2018 17:32:32 +0100
Date:   Mon, 12 Nov 2018 17:32:29 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/5] Makefile: move long inline shell loops in
 "install" into helper
In-Reply-To: <87h8gm2w8n.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121728330.39@tvgsbejvaqbjf.bet>
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-2-avarab@gmail.com> <nycvar.QRO.7.76.6.1811121449080.39@tvgsbejvaqbjf.bet> <87h8gm2w8n.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-10631134-1542040352=:39"
X-Provags-ID: V03:K1:NtNezgMvG1QS2kdT7LFeBjOx/oxWU64Y4BMfa2f/rEhUu5IfRDd
 DLEiPzftdvuMSzkEQCiHpxtKyxx9zp1PthKRjIe2725AZZiZfHiBvpOXR7kYvggNR9DUYK7
 hMzOwhFVlgimzrmOMQM6fTUSlpKnXDHeTLL+BBgaLZQ2zdUwPSCewzHwOEwl08OSw1NFmSZ
 Qt4U/5u80B8nG1/t41wQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:535rBHxXXx8=:LjTR+OFSrG/2dudcY2QqGa
 FeU7ioSYKZy/eJUiPGWx21oVdizGgKKEs9KfnICZxi3ATadXS/bSIR3UC3nW1NrMcZ/gVmZMO
 omE21MHzwUD/DAcL8bil6Ekxi7bVROUmP3GuqsnJoS+jDni/HGd2QrfbpdOhIYvLegKduqV0A
 HHb2Ja6sanp0mTytf7MUPEBx/KFIxI/1gcffNKRpmGjJwCU7ynqQULd0wFx4vSG3WbUfwxiXO
 S7lIffGcKiugzlLvrxieSCTcRWUmz79mpa66EFRK8mKIJk5MlWBIyICiH47SVWszRwpD4nrbq
 XtjWxcu8qdNGQ0zkh026eWvh9KgtAuFd17Ui4ouh6IxEXxQcJmov+QuRJ8NwU/cKns5/IwG13
 BiM7Z3LSVYyL9TN1gODpspbVGicdt3DBI5Y3fKAiApByqKk/nYyD8BcJhK82ra28x/sUOBFRu
 NbfHuE2KmCjKNj0yhdhLLL1vUFYWGtWPTA2Afdkwmm27f7JufAkW6caiKs0f8pn94AcPMeVcg
 4kuJSpLeObYpPnSoho1dNCYxhv4yLQp/H8fKroH/4LFq8+GvxXDEsDpqSq+Jfb8ZD5umWIeoz
 hNr7f2MJaV4bCsPzNzs68nrlNMhcEqy+ym+54B696RJYLlXXyAsP/kS7SFx0H1kkrX84b1nMN
 CwS5mgfvbcqyRPP5MWRDGTZXBdRkfru7hGNiH/tbVvmLucowk/8F6W2DCZXmwGZghnmzUxJju
 1tS5gB9puqqJvxpGS0fye5+2sZ48Pf8TJrM3ABP27Zjuhc/nn7QW0QP2uBiiWjnbpPlrqYtVk
 KXgBZKSUBTjZnMw9sVZBrjvfSZl2Dus3vfQsXXRyeOxZTkoEVYAtbpr78daD5E6UdbbJoOIdF
 USQTxikmUHNqSL/WookKlhppg2ycV0dHyJ/oesoktXgGuZZkvSOc4nffbuiTG1cNY7+ehzJC/
 8Li0jCmzr4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-10631134-1542040352=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Mon, 12 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Nov 12 2018, Johannes Schindelin wrote:
> 
> > On Fri, 2 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> >
> >> Move a 37 line for-loop mess out of "install" and into a helper
> >> script. This started out fairly innocent but over the years has grown
> >> into a hard-to-maintain monster, and my recent ad874608d8 ("Makefile:
> >> optionally symlink libexec/git-core binaries to bin/git", 2018-03-13)
> >> certainly didn't help.
> >>
> >> The shell code is ported pretty much as-is (with getopts added), it'll
> >> be fixed & prettified in subsequent commits.
> >>
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  Makefile         | 52 ++++++++--------------------
> >>  install_programs | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 103 insertions(+), 38 deletions(-)
> >>  create mode 100755 install_programs
> >>
> >> diff --git a/Makefile b/Makefile
> >> index bbfbb4292d..aa6ca1fa68 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -2808,44 +2808,20 @@ endif
> >>  	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
> >>  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
> >>  	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
> >> -	{ test "$$bindir/" = "$$execdir/" || \
> >> -	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
> >> -		$(RM) "$$execdir/$$p" && \
> >> -		test -n "$(INSTALL_SYMLINKS)" && \
> >> -		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
> >> -		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
> >> -		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
> >> -		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
> >> -	  done; \
> >> -	} && \
> >> -	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
> >> -		$(RM) "$$bindir/$$p" && \
> >> -		test -n "$(INSTALL_SYMLINKS)" && \
> >> -		ln -s "git$X" "$$bindir/$$p" || \
> >> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> >> -		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> >> -		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> >> -		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
> >> -	done && \
> >> -	for p in $(BUILT_INS); do \
> >> -		$(RM) "$$execdir/$$p" && \
> >> -		test -n "$(INSTALL_SYMLINKS)" && \
> >> -		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
> >> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> >> -		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
> >> -		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
> >> -		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
> >> -	done && \
> >> -	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
> >> -	for p in $$remote_curl_aliases; do \
> >> -		$(RM) "$$execdir/$$p" && \
> >> -		test -n "$(INSTALL_SYMLINKS)" && \
> >> -		ln -s "git-remote-http$X" "$$execdir/$$p" || \
> >> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> >> -		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
> >> -		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
> >> -		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
> >> -	done && \
> >
> > This indeed looks like a mess...
> >
> >> +	./install_programs \
> >> +		--X="$$X" \
> >> +		--RM="$(RM)" \
> >> +		--bindir="$$bindir" \
> >> +		--bindir-relative="$(bindir_relative_SQ)" \
> >> +		--execdir="$$execdir" \
> >> +		--destdir-from-execdir="$$destdir_from_execdir_SQ" \
> >> +		--flag-install-symlinks="$(INSTALL_SYMLINKS)" \
> >> +		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
> >> +		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
> >> +		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
> >> +		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
> >> +		--list-execdir-git-dashed="$(BUILT_INS)" \
> >> +		--list-execdir-curl-aliases="$(REMOTE_CURL_ALIASES)" && \
> >>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
> >>
> >>  .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
> >> diff --git a/install_programs b/install_programs
> >> new file mode 100755
> >> index 0000000000..e287108112
> >> --- /dev/null
> >> +++ b/install_programs
> >> @@ -0,0 +1,89 @@
> >> +#!/bin/sh
> >> +
> >> +while test $# != 0
> >> +do
> >> +	case "$1" in
> >> +	--X=*)
> >> +		X="${1#--X=}"
> >> +		;;
> >> +	--RM=*)
> >> +		RM="${1#--RM=}"
> >> +		;;
> >> +	--bindir=*)
> >> +		bindir="${1#--bindir=}"
> >> +		;;
> >> +	--bindir-relative=*)
> >> +		bindir_relative="${1#--bindir-relative=}"
> >> +		;;
> >> +	--execdir=*)
> >> +		execdir="${1#--execdir=}"
> >> +		;;
> >> +	--destdir-from-execdir=*)
> >> +		destdir_from_execdir="${1#--destdir-from-execdir=}"
> >> +		;;
> >> +	--flag-install-symlinks=*)
> >> +		INSTALL_SYMLINKS="${1#--flag-install-symlinks=}"
> >> +		;;
> >> +	--flag-no-install-hardlinks=*)
> >> +		NO_INSTALL_HARDLINKS="${1#--flag-no-install-hardlinks=}"
> >> +		;;
> >> +	--flag-no-cross-directory-hardlinks=*)
> >> +		NO_CROSS_DIRECTORY_HARDLINKS="${1#--flag-no-cross-directory-hardlinks=}"
> >> +		;;
> >> +	--list-bindir-standalone=*)
> >> +		list_bindir_standalone="${1#--list-bindir-standalone=}"
> >> +		;;
> >> +	--list-bindir-git-dashed=*)
> >> +		list_bindir_git_dashed="${1#--list-bindir-git-dashed=}"
> >> +		;;
> >> +	--list-execdir-git-dashed=*)
> >> +		list_execdir_git_dashed="${1#--list-execdir-git-dashed=}"
> >> +		;;
> >> +	--list-execdir-curl-aliases=*)
> >> +		list_execdir_curl_aliases="${1#--list-execdir-curl-aliases=}"
> >> +		;;
> >> +
> >> +	*)
> >> +		echo "Unknown option $1"
> >> +		exit 1
> >> +		;;
> >> +	esac
> >> +	shift
> >> +done &&
> >> +{ test "$bindir/" = "$execdir/" ||
> >> +  for p in $list_bindir_standalone; do
> >> +	$RM "$execdir/$p" &&
> >> +	test -n "$INSTALL_SYMLINKS" &&
> >> +	ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
> >> +	{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
> >> +	  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
> >> +	  cp "$bindir/$p" "$execdir/$p" || exit; }
> >> +  done;
> >> +} &&
> >> +for p in $list_bindir_git_dashed; do
> >> +	$RM "$bindir/$p" &&
> >> +	test -n "$INSTALL_SYMLINKS" &&
> >> +	ln -s "git$X" "$bindir/$p" ||
> >> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
> >> +	  ln "$bindir/git$X" "$bindir/$p" 2>/dev/null ||
> >> +	  ln -s "git$X" "$bindir/$p" 2>/dev/null ||
> >> +	  cp "$bindir/git$X" "$bindir/$p" || exit; }
> >> +done &&
> >> +for p in $list_execdir_git_dashed; do
> >> +	$RM "$execdir/$p" &&
> >> +	test -n "$INSTALL_SYMLINKS" &&
> >> +	ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
> >> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
> >> +	  ln "$execdir/git$X" "$execdir/$p" 2>/dev/null ||
> >> +	  ln -s "git$X" "$execdir/$p" 2>/dev/null ||
> >> +	  cp "$execdir/git$X" "$execdir/$p" || exit; }
> >> +done &&
> >> +for p in $list_execdir_curl_aliases; do
> >> +	$RM "$execdir/$p" &&
> >> +	test -n "$INSTALL_SYMLINKS" &&
> >> +	ln -s "git-remote-http$X" "$execdir/$p" ||
> >> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
> >> +	  ln "$execdir/git-remote-http$X" "$execdir/$p" 2>/dev/null ||
> >> +	  ln -s "git-remote-http$X" "$execdir/$p" 2>/dev/null ||
> >> +	  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
> >> +done
> >
> > ... but so does this. I would be very surprised if these four very
> > similar-looking constructs could not be refactored into a single shell
> > script that is then called four times with different parameters.
> >
> > Something like
> >
> > 	#!/bin/sh
> >
> > 	from=
> > 	while case "$1" in
> > 	--no-hardlinks)
> > 		NO_INSTALL_HARDLINKS=t
> > 		;;
> > 	--from=*)
> > 		from="${1#*=}"
> > 		;;
> > 	*)
> > 		break
> > 		;;
> > 	esac; do
> > 		shift
> > 	done
> >
> > 	test $# -gt 3 || {
> > 		echo "Usage: $0 [--no-hardlinks] <from-dir> <to-dir> <file>..." >&2
> > 		exit 1
> > 	}
> >
> > 	fromdir="$1"
> > 	todir="$2"
> > 	shift
> > 	shift
> >
> > 	for p in "$@"
> > 	do
> > 		$RM "$todir/$p" &&
> > 		test -n "$INSTALL_SYMLINKS" &&
> > 		ln -s "$fromdir/${from:-$p}" "$todir/$p" ||
> > 		{ test -z "$NO_INSTALL_HARDLINKS" &&
> > 		  ln "$fromdir/${from:-$p}" "$todir/$p" ||
> > 		  ln -s "$fromdir/${from:-$p}" "$todir/$p" ||
> > 		  cp "$fromdir/${from:-$p}" "$todir/$p" || exit; }
> > 	done
> >
> > and then calling it using
> >
> > 	test "$bindir/" = "$execdir/" ||
> > 	link-or-copy ${NO_CROSS_DIRECTORY_HARDLINKS:+--no-hardlinks} \
> > 		"$bindir" "$execdir" $list_bindir_standalone
> > 	link-or-copy --from=git$X "$bindir" "$bindir" $list_bindir_git_dashed
> > 	link-or-copy --from=git$X "$bindir" "$execdir" $list_bindir_git_dashed
> > 	link-or-copy --from=git-remote-http$X "$bindir" "$execdir" $list_execdir_curl_aliases
> >
> > That would at least DRY up this mess a bit.
> 
> I'll try for a non-RFC re-submission of this which won't have the 5/5
> NO_INSTALL_BUILTIN_EXECDIR_ALIASES (for now) which'll hopefully be ready
> for inclusion.
> 
> I tried to fold up some of these special cases into one thing before,
> but managing the exceptions gets messier to read in my opinion than just
> having some duplication.
> 
> But more to the point, between your suggestion and Junio's to do all of
> this with some make construct: Yeah we should make it awesome, but I
> think a logical first step for a patch series like this is to just as-is
> use the existing logic we have now with some minor fixes for bugs.
> 
> We can refactor this later, I'm mainly interested in moving this over to
> a *.sh first so that process is less of a mess, fixing some minor bugs,
> and not getting a first iteration of improvements stuck on a much bigger
> review for "I rewrote the way the whole install process works" series.

Did you seen any mistake in my version? Because if you didn't, then it
would be unfortunate to leave this technical debt unaddressed. Just moving
the mess really does nothing to address it, and my version should be
almost there to actually do address the mess.

Ciao,
Dscho
--8323328-10631134-1542040352=:39--
