From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] strbuf: add tests
Date: Tue, 31 May 2016 04:04:55 +0200
Message-ID: <574CF147.8020507@alum.mit.edu>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, matthieu.moy@grenoble-inp.fr
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 04:05:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Z3T-0007mJ-Dm
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 04:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162345AbcEaCFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 22:05:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54642 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161746AbcEaCFA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 22:05:00 -0400
X-AuditID: 1207440c-c53ff70000000b85-6e-574cf14ac241
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DB.8C.02949.A41FC475; Mon, 30 May 2016 22:04:59 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V24tZ9018450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 22:04:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqOv90SfcYPI3FovJG+6xWtxtyrDo
	utLNZHHp83pWi6tbbzJa7J58idGBzeNqc4DHxC/HWT0+b5ILYI7itklKLCkLzkzP07dL4M6Y
	2HKYtWC/QcX+09OYGxjPqHUxcnJICJhIfH38ibGLkYtDSGAro8TfttVQzgUmiRN/V7N2MXJw
	CAtoSaxYHwfSICIQKXGuYTI7RE03o8T0t9fAHGaBlYwSR+b8ZgepYhPQlVjU08wEYvMKaEtM
	m/AZLM4ioCqx7tJkNhBbVCBE4vy6rawQNYISJ2c+YQGxOQW8JbqmfwOrZxbQk9hx/RcrhC0v
	sf3tHOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSml
	mxghIcyzg/HbOplDjAIcjEo8vBHdPuFCrIllxZW5hxglOZiURHlZXwCF+JLyUyozEosz4otK
	c1KLDzFKcDArifAGvAbK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	eBM/ADUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg6IyvhgYlyApHqC9z9+D7C0u
	SMwFikK0nmLU5Tiy/95aJiGWvPy8VClx3iKQHQIgRRmleXArYAnrFaM40MfCvAogVTzAZAc3
	6RXQEiagJfEZYEtKEhFSUg2MsQuXrvGWkI26X7aMN6rj+jXH/euvt928dfbTat1JERbyXdef
	La48b18ddWar8Wfb2icy3V5M7S8fyXsW/hftXKDv8f/csmv/gn/brxKzsS3wKLn9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295945>

Hi,

Cool that you are working on this! See my comments below.

On 05/30/2016 12:36 PM, William Duclot wrote:
> Test the strbuf API. Being used throughout all Git the API could be
> considered tested, but adding specific tests makes it easier to improve
> and extend the API.
> ---
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

Is there a particular reason that you pass `sb` into the function? Why
not use a local variable?

It wouldn't hurt to declare this function static, because it is only
used within this one compilation unit. On the other hand, in this
particular case I don't think it matters much one way or the other.

> +{
> +	size_t size, old_alloc;
> +	char *res, *old_buf, *str_test = malloc(5*sizeof(char));

There is no reason to multiply by `sizeof(char)` here, and we don't do
it in our code. (According to the C standard, `sizeof(char)` is always 1.)

> +	strbuf_grow(sb, 1);
> +	strcpy(str_test, "test");
> +	old_alloc = sb->alloc;
> +	strbuf_grow(sb, 1000);
> +	if (old_alloc == sb->alloc)
> +		die("strbuf_grow does not realloc the buffer as expected");

It's not ideal that your test depends on the details of the allocation
policy of strbuf. If somebody were to decide that it makes sense for the
initial allocation of a strbuf to be 1024 characters, this test would
break. I know it's implausible, but it's better to remove this coupling.

You could do it by ensuring that you request more space than is already
allocated:

    strbuf_grow(sb, sb.alloc - sb.len + 1000);

On the other hand, if you *want* to test the details of strbuf's
allocation policy here, you would do it explicitly rather than as the
side effect of this test. For example, before calling `strbuf_grow(sb,
1000)`, you could insert:

    if (sb.alloc > SOME_VALUE)
            die("strbuf_grow(sb, 1) allocated too much space");

Though my opinion is that if you want to write tests of strbuf's
allocation policies, it should be in an entirely separate test.

> +	old_buf = sb->buf;
> +	res = strbuf_detach(sb, &size);

Since you don't use `size`, you can pass `NULL` as the second argument
of `strbuf_detach()`. The same below.

Alternatively, maybe you want to add a test that `strbuf_detach()` sets
`size` to the expected value.

> +	if (res != old_buf)
> +		die("strbuf_detach does not return the expected buffer");
> +	free(res);
> +
> +	strcpy(str_test, "test");

Near the beginning of the function you have this exact line, but here
you do it again even though str_test wasn't touched between the two
lines. One of them can be deleted...

...but in fact it would be easier to initialize str_test using our
xstrdup() function:

    char *str_test = xstrdup("test");

> +	strbuf_attach(sb, (void *)str_test, strlen(str_test), sizeof(str_test));

Since str_test is a `char *`, `sizeof(str_test)` returns the size of the
pointer itself (e.g., 4 or 8 bytes, depending on your computer's
architecture). What you want here is the size of the memory that it
points at, which in this case is `strlen(str_test) + 1`.

(You may be confusing this pattern with code that looks like this:

    char str_test[5];

In this case, `sizeof(str_test)` is indeed 5, because `str_test` is an
array of characters rather than a pointer to a character. It's confusing.)

Also, you don't need to cast `str_test` to `void *`. Any pointer can be
converted to `void *` implicitly.

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
> +	char str_test[5] = "test";
> +	char str_foo[7] = "foo";

`size`, `str_test`, and `str_foo` are all unused.

You should compile using `DEVELOPER=1` to enable a bunch of compiler
warnings that Git developers tend to use. Any code you write should
compile without warnings or errors when compiled with that setting. See
`Documentation/CodingGuidelines` for more info.

> +
> +	if (argc != 2)
> +		usage("test-strbuf mode");
> +
> +	if (!strcmp(argv[1], "basic_grow")) {
> +		/*
> +		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer
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
> +	} else {
> +		usage("test-strbuf mode");
> +	}

Consider putting each test in a separate function, rather than
implementing some tests inline and one as a function. Consistency makes
code easier to read.

> [...]

Michael
