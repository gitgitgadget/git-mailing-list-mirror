Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965911F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeIZAxE (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:53:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40056 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:53:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so14131909qkd.7
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/26tXyB9lFbWblxYg1f6rYxnXQk0DxqWw9SKHEuHKY=;
        b=l9BU5VrU02MR20Yu4yU1JX6WR6J5QDQRV2iGYmLyB/dmP6RKoaT0C7bR7TpZmND9fK
         +N3YWkpIhCODNAriAkbqojtDVMPb55WjOGdO733PboslZCYyOcqq4FkYkO9Kf2330PbW
         4iQf+ZyOzSyBGuzW5+c/j/6+lCQ0XZXZYH821w3ifvLavrjNG+vyYiW5IZ5M4f053CyX
         ICS5LdV23spinfucOxQxjwy7uHpJLOqrKDDx0chHKn5iRUQrcdhFjKEbkHw2Ufm5XDX5
         U1hKehHWvPZ1SAWw/PfwIDstED7TWkn5yhles/Nv3guba+uU7oruxMDd1SdkRXkNCAZH
         nNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/26tXyB9lFbWblxYg1f6rYxnXQk0DxqWw9SKHEuHKY=;
        b=ZtMhXVEDE4wzRnoJWna2PxzoC7syBJT1kA44ZBn8zaBoBpIv4mN1c32YjtpmdLMMC2
         5yz3cg5CJHqbEQf3kb0EtKbbt8ooGLnNcjsrV02K2IZMTCCx7OtY+pMmQu7WxzOFWGgI
         ln8DcGi724oVzNgn/VF+iiXrWyeYwcyXg0HZZlXWTehngAfyfrkozQjeXIqCyeBBuB6H
         HGnJnD0HpB2y8xhIx9dIjWFQUoW/ZxlGzw0HVc+MIzpPkzcrMZix+TP1pBE5hrQhT30r
         3LuBViXsiYJ0FrcJVFCoUHK+YaaUWkncPprX4KZIoC/mYu/IdmKlgp9EJrqy7jhN3pKm
         FEOw==
X-Gm-Message-State: ABuFfogODmbAT3wl50tpB8BiDgWeTudDm0EDIkJ0vvMRfSQEgHRmtHRU
        8nmdNntzT/3Ay+uqeHZGudc=
X-Google-Smtp-Source: ACcGV62ompL2DDSuWqW9kZZOPcypruQmbyNZcnWIt5tma6pGbVd6Xuulz5VdjjBB2rZiQ9u8w61qRA==
X-Received: by 2002:a37:ec3:: with SMTP id 186-v6mr1654187qko.345.1537901051534;
        Tue, 25 Sep 2018 11:44:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 62-v6sm1723306qkw.72.2018.09.25.11.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:44:10 -0700 (PDT)
Subject: Re: Re*: [PATCH v3 0/5] Cleanup pass on special test setups
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
 <xmqqtvmkyppc.fsf_-_@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <96f7e012-dbd2-ad4c-5fd0-40f859b457ed@gmail.com>
Date:   Tue, 25 Sep 2018 14:44:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvmkyppc.fsf_-_@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2018 2:43 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> This round has one code change based on feedback. Other changes are just
>> rewording commit messages.
> 
> Thanks.  I think the only remaining issue is what to do with the
> interaction between extra/additional error message that comes from
> the updates in 3/5 and the test framework selftest in t0000.
> 
> -- >8 --
> Subject: t0000: do not get self-test disrupted by environment warnings
> 
> The test framework test-lib.sh itself would want to give warnings
> and hints, e.g. when it sees a deprecated environment variable is in
> use that we want to encourage users to migrate to another variable.
> 
> The self-test of test framework done in t0000 however do not expect
> to see these warnings and hints, so depending on the settings of
> environment variables, a running test may or may not produce these
> messages to the standard error output, breaking the expectations of
> self-test test framework does on itself.  Here is what we see:
> 
>      $ TEST_GIT_INDEX_VERSION=4 sh t0000-basic.sh -i -v
>      ...
>      'err' is not empty, it contains:
>      warning: TEST_GIT_INDEX_VERSION is now GIT_TEST_INDEX_VERSION
>      hint: set GIT_TEST_INDEX_VERSION too during the transition period
>      not ok 5 - pretend we have a fully passing test suite
> 
> The following quick attempt to work it around does not work, because
> some tests in t0000 do want to see expected errors from the test
> framework itself.
> 
>           t/t0000-basic.sh | 2 +-
>           1 file changed, 1 insertion(+), 1 deletion(-)
> 
>          diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>          index 850f651e4e..88c6ed4696 100755
>          --- a/t/t0000-basic.sh
>          +++ b/t/t0000-basic.sh
>          @@ -88,7 +88,7 @@ _run_sub_test_lib_test_common () {
>                          '
> 
>                          # Point to the t/test-lib.sh, which isn't in ../ as usual
>          -		. "\$TEST_DIRECTORY"/test-lib.sh
>          +		. "\$TEST_DIRECTORY"/test-lib.sh >/dev/null 2>&1
>                          EOF
>                          cat >>"$name.sh" &&
>                          chmod +x "$name.sh" &&
> 
> There are a few possible ways to work this around:
> 
>   * We could strip the warning: and hint: unconditionally from the
>     error output before the error messages are checked in the
>     self-test (helper functions check_sub_test_lib_test_err and
>     check_sub_test_lib_test); the problem with this approach is that
>     it will make it impossible to write self-tests to ensure that
>     right warnings and hints are given.
> 
>   * We could force a sane environment settings before the test helper
>     _run_sub_test_lib_test_common dot-sources test-lib.sh; the
>     problem with this approach is that _run_sub_test_lib_test_common
>     now needs to be aware of what pairs of environment variables are
>     checked in test-lib.sh using check_var_migration helper.
> 
> The final patch I came up with is probably the solution that is
> least bad.  Set a variable to tell test-lib.sh that we are running
> a self-test, so that various pieces in test-lib.sh can react to keep
> the output stable.
> 

This looks like a reasonable compromise to me.  It's nice to give the 
migration hints to end users so they know they need to update their 
environments to reflect the required changes.  On the other hand, we 
don't want or need them to be triggered when we are running the self-test.

It would be nice to enable that automatically without the need for 
another environment variable but I couldn't think of a good way to 
accomplish that so I agree - this seems like the "least bad" solution. :-)

Thanks Junio

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t0000-basic.sh | 4 ++++
>   t/test-lib.sh    | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 850f651e4e..52c02b7c7e 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -87,6 +87,10 @@ _run_sub_test_lib_test_common () {
>   		passing metrics
>   		'
>   
> +		# Tell the framework that we are self-testing to make sure
> +		# it yields a stable result.
> +		GIT_TEST_FRAMEWORK_SELFTEST=t &&
> +
>   		# Point to the t/test-lib.sh, which isn't in ../ as usual
>   		. "\$TEST_DIRECTORY"/test-lib.sh
>   		EOF
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8ef86e05a3..364a11ea25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -135,9 +135,17 @@ GIT_TRACE_BARE=1
>   export GIT_TRACE_BARE
>   
>   check_var_migration () {
> +	# the warnings and hints given from this helper depends
> +	# on end-user settings, which will disrupt the self-test
> +	# done on the test framework itself.
> +	case "$GIT_TEST_FRAMEWORK_SELFTEST" in
> +	t)	return ;;
> +	esac
> +
>   	old_name=$1 new_name=$2
>   	eval "old_isset=\${${old_name}:+isset}"
>   	eval "new_isset=\${${new_name}:+isset}"
> +
>   	case "$old_isset,$new_isset" in
>   	isset,)
>   		echo >&2 "warning: $old_name is now $new_name"
> 
