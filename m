Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E679202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdCOVbX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:31:23 -0400
Received: from mout.web.de ([212.227.17.11]:49945 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbdCOVbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:31:20 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mb90x-1cUomL1dBD-00Kd0f; Wed, 15
 Mar 2017 22:30:46 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
 <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
Date:   Wed, 15 Mar 2017 22:30:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <ffntuqzgjgcfhebokbty@eduj>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kdJ0FRXT0IiPQvJJTzTFpLh9h7w4MFJksbRw83e1TQr/+TiVj4C
 PtCnV73A71oWHG1uTbQHCEIwU9yB+nh13A+OJJ4Kw3E3kBlpiBIC58NTIRpN3sZDMW+J88R
 EkSrz85uaobjyYWSbZaO+Y+aKuUHxxV6b6tJ9Tx06J/DDMP1ZgKDozRdH3k6NEhAcnJEppe
 2Ic+yAM9+Hg88ECM0naBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IF9sFbYethI=:svY4Ewvx9qGSoFZaETULen
 qFHzCr69Q4niVWEic8UmTSNdhRixKCdEji8WSJ7psE9LiVjuknV/rip3lMqO6m9p+y+jLlP/g
 7IebwZ7FRonYoDlqo7dYz1RXXOO2ZYxSxw4yS/P63gekJwRcdZy6cXq+x5lcKx4EN8wF4B5bc
 tSQcUzp7DDje6By989ky9pVox6nLIDcOPQ+zvRq9ZC+vgEAbxiRa/M0+JktZKERLZ85JuWy7/
 BanNcy09SRWdP3FqtqOcDBlOfZyijqEciQB+OtRd5jrgAcRNwG7/7L26mE/yTr0zQ8H0O4g8H
 O7AM6h21FVMSQRLi3Ojl/Icrxn5MHFQWWXXQdHoOutIkiJ9AL+oVN/819uJtIhmw2j27Mun7t
 1DVNRrdUupo8XJFMNoL/7ASa5zBg4CuPXbmLWFDodxWu7RBlqXxLpQldTzN2otzfIEnWwyVDJ
 4XiV0Lt72/3gdPyUAaib9BUPVePwqXaYlpLNGYhDSOoa9o721Fy5rpz4wq5or12S0PD5BMwYX
 JwNPBt+XpYSNeZK9QzRrwMuVDWJW2xI2/7CVRYBI+mte52LQKK4UPzJSVaesAWrewacJUeWxI
 EXglQkIfzHuJbhjz/ZiPf/4dmsEy35+8cq1EOTK2XeYXCWKc9Oc2X9mFg56xCezd+Jb2BYXbi
 sVeC99mdBsnpvoAYI5/iKg6sWPV3FnvHLlEzBrWK6GhAlwuMMuKngOHY9AIkt6/MhfgWpimxb
 PqSnweIJVIAGWcalhW6XiiXGZuiNbmmSpbe2Fp4FKWp44sp/Cpb8JEHisetaTp5jHyoamvndD
 l9WV8o1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
> $ git bisect bad
> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
> commit 7333ed1788b4f2b162a35003044d77a716732a1f
> Author: René Scharfe <l.s.r@web.de>
> Date:   Mon Jul 28 20:26:40 2014 +0200
>
>     setup: convert setup_git_directory_gently_1 et al. to strbuf

That's what I half-suspected, and I think by now I got an idea.  Here's 
a test program:

	#include <errno.h>
	#include <limits.h>
	#include <stdio.h>
	#include <string.h>
	#include <unistd.h>

	int main(int argc, char **argv)
	{
		char buf[PATH_MAX];
		int last_errno = 0;
		size_t len;

		for (len = 0; len <= PATH_MAX; len++) {
			errno = 0;
			getcwd(buf, len);
			if (errno != last_errno) {
				printf("len = %lu, errno = %d, %s\n",
					len, errno, strerror(errno));
			}
			last_errno = errno;
		}
		return 0;
	}

It runs getcwd(2) with buffer sizes from 0 to PATH_MAX and reports when 
the error code changes along the way.  Let's call it test_getcwd.  And 
here's what I get on FreeBSD 10.3:

	$ mkdir /tmp/a
	$ cd /tmp/a

	$ chmod 100 /tmp/a
	$ test_getcwd
	len = 0, errno = 22, Invalid argument
	len = 1, errno = 34, Result too large
	len = 7, errno = 0, No error: 0

	$ chmod 000 /tmp/a
	$ test_getcwd
	len = 0, errno = 22, Invalid argument
	len = 1, errno = 34, Result too large
	len = 2, errno = 13, Permission denied
	len = 7, errno = 0, No error: 0

So if we don't have execute permission and our buffer is at least one 
char long but still too small then we get EACCES (13).  If we don't have 
read permissions and our buffer is big enough then the call succeeds. 
strbuf_getcwd() expects to get ERANGE (34) and nothing else when the 
buffer is too small.

I'd say it's a bug in FreeBSD -- reporting permission denied or success 
based on the size of the supplied buffer makes no sense to me, at least.

The initial buffer size used by strbuf_getcwd() is 128, so you should be 
fine as long as the absolute path to your repository is shorter than 
that.  You should also be fine if you have execute permissions on the 
directory.

And here I'm puzzled again -- you probably have sufficient permissions 
set up for your user, right?  What does the test program report for your 
problematic repository and its parent directories?

René
