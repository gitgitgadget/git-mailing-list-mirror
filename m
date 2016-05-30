From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] strbuf: add tests
Date: Mon, 30 May 2016 13:26:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605301323310.4449@virtualbox>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 13:27:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7LLc-00013N-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 13:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbcE3L04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 07:26:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:55279 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbcE3L0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 07:26:55 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lb4vZ-1bnWi11tWL-00keEs; Mon, 30 May 2016 13:26:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xs7xSkQEJ5KBNFESEFi9lekft0P/cfmyxtvEbaPIoeApGymzBWz
 h+JB0H7fbs2TEfzEkrhmOY4Cy7/lDYz3ZwdWKRORhcnmPNFNPOSE+51EbLVfhT3i5Cxcfcd
 4JT9u3U6EAtVEp9QoDvoByrlN4FQm11lFiZtfg8a28JCM5kxQDtGQgmRgep0DL/9PT3wKkO
 aYVJOe1/Xzy5GbZcbiPzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l0Ht50GQNu0=:WXD6cTQN5/T8DZtelc6Noh
 QL59TC5NBkNcrcbJxw3qyMvab0BIpKFK2NQzT2RtZFoOe79XlvCzKmmyB0BergH/9UaX5wPaC
 MJQRB9cSSw8JXH/22yH6mdflFje98f2/jbidmPFcbWww4dUCRq6NUZOJW+rybNSGHEh9r60Cc
 VaKoYhKVSp2JU0k/PwgHkq5azOb7qqw1BzFB6FO6QEFjnDTaRwz6K96LHboTbdrTJkY9Uxyi1
 dRlo7AifxjN0jfTQByFzM7V0drkiW2iWPs9whOA2sdujqI2NmOYmnQTdA2TxnjM9VLmbUrVuo
 SZRawVNJSRD0WjKPRI0MRgwZ81d2rMFi/x2XxxM46zfwpgbIuGJDg7kdWCjDRuqzzAmnEIqiK
 30Pp2DVcARomNFIQ5mnXMaIOEtO/6CNAfY4fVW+NRP/WuQAnISnkFI8fIqZzywTI+O5b9Fy6T
 0WBfDnNP4l9sjilDXdZcfxyRhB/oh3pucEJRb8XH64naykJWMMDCriALLA3R7NaxL3KxctAPT
 AwHoEOXeURPs8d6gPDY/dh/j7NZp1JQzSS+iVjlNHW2QgiN4p/Rhx66fA9ZIep+tZ8RT6NEg0
 Xp1CfE4D5efV6XPA4d+lA229gvSkx9yBXbN8GB4SF9lvXqXchGF4KGMrq75cncheIySlKvTP+
 pUbekhcOsRJ3tJq0MFdQ+AqY1YexPA+6E7yWTbfjEDWrJTXic7xlWMRQWkTNYrfBZRxZYwdF/
 0b2cPOVNoMHEbCpltvGQAAXjekXQVF1ZlDNsuPw9pn8SfGWO2sr/GW3fZDtrRvxhrq6DOvjQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295888>

Hi William,

On Mon, 30 May 2016, William Duclot wrote:

> Test the strbuf API. Being used throughout all Git the API could be
> considered tested, but adding specific tests makes it easier to improve
> and extend the API.
> ---

The commit message makes sense. Please add your sign-off.

>  Makefile               |  1 +
>  t/helper/test-strbuf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  t/t0082-strbuf.sh      | 19 ++++++++++++++
>  3 files changed, 89 insertions(+)
>  create mode 100644 t/helper/test-strbuf.c
>  create mode 100755 t/t0082-strbuf.sh
> 
> diff --git a/Makefile b/Makefile
> index 3f03366..dc84f43 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -613,6 +613,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
>  TEST_PROGRAMS_NEED_X += test-sha1
>  TEST_PROGRAMS_NEED_X += test-sha1-array
>  TEST_PROGRAMS_NEED_X += test-sigchain
> +TEST_PROGRAMS_NEED_X += test-strbuf
>  TEST_PROGRAMS_NEED_X += test-string-list
>  TEST_PROGRAMS_NEED_X += test-submodule-config
>  TEST_PROGRAMS_NEED_X += test-subprocess
> diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
> new file mode 100644
> index 0000000..622f627
> --- /dev/null
> +++ b/t/helper/test-strbuf.c
> @@ -0,0 +1,69 @@
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +/*
> + * Check behavior on usual use cases
> + */
> +int test_usual(struct strbuf *sb)

I have to admit that I would prefer a more concrete name. And since your
other tests are more fine-grained, maybe this one could be split into
multiple separate ones, too?

> +{
> +	size_t size, old_alloc;
> +	char *res, *old_buf, *str_test = malloc(5*sizeof(char));

Our convention is to list the initialized variables first, the
uninitialized ones after that, and for readability an empty line is
recommended after the variable declaration block.

> +	strbuf_grow(sb, 1);
> +	strcpy(str_test, "test");
> +	old_alloc = sb->alloc;
> +	strbuf_grow(sb, 1000);
> +	if (old_alloc == sb->alloc)
> +		die("strbuf_grow does not realloc the buffer as expected");
> +	old_buf = sb->buf;
> +	res = strbuf_detach(sb, &size);
> +	if (res != old_buf)
> +		die("strbuf_detach does not return the expected buffer");
> +	free(res);
> +
> +	strcpy(str_test, "test");
> +	strbuf_attach(sb, (void *)str_test, strlen(str_test), sizeof(str_test));
> +	res = strbuf_detach(sb, &size);
> +	if (res != str_test)
> +		die("strbuf_detach does not return the expected buffer");
> +	free(res);
> +	strbuf_release(sb);
> +
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	size_t size = 1;
> +	struct strbuf sb;

The common theme in our source code seems to initialize using
STRBUF_INIT... Let's use that paradigm here, too?

> +	char str_test[5] = "test";
> +	char str_foo[7] = "foo";
> +
> +	if (argc != 2)
> +		usage("test-strbuf mode");

A nice and convenient way to do command-line parsing is to use the
parse-options API, in this case with OPT_CMDMODE. This would also give us
a chance to document the command modes in a nice and succinct way: as help
strings.

> +
> +	if (!strcmp(argv[1], "basic_grow")) {
> +		/*
> +		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer

s/allocate/&s/

> +		 */
> +		strbuf_init(&sb, 0);
> +		strbuf_grow(&sb, 0);
> +		if (sb.buf == strbuf_slopbuf)
> +			die("strbuf_grow failed to alloc memory");
> +		strbuf_release(&sb);
> +		if (sb.buf != strbuf_slopbuf)
> +			die("strbuf_release does not reinitialize the strbuf");
> +	} else if (!strcmp(argv[1], "strbuf_check_behavior")) {
> +		strbuf_init(&sb, 0);
> +		return test_usual(&sb);
> +	} else if (!strcmp(argv[1], "grow_overflow")) {
> +		/*
> +		 * size_t overflow: should die()
> +		 */
> +		strbuf_init(&sb, 1000);
> +		strbuf_grow(&sb, maximum_unsigned_value_of_type((size_t)1));

A comment "If this does not die(), fall through to returning success, to
indicate an error" might be nice here.

> +	} else {
> +		usage("test-strbuf mode");
> +	}
> +
> +	return 0;
> +}
> diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
> new file mode 100755
> index 0000000..0800d26
> --- /dev/null
> +++ b/t/t0082-strbuf.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +test_description="Test the strbuf API.
> +"

This description does not need a new-line, and existing one-liner test
descriptions seem not to be terminated by a period.

The rest of this patch looks good.

Ciao,
Johannes
