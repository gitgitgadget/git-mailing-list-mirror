Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCD81F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGYU2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:28:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:60313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfGYU2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564086489;
        bh=DXgh99wMNQyiSNXRXVu7gAXksdyTMrCX3AQt69JyBTI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M8ElBY+AHC9r0K3KFaI6LjWyx4y4lhDJC5hOMbwBw3tzmGO6pc49fJxGDRqWu2tSJ
         LzaEqoSOLzkjvTgpqJ+NEmruvABQHF0t3bJNWawn1Oaufa839hl2qa3fJPFGSimDq2
         WqAE5EiLcKV7ZfLWQBZBCVExae0JQr5E48s89WTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1ifHlK1yBv-00u0tS; Thu, 25
 Jul 2019 22:28:09 +0200
Date:   Thu, 25 Jul 2019 22:28:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/19] merge-recursive: provide a better label for diff3
 common ancestor
In-Reply-To: <20190725174611.14802-20-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252217030.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-20-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ffHa0NOvJ5m7gSLN60iyDMDuTlRgDS2wbn55B+hH/Xb5WEqH34X
 LqDjn5ZYL5hCn0h2Ug1YmmmE+2/uSCco45eBTcRKBuE/SxoXlPW+/2/nBEKkMHapFVm0cpg
 66+rz05qqyz3HOTSL+pa1NpsSZuT8dbbOY0CX//XXqeW/1vVRuwaygFZUFRS16VVU89Dt2k
 JNwESMo+U9ULUNaag/vsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/+tS/ms8IQI=:IMlmufm1sTv3exAT1ZFjqy
 uDn/H4CnRQDXabybI9Eq6GEHSudwm5aLhEMSoyQ9mjkAiBhbFp0sUxQTVj19WkJkCpIb2eRWv
 oKsOhzGHbDuxq4xR+UD2vCsjlWHszFr26yqGeCQFSSm6ZTrJQPxcqnQhxWwS9z7aeNpJdb5zs
 t1nZ5rDCeAUcCjtOuZsfKqWauP6RResS4uKxW2hIIrGpRFzXXYXNNMc95hRwYU+kq1G3Rl/Gq
 ZVzsJAYJyCYGpw9oAWVL91Al9XYHY92mgIhfJmp8lrwMoGvS47QzZBrZ+idyCx+MbJQKpziMZ
 FNxwAb2qimqElDRSSPXEE7NOE61Fw6ZRkSd9lfR9uSi9Ifzc+SeMz08/Rl/6pOfxwJbi5MEfH
 611XUcQ4G8VRZyHK7valcX7EckYGV4PX6VO+EBpIHMZtqAx9pFtVYfD7RSaMv2bq/U//QkX8K
 rLk6iFDPfQeMny+jMD/4vkXNRtDS+QlFlsAD2/Dq8rENSJEP2W9ifcdu/YF1FgS4gBYacw6hi
 BYrFrhkCIpxBzq3ekLcloZsnd/G4WTRVb3fy4uMuYV4agg2TmrG3mp2hyLi79r1BwJ0iCA57U
 eFtM+Im4+aa0IQOs3QXp/5+n/tHAiN9ZGmpO4bmU/QrXeH7QbaqgJ5OWj2Ptkx0Scshid2IY2
 WPg9iwcSMb9QP50jNwdisv75vy9cqHjeQPMaBxmyC19wNGXG3t4ZgfoNxOhxQmM/6JGro7t7N
 GGLn8TW9yzPQitn49uC14WmfTOZfCkdL/Q6nTDoQq2sqGIqPyMt+CMsuEiF7F+jQxS26Tew4L
 9Tijgp+upJoB0urM6AWMjKBwCVVvOZdl4yJWv62KFOumfuqbFFGuBOg6sfQ7UBTj9u9Uc0siH
 la5abtiibD1LupYSXdBWDrOy60n7WjvgONsV1Npx6brAyxlJEaWeLBPci1m3bwib5pKKADX4Y
 qgxnEvfxskXcfy4PNoH9zFQ2Lr08oQFN9HqsU03HO958/mmRM65G8aqqC5OBvxUhjwWtLmcqL
 xHFNWcIDrrZ/oOaYLj0f//UPC6f1+rqhl8OvVUAQh0Yel/hbMXx88V7rkkbXEl8uXa0RJ1wAv
 rBiU/3X2PVorZgJa1ciWUA3I+FxxIBQ1376
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> In commit 7ca56aa07619 ("merge-recursive: add a label for ancestor",
> 2010-03-20), a label was added for the '||||||' line to make it have
> the more informative heading '|||||| merged common ancestors', with
> the statement:
>
>     It would be nicer to use a more informative label.  Perhaps someone
>     will provide one some day.
>
> This chosen label was perfectly reasonable when recursiveness kicks in,
> i.e. when there are multiple merge bases.  (I can't think of a better
> label in such cases.)  But it is actually somewhat misleading when there
> is a unique merge base or no merge base.  Change this based on the
> number of merge bases:
>     >=3D2: "merged common ancestors"
>     1:   <abbreviated commit hash>
>     0:   "<empty tree>"

Nice!

> Also, the code in merge_3way making use of opt->ancestor was overly
> complex because it tried to handle the case of opt->ancestor being NULL.
> We always set it first, though, so just add an assert that opt->ancestor
> is not NULL and simplify the surrounding code.
>
> Tests have also been added to check that we get the right ancestor name
> for each of the three cases.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                 |  35 ++++--
>  t/t6036-recursive-corner-cases.sh |   8 +-
>  t/t6047-diff3-conflict-markers.sh | 191 ++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+), 14 deletions(-)
>  create mode 100755 t/t6047-diff3-conflict-markers.sh
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4cd6599296..8ac53cacdf 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1034,7 +1034,7 @@ static int merge_3way(struct merge_options *opt,
>  {
>  	mmfile_t orig, src1, src2;
>  	struct ll_merge_options ll_opts =3D {0};
> -	char *base_name, *name1, *name2;
> +	char *base, *name1, *name2;

Renaming this variable at the same time as doing other, more involved
changes, made this patch a bit harder to review for me, I must admit.

>  	int merge_status;
>
>  	ll_opts.renormalize =3D opt->renormalize;
> @@ -1058,16 +1058,13 @@ static int merge_3way(struct merge_options *opt,
>  		}
>  	}
>
> -	assert(a->path && b->path && o->path);
> -	if (strcmp(a->path, b->path) ||
> -	    (opt->ancestor !=3D NULL && strcmp(a->path, o->path) !=3D 0)) {
> -		base_name =3D opt->ancestor =3D=3D NULL ? NULL :
> -			mkpathdup("%s:%s", opt->ancestor, o->path);
> +	assert(a->path && b->path && o->path && opt->ancestor);
> +	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) !=3D 0) {
> +		base  =3D mkpathdup("%s:%s", opt->ancestor, o->path);
>  		name1 =3D mkpathdup("%s:%s", branch1, a->path);
>  		name2 =3D mkpathdup("%s:%s", branch2, b->path);
>  	} else {
> -		base_name =3D opt->ancestor =3D=3D NULL ? NULL :
> -			mkpathdup("%s", opt->ancestor);
> +		base  =3D mkpathdup("%s", opt->ancestor);
>  		name1 =3D mkpathdup("%s", branch1);
>  		name2 =3D mkpathdup("%s", branch2);
>  	}
> @@ -1076,11 +1073,11 @@ static int merge_3way(struct merge_options *opt,
>  	read_mmblob(&src1, &a->oid);
>  	read_mmblob(&src2, &b->oid);
>
> -	merge_status =3D ll_merge(result_buf, a->path, &orig, base_name,
> +	merge_status =3D ll_merge(result_buf, a->path, &orig, base,
>  				&src1, name1, &src2, name2,
>  				opt->repo->index, &ll_opts);
>
> -	free(base_name);
> +	free(base);
>  	free(name1);
>  	free(name2);
>  	free(orig.ptr);
> @@ -3517,6 +3514,8 @@ static int merge_recursive_internal(struct merge_o=
ptions *opt,
>  	struct commit *merged_merge_bases;
>  	struct tree *result_tree;
>  	int clean;
> +	int num_merge_bases;
> +	struct strbuf commit_name =3D STRBUF_INIT;
>
>  	if (show(opt, 4)) {
>  		output(opt, 4, _("Merging:"));
> @@ -3538,6 +3537,7 @@ static int merge_recursive_internal(struct merge_o=
ptions *opt,
>  			output_commit_title(opt, iter->item);
>  	}
>
> +	num_merge_bases =3D commit_list_count(merge_bases);

At first, I thought that this does not require a separate variable
because it is used exactly once.

But then I realized that the next line changes the number of commits in
`merge_bases`, so it actually _is_ required.

>  	merged_merge_bases =3D pop_commit(&merge_bases);
>  	if (merged_merge_bases =3D=3D NULL) {
>  		/* if there is no common ancestor, use an empty tree */
> @@ -3579,13 +3579,26 @@ static int merge_recursive_internal(struct merge=
_options *opt,
>  	if (!opt->priv->call_depth)
>  		repo_read_index(opt->repo);
>
> -	opt->ancestor =3D "merged common ancestors";
> +	switch (num_merge_bases) {
> +	case 0:
> +		opt->ancestor =3D "<empty tree>";
> +		break;
> +	case 1:
> +		strbuf_add_unique_abbrev(&commit_name,

The name `commit_name` would suggest a different usage to me. How about
`pretty_merge_base`?

> +					 &merged_merge_bases->object.oid,
> +					 DEFAULT_ABBREV);
> +		opt->ancestor =3D commit_name.buf;
> +		break;
> +	default:
> +		opt->ancestor =3D "merged common ancestors";
> +	}
>  	clean =3D merge_trees_internal(opt,
>  				     repo_get_commit_tree(opt->repo, h1),
>  				     repo_get_commit_tree(opt->repo, h2),
>  				     repo_get_commit_tree(opt->repo,
>  							  merged_merge_bases),
>  				     &result_tree);
> +	strbuf_release(&commit_name);
>  	if (clean < 0) {
>  		flush_output(opt);
>  		return clean;

I was a bit too tired to look more closely at the test cases, in
particular after seeing the enormous complexity of the added test
script. I wonder whether it really has to be all that complex (e.g. why
use a complicated `test_seq` when a `test_commit A A.t
"1${LF}2${LF}3${LF}A${LF}` would suffice? Why start by `git checkout
=2D-orphan` on a just-created repository?)

But otherwise, the patch series looks pretty good to me.

Thanks,
Dscho
