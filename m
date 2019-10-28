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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7978D1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfJ1MCP (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:02:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:49527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfJ1MCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572264125;
        bh=zmONQm+OL+F0h1/PG+pmZneRaxCxo+mjksxxwdaU6aI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dXHiJAevqdqJf9i4sPWufGvvjN9daUqXQ5JSRagyyTZ/ztLPV4V4e0FBzF3L6hJcs
         sUP0O+MaYul7JriyiC+pi61+QUy1NdzQn8tm8hjtX5FmqeEiLlbd0Nm2TzY6S4uTRZ
         ncEhd3rLj57cdFm91wsHjE6wOZ89PmaLZxCAFn8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1i4TpP33By-00yChN; Mon, 28
 Oct 2019 13:02:05 +0100
Date:   Mon, 28 Oct 2019 13:01:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
In-Reply-To: <20191022160105.GE4348@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910281225260.46@tvgsbejvaqbjf.bet>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com> <pull.401.v3.git.1571694882.gitgitgadget@gmail.com> <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com> <20191022160105.GE4348@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2033524033-1572264125=:46"
X-Provags-ID: V03:K1:xcQkN9276l76yiWjHkRZVlzr1Nmd7xbScto0KLe2dID8LYcwGra
 Lv7cV0Z7oy/C1oU+0e3oa62VKYHHHyOTtMxILXcNJp/7L3gl1z/SDzosNk6VOz4Cd1JO8+S
 JA/vNeI4Wqf2prkd8rUNTZyr/rsbGyesi2tye+Wb9EFupCrIZYV+G7c8RXQwW9Qx0JCIqNV
 on/TtVmEWnxwL8t98MKWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g89UezQ1t58=:4GxNDZjnku6mvn4rVI3ZyR
 NcgBq2bM0pEWMEh0kcN9v2KNPwIR7XJmHz1wk28NNAdAS/X5fZvdxX+zOvNjs4c6y+jYLetPb
 ZfNh/LR1lqAy48ILAupQRzKmWMbj7xtywUu0ZNxtdouyhQoYUhYh9kcC3dt1+7epEDXBs4Lf4
 FE34ebmerfmLyUbFv5TxRntB5iJd7JEMO8/IBywQ97nu9nV/0jWtZDRVj2T5DwkAn4HHFK8LJ
 eekP37AG5UV9ZMlyE5/ULZj9Pq7eKjXZU4Z/SGjnDd+PqfbpZ8LFEBddyUGaGYm84Cvath0hm
 7dkpkKZIm1HAVU+ghqrn7Mn1ZzfDK3Titu8oBkiYJ/6Cl0Iz4idWcDJn2j78F6GVdF2IYJQWb
 XGnfzVK8WCssRI2Y2zD8zfPulU0fQdh0MMYp0y5F6zkovYt3ThWTPxdHX2yZx9UEk/ZgoCPok
 tbKn2FcROk3eBFVAZmzsJNY1owMFegIxnWGZywLeCRgXW+DjsSpo+2tE66b8QqQawy9xqHd4K
 5iLlLrB43tjY6NYuglt0+zIcAvm1SzOkFfuBolESK4/uAsjWl+5PluBvypZLaHtmH6sfIL5VN
 /UlP1oNMVWW2UiQBAARBrw3uAU3ZyT/WSnhBSlKVoIbDwn1C9ukTSmtBlNb/748MmPdpDldma
 4eUD8q80vepAwXDjYjtoU5y+q1v1k5akvetTfgScI3nQsYhw90BDjCajV6l6lA5YOq39TkltU
 mP7OdqQjj2lSTzNJPrn3XDWXK2InowDURQgG7/FSAsrkjAhsMaQkF6ewIWYNFidG97Kg+dQEx
 zPf+oiFRP3tkarEFxYEa47+TEQmUgcp/3j7HwKLsoB6FGCX3f5VONH2m/h3meSbaC+T6xo7gO
 mlBZ5THluHMYMWVeAeQtEiAvGT5O7vc2T9L07P8835OFVg7QScoPmLA0j9Ch66JdxHCLofSRA
 byX4xNlB3QbTBmm1J6C8eOawFuyGj5hpqLHZAB3Rx8CQ8UrulLUbFhtGtmkgVPMFVP8wsapQw
 lIoOQlBsDuUrC3n1e4Aoi0cuVd7GuWnc1WvMujS8clk4WhGI1+DT7pF+6BLsikVDPYlHJzXZo
 vmKmt0W7qJA2Fn8lAhOhcGeHB2vglx0A5ONJH8ayqOJXMPYvgaDkj9aSLEwtItBQRxR8fCFLY
 SuspHW7rpYn6zQv+gj8lZmoVHpiyp2relN9CET8SLrNPtWvDJ0ZqFZ/pNiXpxpIKyqE0pR0U5
 U4nDrwkbJuerPZ719oxwqV8C01jHcfbwgthEOBWKRvdN2tPQy+4TWgMOEQlg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2033524033-1572264125=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 22 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Oct 21, 2019 at 09:54:42PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Ever since worktrees were introduced, the `git_path()` function _reall=
y_
> > needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
> > specific to the worktree, and therefore so is its reflog). However, th=
e
> > wrong path is returned for `logs/HEAD.lock`.
> >
> > This does not matter as long as the Git executable is doing the asking=
,
> > as the path for that `logs/HEAD.lock` file is constructed from
> > `git_path("logs/HEAD")` by appending the `.lock` suffix.
> >
> > However, Git GUI just learned to use `--git-path` instead of appending
> > relative paths to what `git rev-parse --git-dir` returns (and as a
> > consequence not only using the correct hooks directory, but also using
> > the correct paths in worktrees other than the main one). While it does
> > not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
> > let's be safe rather than sorry.
> >
> > Side note: Git GUI _does_ ask for `index.lock`, but that is already
> > resolved correctly, due to `update_common_dir()` preferring to leave
> > unknown paths in the (worktree-specific) git directory.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  path.c               |  8 +++++++-
> >  t/t1500-rev-parse.sh | 15 +++++++++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/path.c b/path.c
> > index e3da1f3c4e..5ff64e7a8a 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -349,10 +349,16 @@ static int check_common(const char *unmatched, v=
oid *value, void *baton)
> >  static void update_common_dir(struct strbuf *buf, int git_dir_len,
> >  			      const char *common_dir)
> >  {
> > -	char *base =3D buf->buf + git_dir_len;
> > +	char *base =3D buf->buf + git_dir_len, *base2 =3D NULL;
> > +
> > +	if (ends_with(base, ".lock"))
> > +		base =3D base2 =3D xstrndup(base, strlen(base) - 5);
>
> Hm, this adds the magic number 5 and calls strlen(base) twice, because
> ends_with() calls strip_suffix(), which calls strlen().  Calling
> strip_suffix() directly would allow us to avoid the magic number and
> the second strlen():
>
>   size_t len;
>   if (strip_suffix(base, ".lock", &len))
>           base =3D base2 =3D xstrndup(base, len);

Actually, we should probably avoid the extra allocation. Earlier, I was
concerned about multi-threading issues when attempting to modify the
`strbuf`. But then, we modify that `strbuf` a couple of lines later
anyway, so my fears were totally unfounded. Therefore, my current
version reads like this:

=2D- snip --
	int has_lock_suffix =3D strbuf_strip_suffix(buf, LOCK_SUFFIX);

	init_common_trie();
	if (trie_find(&common_trie, base, check_common, NULL) > 0)
		replace_dir(buf, git_dir_len, common_dir);

	if (has_lock_suffix)
		strbuf_addstr(buf, LOCK_SUFFIX);
=2D- snap --


>
> >  	init_common_trie();
> >  	if (trie_find(&common_trie, base, check_common, NULL) > 0)
> >  		replace_dir(buf, git_dir_len, common_dir);
> > +
> > +	free(base2);
> >  }
> >
> >  void report_linked_checkout_garbage(void)
> > diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> > index 01abee533d..d318a1eeef 100755
> > --- a/t/t1500-rev-parse.sh
> > +++ b/t/t1500-rev-parse.sh
> > @@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'git-path in worktree' '
> > +	test_tick &&
> > +	git commit --allow-empty -m empty &&
> > +	git worktree add --detach wt &&
> > +	test_write_lines >expect \
> > +		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
> > +		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
> > +		"$(pwd)/.git/worktrees/wt/index" \
> > +		"$(pwd)/.git/worktrees/wt/index.lock" &&
> > +	git -C wt rev-parse >actual \
> > +		--git-path logs/HEAD --git-path logs/HEAD.lock \
> > +		--git-path index --git-path index.lock &&
> > +	test_cmp expect actual
> > +'
>
> I think this test better fits into 't0060-path-utils.sh': it already
> checks 'logs/HEAD' and 'index' in a different working tree (well, with
> GIT_COMMON_DIR set, but that's the same), and it has a helper function
> to make each of the two new .lock tests a one-liner.

Excellent point. Thank you for helping me improve the patch!

Ciao,
Dscho

>
> >  test_expect_success 'rev-parse --is-shallow-repository in shallow rep=
o' '
> >  	test_commit test_commit &&
> >  	echo true >expect &&
> > --
> > gitgitgadget
>

--8323328-2033524033-1572264125=:46--
