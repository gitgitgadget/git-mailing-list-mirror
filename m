Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543061F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965242AbeEYIsO (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:48:14 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55503 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964804AbeEYIsM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 May 2018 04:48:12 -0400
X-AuditID: 1207440e-203ff70000000b39-57-5b07cdcbc388
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 98.D9.02873.BCDC70B5; Fri, 25 May 2018 04:48:11 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC483.dip0.t-ipconnect.de [87.188.196.131])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4P8m5H1020346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 25 May 2018 04:48:06 -0400
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=c3=adn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
References: <20180523052517.4443-1-chriscool@tuxfamily.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu>
Date:   Fri, 25 May 2018 10:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523052517.4443-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOffebWfLa6er4smscFpJtd7ElaSH9LgEheU/oaRe3dWNtmm7
        W6hQrAyNzd4PakpqGfawrFWmYQYuyVdp4j/pnBqSYkkP+ycw6t6Gtf8+53wfPw7nB0lmQhEF
        jRabYLXwJq1SQzGq7TG6rjeqtDWlrzB7/6OPYD3j50l28NpJkr0wA9lKTztgnf0ugnWc7ifZ
        s7VOJdvwNomdel8D2JrRTyTrujQF2MePSym2rbcOsKePzyi2zuVcw7Fck3tIxX39ls5Veeyc
        s/SVknvXF8vVjkyquKrxYRU37VmUrE7VJOoFk/GIYF29OVNj6H7XTuXXJxS4pl8qHMCncwI1
        xGgD/nC5nHICDWRQI4Ef1Z5VBQ69BL7SXK+SXWFoL27pbCNlDkc7sXfshEI2kahcgc88qVHK
        AoM24V+On4TMSqTDN8qKJYaQRlvwl4c75GsKLcHPmxuAzBHoAPb3fP8bpdE83HFtjJJZjRLx
        UMOAQmYSLcMz1/vIAEfigbFKIsCL8bOpCvIcQO6guDso4g6KuIMiVYC6CxbxJrtZZ+aNJlHI
        1onZvMUiWHXrV5mNtlWC3u4Bge8LbQSl9dGtAEGgDaGhV5nGKPgjYqG5FcyHhDaC7rilSmNC
        s/L0hQZeNGRY7SZBbAUYktpw+mKKpNF6vrBIsObNSgsgpY2klRtepDIol7cJhwQhX7DOqtEQ
        ajE90i0F51mFXKEgx2iy/ZcJqJbLQ6TyAtlDi/m8WTTmBvROsB76SsrKSOjvuFhGMpQlzyJE
        RdJh0gYySLYa7JZ/bbMLOgkipceF0VAuDJHW91/fpDSKkEY9uPd3lI3/L0U5QN1G49VQX+vv
        vKUxRQwc/la8oj/T/eNwYsbtzqNNtxJ6/euOe6rvjGbWap72ZDD+5vT4+Jaa6JI54kPRc7Di
        C1zhmL6Tcy4bZbWV43v4ZvXERhsaTNlduSd/ZXNcUtxAnP6U15js3Zey37MwHiZvO3Zhl/uz
        1/d6JDqmqygpIUVLiQZ+7XLSKvJ/AF1NhVd7AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/23/2018 07:25 AM, Christian Couder wrote:
> From: David Turner <dturner@twopensource.com>
> 
> Many tests are very focused on the file system representation of the
> loose and packed refs code. As there are plans to implement other
> ref storage systems, let's migrate these tests to a form that test
> the intent of the refs storage system instead of it internals.
> [...]
> 
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 9e782a8122..a4ebb0b65f 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -65,7 +65,7 @@ reset_to_sane
>  test_expect_success 'symbolic-ref fails to delete real ref' '
>  	echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
>  	test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
> -	test_path_is_file .git/refs/heads/foo &&
> +	git rev-parse --verify refs/heads/foo &&
>  	test_cmp expect actual
>  '
>  reset_to_sane

Should t1401 be considered a backend-agnostic test, or is it needed to
ensure that symbolic refs are written correctly in the files backend?

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c0ef946811..222dc2c377 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -234,34 +234,34 @@ test_expect_success 'git branch -M master2 master2 should work when master is ch
>  
>  test_expect_success 'git branch -v -d t should work' '
>  	git branch t &&
> -	test_path_is_file .git/refs/heads/t &&
> +	git rev-parse --verify refs/heads/t &&
>  	git branch -v -d t &&
> -	test_path_is_missing .git/refs/heads/t
> +	test_must_fail git rev-parse --verify refs/heads/t
>  '
>  
>  test_expect_success 'git branch -v -m t s should work' '
>  	git branch t &&
> -	test_path_is_file .git/refs/heads/t &&
> +	git rev-parse --verify refs/heads/t &&
>  	git branch -v -m t s &&
> -	test_path_is_missing .git/refs/heads/t &&
> -	test_path_is_file .git/refs/heads/s &&
> +	test_must_fail git rev-parse --verify refs/heads/t &&
> +	git rev-parse --verify refs/heads/s &&
>  	git branch -d s
>  '
>  
>  test_expect_success 'git branch -m -d t s should fail' '
>  	git branch t &&
> -	test_path_is_file .git/refs/heads/t &&
> +	git rev-parse refs/heads/t &&
>  	test_must_fail git branch -m -d t s &&
>  	git branch -d t &&
> -	test_path_is_missing .git/refs/heads/t
> +	test_must_fail git rev-parse refs/heads/t
>  '
>  
>  test_expect_success 'git branch --list -d t should fail' '
>  	git branch t &&
> -	test_path_is_file .git/refs/heads/t &&
> +	git rev-parse refs/heads/t &&
>  	test_must_fail git branch --list -d t &&
>  	git branch -d t &&
> -	test_path_is_missing .git/refs/heads/t
> +	test_must_fail git rev-parse refs/heads/t
>  '
>  
>  test_expect_success 'git branch --list -v with --abbrev' '
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aefde7b172..1f871d3cca 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -726,7 +726,7 @@ test_expect_success 'store updates stash ref and reflog' '
>  	git reset --hard &&
>  	! grep quux bazzy &&
>  	git stash store -m quuxery $STASH_ID &&
> -	test $(cat .git/refs/stash) = $STASH_ID &&
> +	test $(git rev-parse stash) = $STASH_ID &&
>  	git reflog --format=%H stash| grep $STASH_ID &&
>  	git stash pop &&
>  	grep quux bazzy
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 0680dec808..d4f435155f 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -30,7 +30,7 @@ add () {
>  	test_tick &&
>  	commit=$(echo "$text" | git commit-tree $tree $parents) &&
>  	eval "$name=$commit; export $name" &&
> -	echo $commit > .git/refs/heads/$branch &&
> +	git update-ref "refs/heads/$branch" "$commit" &&
>  	eval ${branch}TIP=$commit
>  }
>  
> @@ -45,10 +45,10 @@ pull_to_client () {
>  
>  			case "$heads" in
>  			    *A*)
> -				    echo $ATIP > .git/refs/heads/A;;
> +				    git update-ref refs/heads/A "$ATIP";;
>  			esac &&
>  			case "$heads" in *B*)
> -			    echo $BTIP > .git/refs/heads/B;;
> +			    git update-ref refs/heads/B "$BTIP";;
>  			esac &&
>  			git symbolic-ref HEAD refs/heads/$(echo $heads \
>  				| sed -e "s/^\(.\).*$/\1/") &&
> @@ -92,8 +92,8 @@ test_expect_success 'setup' '
>  		cur=$(($cur+1))
>  	done &&
>  	add B1 $A1 &&
> -	echo $ATIP > .git/refs/heads/A &&
> -	echo $BTIP > .git/refs/heads/B &&
> +	git update-ref refs/heads/A "$ATIP" &&
> +	git update-ref refs/heads/B "$BTIP" &&
>  	git symbolic-ref HEAD refs/heads/B
>  '
>  
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ae5a530a2d..e402aee6a2 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -63,7 +63,7 @@ test_expect_success "fetch test" '
>  	git commit -a -m "updated by origin" &&
>  	cd two &&
>  	git fetch &&
> -	test -f .git/refs/heads/one &&
> +	git rev-parse --verify refs/heads/one &&
>  	mine=$(git rev-parse refs/heads/one) &&
>  	his=$(cd ../one && git rev-parse refs/heads/master) &&
>  	test "z$mine" = "z$his"
> @@ -73,8 +73,8 @@ test_expect_success "fetch test for-merge" '
>  	cd "$D" &&
>  	cd three &&
>  	git fetch &&
> -	test -f .git/refs/heads/two &&
> -	test -f .git/refs/heads/one &&
> +	git rev-parse --verify refs/heads/two &&
> +	git rev-parse --verify refs/heads/one &&
>  	master_in_two=$(cd ../two && git rev-parse master) &&
>  	one_in_two=$(cd ../two && git rev-parse one) &&
>  	{
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index 31db7b5f91..aa2d360ce3 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -34,7 +34,7 @@ doit () {
>  
>  	commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
>  
> -	echo $commit >.git/refs/tags/$NAME &&
> +	git update-ref "refs/tags/$NAME" "$commit" &&
>  	echo $commit
>  }
>  
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 76c223c967..ab9da61da3 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -65,7 +65,7 @@ test_expect_success setup '
>  test_expect_success "checkout from non-existing branch" '
>  
>  	git checkout -b delete-me master &&
> -	rm .git/refs/heads/delete-me &&
> +	git update-ref -d --no-deref refs/heads/delete-me &&
>  	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
>  	git checkout master &&
>  	test refs/heads/master = "$(git symbolic-ref HEAD)"
> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
> index a735fa3717..9c49b6c1fe 100755
> --- a/t/t9104-git-svn-follow-parent.sh
> +++ b/t/t9104-git-svn-follow-parent.sh
> @@ -215,7 +215,8 @@ test_expect_success "multi-fetch continues to work" "
>  	"
>  
>  test_expect_success "multi-fetch works off a 'clean' repository" '
> -	rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
> +	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
> +	git reflog expire --all --expire=all &&
>  	mkdir "$GIT_DIR/svn" &&
>  	git svn multi-fetch
>  	'
> 

`rm -rf "$GIT_DIR/refs/remotes"` is not kosher. I think it can be written

    printf 'option no-deref\ndelete %s\n' $(git for-each-ref
--format='%(refname)' refs/remotes) | git update-ref --stdin

as long as the number of references doesn't exceed command-line limits.
This will also take care of the reflogs. Another alternative would be to
write it as a loop.

Michael
