Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053A11F404
	for <e@80x24.org>; Tue, 28 Aug 2018 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeH2CtF (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 22:49:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44495 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeH2CtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 22:49:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so1368719plb.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s7wtzcaasZnZj7KihxdZYHsZ75sff8vsfCzn8OCLpig=;
        b=mirXUxl9us6aXPVHf5SXf0h3s3DAYvTIWhHldtG1Ub9guk+3SU4uDOVHFiNEPdqKbD
         OtN5nh4Kb6SyqRgcKDBN287d8gjOJHK2pcpq5Qj+whLP91jAIsqlNwlWEkxwwnz6D6+T
         qjLRVjnH7SOgoWLdKKkkOOjwY8QkX9ETdUIPxYjUMWK4TEnBYHsiu8fTbRd4Ybkwjy7D
         i7myPJyKbTItprGmhqIlrx5/vgWii7GTcNjl7uKFbfF/y/XWprSGfNMdru3eAMEKapQI
         1DQjDIkMJYSvgKYbb9tLdt18CqxoHw+ERgM6bc58dUBciDe6oPTdLVu/Q9tM+zhFd8cP
         hS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s7wtzcaasZnZj7KihxdZYHsZ75sff8vsfCzn8OCLpig=;
        b=FMTretWpAHujDIQeV/ahI5UtUAuf0crtXtUUR/M25JOnsxQtixizXwAj8H6LeK06k4
         6g/jq9K2R7PEWFILTTV6r/iQ8GJRG9gFG1KIh9iw85Z4neCcYhkNMI41edziac1hLZRi
         Hb4XXSbzH8O0FNrthimIMi7XA3iUVZwJ6mfa6CvYp/xr3ylRU3bEWH77C0mUxThsi7Jj
         980lgOrisXTEXMO/gDZjYOR6/yhNYPX+cD/cj28fMadBkKFEG2NWRndps1/ormqbeuMo
         XByef6PmaUGtmjHxNQ5HfXlwUIUYRZi2Sa+8uyw4OcouROGE9Lm1D9wvDH5HclVO2Xis
         29qA==
X-Gm-Message-State: APzg51BKkyLiZ5iumpRvG3XQQpJK/INqtyNiLwRzM/eYw4cDcELR2N1H
        PGBdGOsRzbLkPWNWjqVcBHY=
X-Google-Smtp-Source: ANB0VdbWvsetTHbc5G6AJr8XN8wHKehU69sINEFkbqV9DLZoN40+Fs/x1gzPY+oo1JV41IAMbJxR3g==
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr3431894pld.319.1535496914594;
        Tue, 28 Aug 2018 15:55:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l84-v6sm5340377pfg.3.2018.08.28.15.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:55:13 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:55:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH 2/2] tests: fix non-portable iconv invocation
Message-ID: <20180828225512.GB74687@aiede.svl.corp.google.com>
References: <20180828193827.8648-1-avarab@gmail.com>
 <20180828193827.8648-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828193827.8648-3-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> The iconv that comes with a FreeBSD 11.2-RELEASE-p2 box I have access
> to doesn't support the SHIFT-JIS encoding. Guard a test added in
> e92d62253 ("convert: add round trip check based on
> 'core.checkRoundtripEncoding'", 2018-04-15) first released with Git
> v2.18.0 with a prerequisite that checks for its availability.
>
> The iconv command is in POSIX, and we have numerous tests
> unconditionally relying on its ability to convert ASCII, UTF-8 and
> UTF-16, but unconditionally relying on the presence of more obscure
> encodings isn't portable.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t0028-working-tree-encoding.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

One nit:

[...]
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> index 12b8eb963a..b0f4490e8e 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -203,7 +203,11 @@ test_expect_success 'error if encoding garbage is already in Git' '
>  	test_i18ngrep "error: BOM is required" err.out
>  '
>  
> -test_expect_success 'check roundtrip encoding' '
> +test_lazy_prereq ICONV_SHIFT_JIS '
> +	iconv -f UTF-8 -t SHIFT-JIS </dev/null 2>/dev/null

Is this 2>/dev/null needed?  Leaving it out should make the test
easier to debug.

If I'm reading it correctly, test_run_lazy_prereq_ appears to respect
the normal --verbose etc settings, which means that the 2>/dev/null
could be left out.  A quick check[*] with and without -v seems to bear
this out.

> +'
> +
> +test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
>  	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
>  	test_when_finished "git reset --hard HEAD" &&

With that tweak (removal of 2>/dev/null), this is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[*]
 diff --git i/t/t0000-basic.sh w/t/t0000-basic.sh
 index 850f651e4e..879f63118e 100755
 --- i/t/t0000-basic.sh
 +++ w/t/t0000-basic.sh
 @@ -25,6 +25,10 @@ try_local_x () {
  	echo "$x"
  }
  
 +test_lazy_prereq NOISY_TEST '
 +	echo >&2 "PAAARTY!"
 +'
 +
  # This test is an experiment to check whether any Git users are using
  # Shells that don't support the "local" keyword. "local" is not
  # POSIX-standard, but it is very widely supported by POSIX-compliant
 @@ -35,7 +39,7 @@ try_local_x () {
  # fails this test, you can ignore the failure, but please report the
  # problem to the Git mailing list <git@vger.kernel.org>, as it might
  # convince us to continue avoiding the use of "local".
 -test_expect_success 'verify that the running shell supports "local"' '
 +test_expect_success NOISY_TEST 'verify that the running shell supports "local"' '
  	x="notlocal" &&
  	echo "local" >expected1 &&
  	try_local_x >actual1 &&
