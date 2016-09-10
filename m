Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C561207DF
	for <e@80x24.org>; Sat, 10 Sep 2016 05:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbcIJFvq (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 01:51:46 -0400
Received: from mout.web.de ([212.227.15.3]:63402 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbcIJFvp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 01:51:45 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Ljahc-1bBSIk02Mi-00bY2a; Sat, 10 Sep 2016 07:51:22
 +0200
Date:   Sat, 10 Sep 2016 05:51:19 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v4 1/3] tests: move test_lazy_prereq JGIT to test-lib.sh
Message-ID: <20160910055119.GA11001@tb-raspi>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473441620.git.jonathantanmy@google.com>
 <37c4e775948b88b2d5af1caee3a70e36f00bc88a.1473441620.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c4e775948b88b2d5af1caee3a70e36f00bc88a.1473441620.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:U5cQDzodS741rep5hEjSJTGdwSrokU99MPVe8Lae8GTDOFZGD8x
 f84SJfOZNysP3jm1qLArCivQBgTheQ31gzUhyLiIu9Gh+94tdEV9dQ1Ubdru8gH5ihyDdcE
 /AVP/fKG8HiDofCUkLBmPsWcw5Px84fGKlx9Yt5v1XMYDDGPcBI7sQVba7Nrm/RK75Phwna
 giB2UxkqbKwqyjYMlsdsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sLRTNOQCpTc=:/5MEjvjiqM6G0FK0LXbceB
 yZm6CRnCXYwxk/bWSd5N5NHxROXzog/oq6H5Eo3LWWtUK0uA4bl5PVKHj8KOmKH9MVrkplQrH
 gJ7dbiQw59nzKZqypKI2qQJhch00sPGMW27r5W1gHNhpQUtWLUF3hAIygDNoTJ6pZQRl8b2yD
 HxUuFJF0o6SxcFTor6gZ6qvJ/VAfPLjWDB2zeFbYenQYTSTc3zr3/Oc4odXUmHk0RCApGAohs
 LdlFu4QKgLKq6/1eppDtP4LSvBnAWnnB69rzEN6c20r6YTz/08ogNtp1Pa61VX9ufiLU0pLwD
 CEbdkEDgzZZkvMgpaC5Oc3kFyWiFca/5QQZ9MXdKv5v1MzcMj+wjkwkFbAWVDz/XKUd3qyAFi
 oc6J4LHRRovLreFDep/tjeLIk5YucixeE1mvg41PS13LcmmfI5e6j/KmsWY7z3Vw8DlYx0B1r
 M+lYpefVH8j9yFTn618ZYHsnLMxgA9NyuA9llTIegh3+jh0JD/Cx7/9kr+iYjJHxbfmK66L3P
 4z+981sImGz0bi4c5al7u4IA606QtRuVMakf2jTEM1jfxGjLzmcYJsGtc1YdgE3ThR7/8/8Am
 F/CZ31xb9GmCQTy49kAZLWanjPcO49i9IEbeoVYxDEzcRFgziv1cXnVcZUfWWvtu2D/+oB07u
 xild6Fd5v2jRcj0eZYojqLSLYJg9b3V03BKsYREPhnOBkXEZLKZmjfL8XuSzMYSbtmUhrudLF
 npI02aamu1LWPyVYubrCH8lR79CP+RXByQBxKZgoGi0ubtqZXTPXhfNUptk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 10:36:28AM -0700, Jonathan Tan wrote:
[]
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d731d66..c9c1037 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1072,6 +1072,10 @@ test_lazy_prereq NOT_ROOT '
>  	test "$uid" != 0
>  '
>  
> +test_lazy_prereq JGIT '
> +	type jgit
> +'
> +

Minor note: 
Typically the stdout of `which` is suppressed like this:

if ! type cvs >/dev/null 2>&1
