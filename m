Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF5A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfJ1PwM (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:52:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:58373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfJ1PwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572277928;
        bh=lEQjB4dI4fCMd51ygLXl5FlsuSAVLNKali37xy+yZVY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ce7FEZ75IGAQg4gYaxDgP9hqgdxZw+NhcMEEWeoCpwj1OX5uufEnx9KSmsneFnS2q
         aACCXkf2GxqL16ROQOWuGJrNkZgpSwTRcgnzScz6fAWQ4nRWthD0CDCMf3fC354ypw
         CLQQ80yxaokTZ9wZQ2oIwOf7vYxbRYCiitGFeABY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1iTdZA0kym-00UnkY; Mon, 28
 Oct 2019 16:52:08 +0100
Date:   Mon, 28 Oct 2019 16:51:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 8/9] bugreport: list contents of $OBJDIR/info
In-Reply-To: <20191025025129.250049-9-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281645580.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-9-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vT5E6uoMzCYq07fl2W/0LOuTHipsHjuyXh/boPxEhJ/3GB4e6Rl
 5hKig4ujAThMToytvL0EAvCRhdovewBL+q/7x7OaOZ3J8IMLnQEWiXfdG6sRtQTTK1zwX23
 0PCb6eR304UqTKb8Yo1n80l9xmAPNAHmuSN3Zg9oFnckf4FanFinMaKQ7Qdlyvr3ZYvqHeY
 3k3Vg4ui7RzChxiLSBzKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LR7H7T9Iups=:t5u0CH8aKcJQCNq13bJ2DP
 t2p1EmKINFphUBVnngpyct2vY5YS8Idvvst1bAugcIANwAk3Fd45UHg8T01uiBIj5LMUR16de
 5pSxn6D3wwksomV5LhSiV4fd4F8zeudZe/Ykk28A2+m0usmq+AZFkAiwJvmdHScwrOBqCKQ8G
 aHsU3Z1yEHKQ+SNiME1lK0zD/Vr+AtkDI8G8EaQOmZ4whAHmVMHWc8+zHcA8NbwlYtf2UKYKA
 6IYkos9gnFxB3PXX8wbvumCYP5y/ovhl69l+ditaXKN715em764RY+L80ZeCQ1a5ZgTq0lXQU
 IN4dPgzNoKEO0+yY27RCkEib+fDs7vlqWZOroqDhvM0VIIOEDPwr9CKqlIh2y8eyLiNxFz+FU
 pVV3dsTNm3ZUqEnSMbQfCxAjKp/I9T5chGehW9FqDWp9cr6zEdBk18YLPD7rbh0qO/i+88nFT
 fmKog2TZT9240GJ+Gq2haG/gp1BVUwQOha7kuSsoOJ0fM583HOkB0FR1QLKSefbmhhx6KgIgA
 xF0sxHBGP5ueLdTl80xmbgBXXna0p6vyiH4l7+J/bdSx/QF8Nwy0ZjXvODiFWkrwkA0qDUIgU
 CB4VM7LtjirovKF480/X60nLACEEYjHpZIhornk2bXL0J/txePfWRx5bUJYpXdz9vm5ZZ4pGu
 Ld5T0rBk8T7oyApXE1bProAloZkxYy9Ru8H6J8SfWHs2bcIYyedhg/Yk4zIyBdeG/PwLBFPws
 ggOyeEGhuoTS/8uBS//OaMfB+tswJ3jQx3mFsy9E0ec8TukYL+lIgAdXz4GO8aVKU12dHS5qw
 iH+sspRjjoWcMBogeBUeM6sVOiZB7rW9yoQcW8sFXntgpBXE8+h51qz3efXKk45012zj3uNfg
 yQHIENnbIwSLYog3rSVLQKGx2iTS28XfWlOLPYZVMETmDuT7+pnOqov7Uie4aTEfUv1fhfXt2
 GBiszvdrUBBQ4Xy0SYHj7lb32tNZkOrzJ5xYDjsNB5VXoHk9dPPclH9tXF4stpjkLaXBb72Do
 ncQ14LAFszMH9BCvtZr6Q660pmCG/GNqsr3CMOGGXiTkK6CSieUaTiZrnac+pZnDx7fsGD1DU
 qh8hLVQi9bW/7RLacfbW4hNE6PzGD6z13K/0D197bOOYDowlN7ZEbRxsJMY1s/yCJD4dFj+U3
 SPb+HXyZ1ML6BJH23qAsd6YtWJyU3qTWDTk6CuuW0liBE8BIEUp/Lp199JAscwB1bJHwbcJoi
 BuW74szoj+njURCjIZlJVZf2jKJZH3nvpm6bpJgIyY4D+DkTx0lwqflQtF/8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> Miscellaneous information used about the object store can end up in
> .git/objects/info; this can help us understand what may be going on with
> the object store when the user is reporting a bug. Otherwise, it could
> be difficult to track down what is going wrong with an object which
> isn't kept locally to .git/objects/ or .git/objects/pack. Having some
> understanding of where the user's objects may be kept can save us some
> hops during the bug reporting process.

Makes sense.

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c         | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  bugreport.h         |  6 +++++
>  builtin/bugreport.c |  7 ++++++
>  3 files changed, 71 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index 79ddb8baaa..ce15904fec 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -6,6 +6,7 @@
>  #include "help.h"
>  #include "run-command.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  #include "version.h"
>
>  #include "dirent.h"
> @@ -171,6 +172,41 @@ void list_contents_of_dir(struct string_list *conte=
nts, struct strbuf *dirpath,
>  	}
>  }
>
> +/**
> + * Fills 'contents' with a list of all directories within the provided
> + * directory, recursing into each directory.
> + */
> +void list_contents_of_dir_recursively(struct string_list *contents,
> +				      struct strbuf *dirpath)
> +{
> +	struct string_list current_contents =3D STRING_LIST_INIT_DUP;
> +	struct string_list current_subdirs =3D STRING_LIST_INIT_DUP;

Rather than populating those string lists, why not write into the
`contents` directly, _while_ traversing the directories?

But if you really, really want to use string lists (hey, I'm a fan, I
introduced them to Git's source code, after all), then please make sure
to release them in the end, too.

> +	struct string_list_item *it;
> +	struct strbuf buf =3D STRBUF_INIT;
> +
> +	list_contents_of_dir(&current_contents, dirpath, 0, 0);
> +	for_each_string_list_item(it, &current_contents) {
> +		strbuf_reset(&buf);
> +		strbuf_addbuf(&buf, dirpath);
> +		strbuf_complete(&buf, '/');
> +		strbuf_addstr(&buf, it->string);

You don't need a separate `strbuf` for that: just complete `dirpath`
with a trailing slash, remember the length, then in each iteration reset
the length and append the current subdirectory name.

> +
> +		string_list_append(contents, buf.buf);
> +	}
> +
> +	list_contents_of_dir(&current_subdirs, dirpath, 1, DT_DIR);
> +	for_each_string_list_item(it, &current_subdirs) {
> +		if (strcmp(it->string, ".") =3D=3D 0
> +		    || strcmp(it->string, "..") =3D=3D 0)
> +			continue;
> +		strbuf_reset(&buf);
> +		strbuf_addbuf(&buf, dirpath);
> +		strbuf_complete(&buf, '/');
> +		strbuf_addstr(&buf, it->string);
> +
> +		list_contents_of_dir_recursively(contents, &buf);
> +	}
> +}
>
>  void get_object_counts(struct strbuf *obj_info)
>  {
> @@ -240,3 +276,25 @@ void get_packed_object_summary(struct strbuf *obj_i=
nfo)
>  		strbuf_complete_line(obj_info);
>  	}
>  }
> +
> +void get_object_info_summary(struct strbuf *obj_info)
> +{
> +	// strbuf +=3D GITDIR/info/:
> +	// recursively list contents of $GIT_OBJECT_DIRECTORY/info
> +	struct strbuf dirpath =3D STRBUF_INIT;
> +	struct string_list contents =3D STRING_LIST_INIT_DUP;
> +	struct string_list_item *entry;
> +
> +	strbuf_reset(obj_info);
> +
> +	strbuf_addstr(&dirpath, get_object_directory());
> +	strbuf_complete(&dirpath, '/');
> +	strbuf_addstr(&dirpath, "info/");
> +
> +	list_contents_of_dir_recursively(&contents, &dirpath);
> +
> +	for_each_string_list_item(entry, &contents) {
> +		strbuf_addstr(obj_info, entry->string);
> +		strbuf_complete_line(obj_info);
> +	}

As mentioned earlier, I would rather write things into `obj_info`
directly, without detouring to a string list.

Or, if you decide that you want to write to a `FILE *` anyway, I'd
rather avoid the detour to the `strbuf` altogether.

Ciao,
Dscho

> +}
> diff --git a/bugreport.h b/bugreport.h
> index 11ff7df41b..4f5e2d1b9a 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -30,3 +30,9 @@ void get_loose_object_summary(struct strbuf *obj_info)=
;
>   * hook_info will be discarded.
>   */
>  void get_packed_object_summary(struct strbuf *obj_info);
> +
> +/**
> + * Adds a list of all contents (recursively) of '.git/objects/info'. Th=
e
> + * previous contents of hook_info will be discarded.
> + */
> +void get_object_info_summary(struct strbuf *obj_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index da91a3944e..8aad33a9b0 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -72,6 +72,13 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_packed_object_summary(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Object Info Data");
> +	get_object_info_summary(&buffer);
> +	strbuf_write(&buffer, report);
> +
> +	// Close file
> +	// open file in editor
> +	launch_editor(report_path, NULL, NULL);
>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
