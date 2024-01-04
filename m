Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBD25549
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xo/nsC2T"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-781706de787so49208585a.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 09:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704389605; x=1704994405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNBckTmAxdJ36V7tbqUtSl+lEgGqyrMFmbCGhmFCCJQ=;
        b=xo/nsC2Tn4m78slD2H3lxtXY34/0O89MD3z4tW6mCKvWBV64TjTey+GAENRHrZxDJu
         11LTM1lm81kapPda43/IV/MBDH276ZGx9hVzu7NfGYpZSe8djG4TT2zY1MiyVO1dirga
         hhOMk2KUk2/cXmPr9efVmLaHSiiRANpzhJnh4du+RhiDSyzM0axti/mlRfcfygxDW6o8
         S1CvDKzOIowJK3cui2xWOIe6q1UdICcpEfBEpvv9PUAP8COd7jabw21zzhwUL7MdZj+K
         B5tFPY2S9slp8sgdTjTa464MaUeUi+GqvRh4hFKQqQl3x1tZEehes58+zBRnyhJ44DB9
         4D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389605; x=1704994405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNBckTmAxdJ36V7tbqUtSl+lEgGqyrMFmbCGhmFCCJQ=;
        b=CW7MLp4/bv84Zq2Kp5wrZGzM28rb/zZ01SPtvgLNzOnGEK93VpcHRulMcAYW8ch+1v
         LF951nqJK2ghOjFmHZ0js7YKJsmgOoCdA64iBvr16Df4zPQo/x6hyRyu6gArcoM3VzXm
         uHSJ3X0qeU6tbfRvLdI3K0/68ZzHzK4A6BrSDcOsI97UmHsAFLWh2rwLlET805hH6BoJ
         MciavFoxe3h3+NXxMH1KLD5HZx1hZvUdWjpg4Sg8AQ5fnV49pdstYK8QyrCnBjs+gvsd
         MAKXeMX7SNAQTTuw7HU+44VCpPj+lJyOCg6+215Htg0lfUY7CSap0S5NI0EaA0YCa0q1
         uZuw==
X-Gm-Message-State: AOJu0YxDvAJ/GyTLSfykibm/o1Ab4T0BYS9D5GdgvyzkBPKrtjMZYQaR
	v5ENFZ2zmHuYld5oUdK30ESrCCGi0iXOHE6c3SzeTkQ0Y1JFxw==
X-Google-Smtp-Source: AGHT+IH2BwruhNshh0bAfRsnZRVUWsZhndzN7bEwNdhFejqpzF/3XZou5IGbF20kTI1kEXKLu+bHwA==
X-Received: by 2002:ae9:c302:0:b0:781:edc8:a3f1 with SMTP id n2-20020ae9c302000000b00781edc8a3f1mr834835qkg.1.1704389604640;
        Thu, 04 Jan 2024 09:33:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l20-20020ae9f014000000b00781afb6ec21sm3911228qkg.56.2024.01.04.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:33:24 -0800 (PST)
Date: Thu, 4 Jan 2024 12:33:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch: add new config option fetch.all
Message-ID: <ZZbr4yAJe0dnHRcO@nand.local>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
 <20240104143656.615117-1-dev@tb6.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104143656.615117-1-dev@tb6.eu>

On Thu, Jan 04, 2024 at 03:33:55PM +0100, Tamino Bauknecht wrote:
> ---
>  Documentation/config/fetch.txt |  4 ++
>  builtin/fetch.c                | 18 +++++--
>  t/t5514-fetch-multiple.sh      | 88 ++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 5 deletions(-)

Nice. This looks like a useful feature that folks working with more than
one remote may want to take advantage of. Not that typing "git fetch
--all" is all that hard, but I can see the utility of something like
this for a repository with >1 remotes where the individual wants to keep
all remotes up-to-date.

> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index aea5b97477..4f12433874 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -50,6 +50,10 @@ fetch.pruneTags::
>  	refs. See also `remote.<name>.pruneTags` and the PRUNING
>  	section of linkgit:git-fetch[1].
>
> +fetch.all::
> +	If true, fetch will attempt to update all available remotes.
> +	This behavior can be overridden by explicitly specifying a remote.
> +

Instead of "can be overridden ...", how about:

    This behavior can be overridden by explicitly specifying one or more
    remote(s) to fetch from.

> @@ -2337,11 +2344,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
>  		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
>
> -	if (all) {
> -		if (argc == 1)
> -			die(_("fetch --all does not take a repository argument"));
> -		else if (argc > 1)
> -			die(_("fetch --all does not make sense with refspecs"));
> +	if (all && argc == 1) {
> +		die(_("fetch --all does not take a repository argument"));
> +	} else if (all && argc > 1) {
> +		die(_("fetch --all does not make sense with refspecs"));
> +	} else if (all || (config.all > 0 && argc == 0)) {
> +		/* Only use fetch.all config option if no remotes were explicitly given */

To minimize the diff, let's leave the existing conditional as is, so the
end state would look like:

    if (all) {
      if (argc == 1)
        die(_("fetch --all does not take a repository argument"));
      else if (argc > 1)
        die(_("fetch --all does not make sense with refspecs"));
    }

    if (all || (config.all > 0 && !argc))
      (void) for_each_remote(get_one_remote_for_fetch, &list);

I don't feel particularly strongly about whether or not you reorganize
these if-statements, but we should change "argc == 0" to "!argc", which
matches the conventions of the rest of the project.

>  		(void) for_each_remote(get_one_remote_for_fetch, &list);
>
>  		/* do not do fetch_multiple() of one */
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> index a95841dc36..cd0aee97f9 100755
> --- a/t/t5514-fetch-multiple.sh
> +++ b/t/t5514-fetch-multiple.sh
> @@ -209,4 +209,92 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
>  	 git fetch --multiple --jobs=0)
>  '
>
> +cat > expect << EOF

This should be `cat >expect <<-\EOF` (without the space between the
redirect and heredoc, as well as indicating that the heredoc does not
need any shell expansions).

> +  one/main
> +  one/side
> +  origin/HEAD -> origin/main
> +  origin/main
> +  origin/side
> +  three/another
> +  three/main
> +  three/side
> +  two/another
> +  two/main
> +  two/side
> +EOF
> +
> +test_expect_success 'git fetch (fetch all remotes with fetch.all = true)' '
> +	(git clone one test9 &&
> +	 cd test9 &&
> +	 git config fetch.all true &&
> +	 git remote add one ../one &&
> +	 git remote add two ../two &&
> +	 git remote add three ../three &&
> +	 git fetch &&
> +	 git branch -r > output &&

Same note here about the space between the redirect.

> +	 test_cmp ../expect output)

It looks like these tests match the existing style of the test suite,
but they are somewhat out of date with respect to our more modern
standards. I would probably write this like:

    test_expect_success 'git fetch --all (works with fetch.all = true)' '
      git clone one test10 &&
      test_config -C test10 fetch.all true &&
      for r in one two three
      do
        git -C test10 remote add $r ../$r || return 1
      done &&
      git -C test10 fetch --all &&
      git -C test10 branch -r >actual &&
      test_cmp expect actual
    '

While reviewing, I thought that the tests using the test9 and test10
clones were duplicates, but they are not: the earlier one uses a "git
fetch", and the latter uses a "git fetch --all".

If we take just the test10 and test11 tests, I think there is some
opportunity to consolidate these two, like so:

    for v in true false
    do
        test_expect_success "git fetch --all (works with fetch.all=$v)" '
          git clone one test10 &&
          test_config -C test10 fetch.all $v &&
          for r in one two three
          do
            git -C test10 remote add $r ../$r || return 1
          done &&
          git -C test10 fetch --all &&
          git -C test10 branch -r >actual &&
          test_cmp expect actual
        '
    done

> +cat > expect << EOF
> +  one/main
> +  one/side
> +  origin/HEAD -> origin/main
> +  origin/main
> +  origin/side
> +EOF

Same note(s) about cleaning up this heredoc.

> +test_expect_success 'git fetch one (explicit remote overrides fetch.all)' '
> +	(git clone one test12 &&
> +	 cd test12 &&
> +	 git config fetch.all true &&
> +	 git remote add one ../one &&
> +	 git remote add two ../two &&
> +	 git remote add three ../three &&
> +	 git fetch one &&
> +	 git branch -r > output &&
> +	 test_cmp ../expect output)
> +'

I suspect that you could go further with a "setup" function that gives
you a fresh clone (with fetch.all set to a specified value), and then
test test would continue on from the line "git fetch one". But I think
it's worth not getting too carried away with refactoring these tests
;-).

Thanks,
Taylor
