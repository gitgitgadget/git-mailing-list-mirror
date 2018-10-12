Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6981F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJLQ6M (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:58:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:36109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:58:12 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJGFi-1gDdnx3Qug-002svd; Fri, 12
 Oct 2018 11:26:32 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJGFi-1gDdnx3Qug-002svd; Fri, 12
 Oct 2018 11:26:32 +0200
Date:   Fri, 12 Oct 2018 11:26:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Lucas De Marchi <lucas.demarchi@intel.com>
cc:     lucas.de.marchi@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, t.gummerer@gmail.com
Subject: Re: [PATCH v2] range-diff: allow to diff files regardless
 submodule
In-Reply-To: <20181011081750.24240-1-lucas.demarchi@intel.com>
Message-ID: <nycvar.QRO.7.76.6.1810121124570.45@tvgsbejvaqbjf.bet>
References: <CAKi4VAL+qSObOABeNHVXGytE9aB3sUJtecE5jYF6_ZfDA+J0ZQ@mail.gmail.com> <20181011081750.24240-1-lucas.demarchi@intel.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dNKEhO1v5rTgxPBtD6RV5wSn63O+I9PEBZq5d1pWp6z1KpEWNFi
 rze4gIIyv8V7oO3Y5Mtv6m+OQrzzi9WGK+8Zzd6L9sVQObwZ1Qwl7SG/I7bXHOO7Fc1HhVf
 /ZXYi2Yt5dS5dmE6cBBu3yRZxIrzfk/RvRq0yreso/h6VYWr9IDy7tVCudfgx0hDF6W4+Tr
 v9OCmWRSsdGYYsJ6YmGdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sn31UobKvcU=:1UuJNJntGwsSnUYSNZxASv
 kVAN+1CxVnzzuNkH7GkFngUTHR01PjqRrKl5eg00kNf1D/3PP0Cie5jYRbxX/DWvOjqnv22wR
 52QKE56TpFDfT323xXq6VjGuY3ARh2XrVQV9TJuucunZttfnNkU4HRs2jv7VSulRC4K09iga+
 FWnJ+1zGQ89ginKNmElY9fvnPqdPaAJaTiLQHR+h3XzI+aD/xuev/bA+u87EBEGgIfCS+0/c2
 yZk1YWvGnEUvlHBICRopw0dzYuVpU2QDOxAOKUBrArsRVH2lNoIZUkuIJsSYwGejzPhVpJJ8e
 QaTy4XoAGzdxYuntCg9wIlRayRD799IaYyENZFwL2KsSyYdcy4KAYpbXgRfCB+TRpN5w0qy7I
 Cmk1W5+y6T9eSpV0caBMKnYc/35oqTKMzL6GHl4n45PvuZkACX2hLsIKZcLrPdqYdKYT99Wve
 fvYnjDQNwUy9ClUVHxaUpboCJWOr8QRjNkqX3xV5seXZ9Iiv0uepohnPtruDj74DDEvpUAMWR
 RRBsSD7JuS4rLiI3P6I5HnUy55h20pzvN6jX9cF/p4OiXKzL/8bucfEjXjB5hfRyjfX7B2D2p
 meFkGDf0GuNalE705++AwiF4zQVPUumromE3KXvBKHNn9VDDQjfoDcjbOAZcNfswyNxz61Chr
 yEgHGcqMrFgYXwcWMIyz7jUvVNNJQ87ZYxvGYzuxexLwYDtSIvEra1DeMryRsoz+VVKXhW2Qi
 4koKsNtFWEYssVI0EmmuxhoMCpq+so6UJdYQjEM6BQHMiuHBgGQrBFtcixV6BRs8lQ02wLUB3
 VPKifyyMXCmY75H8SBYtBbcB4yQsCxMFOxvAMvEeaqEavUxzFo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lucas,

On Thu, 11 Oct 2018, Lucas De Marchi wrote:

> Do like it's done in grep so mode doesn't end up as
> 0160000, which means range-diff doesn't work if one has
> "submodule.diff = log" in the configuration. Without this
> while using range-diff I only get a
> 
>     Submodule a 0000000...0000000 (new submodule)
> 
> instead of the diff between the revisions.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Thank you for this contribution, which I am glad to ACK.

I am especially happy that you added a regression test so that we are
confident not to break this again.

Ciao,
Dscho

> ---
>  range-diff.c          |  2 +-
>  t/t3206-range-diff.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index 60edb2f518..bd8083f2d1 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
>  {
>  	struct diff_filespec *spec = alloc_filespec(name);
>  
> -	fill_filespec(spec, &null_oid, 0, 0644);
> +	fill_filespec(spec, &null_oid, 0, 0100644);
>  	spec->data = (char *)p;
>  	spec->size = strlen(p);
>  	spec->should_munmap = 0;
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 045aca1c18..6aae364171 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -122,6 +122,35 @@ test_expect_success 'changed commit' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'changed commit with sm config' '
> +	git range-diff --no-color --submodule=log topic...changed >actual &&
> +	cat >expected <<-EOF &&
> +	1:  4de457d = 1:  a4b3333 s/5/A/
> +	2:  fccce22 = 2:  f51d370 s/4/A/
> +	3:  147e64e ! 3:  0559556 s/11/B/
> +	    @@ -10,7 +10,7 @@
> +	      9
> +	      10
> +	     -11
> +	    -+B
> +	    ++BB
> +	      12
> +	      13
> +	      14
> +	4:  a63e992 ! 4:  d966c5c s/12/B/
> +	    @@ -8,7 +8,7 @@
> +	     @@
> +	      9
> +	      10
> +	    - B
> +	    + BB
> +	     -12
> +	     +B
> +	      13
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'no commits on one side' '
>  	git commit --amend -m "new message" &&
>  	git range-diff master HEAD@{1} HEAD
> -- 
> 2.19.1.1.g8c3cf03f71
> 
> 
