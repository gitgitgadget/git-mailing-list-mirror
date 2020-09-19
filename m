Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5390C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEDC21D42
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lNBYN9R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgISUma (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 16:42:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60536 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgISUma (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 16:42:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ABBA729FE;
        Sat, 19 Sep 2020 16:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FGLXA0mIG2SKTl5EoTip/0oeFEc=; b=lNBYN9
        R4/y89tUDadnh0l7K1F4pGui7Kx1PxJ49y+1EhA+RJ7kFbg9gVmMhDvZ2VU7Ii9L
        LTbet5qtvaPMC4gMRqw33IqVK3xLpFBxoWZWwtH9c5FkhELFAG1LjGQdqj32Z2Oi
        GNuth1Vafn5lxwh9SIznhvFcxrjXZCcGiLmhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FGbLM/tzQF/Hay5t/nNRqLXz13G8yv3l
        K40uQNmj5/SiLZJwYtNOLWo3BeX6XddIthQoDGyQMlO+uM6JVIuLZIjKDnVJ7HbM
        iB0o5ZHGj03+YLQrcRv09nQDkbZVw/CFsVDEI+uab8JZnJi9I4fhVqBYdny2gfhM
        vHYyw5C/Llc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 229AD729FD;
        Sat, 19 Sep 2020 16:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A622B729FB;
        Sat, 19 Sep 2020 16:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t, doc: update tests, reference for
 "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-4-shrinidhi.kaushik@gmail.com>
Date:   Sat, 19 Sep 2020 13:42:26 -0700
In-Reply-To: <20200919170316.5310-4-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 19 Sep 2020 22:33:16 +0530")
Message-ID: <xmqq363djy6l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A165AC2A-FAB8-11EA-ADC0-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Subject: Re: [PATCH v4 3/3] t, doc: update tests, reference for "--force-if-includes"

good.

> * t/t5533-push-cas.sh:
>     Updates test cases for "compare-and-swap" when used along with
>     "--force-if-includes" helps mitigate overwrites when remote
>     ref are updated in the background.
>
> * Documentation:
>     Adds reference for the new option, configuration setting
>     ("push.useForceIfIncludes") and advise messages.

s/Updates/Update/; s/Adds/Add/;

> +push.useForceIfIncludes::
> +	If set to "true", it is equivalent to specifying "--force-if-includes"
> +	as an argument to linkgit:git-push[1]. Adding "--no-force-if-includes"

s/as an argument to/on the command line of/ would be better.

Some readers differenciate arguments and options and we are
discussing an option, not an argument.

> +Alternatively, specifying "--force-if-includes" an an ancillary option along
> +with "--force-with-lease[=<refname>]" (i.e., without saying what exact commit
> +the ref on the remote side must be pointing at, or which refs on the remote
> +side are being protected) at the time of "push" will verify if updates from the
> +remote-tracking refs that may have been implicitly updated in the background
> +are integrated locally before allowing a forced update.

OK.  A user who wants to know more can refer to --force-if-includes
from here pretty easily.

> @@ -341,6 +348,19 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
>  origin +master` to force a push to the `master` branch). See the
>  `<refspec>...` section above for details.
>  
> +--[no-]force-if-includes::
> +	Force an update only if the tip of the remote-tracking ref
> +	has been integrated locally.
> ++
> +This option verifies if the tip of the remote-tracking ref on which
> +a local branch has based on (for a rewrite), is reachable from at
> +least one of the "reflog" entries of the local branch about to be
> +updated by force on the remote.

The latter half of this sentence is quite a mouthful, and after
reading it three times, it is not quite clear.

> +The check ensures that any updates
> +from the remote have been incorporated locally by rejecting a push
> +if that is not the case.

OK.

> ++
> +Specifying "--no-force-if-includes" disables this behavior.

Do we want to add:

    It is a no-op unless "--force-with-lease[=<refname>]" without exact
    object name is used at the same time.

here or somewhere nearby?


> +test_expect_success 'background updates of REMOTE can be mitigated with "--force-if-includes"' '
> +	rm -rf src dst &&
> +	git init --bare src.bare &&
> +	test_when_finished "rm -rf src.bare" &&
> +	git clone --no-local src.bare dst &&
> +	test_when_finished "rm -rf dst" &&
> +	(
> +		cd dst &&
> +		test_commit G &&
> +		git push origin master:master
> +	) &&
> +	git clone --no-local src.bare dst2 &&
> +	test_when_finished "rm -rf dst2" &&
> +	(
> +		cd dst2 &&
> +		test_commit H &&
> +		git push
> +	) &&
> +	(
> +		cd dst &&
> +		test_commit I &&
> +		git fetch origin &&
> +		test_must_fail git push --force-with-lease --force-if-includes origin

I briefly wondered if it makes sense to also check if
--force-with-lease alone (or with --no-force-if-includes)
successfully pushes in this case, but I think we are OK without such
a test.  After all, we won't test "--force" alone, either, as we
expect that to work (and should be tested elsewhere).

> +	)
> +'
> +
> +test_expect_success 'background updates of REMOTE can be mitigated with "push.useForceIfIncludes"' '
> +	rm -rf src dst &&
> +	git init --bare src.bare &&
> +	test_when_finished "rm -rf src.bare" &&
> +	git clone --no-local src.bare dst &&
> +	test_when_finished "rm -rf dst" &&
> +	(
> +		cd dst &&
> +		test_commit G &&
> +		git push origin master:master
> +	) &&
> +	git clone --no-local src.bare dst2 &&
> +	test_when_finished "rm -rf dst2" &&
> +	(
> +		cd dst2 &&
> +		test_commit H &&
> +		git push
> +	) &&
> +	(
> +		cd dst &&
> +		test_commit I &&
> +		git fetch origin &&
> +		git config --local push.useForceIfIncludes "true" &&
> +		test_must_fail git push --force-if-includes origin

I am not sure what is tested here.  I thought with or without the
configuration variable, the feature is a no-op unless a lazy
force-with-lease is in use?

Perhaps you meant to test

		test_must_fail git push --force-with-lease origin

instead?

> +	)
> +'
> +
>  test_done

Thanks.
