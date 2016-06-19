Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F3520189
	for <e@80x24.org>; Sun, 19 Jun 2016 16:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFSQ4u (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 12:56:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35410 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbcFSQ4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 12:56:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so3715242wme.2
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 09:56:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v7OZNF8ZC8PZT9+dbbtacSy9NmOjFmjOFIOQq3pdXIE=;
        b=Z0Qk0UVVW5GRi83ofHS242hZVZPpaJTWoS23qpN4waLnOxfp7qiZ/xDQg6SCl/TP8f
         MzpPGDUcT5GVCtpGIINfgJQMtVU2xx0tAZgCKfakk5YMFPHrT5QOCz2eV+FE8giUfUMB
         DIcDFM8MwFg15/3Bfiz1sJItFvx66D7q1SOOMOZ8uOo0Zuanj5CkQQo3BxPpEczgaszb
         6Fsa1hMyKHv4Vzc/yrbHHEzItMkTq4qVq6FtKrE5/w8AmABfshWIgoqATRKoBeNqxgr/
         qThlk+GKJ4VinRFwWJqbp5ncyr1O5AUslaqEqHESD4QUPTNE+FuSCxa3cCzr/3KIZWSM
         G2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v7OZNF8ZC8PZT9+dbbtacSy9NmOjFmjOFIOQq3pdXIE=;
        b=LHTThjTXejTruW9JsnksLx+us7X365FWc+fLoF+To7kR2dOzdKmwYyhBByS/ej98Zt
         F3l6o97dLifIVa2sPaJNIw6VPu7lqi56nPM1VPWGW7B5JF54n1d/RQ7/6FpPUMCFdHFG
         JQu9RMvnOADh68n/m4V9iX61kQyn3I8hZi+Pb4O5VLnOXsH0N/CVxtf7AyCWnNwcMenm
         zGgcE77TIsdRc2o1SQxbSzVeQtaLux/PFl4uQP15OcbPLZ3OAjuPbDxTkB7+r0hYvUoL
         wpf7cudYbUYxVy3pz6ELv5tw1z8UDXq7GOl8J5z1pNekRuvikM+mox19/KhipMQg1A2Y
         //Mg==
X-Gm-Message-State: ALyK8tJgDTHMhIDL9zV11j2M+2gUeMlEmXjh2ABPRZhXUZ1JDTlwDtw6MkXI7MzFuNaSuw==
X-Received: by 10.194.201.102 with SMTP id jz6mr10481715wjc.101.1466355408557;
        Sun, 19 Jun 2016 09:56:48 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id zb9sm12930286wjc.34.2016.06.19.09.56.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jun 2016 09:56:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] perf: accommodate for MacOSX
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
Date:	Sun, 19 Jun 2016 18:56:46 +0200
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 18 Jun 2016, at 15:03, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> As this developer has no access to MacOSX developer setups anymore,
> Travis becomes the best bet to run performance tests on that OS.
We don't run the performance tests on Travis CI right now.
Maybe we should? With your patch below it should work, right?

I only saw one error on my local OS X machine here:
https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/perf/p0000-perf-lib-sanity.sh#L26

Does the export of foo not work properly on OS X? "$foo" is empty...

- Lars


> However, on MacOSX /usr/bin/time is that good old BSD executable that
> no Linux user cares about, as demonstrated by the perf-lib.sh's use
> of GNU-ish extensions. And by the hard-coded path.
> 
> Let's just work around this issue by using gtime on MacOSX, the
> Homebrew-provided GNU implementation onto which pretty much every
> MacOSX power user falls back anyway.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/perf-macosx-v1
> 
> 	This is another of those patches that came up in my rebase--helper
> 	work, even if it is not quite obvious from the patch ;-)
> 
> .travis.yml        | 2 +-
> t/perf/perf-lib.sh | 6 +++++-
> 2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index c20ec54..0e569bc 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -82,7 +82,7 @@ before_install:
>       brew tap homebrew/binary --quiet
>       brew_force_set_latest_binary_hash perforce
>       brew_force_set_latest_binary_hash perforce-server
> -      brew install git-lfs perforce-server perforce gettext
> +      brew install git-lfs perforce-server perforce gettext gnu-time
>       brew link --force gettext
>       ;;
>     esac;
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 18c363e..773f955 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -127,11 +127,15 @@ test_checkout_worktree () {
> # Performance tests should never fail.  If they do, stop immediately
> immediate=t
> 
> +# Perf tests require GNU time
> +case "$(uname -s)" in Darwin) GTIME="${GTIME:-gtime}";; esac
> +GTIME="${GTIME:-/usr/bin/time}"
> +
> test_run_perf_ () {
> 	test_cleanup=:
> 	test_export_="test_cleanup"
> 	export test_cleanup test_export_
> -	/usr/bin/time -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> +	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> . '"$TEST_DIRECTORY"/test-lib-functions.sh'
> test_export () {
> 	[ $# != 0 ] || return 0
> -- 
> 2.9.0.119.gb7b8d21
> 
> base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

