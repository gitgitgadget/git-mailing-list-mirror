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
	by dcvr.yhbt.net (Postfix) with ESMTP id 882E41F454
	for <e@80x24.org>; Fri,  1 Nov 2019 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKATIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 15:08:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:55783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfKATIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 15:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572635307;
        bh=CN/DNDfUSQ0h0ST/m7YTtsASGbjxfzicM7mAuwPW/ZA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NIW2JB9XjHeAc5YgyO8xVv006ra0cSlXtQ/z0fMokepdf596gNGYAb0ocXFGhmpGs
         gxIfibGCeELAHinlSazMtLGBS3B+9OZy9D4XnNFmQ/yeGFc+1Newv9diqxZ0ubu2Uy
         9JXq5QYc8MQp3Q8vt2UQ4dunZYqqh9Q+r4DQZ9C8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1hqBXL1WfU-00aU0n; Fri, 01
 Nov 2019 20:08:27 +0100
Date:   Fri, 1 Nov 2019 20:08:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Davide Berardi <berardi.dav@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
In-Reply-To: <20191101002432.GA49846@carpenter.lan>
Message-ID: <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
References: <20191101002432.GA49846@carpenter.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ybbRaLVwqCeYd5b5cXMXaj+y1prI52v+C4Ji+LShOdaTlK6Pos2
 nmQRPfuyFXlKjwMnErNUrv5So9x1smB9bXGM3r6Opem+IHT7EXQIF1k8D/48tIYniPP0WuC
 Mdg8V0vQCbUBmRyS7HIeSYH21g6yQ0PxN9hZtxhSeKQ7ZoPR4H2FLPVbXfxXcoYovqDEPsA
 jHkLgsqVMykKD6lLf1HOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LeaaK/CIvdw=:X6L6cfdK6LJ7k624py3I8D
 wV/chxT3WRehohS7mFCNheDcw2EcvoxE7ihdRtxsmLNk2DslV18QpfA4egRmXGeMvG5Em0/0A
 FUOE7SbvZ/pyLQpKV2Rd6ECYG8f7EMUwzo8xA1BcBwfC+RlRiddzl4BluBKm3fSE2zqa4yd14
 uAhNhQurAcfZ5X43tdFEe3WBDRO+Czv+DG5VMM1tGvRuxsgCcM8EId+maHN2xd9vgwnr1EvBy
 SjJKTkJjybtdUVIGLxTECB0Mcqoc22+BnoZRKll0q2nntW544L9pYiW2KqFTJXjORu0hGaa9f
 3Uv+X/thx46dLnfYR8M8qeDMTXmEnB6XUawxvyaGuVwscyQExtyxhwZDnD7gNX22XLeRlt5Ha
 0GDGxMSy6BqBS21LZHNtkJjR59lG3m0biemhiIQwb4gkWh26scDK6EVVaTH5BE+zKWlf3zrYD
 pWp+xIog4nnmOXkdhpQW9EzpCnHzADonz7Z1m2at6pA5jSMxAK8YSgPyPy5YjTOeGC5Z9laTr
 jEnui9S6y+7k1BeJ/vqFdR579PP1CePDG1U8NjmeWHeSpgxHJOMdDeE1VNU+ckG69297WN0i8
 vvP6d90fDbpnsNdJYcMeKYxbZvcyd/evILIEXnPnO0WTqZnvwxe3hkbumQKe0xpvqk+SP02Wj
 ft5kPdtdpAc672hnikkymwXp5H0cSG1oHf3q6fF5U6SIaGAoUVW+UecMRHLZmVzxwYvunHSoW
 LAMXWaPz/cqd73JSbs9X0V19h8W6e3moUThNDunr19rDq0fO4N2U/XmUGB4/PLv8KuPhCjM/m
 1bNvCHMASbaU1oZJi2adTuVo+VUGnSwU8WslH6RQWmhuWn3IoRnX9q1ZsrqDdM6OMcc4ltXg6
 sHQWIzg5VXVkFcjFuWAlX68r7omtF1KnbG3T+IipyhBaWCnsR5rG2U1O5LWvo3IVL6jyWXMkt
 rMZ5dmLBwxU4f9ZN65gazdbK+PPXh4wNgvPL5NMkFriPWO+hi+qu7hVbfGOH4I5eYd0+8uFb2
 rjYyNucQMOsR/R/ApcMDHpgpg+11dM3pyg1c+QcFc5dt9//GVTT9GCVMQvSf86zT+n1jrlebs
 KV6w3z9mU+67UbNaTnmNMuEc7vwJJcfx0HlYRlT1dIm94AbVgmZU6HSn5UbtbYJAefu3gI1Dk
 /4xArX3DSHSAJUmR/POpaGA6Yf2qxxUI1E1QKYrXhbHgaZxBZ3FOKUo+tM4OdCuGPrmveP/uJ
 Qyv/FFdYj3UhS2wAWpC5PGFtnkkrOlvMlhhLeSVvDL+E/3uRRo3lcH5aCrY8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Davide,

I wonder whether you might want to reword the Subject: such that it
reflects what the patch does instead of what the problem is that
motivated you to work on the patch (the patch does not cause the
segmentation fault, after all, but it fixes it).

On Fri, 1 Nov 2019, Davide Berardi wrote:

> Fixed segmentation fault that can be triggered using
> $ git clone --branch $object $repository
> with object pointing to a non-commit ref (e.g. a blob).
>
> Signed-off-by: Davide Berardi <berardi.dav@gmail.com>
>
> ---
> builtin/clone.c         | 26 ++++++++++++++++++++++++++
> refs.h                  |  7 +++++++
> t/t5609-clone-branch.sh | 22 +++++++++++++++++++++-
> 3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f665b28ccc..0f4a18302c 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -704,11 +704,32 @@ static void update_remote_refs(const struct ref *r=
efs,
> 	}
> }
>
> +static int fallback_on_noncommit(const struct ref *check,
> +				 const struct ref *remote,
> +				 const char *msg)
> +{
> +	if (check =3D=3D NULL)
> +		return 1;
> +	struct commit *c =3D lookup_commit_reference_gently(the_repository,
> +						   &check->old_oid, 1);
> +	if (c =3D=3D NULL) {
> +		/* Fallback HEAD to fallback refs */
> +		warning(_("%s is not a valid commit object, HEAD will fallback
> to %s"),
> +			check->name, FALLBACK_REF);

Quite honestly, I do not think that it is a good idea to fall back in
this case. The user asked for something that cannot be accomplished, and
the best way to handle this is to exit with an error, i.e. `die()`.

> +		update_ref(msg, FALLBACK_REF, &remote->old_oid, NULL,
> +			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
> +	}
> +
> +	return c =3D=3D NULL;
> +}
> +
> static void update_head(const struct ref *our, const struct ref *remote,
> 			const char *msg)
> {
> 	const char *head;
> 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
> +		if (fallback_on_noncommit(our, remote, msg) !=3D 0)
> +			return;
> 		/* Local default branch link */
> 		if (create_symref("HEAD", our->name, NULL) < 0)
> 			die(_("unable to update HEAD"));
> @@ -718,12 +739,17 @@ static void update_head(const struct ref *our, con=
st
> struct ref *remote,
> 			install_branch_config(0, head, option_origin,
> 		our->name);
> 		}
> 	} else if (our) {
> +		if (fallback_on_noncommit(our, remote, msg) !=3D 0)
> +			return;
> +		/* here commit is valid */
> 		struct commit *c =3D lookup_commit_reference(the_repository,
> 							   &our->old_oid);
> 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
> 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
> 			   UPDATE_REFS_DIE_ON_ERR);
> 	} else if (remote) {
> +		if (fallback_on_noncommit(remote, remote, msg) !=3D 0)
> +			return;
> 		/*
> 		 * We know remote HEAD points to a non-branch, or
> 		 * HEAD points to a branch but we don't know which one.
> diff --git a/refs.h b/refs.h
> index 730d05ad91..35ee6eb058 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -497,6 +497,13 @@ enum action_on_err {
> 	UPDATE_REFS_QUIET_ON_ERR
> };
>
> +/*
> + * In case of a remote HEAD pointing to a non-commit update_head
> + * will make HEAD reference fallback to this value, master ref
> + * should be safe.
> + */
> +#define FALLBACK_REF "refs/heads/master"
> +
> /*
>  * Begin a reference transaction.  The reference transaction must
>  * be freed by calling ref_transaction_free().
> diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
> index 6e7a7be052..0680cf5a89 100755
> --- a/t/t5609-clone-branch.sh
> +++ b/t/t5609-clone-branch.sh
> @@ -20,7 +20,13 @@ test_expect_success 'setup' '
> 	 echo one >file && git add file && git commit -m one &&
> 	 git checkout -b two &&
> 	 echo two >file && git add file && git commit -m two &&
> -	 git checkout master) &&
> +	 git checkout master &&
> +	 # Create dummy objects
> +	 _B=3D$(git rev-list --objects --all | grep -m 1 "^[^ ]\+ [^ ]\+" | \

Hmm. That naming convention (`_B`) is a new one, and does not really
align with the existing code in the test suite, does it?

Further, it seems that you pick some semi-random object from the object
database. I think you can do better: if you want to get the hash of a
blob, use `git rev-parse HEAD:file`, if you want the hash of a tree, use
the same command with `HEAD:`, if you want a commit, with `HEAD`.

> +	      awk "{print \$1}") &&
> +	 echo "${_B}" >> .git/refs/tags/broken-tag &&

In the Git test suite, we only use curlies to expand shell variables
when necessary, i.e. when followed by a valid variable name character.

> +	 echo "${_B}" >> .git/refs/heads/broken-head
> +	) &&
> 	mkdir empty &&
> 	(cd empty && git init)
> '
> @@ -67,4 +73,18 @@ test_expect_success 'clone -b not allowed with empty =
repos'
> '
> 	test_must_fail git clone -b branch empty clone-branch-empty
> '
>
> +test_expect_success 'clone -b with broken tag will fallback to master' =
'
> +	git clone -b broken-tag parent clone-broken-tag &&

As I said earlier, I think this should fail, i.e. something like

	test_must_fail git clone ... 2>err &&
	test_i18ngrep [something-from-that-error-message] err

Thanks,
Johannes

> +	(cd clone-broken-tag &&
> +	 check_HEAD master
> +	)
> +'
> +
> +test_expect_success 'clone -b with broken head will fallback to master'=
 '
> +	git clone -b broken-head parent clone-broken-head &&
> +	(cd clone-broken-head &&
> +	 check_HEAD master
> +	)
> +'
> +
> test_done
> --
> 2.22.0
>
>
>
