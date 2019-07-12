Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5B31F461
	for <e@80x24.org>; Fri, 12 Jul 2019 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfGLKpG (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 06:45:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:35325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfGLKpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 06:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562928297;
        bh=rtetGd1Hkt1KcZDMtc+9qsMAI4/zDAznYWHRx654bHg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UJ8LF32WVWw319ascm84G8RW0p5WUFbaxvngomh1rRIO0LsCQwTws71o8CVKAaaN8
         /Nlv16l2Mp7jhW/kyQfi86QZh8TnuGMQIIC/g5ipwSWMF/zCddZ5GRLhP3kH3ulO1C
         QGu7Tb00Nlm0BZMArAzbhPC8uiVqsk3+kiIlo8Lc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrJTs-1iSp2z0v08-01331y; Fri, 12
 Jul 2019 12:44:57 +0200
Date:   Fri, 12 Jul 2019 12:44:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 00/14] output improvements for git range-diff
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907121244270.47@tvgsbejvaqbjf.bet>
References: <20190708163315.29912-1-t.gummerer@gmail.com> <20190711160851.14380-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ta1HFSNC9HCVFTdNxzOKJstrDVFdaGuweqRXLAXfQ07pmM2KQVB
 1p8DirihVqdc1agSDJl5E9+kI5uLx6ad87BWE+kUPiRBT23AfP7bHxgGOB3lwH1dh4lWgt8
 zNkw0UCgdHUytjsJWNBPwQqTQNfwnXBTcnXECncIzSYJvcgXsL5tSFn6O4Qm9GrBnQb9JA+
 wSG2hKnDZXKLscnk4JcyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:scM1CX+Wk6E=:HuufjuYETX3Lo3X0IQhgSa
 pKO/ZXE0USyOdtfJ2pb0cDGVXLY9BnTw8w8RyYX1TISM0H5bgU5u3vroLMu6FAD9ipDyI5MdU
 Cih5i4pS2lHw7LmVJQiXfQdV26GJp0yeS4/coprk+lWQtULYX2ejdmWj/uQCqZSws58fc+rXH
 uVBuXOYII5ZaZZhoUrgdQ21rkU2x27F1XvYhhNRoJPYxDW7cDywsLd+IlB/Xd7Bbq0WFpvA61
 Nz4/DWWvnJTjR9hJAWP5TzgmvsIL7QzXb4lkw9pdNCEbwLwBT/amfx0OtUHTmw1PjqxBWew8V
 6xe9lC+vMIpkK+qXt/gD3SNFCqbEulnwHcHjn4dFHMrA/oHcNCRbfcZV0jq0YlzLGsfEZG5jj
 C5DtDnOYY1PwscF8XwXpWz5hf1TG6G85sfcXvbrWRcpDn1s7TGIAX4TZ8V3UCoYgIMO4/JCWR
 nUfYfZ3B1vK3MY9iD5u5oDEqqVpqZJObVquSlAZXFoWXszw90ZwPPhFKS93sJPTaCVyTiWAGY
 PjIAjza2VUKV918F+MtyZohk9SNaDK+bv29kZWpEXaUOViJKWl8l1KwrawTnUMVX47yV109Cq
 pp4cqOKYwZHwrZAUj0svsxjhT4/A8MbUbSvTgv/7C+3j15ICtQ8M0H66o4ajVdbYhHwReMMDz
 48FL6HhA/dXEf/p9L4uN5mutAFu7te1eThpzTMgHbRXSlD5F3fo2yJj4SB0J3fJQY7+sx2UX0
 4z/o63CqhrrWSvH2A5f+niMPwh9rr47q14F1vZShYUFrF/xqfxl0pne0arG9g3PgtKgfLlC0c
 DA6VGDOTEiRgEQxSR8zQnMzyKmUiSoOWPR/eGDCs9gg8X7dnBm1cTF6QMJMnjqKCxUIicAm2K
 zi39orkp9GolPFI+RlHU/lIyYS1WFJN5psu6I/iRXmfwoRyHKobcGjwgCYuuM6rAf29SwaEVe
 sVM+ZO/6V6VGR7VnZ3+OIv15hmDghXVEft1cy9r9t6eJz1m1HAwMxmclirE/pjRGxX+j6AEUp
 QaUDTJe00Ak55vysH2YWYvwtKULkhBHSUVmV6h7vCoQ+JK/+MA+3xuhyAq5qCVJw3MoQY0BKl
 PgbgXLlF8+uZNJPUuFtchyORTV+PHBF2mqe
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Thu, 11 Jul 2019, Thomas Gummerer wrote:

> Thanks Junio for the comment on the previous round [1].  This round
> reanmes the struct we're using in apply.c to 'struct gitdiff_data',
> and updates the commit message of 7/14 to reflect the new name of the
> renamed function.

Yep, and the range-diff looks good to me, too.

Thank you!
Dscho

>
> [1]: https://public-inbox.org/git/20190708163315.29912-1-t.gummerer@gmai=
l.com/
>
> Thomas Gummerer (14):
>   apply: replace marc.info link with public-inbox
>   apply: only pass required data to skip_tree_prefix
>   apply: only pass required data to git_header_name
>   apply: only pass required data to check_header_line
>   apply: only pass required data to find_name_*
>   apply: only pass required data to gitdiff_* functions
>   apply: make parse_git_diff_header public
>   range-diff: fix function parameter indentation
>   range-diff: split lines manually
>   range-diff: don't remove funcname from inner diff
>   range-diff: suppress line count in outer diff
>   range-diff: add section header instead of diff header
>   range-diff: add filename to inner diff
>   range-diff: add headers to the outer hunk header
>
>  apply.c                | 186 ++++++++++++++++++-----------------------
>  apply.h                |  48 +++++++++++
>  diff.c                 |   5 +-
>  diff.h                 |   1 +
>  range-diff.c           | 124 +++++++++++++++++++--------
>  t/t3206-range-diff.sh  | 124 ++++++++++++++++++++++-----
>  t/t3206/history.export |  84 ++++++++++++++++++-
>  7 files changed, 409 insertions(+), 163 deletions(-)
>
> Range-diff against v3:
>  1:  ef2245edda =3D  1:  ef2245edda apply: replace marc.info link with p=
ublic-inbox
>  2:  94578fa45c =3D  2:  94578fa45c apply: only pass required data to sk=
ip_tree_prefix
>  3:  988269a68e =3D  3:  988269a68e apply: only pass required data to gi=
t_header_name
>  4:  a2c1ef3f5f =3D  4:  a2c1ef3f5f apply: only pass required data to ch=
eck_header_line
>  5:  0f4cfe21cb =3D  5:  0f4cfe21cb apply: only pass required data to fi=
nd_name_*
>  6:  07a271518d !  6:  42665e5295 apply: only pass required data to gitd=
iff_* functions
>     @@ -28,7 +28,7 @@
>       #include "rerere.h"
>       #include "apply.h"
>
>     -+struct parse_git_header_state {
>     ++struct gitdiff_data {
>      +	struct strbuf *root;
>      +	int linenr;
>      +	int p_value;
>     @@ -42,7 +42,7 @@
>       }
>
>      -static int gitdiff_hdrend(struct apply_state *state,
>     -+static int gitdiff_hdrend(struct parse_git_header_state *state,
>     ++static int gitdiff_hdrend(struct gitdiff_data *state,
>       			  const char *line,
>       			  struct patch *patch)
>       {
>     @@ -51,7 +51,7 @@
>       #define DIFF_NEW_NAME 1
>
>      -static int gitdiff_verify_name(struct apply_state *state,
>     -+static int gitdiff_verify_name(struct parse_git_header_state *stat=
e,
>     ++static int gitdiff_verify_name(struct gitdiff_data *state,
>       			       const char *line,
>       			       int isnull,
>       			       char **name,
>     @@ -77,7 +77,7 @@
>       }
>
>      -static int gitdiff_oldname(struct apply_state *state,
>     -+static int gitdiff_oldname(struct parse_git_header_state *state,
>     ++static int gitdiff_oldname(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -86,7 +86,7 @@
>       }
>
>      -static int gitdiff_newname(struct apply_state *state,
>     -+static int gitdiff_newname(struct parse_git_header_state *state,
>     ++static int gitdiff_newname(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -95,7 +95,7 @@
>       }
>
>      -static int gitdiff_oldmode(struct apply_state *state,
>     -+static int gitdiff_oldmode(struct parse_git_header_state *state,
>     ++static int gitdiff_oldmode(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -103,7 +103,7 @@
>       }
>
>      -static int gitdiff_newmode(struct apply_state *state,
>     -+static int gitdiff_newmode(struct parse_git_header_state *state,
>     ++static int gitdiff_newmode(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -111,7 +111,7 @@
>       }
>
>      -static int gitdiff_delete(struct apply_state *state,
>     -+static int gitdiff_delete(struct parse_git_header_state *state,
>     ++static int gitdiff_delete(struct gitdiff_data *state,
>       			  const char *line,
>       			  struct patch *patch)
>       {
>     @@ -120,7 +120,7 @@
>       }
>
>      -static int gitdiff_newfile(struct apply_state *state,
>     -+static int gitdiff_newfile(struct parse_git_header_state *state,
>     ++static int gitdiff_newfile(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -129,7 +129,7 @@
>       }
>
>      -static int gitdiff_copysrc(struct apply_state *state,
>     -+static int gitdiff_copysrc(struct parse_git_header_state *state,
>     ++static int gitdiff_copysrc(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -141,7 +141,7 @@
>       }
>
>      -static int gitdiff_copydst(struct apply_state *state,
>     -+static int gitdiff_copydst(struct parse_git_header_state *state,
>     ++static int gitdiff_copydst(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -153,7 +153,7 @@
>       }
>
>      -static int gitdiff_renamesrc(struct apply_state *state,
>     -+static int gitdiff_renamesrc(struct parse_git_header_state *state,
>     ++static int gitdiff_renamesrc(struct gitdiff_data *state,
>       			     const char *line,
>       			     struct patch *patch)
>       {
>     @@ -165,7 +165,7 @@
>       }
>
>      -static int gitdiff_renamedst(struct apply_state *state,
>     -+static int gitdiff_renamedst(struct parse_git_header_state *state,
>     ++static int gitdiff_renamedst(struct gitdiff_data *state,
>       			     const char *line,
>       			     struct patch *patch)
>       {
>     @@ -177,7 +177,7 @@
>       }
>
>      -static int gitdiff_similarity(struct apply_state *state,
>     -+static int gitdiff_similarity(struct parse_git_header_state *state=
,
>     ++static int gitdiff_similarity(struct gitdiff_data *state,
>       			      const char *line,
>       			      struct patch *patch)
>       {
>     @@ -186,7 +186,7 @@
>       }
>
>      -static int gitdiff_dissimilarity(struct apply_state *state,
>     -+static int gitdiff_dissimilarity(struct parse_git_header_state *st=
ate,
>     ++static int gitdiff_dissimilarity(struct gitdiff_data *state,
>       				 const char *line,
>       				 struct patch *patch)
>       {
>     @@ -195,7 +195,7 @@
>       }
>
>      -static int gitdiff_index(struct apply_state *state,
>     -+static int gitdiff_index(struct parse_git_header_state *state,
>     ++static int gitdiff_index(struct gitdiff_data *state,
>       			 const char *line,
>       			 struct patch *patch)
>       {
>     @@ -204,7 +204,7 @@
>        * into the next diff. Tell the parser to break out.
>        */
>      -static int gitdiff_unrecognized(struct apply_state *state,
>     -+static int gitdiff_unrecognized(struct parse_git_header_state *sta=
te,
>     ++static int gitdiff_unrecognized(struct gitdiff_data *state,
>       				const char *line,
>       				struct patch *patch)
>       {
>     @@ -212,7 +212,7 @@
>       			    struct patch *patch)
>       {
>       	unsigned long offset;
>     -+	struct parse_git_header_state parse_hdr_state;
>     ++	struct gitdiff_data parse_hdr_state;
>
>       	/* A git diff has explicit new/delete information, so we don't gu=
ess */
>       	patch->is_new =3D 0;
>     @@ -228,7 +228,7 @@
>       		static const struct opentry {
>       			const char *str;
>      -			int (*fn)(struct apply_state *, const char *, struct patch *);
>     -+			int (*fn)(struct parse_git_header_state *, const char *, struct=
 patch *);
>     ++			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
>       		} optable[] =3D {
>       			{ "@@ -", gitdiff_hdrend },
>       			{ "--- ", gitdiff_oldname },
>  7:  9cb6732a5f !  7:  3068fda8a9 apply: make parse_git_header public
>     @@ -1,9 +1,12 @@
>      Author: Thomas Gummerer <t.gummerer@gmail.com>
>
>     -    apply: make parse_git_header public
>     +    apply: make parse_git_diff_header public
>
>     -    Make parse_git_header a "public" function in apply.h, so we can=
 re-use
>     -    it in range-diff in a subsequent commit.
>     +    Make 'parse_git_header()' (renamed to 'parse_git_diff_header()'=
) a
>     +    "public" function in apply.h, so we can re-use it in range-diff=
 in a
>     +    subsequent commit.  We're renaming the function to make it clea=
rer in
>     +    other parts of the codebase that we're talking about a diff hea=
der and
>     +    not just any header.
>
>          Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>
>     @@ -70,7 +73,7 @@
>      +			  struct patch *patch)
>       {
>       	unsigned long offset;
>     - 	struct parse_git_header_state parse_hdr_state;
>     + 	struct gitdiff_data parse_hdr_state;
>      @@
>       	 * or removing or adding empty files), so we get
>       	 * the default name from the header.
>     @@ -100,7 +103,7 @@
>      +	for (offset =3D len ; size > 0 ; offset +=3D len, size -=3D len, =
line +=3D len, (*linenr)++) {
>       		static const struct opentry {
>       			const char *str;
>     - 			int (*fn)(struct parse_git_header_state *, const char *, struct=
 patch *);
>     + 			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
>      @@
>       			res =3D p->fn(&parse_hdr_state, line + oplen, patch);
>       			if (res < 0)
>  8:  76a11ce995 =3D  8:  781d054cab range-diff: fix function parameter i=
ndentation
>  9:  6f70e7faa6 =3D  9:  68a2953310 range-diff: split lines manually
> 10:  6618cdff2c =3D 10:  8ae95d053b range-diff: don't remove funcname fr=
om inner diff
> 11:  2667df4fa5 =3D 11:  e572510c52 range-diff: suppress line count in o=
uter diff
> 12:  47cd8c6733 =3D 12:  45605db760 range-diff: add section header inste=
ad of diff header
> 13:  f67fd5dd9a =3D 13:  89a27fbeaa range-diff: add filename to inner di=
ff
> 14:  812893a5dc =3D 14:  8bee2c525f range-diff: add headers to the outer=
 hunk header
>
> --
> 2.22.0.510.g264f2c817a
>
