Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AFB1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbcHSBwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:52:01 -0400
Received: from mout.web.de ([212.227.15.3]:58785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754555AbcHSBvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:51:17 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LmLOE-1b1cyi2ruk-00ZwA0; Thu, 18 Aug 2016 17:49:10
 +0200
Date:   Thu, 18 Aug 2016 15:49:08 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
Message-ID: <20160818154908.GB17141@tb-raspi>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:Y4GBSmvNCkd/vigWK4pN2k4YZ3A0Bt1XLHjE7VlIWDi4E+mFpSf
 IK08hBGOd14xeL4Z2UvPhF2eY49F4RgW4ZD4Q0qTaY6yMvk2HfAb0KPK9QbJPmky8D+FxQK
 XNqMMaE6x+3HZKbahaeWUMT6nZujqdZB30IPCJYwZsd3ug9lItSVoHeSpFk0yifloiyzY5g
 dU/vW3eY4oVVDsZ15unvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WbGSQ050vG8=:yv7l7OGjVYbGQaVfss3CUE
 kt6brbYEi28ztrI+SvN+iNealNfbKUI4IJV/4C7S2dJAI/XEUFppVVGkKFQ74aKLyC9XPHSId
 qfOEevatkFof8p9GslmyuL+d7/ZzBqsb39lH2lQDfW689mVS8m5b3MC+I/8b1jBi1SCBy62Av
 4bhufWc45EdfKI7YrTa3N77X2qKXnZ0PLY0I5LKRWPIfAHmeQv4B8sr6gyh1fvSMxhk/gizN3
 nyUbLcONyVL7bGt3GFR+1xBZKLdk96nUdqoqPDJG8lYrtBpTmwdsXYgJ4NwNbORcd7kuR7E9s
 JVZO0+XkNb3BqoxlvqQGxfMnu1qTl+7kNW7st4xAcBdomjGxUspxESbzfQxvKcdcQ90RWJgsu
 zVUGr2cuN5gIBOBe0/gHVgLvpwKtOV0neFa426PVGKhH6ycQVB8CUA7RmAOCSEpeyqGNdEP5D
 qmN6uH72psFj3ALKwImD0Rt74xA8U75aBjmYlZVa9vDQce0JKtXxrBUPBnz9znQlxgVbFyvwK
 4sj1HkdduVZlZYVfqLUV1kMtGAdbK4f3WmKxZudgg6l6pivPAbjLx+Kvq/9W4u4cUPqHGvzwV
 TPR7+K64t5hechEJ0C9sQ652N30LXIC6OdFBh81/oC6WLEkovtqHhZDyd0Yt2Age/O4bOzI6G
 5kOLlgqV3S5fW6+LhVq2td0rUI9t39hVOMTgZS8vTPLhIimhKKoexIHZ+9/4zsyuUWAjiq32B
 PySOaxbqb9SgeyzORvRSmGHPY6S17MbGQ8PfTTFcCh4r43J9hR1HgB2Ei04=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:
> As suggested by its name, the --filters option applies the filters

[]
> diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
Does it make sense to integrate tests into t1006-cat-file ?
> new file mode 100755
> index 0000000..e466634
> --- /dev/null
> +++ b/t/t8010-cat-file-filters.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='git cat-file filters support'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
> +	echo "hello" | append_cr >world.txt &&
> +	git add .gitattributes world.txt &&
> +	test_tick &&
> +	git commit -m "Initial commit"
> +'
> +
> +has_cr () {
> +	tr '\015' Q <"$1" | grep Q >/dev/null
> +}
> +
> +test_expect_success 'no filters with `git show`' '
> +	git show HEAD:world.txt >actual &&
I would prefer to have something using
  cat >expect <<-\EOF &&
  xxx
  test_cmp expect actual
to make it easier to debug in case of a failure ?
