From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Wed, 8 Jul 2015 10:09:37 +0200
Message-ID: <559CDAC1.8030600@web.de>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 10:10:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCkQj-0000Xq-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 10:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933946AbbGHIKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 04:10:00 -0400
Received: from mout.web.de ([212.227.15.3]:63994 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934093AbbGHIJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 04:09:42 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LzEO1-1YzdQp0BFZ-014WaM; Wed, 08 Jul 2015 10:09:38
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
X-Provags-ID: V03:K0:tx/Zpb6DcXSvwuk9VqF1u8uRT0COT7cCXVtWk8Dnm9G3thzjMRE
 bcd5hbMgbQ23pmX2AZ1USMk5ELonzI1hG2Et+lJ/X3QDCVG2VrH2LA1oo+ED1pVD7awrJKn
 cqLmsvaKyrDiE9rBz2J10l+0HJH0gXmzKWcXtwNVmC78kMGf6xbfG1kb1ukYxElmshIDZGf
 bWIGoGXEjY77JGwcxeFEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F/k90bAwsMU=:hhm8HGjBf0WnRu0lNeHKl3
 HxBfVJ35+bkNPg4Nq1M9dfMRmiW5pI6jxCdCaOHkMB/nqNT+Sk80nhdZLq8Rd2uhcsrAztjUT
 Siqnfc9d4UB5jCegrEJvKe+uBW4BrM/TRhdMcqP5JuX4UiV7nMPr542A1i1BB31th5tIwLL/n
 XsA8YOJy6fQNBR3WrIIFEAT94OOUAZwcMd145EjNU7IcbYvl/HV33rBFOZu2MpYycsXW0YTBk
 sZw3VPZA6MNE0w6KlCR3cmPX5DFgRq43vOrubrcRzkP/AW/2sxbhYKxtU4G14LjmOUNlSE75Y
 /yxw6nGUWVYdKEa6Wwk+dCjT+cKEA+KcrK/+4Wjblbp/4Ed+ldZ72osrg4a6R2gt+bgD8v3FK
 O7eGP0zImI/uqGE/9E+NX9MWJ+iBrgjgv28dCm7td0gwehqweAakEbOjFXEMe5KtT8RVPIug+
 e+NqOva81AJ8UZ6g4Qq/vWmPu85ym0La0McELgP+e8Uv5m+PTIvy9vH1/9ynevYHskpTLS743
 AN8X6XtbTBY7dUC7RDqYziCSQockPRtumTp7WxOgBXKo5GNkCsD4QVTDrPymzZ9IpzTtjqOnU
 ph65R5m33JfAyHDffi1DP0RSiWGmNIUdOgtVQGvscVybfGhUHOhh9YMxOT9ieuztlP3Rl88eP
 LrevFFM2vd+RT7351z+l1P8oN81g8SZwH09+TJpsf4XUUSsOXkEu3Y+UxT+tyCgB41u0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273652>

On 2015-07-07 18.06, Karthik Nayak wrote:
> Add a test suite for testing the ref-filter APIs used
> by for-each-ref. We just intialize the test suite for now.
> More tests will be added in the following patches as more
> options are added to for-each-ref.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  t/t6302-for-each-ref-filter.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100755 t/t6302-for-each-ref-filter.sh
> 
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> new file mode 100755
> index 0000000..44d2f24
> --- /dev/null
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +test_description='test for-each-refs usage of ref-filter APIs'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-gpg.sh
> +
> +test_expect_success 'setup some history and refs' '
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three &&
> +	git checkout -b side &&
> +	test_commit four &&
> +	git tag -s -m "A signed tag message" signed-tag &&
> +	git tag -s -m "Annonated doubly" double-tag signed-tag &&
> +	git checkout master &&
> +	git update-ref refs/odd/spot master
> +'
> +
> +test_done
> 
Could we have a tweak for people without gpg?

error: cannot run gpg: No such file or directory
error: could not run gpg.
error: unable to sign the tag
not ok 1 - setup some history and refs
