Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CE21F462
	for <e@80x24.org>; Fri, 31 May 2019 20:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfEaUPZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:15:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:44439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfEaUPY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 16:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559333714;
        bh=9fjoU8UuQVXoTTPx0cezASNLwkli12HuAjgqNjY0qC4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Edd/ekQOpVAXVdnmPE0emvOViZ7XJZOM8Eq8HksI6zKPgvcoUCtCtkQM5/hENeE0V
         xOzmJHX4uFW5VOBXZjbqFY6o8T6xwSK8deTvOWd99W3S2gVcXNwCRd6W1+LmUSWeKo
         skBqxH5fX5rt7rYuj2L0aFIpUa9OJYkxsoOHfxV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVsUW-1h4JlC2HPs-00X0ul; Fri, 31
 May 2019 22:15:14 +0200
Date:   Fri, 31 May 2019 22:14:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: learn the "onbranch:" includeIf condition
In-Reply-To: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905312214331.1775@tvgsbejvaqbjf.bet>
References: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com> <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J8a8Uc5YU2h1kDCTJOzNatd7w5UcCn15Zg2A2XY2rCVn5RpZdGF
 X6loYiFCKiYZJyUr2KbLx1Oy+rc39eJb1MrlfMuV5yVzErWyNV54uYefasFlvKRTmU2vTzY
 ApAjECANarF01lKu+87TV8ar7ieMiaOGgNy5gFvefcTS/ADy3eBlusfAprazn4QMqXF63CB
 zV1dOcfIACIUkO8WZJ0QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:McsQtRCDyEY=:iuhf596NvGOKb18ISbVmo5
 kiNU2x4XreebtoP0kmDt7RqjV/kKaMLf2WPUsUdOuO3wO3l3yCNNxYExzwFhihjZxwLnaHu0H
 LRvMvn9ZfzE+yMFcT9IMs+NjvR6Fu7t36YqttCVJlSAxIkh8eKvhcQR1UKnin1HaKu/nfesRe
 LZ6MZLgzoiCVRLlbJFr2lNd0hyxdvUk003xXlGzlAxbFx74Wsthdy8UFAK+F2L6AMAvkzJxFo
 HpErM3hYqY3vhASgr/l1E2qPIUq/k8vV43/Z8TAJozcPFpJvvh1OaQ5VK/k1dPbka1cTaAoNO
 aDjx7pkc3Xb1Zl8/Oy8yz/3ZHGiBoztwmW2hA/6O3V4ag+mFIq63VCGuIH0ngOJ3oOTJpRHUO
 UPvJiI4WrbJu+Z3gk3XSY1B3Uhxf3PPQg26bt1Faj2VMq79f6/zoxn77yWr5OM9EhSvNdJVpO
 Yg2qBNXELF6XcX3HfNED21+zlOMRFszxZ86MnQQM/LcTqlgz/hk19/yMX3XshSA9zzx5NLylZ
 G8RiVGBV4rTTdXB3lXKFX3aVMRLwApsMthrGLFly8E1NjLexZeqsk4NycdUQbZ7aVXPDpnVL6
 VxkdFBqn9Z76hR08sKHoR37C+tYCJQd2mecSYNVK5wvvx8cl6Fd3OE9VNZsS00piuSWoopfUh
 Ml94AJlhElsVniltOuwpQ+SkWXS3MHCTx6ZSZX+clj7GpaoNnJDzvXgLkYC04BP6DpkLhtqUX
 dIdyuE+/ScHHapETWnlKXw5MESeX4jKuw0cIwOT2YZxbWc+SRL0rz0pxouQveag+MVT8wm5Wp
 6tvFPjK+DZpCN1d5bhXjaP8rRYnsYKsmtMwxV682zeA6MkGg7lVijPPeXbxqYmPG0FRFfjdVf
 LmttB+TCILqvQu3DEJMym9BpBXeFe339AVYZXA2XVjboVf2ED+EQU8/BI7B54Yek3RHzUipRF
 zo5ON8cAuYV9s/SNb/+fuv9IXvovLCWT8JCKDac9t0s3a5kW65WDQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, 31 May 2019, Denton Liu wrote:

> Currently, if a user wishes to have individual settings per branch, they
> are required to manually keep track of the settings in their head and
> manually set the options on the command-line or change the config at
> each branch.
>
> Teach config the "onbranch:" includeIf condition so that it can
> conditionally include configuration files if the branch that is checked
> out in the current worktree matches the pattern given.

This looks good to me.

Thanks,
Dscho

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Thanks for taking a look, Johannes. I've modified the patch to match
> with wildcards now.
>
> Changes since v1:
>
> * Allow onbranch: to specify a pattern instead of just a static
>   comparison
>
> Interdiff against v1:
>   diff --git a/Documentation/config.txt b/Documentation/config.txt
>   index 3b9fbe1860..93aa4323c6 100644
>   --- a/Documentation/config.txt
>   +++ b/Documentation/config.txt
>   @@ -145,9 +145,11 @@ refer to linkgit:gitignore[5] for details. For co=
nvenience:
>    	case-insensitively (e.g. on case-insensitive file sytems)
>
>    `onbranch`::
>   -	The data that follows the keyword `onbranch:` is taken to be a
>   -	name of a local branch. If we are in a worktree where that
>   -	branch is currently checked out, the include condition is met.
>   +	The data that follows the keyword `onbranch:` is taken to be a patte=
rn
>   +	with standard globbing wildcards and two additional ones, `**/` and
>   +	`/**`, that can match multiple path components. If we are in a workt=
ree
>   +	where the name of the branch that is currently checked out matches t=
he
>   +	pattern, the include condition is met.
>
>    A few more notes on matching via `gitdir` and `gitdir/i`:
>
>   diff --git a/config.c b/config.c
>   index 954e84e13a..48bb435739 100644
>   --- a/config.c
>   +++ b/config.c
>   @@ -268,6 +268,8 @@ static int include_by_gitdir(const struct config_o=
ptions *opts,
>    static int include_by_branch(const char *cond, size_t cond_len)
>    {
>    	int flags;
>   +	int ret;
>   +	struct strbuf pattern =3D STRBUF_INIT;
>    	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>    	const char *shortname;
>
>   @@ -275,7 +277,10 @@ static int include_by_branch(const char *cond, si=
ze_t cond_len)
>    			!skip_prefix(refname, "refs/heads/", &shortname))
>    		return 0;
>
>   -	return !strncmp(cond, shortname, cond_len);
>   +	strbuf_add(&pattern, cond, cond_len);
>   +	ret =3D !wildmatch(pattern.buf, shortname, WM_PATHNAME);
>   +	strbuf_release(&pattern);
>   +	return ret;
>    }
>
>    static int include_condition_is_true(const struct config_options *opt=
s,
>   diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
>   index 062db08ad9..05c7def1f2 100755
>   --- a/t/t1305-config-include.sh
>   +++ b/t/t1305-config-include.sh
>   @@ -314,6 +314,7 @@ test_expect_success 'conditional include, onbranch=
' '
>    		cd bar &&
>    		echo "[includeIf \"onbranch:foo-branch\"]path=3Dbar9" >>.git/config=
 &&
>    		echo "[test]nine=3D9" >.git/bar9 &&
>   +		git checkout -b master &&
>    		test_must_fail git config test.nine &&
>    		git checkout -b foo-branch &&
>    		echo 9 >expect &&
>   @@ -322,6 +323,25 @@ test_expect_success 'conditional include, onbranc=
h' '
>    	)
>    '
>
>   +test_expect_success 'conditional include, onbranch, wildcard' '
>   +	(
>   +		cd bar &&
>   +		echo "[includeIf \"onbranch:?oo-*/**\"]path=3Dbar10" >>.git/config =
&&
>   +		echo "[test]ten=3D10" >.git/bar10 &&
>   +		git checkout -b not-foo-branch/a &&
>   +		test_must_fail git config test.ten &&
>   +
>   +		echo 10 >expect &&
>   +		git checkout -b foo-branch/a/b/c &&
>   +		git config test.ten >actual &&
>   +		test_cmp expect actual &&
>   +
>   +		git checkout -b moo-bar/a &&
>   +		git config test.ten >actual &&
>   +		test_cmp expect actual
>   +	)
>   +'
>   +
>    test_expect_success 'include cycles are detected' '
>    	cat >.gitconfig <<-\EOF &&
>    	[test]value =3D gitconfig
>
>  Documentation/config.txt  | 12 ++++++++++++
>  config.c                  | 21 +++++++++++++++++++++
>  t/t1305-config-include.sh | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7e2a6f61f5..93aa4323c6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -144,6 +144,13 @@ refer to linkgit:gitignore[5] for details. For conv=
enience:
>  	This is the same as `gitdir` except that matching is done
>  	case-insensitively (e.g. on case-insensitive file sytems)
>
> +`onbranch`::
> +	The data that follows the keyword `onbranch:` is taken to be a pattern
> +	with standard globbing wildcards and two additional ones, `**/` and
> +	`/**`, that can match multiple path components. If we are in a worktre=
e
> +	where the name of the branch that is currently checked out matches the
> +	pattern, the include condition is met.
> +
>  A few more notes on matching via `gitdir` and `gitdir/i`:
>
>   * Symlinks in `$GIT_DIR` are not resolved before matching.
> @@ -206,6 +213,11 @@ Example
>  	[includeIf "gitdir:/path/to/group/"]
>  		path =3D foo.inc
>
> +	; include only if we are in a worktree where foo-branch is
> +	; currently checked out
> +	[includeIf "onbranch:foo-branch"]
> +		path =3D foo.inc
> +
>  Values
>  ~~~~~~
>
> diff --git a/config.c b/config.c
> index 296a6d9cc4..48bb435739 100644
> --- a/config.c
> +++ b/config.c
> @@ -19,6 +19,7 @@
>  #include "utf8.h"
>  #include "dir.h"
>  #include "color.h"
> +#include "refs.h"
>
>  struct config_source {
>  	struct config_source *prev;
> @@ -264,6 +265,24 @@ static int include_by_gitdir(const struct config_op=
tions *opts,
>  	return ret;
>  }
>
> +static int include_by_branch(const char *cond, size_t cond_len)
> +{
> +	int flags;
> +	int ret;
> +	struct strbuf pattern =3D STRBUF_INIT;
> +	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> +	const char *shortname;
> +
> +	if (!refname || !(flags & REF_ISSYMREF)	||
> +			!skip_prefix(refname, "refs/heads/", &shortname))
> +		return 0;
> +
> +	strbuf_add(&pattern, cond, cond_len);
> +	ret =3D !wildmatch(pattern.buf, shortname, WM_PATHNAME);
> +	strbuf_release(&pattern);
> +	return ret;
> +}
> +
>  static int include_condition_is_true(const struct config_options *opts,
>  				     const char *cond, size_t cond_len)
>  {
> @@ -272,6 +291,8 @@ static int include_condition_is_true(const struct co=
nfig_options *opts,
>  		return include_by_gitdir(opts, cond, cond_len, 0);
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len=
))
>  		return include_by_gitdir(opts, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len=
))
> +		return include_by_branch(cond, cond_len);
>
>  	/* unknown conditionals are always false */
>  	return 0;
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 579a86b7f8..05c7def1f2 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -309,6 +309,39 @@ test_expect_success SYMLINKS 'conditional include, =
gitdir matching symlink, icas
>  	)
>  '
>
> +test_expect_success 'conditional include, onbranch' '
> +	(
> +		cd bar &&
> +		echo "[includeIf \"onbranch:foo-branch\"]path=3Dbar9" >>.git/config &=
&
> +		echo "[test]nine=3D9" >.git/bar9 &&
> +		git checkout -b master &&
> +		test_must_fail git config test.nine &&
> +		git checkout -b foo-branch &&
> +		echo 9 >expect &&
> +		git config test.nine >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'conditional include, onbranch, wildcard' '
> +	(
> +		cd bar &&
> +		echo "[includeIf \"onbranch:?oo-*/**\"]path=3Dbar10" >>.git/config &&
> +		echo "[test]ten=3D10" >.git/bar10 &&
> +		git checkout -b not-foo-branch/a &&
> +		test_must_fail git config test.ten &&
> +
> +		echo 10 >expect &&
> +		git checkout -b foo-branch/a/b/c &&
> +		git config test.ten >actual &&
> +		test_cmp expect actual &&
> +
> +		git checkout -b moo-bar/a &&
> +		git config test.ten >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'include cycles are detected' '
>  	cat >.gitconfig <<-\EOF &&
>  	[test]value =3D gitconfig
> --
> 2.22.0.rc1.169.g49223abbf8
>
>
