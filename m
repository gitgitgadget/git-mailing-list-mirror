Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114051F453
	for <e@80x24.org>; Sun, 30 Sep 2018 16:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeI3XdO (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 19:33:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeI3XdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 19:33:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so535599wrt.5
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/ttg1PdzqIVMgnkJs5RuFc3ccEn7nyJ8bj7QXJ1dJs=;
        b=RkuSrzgFU+S5JOAhIlJcr0hjrvt6POwlehpigfo7qLP4kCu1HSePuFylWt9B4WWW40
         VXCk1/Ec2ceAHhR71rWoioPPxjM7vuilRyC8pksgQxUG71+1ynl/qmMJFTabTMIUMOjv
         zUJlmQ9G+H3iYe1dolGoZvak092j62Afg1iSJ1ETanewYbAzuPpa8/RBMgjBWGBSKmID
         yfLrQvaDnIT33LTI3bfK9zaF1xBDv9mMNxYapA1Ds59ffJMxpbwYt7bTceJS63QfLNpM
         aXqS57o5NSrf5B6xmTlVzYjMSNuDpfcMRaGANgTAHUvXlcBDZnp1qdy9wIOsxAJVJgVT
         81ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/ttg1PdzqIVMgnkJs5RuFc3ccEn7nyJ8bj7QXJ1dJs=;
        b=nt0rVqzpS7B0qQE1eNdRZL/XJdtloLTp5O0dnXQ/g6R1yOVY7P0nQMU71mMiNfSo+S
         bYUuP80o2XvGAocILuMZkmzaKKzy2XEq4H35gYylP/laDmZHZ+O5DIfyZ6biP+2rOKA+
         kGQWK//Dw7ZxR6EyT6mdykj7QGTp2aHcvplu6bPGyQqmmP4QqccWO1ljumEM5DSkjXAH
         2dLdrL84755PkO3J1p9PJg7/RKTpO/CrFd9VaUMqdRmp6TFm2XRqQxLErnFVW1aaZw4p
         nqT20EFw/rVgXVMmlKOT1fAgXoSMKW63LmiGlIjhKYXpzb/UZoK5pXdVcsZu7krW/asg
         dzzw==
X-Gm-Message-State: ABuFfojRCO5JedOg+cGJhyd1E8aMMi0kkBsFPq1LF4P8BESmC45B377s
        mczyF647lkczJoO3dy8xDaWgbTug
X-Google-Smtp-Source: ACcGV61qeTt7VYX+qDwBUiZ/cUShu3gf5o5sy8HGs0pv8ZwvJXlIKlmHx5FwTs4FZLlIk0EOJvVotQ==
X-Received: by 2002:a5d:5210:: with SMTP id j16-v6mr4348130wrv.290.1538326763412;
        Sun, 30 Sep 2018 09:59:23 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id a9-v6sm6812343wmf.28.2018.09.30.09.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 09:59:22 -0700 (PDT)
Date:   Sun, 30 Sep 2018 17:59:21 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 04/21] stash: update test cases conform to coding
 guidelines
Message-ID: <20180930165921.GD2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <e2ced7320ffc205739133858a6b301c57893254f.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ced7320ffc205739133858a6b301c57893254f.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: stash: update test cases conform to coding guidelines

s/stash/t3903/
s/conform/to &/

Alternatively the subject could also be "t3903: modernize style",
which would be a bit shorter, and still convey the same information to
a reader of 'git log --oneline'.

On 09/26, Paul-Sebastian Ungureanu wrote:
> Removed whitespaces after redirection operators.

s/Removed/Remove/.  Commit messages should always use the imperative
mood, as described in Documentation/SubmittingPatches.

> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  t/t3903-stash.sh | 120 ++++++++++++++++++++++++-----------------------
>  1 file changed, 61 insertions(+), 59 deletions(-)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index af7586d43d..de6cab1fe7 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -8,22 +8,22 @@ test_description='Test git stash'
>  . ./test-lib.sh
>  
>  test_expect_success 'stash some dirty working directory' '
> -	echo 1 > file &&
> +	echo 1 >file &&
>  	git add file &&
>  	echo unrelated >other-file &&
>  	git add other-file &&
>  	test_tick &&
>  	git commit -m initial &&
> -	echo 2 > file &&
> +	echo 2 >file &&
>  	git add file &&
> -	echo 3 > file &&
> +	echo 3 >file &&
>  	test_tick &&
>  	git stash &&
>  	git diff-files --quiet &&
>  	git diff-index --cached --quiet HEAD
>  '
>  
> -cat > expect << EOF
> +cat >expect <<EOF
>  diff --git a/file b/file
>  index 0cfbf08..00750ed 100644
>  --- a/file
> @@ -35,7 +35,7 @@ EOF
>  
>  test_expect_success 'parents of stash' '
>  	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
> -	git diff stash^2..stash > output &&
> +	git diff stash^2..stash >output &&
>  	test_cmp output expect
>  '
>  
> @@ -74,7 +74,7 @@ test_expect_success 'apply stashed changes' '
>  
>  test_expect_success 'apply stashed changes (including index)' '
>  	git reset --hard HEAD^ &&
> -	echo 6 > other-file &&
> +	echo 6 >other-file &&
>  	git add other-file &&
>  	test_tick &&
>  	git commit -m other-file &&
> @@ -99,12 +99,12 @@ test_expect_success 'stash drop complains of extra options' '
>  
>  test_expect_success 'drop top stash' '
>  	git reset --hard &&
> -	git stash list > stashlist1 &&
> -	echo 7 > file &&
> +	git stash list >expected &&
> +	echo 7 >file &&
>  	git stash &&
>  	git stash drop &&
> -	git stash list > stashlist2 &&
> -	test_cmp stashlist1 stashlist2 &&
> +	git stash list >actual &&
> +	test_cmp expected actual &&
>  	git stash apply &&
>  	test 3 = $(cat file) &&
>  	test 1 = $(git show :file) &&
> @@ -113,9 +113,9 @@ test_expect_success 'drop top stash' '
>  
>  test_expect_success 'drop middle stash' '
>  	git reset --hard &&
> -	echo 8 > file &&
> +	echo 8 >file &&
>  	git stash &&
> -	echo 9 > file &&
> +	echo 9 >file &&
>  	git stash &&
>  	git stash drop stash@{1} &&
>  	test 2 = $(git stash list | wc -l) &&
> @@ -160,7 +160,7 @@ test_expect_success 'stash pop' '
>  	test 0 = $(git stash list | wc -l)
>  '
>  
> -cat > expect << EOF
> +cat >expect <<EOF
>  diff --git a/file2 b/file2
>  new file mode 100644
>  index 0000000..1fe912c
> @@ -170,7 +170,7 @@ index 0000000..1fe912c
>  +bar2
>  EOF
>  
> -cat > expect1 << EOF
> +cat >expect1 <<EOF
>  diff --git a/file b/file
>  index 257cc56..5716ca5 100644
>  --- a/file
> @@ -180,7 +180,7 @@ index 257cc56..5716ca5 100644
>  +bar
>  EOF
>  
> -cat > expect2 << EOF
> +cat >expect2 <<EOF
>  diff --git a/file b/file
>  index 7601807..5716ca5 100644
>  --- a/file
> @@ -198,79 +198,79 @@ index 0000000..1fe912c
>  EOF
>  
>  test_expect_success 'stash branch' '
> -	echo foo > file &&
> +	echo foo >file &&
>  	git commit file -m first &&
> -	echo bar > file &&
> -	echo bar2 > file2 &&
> +	echo bar >file &&
> +	echo bar2 >file2 &&
>  	git add file2 &&
>  	git stash &&
> -	echo baz > file &&
> +	echo baz >file &&
>  	git commit file -m second &&
>  	git stash branch stashbranch &&
>  	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
>  	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
> -	git diff --cached > output &&
> +	git diff --cached >output &&
>  	test_cmp output expect &&
> -	git diff > output &&
> +	git diff >output &&
>  	test_cmp output expect1 &&
>  	git add file &&
>  	git commit -m alternate\ second &&
> -	git diff master..stashbranch > output &&
> +	git diff master..stashbranch >output &&
>  	test_cmp output expect2 &&
>  	test 0 = $(git stash list | wc -l)
>  '
>  
>  test_expect_success 'apply -q is quiet' '
> -	echo foo > file &&
> +	echo foo >file &&
>  	git stash &&
> -	git stash apply -q > output.out 2>&1 &&
> +	git stash apply -q >output.out 2>&1 &&
>  	test_must_be_empty output.out
>  '
>  
>  test_expect_success 'save -q is quiet' '
> -	git stash save --quiet > output.out 2>&1 &&
> +	git stash save --quiet >output.out 2>&1 &&
>  	test_must_be_empty output.out
>  '
>  
>  test_expect_success 'pop -q is quiet' '
> -	git stash pop -q > output.out 2>&1 &&
> +	git stash pop -q >output.out 2>&1 &&
>  	test_must_be_empty output.out
>  '
>  
>  test_expect_success 'pop -q --index works and is quiet' '
> -	echo foo > file &&
> +	echo foo >file &&
>  	git add file &&
>  	git stash save --quiet &&
> -	git stash pop -q --index > output.out 2>&1 &&
> +	git stash pop -q --index >output.out 2>&1 &&
>  	test foo = "$(git show :file)" &&
>  	test_must_be_empty output.out
>  '
>  
>  test_expect_success 'drop -q is quiet' '
>  	git stash &&
> -	git stash drop -q > output.out 2>&1 &&
> +	git stash drop -q >output.out 2>&1 &&
>  	test_must_be_empty output.out
>  '
>  
>  test_expect_success 'stash -k' '
> -	echo bar3 > file &&
> -	echo bar4 > file2 &&
> +	echo bar3 >file &&
> +	echo bar4 >file2 &&
>  	git add file2 &&
>  	git stash -k &&
>  	test bar,bar4 = $(cat file),$(cat file2)
>  '
>  
>  test_expect_success 'stash --no-keep-index' '
> -	echo bar33 > file &&
> -	echo bar44 > file2 &&
> +	echo bar33 >file &&
> +	echo bar44 >file2 &&
>  	git add file2 &&
>  	git stash --no-keep-index &&
>  	test bar,bar2 = $(cat file),$(cat file2)
>  '
>  
>  test_expect_success 'stash --invalid-option' '
> -	echo bar5 > file &&
> -	echo bar6 > file2 &&
> +	echo bar5 >file &&
> +	echo bar6 >file2 &&
>  	git add file2 &&
>  	test_must_fail git stash --invalid-option &&
>  	test_must_fail git stash save --invalid-option &&
> @@ -486,11 +486,12 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	git stash branch stash-branch ${STASH_ID} &&
> -	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
> +	test_when_finished "git reset --hard HEAD && git checkout master &&
> +	git branch -D stash-branch" &&
>  	test $(git ls-files --modified | wc -l) -eq 1
>  '
>  
> @@ -498,14 +499,15 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	git stash &&
>  	test_when_finished "git stash drop" &&
> -	echo bar >> file &&
> +	echo bar >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	git stash branch stash-branch ${STASH_ID} &&
> -	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
> +	test_when_finished "git reset --hard HEAD && git checkout master &&
> +	git branch -D stash-branch" &&
>  	test $(git ls-files --modified | wc -l) -eq 1
>  '
>  
> @@ -518,10 +520,10 @@ test_expect_success 'stash show format defaults to --stat' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	git stash &&
>  	test_when_finished "git stash drop" &&
> -	echo bar >> file &&
> +	echo bar >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	cat >expected <<-EOF &&
> @@ -536,10 +538,10 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	git stash &&
>  	test_when_finished "git stash drop" &&
> -	echo bar >> file &&
> +	echo bar >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	echo "1	0	file" >expected &&
> @@ -551,10 +553,10 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	git stash &&
>  	test_when_finished "git stash drop" &&
> -	echo bar >> file &&
> +	echo bar >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	cat >expected <<-EOF &&
> @@ -574,7 +576,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	echo "1	0	file" >expected &&
> @@ -586,7 +588,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
>  	git reset --hard &&
> -	echo foo >> file &&
> +	echo foo >>file &&
>  	STASH_ID=$(git stash create) &&
>  	git reset --hard &&
>  	cat >expected <<-EOF &&
> @@ -606,9 +608,9 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
>  	git reset --hard &&
> -	echo foo > file &&
> +	echo foo >file &&
>  	git stash &&
> -	echo bar > file &&
> +	echo bar >file &&
>  	git stash &&
>  	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
>  	git stash pop &&
> @@ -620,9 +622,9 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
>  	git reset --hard &&
> -	echo foo > file &&
> +	echo foo >file &&
>  	git stash &&
> -	echo bar > file &&
> +	echo bar >file &&
>  	git stash &&
>  	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
>  	git stash pop &&
> @@ -632,8 +634,8 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
>  
>  test_expect_success 'ref with non-existent reflog' '
>  	git stash clear &&
> -	echo bar5 > file &&
> -	echo bar6 > file2 &&
> +	echo bar5 >file &&
> +	echo bar6 >file2 &&
>  	git add file2 &&
>  	git stash &&
>  	test_must_fail git rev-parse --quiet --verify does-not-exist &&
> @@ -653,8 +655,8 @@ test_expect_success 'ref with non-existent reflog' '
>  test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
>  	git stash clear &&
>  	test_must_fail git stash drop stash@{0} &&
> -	echo bar5 > file &&
> -	echo bar6 > file2 &&
> +	echo bar5 >file &&
> +	echo bar6 >file2 &&
>  	git add file2 &&
>  	git stash &&
>  	test_must_fail git stash drop stash@{1} &&
> @@ -724,7 +726,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
>  	test_i18ncmp expect actual
>  '
>  
> -cat > expect << EOF
> +cat >expect <<EOF
>  diff --git a/HEAD b/HEAD
>  new file mode 100644
>  index 0000000..fe0cbee
> @@ -737,14 +739,14 @@ EOF
>  test_expect_success 'stash where working directory contains "HEAD" file' '
>  	git stash clear &&
>  	git reset --hard &&
> -	echo file-not-a-ref > HEAD &&
> +	echo file-not-a-ref >HEAD &&
>  	git add HEAD &&
>  	test_tick &&
>  	git stash &&
>  	git diff-files --quiet &&
>  	git diff-index --cached --quiet HEAD &&
>  	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
> -	git diff stash^..stash > output &&
> +	git diff stash^..stash >output &&
>  	test_cmp output expect
>  '
>  
> -- 
> 2.19.0.rc0.23.g1fb9f40d88
> 
