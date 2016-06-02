From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Thu, 2 Jun 2016 13:11:56 +0200
Message-ID: <5750147C.5060609@alum.mit.edu>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <20160601074218.GB14096@sigill.intra.peff.net>
 <20160601210713.GA18118@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 02 13:12:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8QXp-00078t-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 13:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbcFBLME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 07:12:04 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50827 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145AbcFBLMC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 07:12:02 -0400
X-AuditID: 1207440f-8a7ff700000008e4-87-5750147f74f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DE.EA.02276.F7410575; Thu,  2 Jun 2016 07:11:59 -0400 (EDT)
Received: from [192.168.69.130] (p508EAEB0.dip0.t-ipconnect.de [80.142.174.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u52BBuoe028961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 2 Jun 2016 07:11:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160601210713.GA18118@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqNsgEhBu0PCT0WLyhnusFnebMiy6
	rnQzWVz6vJ7V4kdLD7NFX/9EVourW28yWuyefInRgcPjanOAx8Qvx1k9nvXuYfT4vEkugCWK
	2yYpsaQsODM9T98ugTuj8egZ5oJvxhU/j/5mbmA8ot7FyMkhIWAiMXfRT8YuRi4OIYGtjBK9
	05azQDjnmSSaP99gB6liE9CVWNTTzARiCwvoSEw6vg2oiINDRCBdYktfIET9D0aJO/9ngtUz
	C1xmknjxUAfE5hXQlrhx5B8LiM0ioCJxc9EDNhBbVCBE4vy6rawQNYISJ2c+AavhFLCWWPz4
	DCPEHHWJP/MuMUPY8hLb385hnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyY
	l5dapGuil5tZopeaUrqJERLe/DsYu9bLHGIU4GBU4uFl0PEPF2JNLCuuzD3EKMnBpCTKu7IM
	KMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN0cgIFyINyWxsiq1KB8mJc3BoiTOq75E3U9IID2x
	JDU7NbUgtQgmK8PBoSTBWyAM1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPisn4
	YmBUgqR4gPYeFATZW1yQmAsUhWg9xWjMsWzR9bVMHEf231vLJMSSl5+XKiXO6yMEVCoAUppR
	mge3CJbYXjGKA/0tzNsJcg8PMCnCzXsFtIoJaFXBI3+QVSWJCCmpBsZMvt26a5f1t6g++bRL
	r5GhZI8Y05n/dxvWdzvvmyp6bc3hc0tNV8ocn/jLb0NJsNw5pqaVh1ve+H9pTNu/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296194>

On 06/01/2016 11:07 PM, Jeff King wrote:
> On Wed, Jun 01, 2016 at 03:42:18AM -0400, Jeff King wrote:
> 
>> I have no idea if those ideas would work. But I wouldn't want to start
>> looking into either of them without some idea of how much time we're
>> actually spending on strbuf mallocs (or how much time we would spend if
>> strbufs were used in some proposed sites).
> 
> So I tried to come up with some numbers.
> 
> Here's an utterly silly use of strbufs, but one that I think should
> over-emphasize the effect of any improvements we make:
> 
> diff --git a/Makefile b/Makefile
> index 7a0551a..72b968a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -579,6 +579,7 @@ PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
>  PROGRAM_OBJS += upload-pack.o
>  PROGRAM_OBJS += remote-testsvn.o
> +PROGRAM_OBJS += foo.o
>  
>  # Binary suffix, set to .exe for Windows builds
>  X =
> diff --git a/foo.c b/foo.c
> index e69de29..b62dd97 100644
> --- a/foo.c
> +++ b/foo.c
> @@ -0,0 +1,18 @@
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +int main(void)
> +{
> +	const char *str = "this is a string that we'll repeatedly insert";
> +	size_t len = strlen(str);
> +
> +	int i;
> +	for (i = 0; i < 1000000; i++) {
> +		struct strbuf buf = STRBUF_INIT;
> +		int j;
> +		for (j = 0; j < 500; j++)
> +			strbuf_add(&buf, str, len);
> +		strbuf_release(&buf);
> +	}
> +	return 0;
> +}

Thanks for generating actual data.

Your benchmark could do two things to stress malloc()/free()
even more. I'm not claiming that this makes the benchmark more typical
of real-world use, but it maybe gets us closer to the theoretical upper
limit on improvement.

1. Since strbuf_grow() allocates new space in geometrically increasing
sizes, the number of mallocs needed to do N strbuf_add()s increases only
like log(N). So decreasing the "500" would increase the fraction of the
time spent on allocations.

2. Since the size of the string being appended increases the time spent
copying bytes, without appreciably changing the number of allocations
(also because of geometric growth), decreasing the length of the string
would also increase the fraction of the time spent on allocations.

I put those together as options, programmed several variants of the
string-concatenating loop, and added a perf script to run them; you can
see the full patch here:


https://github.com/mhagger/git/commit/b417935a4425e0f2bf62e59a924dc652bb2eae0c

The guts look like this:

> 	int j;
> 	if (variant == 0) {
> 		/* Use buffer allocated a single time */
> 		char *buf = big_constant_lifetime_buf;
> 
> 		for (j = 0; j < reps; j++)
> 			strcpy(buf + j * len, str);
> 	} else if (variant == 1) {
> 		/* One correct-sized buffer malloc per iteration */
> 		char *buf = xmalloc(reps * len + 1);
> 
> 		for (j = 0; j < reps; j++)
> 			strcpy(buf + j * len, str);
> 
> 		free(buf);
> 	} else if (variant == 2) {
> 		/* Conventional use of strbuf */
> 		struct strbuf buf = STRBUF_INIT;
> 
> 		for (j = 0; j < reps; j++)
> 			strbuf_add(&buf, str, len);
> 
> 		strbuf_release(&buf);
> 	} else if (variant == 3) {
> 		/* strbuf initialized to correct size */
> 		struct strbuf buf;
> 		strbuf_init(&buf, reps * len);
> 
> 		for (j = 0; j < reps; j++)
> 			strbuf_add(&buf, str, len);
> 
> 		strbuf_release(&buf);
> 	} else if (variant == 4) {
> 		/*
> 		 * Simulated fixed strbuf with correct size.
> 		 * This code only works because we know how
> 		 * strbuf works internally, namely that it
> 		 * will never realloc() or free() the buffer
> 		 * that we attach to it.
> 		 */
> 		struct strbuf buf = STRBUF_INIT;
> 		strbuf_attach(&buf, big_constant_lifetime_buf, 0, reps * len + 1);
> 
> 		for (j = 0; j < reps; j++)
> 			strbuf_add(&buf, str, len);
> 
> 		/* No strbuf_release() here! */
> 	}

I ran this for a short string ("short") and a long string ("this is a
string that we will repeatedly insert"), and also concatenating the
string 5, 20, or 500 times. The number of loops around the whole program
is normalized to make the total number of concatenations approximately
constant. Here are the full results:


                               time (s)
Test                   0      1      2      3      4
----------------------------------------------------
5 short strings     1.64   3.37   8.72   6.08   3.65
20 short strings    1.72   2.12   5.43   4.01   3.39
500 short strings   1.62   1.61   3.36   3.26   3.10
5 long strings      2.08   6.64  13.09   8.50   3.79
20 long strings     2.16   3.33   7.03   4.72   3.55
500 long strings    2.04   2.10   3.61   3.33   3.26


Column 0 is approximately the "bare metal" approach, with a
pre-allocated buffer and no strbuf overhead.

Column 1 is like column 0, except allocating a correctly-sized buffer
each time through the loop. This increases the runtime by as much as 219%.

Column 2 is a naive use of strbuf, where each time through the loop the
strbuf is reinitialized to STRBUF_INIT, and managing the space is
entirely left to strbuf.

Column 3 is like column 2, except that it initializes the strbuf to the
correct size right away using strbuf_init(). This reduces the runtime
relative to column 2 by as much as 35%.

Column 4 uses a simulated "fixed strbuf", where the fixed-size buffer is
big enough for the full string (thus there are no calls to
malloc()/realloc()/free()).

The comparison between columns 0 and 4 shows that using a strbuf costs
as much as 123% more than using a simple char array, even if the strbuf
doesn't have to do any memory allocations.

The comparison between columns 3 and 4 shows savings a reduction in
runtime of up to 55% from using a "fixed strbuf" rather than a pre-sized
conventional strbuf. I think this is the comparison that is most
relevant to the current discussion.

Of course strbuf manipulation (especially of small numbers of strings)
is unlikely to be a big fraction of the workload of any Git command, so
this is far from proof that this optimization is worthwhile in terms of
code complexity. But I am still moderately in favor of the idea, for two
reasons:

1. The amount of added code complexity is small and quite
   encapsulated.

2. The ability to use strbufs without having to allocate memory might
   make enough *psychological* difference that it encourages some
   devs to use strbufs where they would otherwise have done manual
   memory management. I think this would be a *big* win in terms of
   potential bugs and security vulnerabilities avoided.

Michael
