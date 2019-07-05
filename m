Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9471D1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 19:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGETfE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 15:35:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:55593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfGETfE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 15:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562355293;
        bh=vhZUsJARWArNHGryMnWlyVgHmVM8zpGlRamA+X2P1rM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R5caTMHM7VJyLGL/JbE3RiZyKOYsExNzsUTk5nuWyATIZSbARi97RtXwkcxAUbirf
         k+0HgTzQfJqpZePFTMgMPCceLvI6GpMCjSVc6f0do2tKl1QXqh6R43z0RiG+e/vm8H
         uBktXgyfKgJbt51Y2RqE7OmwH8780kGdKw3bBEhY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1iMNF02vFy-00n9Xd; Fri, 05
 Jul 2019 21:34:52 +0200
Date:   Fri, 5 Jul 2019 21:35:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 12/14] range-diff: add section header instead of diff
 header
In-Reply-To: <20190705170630.27500-13-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052114480.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-13-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7/9p4cfGoC2hFvHzt767dUwIcQNhAElAVPkLp0xI/MOKPNi85pO
 5VxWQWKgAipmwVcEswl7LMSixzLf4OETz6bQN+Fiak6xWGpdHQl2bXHvrO+xU/pi5obirsl
 qn8xJTUFSNh2DuDwltJm+bdANfhgbz2UKefc25l6gwklfEvu/Eo1W5ujuCvhTcg4Mly+mMs
 dqyC3SYB0IF2Smr2sa5HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uUxwuJLDmy4=:eWKyRPHz/BiIXLTmNE+1SP
 sG66nqsx8dh63wyu6B2JMPVsM7L4sqEq0X4OSttkaCv84oE9D6JrFFXXb1pM21aVtZ4TpaREE
 SM8aYrV82SKjEGbjmH9VWA41szyVUigNV4PWusG95GoHjmuUy1jffjbx3WWh7xs0z5TD6L0NT
 zZZlSoLC1N5zG880Zck1SJZ3WbFK2XCQ+QRUCetprX3HOdmgJylCcek0KsZ2bYV2bybDddl/b
 YrHIDQDvU7L0c571yDZBR6ZGCoi1vjRFovmPcUitFYbDA9QQ8RhX/K9Ws1D3yN8JFm3LbdA2v
 twnDlwlL3dvZfNTKIttGx4CZIavASYAyV/v34KHRcsayty8cm3b42hlfy3TkCXiDFvt8skidy
 B1IPNRMWqBac9+iIR75/Ub+alOfNPLheu093JifW4BP0DBDnovZrn9CBCTD3gz4EPtFI8jefg
 LkdMjUF9NohxdcKsmBF5YnR4CeTsFOuLUQEsu+JC7Yx9S87lM64jlzPZ1kvREHZ34xP52hMjG
 78vpaveCX0Io6nn1xln6Nhut7cR4VTz4Ul9m/FlAyKSncWV1kt8/sOXLn5VD5N/JFYr8+HC+m
 tcjdg1Z28Ro4kP7cYkIMU7fCsm5m8yrB/3k/SfOQgEQFjllO7pxvpNxDZ+7o7ecTdWjGELkcm
 /d2Xbwg0t/2ULlGZl15kLbcni3b7iiR7WEyx2gysLhcVJcrHRPQbeaa72FUnXXCbP2H6IXp1p
 VWlda5ddpFguHQ/8gEuR5H5o+WV+ywmOSpKoOICCC2N41RoXkZuADMZJBRZddZ4GQf+APmQpJ
 lK/vUXaVxrEuFq67VrcV33Y6u4gQxoyHh8wmX2XrevKJ1pzq07IybjvdjiBSvfiLSdFiNOMTu
 hUbgvwPPf7uhsuQ52CJZfgKyG8wUNcoViSldGaxskwAKAEzOxOmsP/LqvYIscfhecWkDZhAUm
 RH4ZMAF7svfY8gsGpQuDYakY9M+c7ZQvzCKGfE4iJ+S9KG4jzNGCz0/jLclNh7TJ9UvF2tlAp
 l7nnTIC6WaDZJ5kY7fPhWWboOJlE9QoI6T/BqcVKhkhDvlsGAhWP1x0CIf1YvQ3RZWa7edxhH
 7FErWi0NosdqEIpZe7nZ/nRecFgMZgDXPIX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> Currently range-diff keeps the diff header of the inner diff
> intact (apart from stripping lines starting with index).  This diff
> header is somewhat useful, especially when files get different
> names in different ranges.
>
> However there is no real need to keep the whole diff header for that.
> The main reason we currently do that is probably because it is easy to
> do.
>
> Introduce a new range diff hunk header, that's enclosed by "##",
> similar to how line numbers in diff hunks are enclosed by "@@", and
> give human readable information of what exactly happened to the file,
> including the file name.
>
> This improves the readability of the range-diff by giving more concise
> information to the users.  For example if a file was renamed in one
> iteration, but not in another, the diff of the headers would be quite
> noisy.  However the diff of a single line is concise and should be
> easier to understand.
>
> Additionaly, this allows us to add these range diff section headers to

s/Additionaly/Additionally/

> the outer diffs hunk headers using a custom userdiff pattern, which
> should help making the range-diff more readable.

Makes sense.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  range-diff.c           | 35 ++++++++++++----
>  t/t3206-range-diff.sh  | 91 +++++++++++++++++++++++++++++++++++++++---
>  t/t3206/history.export | 84 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 193 insertions(+), 17 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index b31fbab026..cc01f7f573 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -10,6 +10,7 @@
>  #include "commit.h"
>  #include "pretty.h"
>  #include "userdiff.h"
> +#include "apply.h"
>
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -95,12 +96,36 @@ static int read_patches(const char *range, struct st=
ring_list *list)
>  		}
>
>  		if (starts_with(line, "diff --git")) {
> +			struct patch patch;

If you append ` =3D { 0 }` (or ` =3D { NULL }`, depending on the first fie=
ld
of that struct, you don't need that `memset()` later.

> +			struct strbuf root =3D STRBUF_INIT;
> +			int linenr =3D 0;
> +
>  			in_header =3D 0;
>  			strbuf_addch(&buf, '\n');
>  			if (!util->diff_offset)
>  				util->diff_offset =3D buf.len;
> -			strbuf_addch(&buf, ' ');
> -			strbuf_addstr(&buf, line);
> +			memset(&patch, 0, sizeof(patch));
> +			line[len - 1] =3D '\n';

I guess `parse_git_header()` cannot handle lines ending in a NUL?

> +			len =3D parse_git_header(&root, &linenr, 1, line,
> +					       len, size, &patch);
> +			if (len < 0)
> +				die(_("could not parse git header"));

Maybe include the line's contents, like ` '%.*s'", (int)len, line`?

> +			strbuf_addstr(&buf, " ## ");
> +			if (patch.is_new > 0)
> +				strbuf_addf(&buf, "%s (new)", patch.new_name);
> +			else if (patch.is_delete > 0)
> +				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> +			else if (patch.is_rename)
> +				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
> +			else
> +				strbuf_addstr(&buf, patch.new_name);
> +
> +			if (patch.new_mode && patch.old_mode &&
> +			    patch.old_mode !=3D patch.new_mode)
> +				strbuf_addf(&buf, " (mode change %06o =3D> %06o)",
> +					    patch.old_mode, patch.new_mode);
> +
> +			strbuf_addstr(&buf, " ##");
>  		} else if (in_header) {
>  			if (starts_with(line, "Author: ")) {
>  				strbuf_addstr(&buf, line);
> @@ -117,17 +142,13 @@ static int read_patches(const char *range, struct =
string_list *list)
>  			if (!(p =3D strstr(p, "@@")))
>  				die(_("invalid hunk header in inner diff"));
>  			strbuf_addstr(&buf, p);
> -		} else if (!line[0] || starts_with(line, "index "))
> +		} else if (!line[0])
>  			/*
>  			 * A completely blank (not ' \n', which is context)
>  			 * line is not valid in a diff.  We skip it
>  			 * silently, because this neatly handles the blank
>  			 * separator line between commits in git-log
>  			 * output.
> -			 *
> -			 * We also want to ignore the diff's `index` lines
> -			 * because they contain exact blob hashes in which
> -			 * we are not interested.

Oh, are we interested in them again?

>  			 */
>  			continue;
>  		else if (line[0] =3D=3D '>') {
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 9f89af7178..c277756057 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -181,6 +181,85 @@ test_expect_success 'changed commit with sm config'=
 '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'renamed file' '
> +	git range-diff --no-color --submodule=3Dlog topic...renamed-file >actu=
al &&
> +	sed s/Z/\ /g >expected <<-EOF &&
> +	1:  4de457d =3D 1:  f258d75 s/5/A/
> +	2:  fccce22 ! 2:  017b62d s/4/A/
> +	    @@
> +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> +	    Z
> +	    -    s/4/A/
> +	    +    s/4/A/ + rename file
> +	    Z
> +	    - ## file ##
> +	    + ## file =3D> renamed-file ##

I guess there is no good way to suppress the `- ## file ##` line in this
case? It is a bit distracting...

> +	    Z@@
> +	    Z 1
> +	    Z 2
> +	3:  147e64e ! 3:  3ce7af6 s/11/B/
> +	    @@
> +	    Z
> +	    Z    s/11/B/
> +	    Z
> +	    - ## file ##
> +	    + ## renamed-file ##
> +	    Z@@ A
> +	    Z 8
> +	    Z 9
> +	4:  a63e992 ! 4:  1e6226b s/12/B/
> +	    @@
> +	    Z
> +	    Z    s/12/B/
> +	    Z
> +	    - ## file ##
> +	    + ## renamed-file ##
> +	    Z@@ A
> +	    Z 9
> +	    Z 10
> +	EOF
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'file added and later removed' '
> +	git range-diff --no-color --submodule=3Dlog topic...added-removed >act=
ual &&
> +	sed s/Z/\ /g >expected <<-EOF &&
> +	1:  4de457d =3D 1:  096b1ba s/5/A/
> +	2:  fccce22 ! 2:  d92e698 s/4/A/
> +	    @@
> +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> +	    Z
> +	    -    s/4/A/
> +	    +    s/4/A/ + new-file
> +	    Z
> +	    Z ## file ##
> +	    Z@@
> +	    @@
> +	    Z A
> +	    Z 6
> +	    Z 7
> +	    +
> +	    + ## new-file (new) ##
> +	3:  147e64e ! 3:  9a1db4d s/11/B/
> +	    @@
> +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> +	    Z
> +	    -    s/11/B/
> +	    +    s/11/B/ + remove file
> +	    Z
> +	    Z ## file ##
> +	    Z@@ A
> +	    @@
> +	    Z 12
> +	    Z 13
> +	    Z 14
> +	    +
> +	    + ## new-file (deleted) ##
> +	4:  a63e992 =3D 4:  fea3b5c s/12/B/
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'no commits on one side' '
>  	git commit --amend -m "new message" &&
>  	git range-diff master HEAD@{1} HEAD
> @@ -197,9 +276,9 @@ test_expect_success 'changed message' '
>  	    Z
>  	    +    Also a silly comment here!
>  	    +
> -	    Z diff --git a/file b/file
> -	    Z --- a/file
> -	    Z +++ b/file
> +	    Z ## file ##
> +	    Z@@
> +	    Z 1
>  	3:  147e64e =3D 3:  b9cb956 s/11/B/
>  	4:  a63e992 =3D 4:  8add5f1 s/12/B/
>  	EOF
> @@ -216,9 +295,9 @@ test_expect_success 'dual-coloring' '
>  	:     <RESET>
>  	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESE=
T>
>  	:    <REVERSE><GREEN>+<RESET>
> -	:      diff --git a/file b/file<RESET>
> -	:      --- a/file<RESET>
> -	:      +++ b/file<RESET>
> +	:      ## file ##<RESET>
> +	:    <CYAN> @@<RESET>
> +	:      1<RESET>

I am a bit confused where these last two lines come from all of a
sudden... They were not there before, and I do not see any code change in
this patch that would be responsible for them, either...

Could you help me understand?

>  	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YE=
LLOW> s/11/B/<RESET>
>  	:    <REVERSE><CYAN>@@<RESET>
>  	:      9<RESET>
> diff --git a/t/t3206/history.export b/t/t3206/history.export
> index b8ffff0940..7bb3814962 100644
> --- a/t/t3206/history.export
> +++ b/t/t3206/history.export
> @@ -22,8 +22,8 @@ data 51
>  19
>  20
>
> -reset refs/heads/removed
> -commit refs/heads/removed
> +reset refs/heads/renamed-file
> +commit refs/heads/renamed-file

Hmm. Is the `removed` ref no longer required by the 'removed a commit'
test case?

>  mark :2
>  author Thomas Rast <trast@inf.ethz.ch> 1374424921 +0200
>  committer Thomas Rast <trast@inf.ethz.ch> 1374484724 +0200
> @@ -599,6 +599,82 @@ s/12/B/
>  from :46
>  M 100644 :28 file
>
> -reset refs/heads/removed
> -from :47
> +commit refs/heads/added-removed
> +mark :48
> +author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574151 +0100

Neat ;-)

> +data 7
> +s/5/A/
> +from :2
> +M 100644 :3 file
> +
> +blob
> +mark :49
> +data 0
> +
> +commit refs/heads/added-removed
> +mark :50
> +author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> +data 18
> +s/4/A/ + new-file
> +from :48
> +M 100644 :5 file
> +M 100644 :49 new-file
> +
> +commit refs/heads/added-removed
> +mark :51
> +author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> +data 22
> +s/11/B/ + remove file
> +from :50
> +M 100644 :7 file
> +D new-file
> +
> +commit refs/heads/added-removed
> +mark :52
> +author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> +data 8
> +s/12/B/
> +from :51
> +M 100644 :9 file
> +
> +commit refs/heads/renamed-file
> +mark :53
> +author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574309 +0100
> +data 7
> +s/5/A/
> +from :2
> +M 100644 :3 file
> +
> +commit refs/heads/renamed-file
> +mark :54
> +author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574312 +0100
> +data 21
> +s/4/A/ + rename file
> +from :53
> +D file
> +M 100644 :5 renamed-file
> +
> +commit refs/heads/renamed-file
> +mark :55
> +author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
> +data 8
> +s/11/B/
> +from :54
> +M 100644 :7 renamed-file
> +
> +commit refs/heads/renamed-file
> +mark :56
> +author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
> +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
> +data 8
> +s/12/B/
> +from :55
> +M 100644 :9 renamed-file

I have to admit that I allowed myself not to study this script too
closely, trusting that the range-diff explains better what commit history
it creates than the fast-import script.

Thanks,
Dscho

>
> --
> 2.22.0.510.g264f2c817a
>
>
