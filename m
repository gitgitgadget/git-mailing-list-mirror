From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t7012: Implement test for git-checkout
Date: Fri, 25 Mar 2016 23:32:52 +0100
Message-ID: <56F5BC94.1070903@web.de>
References: <56F57714.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Chhatoi Pritam Baral <chhatoipritam@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 23:33:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajaHu-0007Tl-7p
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbcCYWc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:32:58 -0400
Received: from mout.web.de ([212.227.15.3]:58196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbcCYWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:32:57 -0400
Received: from macce.local ([79.223.115.132]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MWAtV-1aGilw1nRp-00XO0l; Fri, 25 Mar 2016 23:32:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <56F57714.4050708@gmail.com>
X-Provags-ID: V03:K0:la82GwvMtkgHMTfTds6MOWQOHZoPJVsW2WhOVOk+EUREwVIwVxK
 PaWH0wOh/nFCc4CUoEoJbW0CVri9xptXaU5mdDetMbwrPbaH06ma5me1exAY6vQXArEvP2b
 7J2sPYQCjo3NlYsVSIaSQeDJv7L71vZ5aaWQBiq8diZ+EFrKalRr3j0Xo+gFHjwWFTl7MIa
 4VvgRJe1S2t//5HohBhzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KPDc16HDNDM=:L3eXsTcaYQfS/fdGJ26nzQ
 Pns0Q1Ge7gQuNZqxF+BUaN2s1CYRGgq3Zs5o5bXloumeVa1ZmTVu+aSVbueEcMfx4mJqV/wor
 sI6gaMvbSJ5INPZnK2pF7AjB7slNd8OrC69qPODCLsLlFR4vLiTwXdBOCZNQXzNwZSsHdakvj
 TB16TWXnDyb5aEAGAWJo3ofhg7hGSK28ZLOhZKtujiDzzEacl3o19eG63rMwznHKyP8XROMV3
 qkOxIGx/QZh/6VrNDAibb5ghnVKOZ11GDvTKaOBy3f4hlliEsu7iyzk9s8nl7aXh/N4O+cEfg
 tUNRQS+M8Ct/j7oky+jVzynCZu7nEhLZ7x1MEPhz9J9O2IhCajEre6lsmVXCDyGzm0RKDXTZG
 Uhy3Yb1RmZd2+W31hfHwuyejUqFaKT5ZbikPNUnJeZdK6P1uEYvqHG0TZEf1/g9Vk9wZ8vDXT
 RUIeBhjP8ZFjHKU+x2qpDg8d/Ss/A9PQ6mabaXPZlX5CifMAqy6vd/wi+3mUw++oTCIE0b3Wy
 zBX0RW3MF67Jb+3296SKnwvOUT8PQuFynze9omIWmLOrHSP/bxPuXgsJhJZCcJJjnmOrGcZbN
 RN1K1dG2GJt520O9UDsMkggi4nEZAkXvKJhQWHRZdlNefBY+FNk2DKW78pDmlvsD1z1YXyFcz
 vGI64TM27TPCRBgq34wRXzoGp2A4vNX5BWjfOQRVCxTGqLJ4ZawvYfguX1th4hY8/wZ9gY3yE
 1znuSf1oNU3xn4CONn3hYHbvaqWYghHCE9DqY+4VGs9XJyvoGxZdD6AEhGsDnXBw2kxv5qs7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289958>

On 2016-03-25 18.36, Chhatoi Pritam Baral wrote:
Thanks for working on Git.
Some comments inline.
> Previously a TODO, this patch adds a test for git-checkout skipping a
> file with the
> skip-worktree bit set.
Micro-nit: the "this patch ..." may be written shorter:
> Previously a TODO, add a test for git-checkout skipping a
> file with the skip-worktree bit set.

> 
> I'm doing this as a microproject for my GSoC '16 application.
This info is good to have, but doesn't need to stay forever in the
commit message. It may be below (see XXX)
> 
> Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
> ---
XXX Add additional info here.
>  t/t7012-skip-worktree-writing.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7012-skip-worktree-writing.sh
> b/t/t7012-skip-worktree-writing.sh
> index 9ceaa40..d5b42d6 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
>  #TODO test_expect_failure 'git-apply removes file' false
>  #TODO test_expect_failure 'git-mv to skip-worktree' false
>  #TODO test_expect_failure 'git-mv from skip-worktree' false
> -#TODO test_expect_failure 'git-checkout' false
> +
> +test_expect_success 'git-checkout ignores skip-worktree file' '
> +	echo > 1 &&
Style: No space after the '>', like this:
echo >1 &&

> +	git commit -m "Add files" &&
> +	echo dirty > 1 &&
> +	echo dirty > 2 &&
> +	git update-index --skip-worktree 1 &&
> +	git checkout -- . &&
> +	grep -q dirty 1 &&
> +	test_must_fail grep -q dirty 2
> +'
>   test_done
> 
