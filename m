Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7A63C3
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RbX3adg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704127267; x=1704732067; i=l.s.r@web.de;
	bh=KwvT6TisN2eeqU4FiJhj2jfSWKPs2/6C3yBJSd1M9+I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RbX3adg2XgLnlybAHlyKqSxwmJ7InYudFXBHyCHMSI0n5CFT46Z1UNgpFsll+Peo
	 XYbnFjxvc/6aynlfkaNrtKwbvPi2YBpJ3iffpRb2bS4h/k9iszHPp9h97OOG/emVb
	 Jdlz4eAl491QMbGEgJYycFSTNF856WQdaw+v/SrbrWmBVEfBX+ZSEdlCwHCgVxMwt
	 VzxkwnNPL8hgs0+qPlZ+xT6IsL/ihCcO3XKf5fbCrrjQ8fzWpHfF3tw9wAgN4cjqE
	 62OdLeFdb1bXzCz+NWq/ykeWpEq/Ukddc0BReoBuDFy/iW4chOFZWewWDnLZBtWp2
	 QSGrYU9fIo7txzEvbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1rmpWF0YSO-00T3M3; Mon, 01
 Jan 2024 17:41:07 +0100
Message-ID: <435a03c7-dbf3-4ddb-b183-cac86ed0467d@web.de>
Date: Mon, 1 Jan 2024 17:41:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH v3] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
Content-Language: en-US
To: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, christian.couder@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, steadmon@google.com
References: <20231230001102.9220-1-ach.lumap@gmail.com>
 <20240101104017.9452-2-ach.lumap@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240101104017.9452-2-ach.lumap@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zeE7eJy1PmSk3fvSkErpMQg6NGz9q+d5jA+Dtz8LLaMkmtI1SbA
 Myfi26mJkWSiyoJmXlcfOPckIzQlJ6R8NGAIxZSlO4w2su58aEMqi5qdK4GHd6GOIxGxsvN
 MQwApUZLGdJmAU5pnzj4T29b6Ij/x7en1LXT17rFEYfeVrESEDMbg9XG3CO4sMD6WnTqT0z
 6oVub+4QcmXS7z4kgjwiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v4QZtA8NWr0=;qCZqn7nATr2DU8/T4UYQ11QhoHF
 RbFYlVIHGmfj5CAbMaHT3KETTC5fqCbRu5tInxEwkmDAKDDE4PH1CmeQEZp+R8QfFVgik4xos
 0ga7ilyWCJV9uq7xjSpc9Xy8MqUo3lAq2MbdA2ly+paS+osBd1sTOxIGAepyaAcLnFynBtLjd
 qhuYl0o3d/GYyk3MwtXYI9X/NJuWiF1Vj3kJgFPMydJeboTBCvzyMHpSLkdhM/2J1czMjlJQC
 jUCvQJBSh6LMJFrML/g1bQeOUsPU3iw56awkEPbRc8CSiGAzPKu5pBBLzqoASZjgwHr2p64P/
 koHzmuVhakgx9g03VNCKCIu8yNXWE5eb1n//3ESuRxROzpjWzVASXBDcuQ1nxpDhVMnc3RFtv
 AKD7g/wvkoBZETiiQ4zqk12RGPw9Ooa4NLRmyNsem9ypdoG0ALaIuZOUDR5exo8wU//OqDBAS
 2IBYt79uveRG5cqfNSzs7MZQ58W8WsI1I5ikq5EDYNvRUyiJNb6inbTZN6CFUzOqBPi/sGlFs
 n4jMiOYyAD99CH3YjQFy+7os7vlJZbctceMq8VtIo0uHwvC9a2mROUxodr/cUca4L75mZFAvI
 rpx4Kq1E1jQ7ZtxMgasf14eWURAcxwYxxk5H37Ftpm/sZsLkp+hjAzeDStO6z2RqDVQzhknDV
 smvUmj2q6lAIy8nm7JeKvsLDTP5iPh8htUg5vxVmB0/sAbGZeGVKd/Scr/n9IwTcqe34xMiZl
 rShG9Soe9pD4IicpzLPkibQuCANW50JDKzoVF6zmcZ0Ceqn7ZuFr45X6HtE1K7NaQnov0JBc0
 Nf2T9dVeS4gJSAWsunOg0aQq7dUxT7+4KrOjXhf4JdRlbzizumvHZwr+tgWC3QR/zPaaSz5f6
 /Vuwnl5ckTC2a329U5OobhHZonaptw+wSN7QyBi7oL8/aCupBLHpNPbdNCx2iAOPnRngR++yC
 3xnR0w==

Am 01.01.24 um 11:40 schrieb Achu Luma:
> In the recent codebase update(8bf6fbd00d (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>
> This commit migrates the unit tests for C character classification
> functions (isdigit(), isspace(), etc) from the legacy approach
> using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
> to the new unit testing framework (t/unit-tests/test-lib.h).
>
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>

v1 and v2 had "Mentored-by: Christian Couder <chriscool@tuxfamily.org>".
It's gone now; intentionally?

> ---
>  Sorry for the poor description of the changes, maybe the following is b=
etter:
>  In the revised patch we added a call to test_msg() suggested by Phillip=
 to
>  print the character code. This helps us pinpoint exactly the byte value=
 that
>  is an issue as suggested by Junio. We keep using check_int() as it allo=
ws us
>  to still see the actual and expected return which might help us in case=
 func()
>  returned a different non-zero value when we were expecting "1". It is u=
seful
>  to have the return value printed on error in case we start returning "5=
3"
>  instead of "1" for "true".

To illustrate, here are the changes between v1 and v2 in diff form:

=2D-- >8 ---
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 41189ba9f9..8a215d387a 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -14,12 +14,13 @@ static int is_in(const char *s, int ch)
 }

 /* Macro to test a character type */
-#define TEST_CTYPE_FUNC(func, string)			\
+#define TEST_CTYPE_FUNC(func, string)				\
 static void test_ctype_##func(void)				\
 {								\
-	int i;                                     	 	\
-	for (i =3D 0; i < 256; i++)                 		\
-		check_int(func(i), =3D=3D, is_in(string, i)); 	\
+	for (int i =3D 0; i < 256; i++) {				\
+        	if (!check_int(func(i), =3D=3D, is_in(string, i))) 	\
+        		test_msg("       i: %02x", i);		\
+        } 							\
 }

 #define DIGIT "0123456789"
=2D-- >8 ---

v3 is the same as v2.

>
>  Makefile               |  2 +-
>  t/helper/test-ctype.c  | 70 --------------------------------------
>  t/helper/test-tool.c   |  1 -
>  t/helper/test-tool.h   |  1 -
>  t/t0070-fundamental.sh |  4 ---
>  t/unit-tests/t-ctype.c | 77 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 78 insertions(+), 77 deletions(-)
>  delete mode 100644 t/helper/test-ctype.c
>  create mode 100644 t/unit-tests/t-ctype.c
>
> diff --git a/Makefile b/Makefile
> index 88ba7a3c51..a4df48ba65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -792,7 +792,6 @@ TEST_BUILTINS_OBJS +=3D test-chmtime.o
>  TEST_BUILTINS_OBJS +=3D test-config.o
>  TEST_BUILTINS_OBJS +=3D test-crontab.o
>  TEST_BUILTINS_OBJS +=3D test-csprng.o
> -TEST_BUILTINS_OBJS +=3D test-ctype.o
>  TEST_BUILTINS_OBJS +=3D test-date.o
>  TEST_BUILTINS_OBJS +=3D test-delta.o
>  TEST_BUILTINS_OBJS +=3D test-dir-iterator.o
> @@ -1341,6 +1340,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
>
>  UNIT_TEST_PROGRAMS +=3D t-basic
>  UNIT_TEST_PROGRAMS +=3D t-strbuf
> +UNIT_TEST_PROGRAMS +=3D t-ctype
>  UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGR=
AMS))
>  UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRA=
MS))
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
> diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
> deleted file mode 100644
> index e5659df40b..0000000000
> --- a/t/helper/test-ctype.c
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#include "test-tool.h"
> -
> -static int rc;
> -
> -static void report_error(const char *class, int ch)
> -{
> -	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
> -	rc =3D 1;
> -}
> -
> -static int is_in(const char *s, int ch)
> -{
> -	/*
> -	 * We can't find NUL using strchr. Accept it as the first
> -	 * character in the spec -- there are no empty classes.
> -	 */
> -	if (ch =3D=3D '\0')
> -		return ch =3D=3D *s;
> -	if (*s =3D=3D '\0')
> -		s++;
> -	return !!strchr(s, ch);
> -}
> -
> -#define TEST_CLASS(t,s) {			\
> -	int i;					\
> -	for (i =3D 0; i < 256; i++) {		\
> -		if (is_in(s, i) !=3D t(i))	\
> -			report_error(#t, i);	\
> -	}					\
> -	if (t(EOF))				\
> -		report_error(#t, EOF);		\
> -}
> -
> -#define DIGIT "0123456789"
> -#define LOWER "abcdefghijklmnopqrstuvwxyz"
> -#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> -#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
> -#define ASCII \
> -	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> -	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> -	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
> -	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
> -	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
> -	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
> -	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
> -	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
> -#define CNTRL \
> -	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> -	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> -	"\x7f"
> -
> -int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
> -{
> -	TEST_CLASS(isdigit, DIGIT);
> -	TEST_CLASS(isspace, " \n\r\t");
> -	TEST_CLASS(isalpha, LOWER UPPER);
> -	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
> -	TEST_CLASS(is_glob_special, "*?[\\");
> -	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
> -	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
> -	TEST_CLASS(isascii, ASCII);
> -	TEST_CLASS(islower, LOWER);
> -	TEST_CLASS(isupper, UPPER);
> -	TEST_CLASS(iscntrl, CNTRL);
> -	TEST_CLASS(ispunct, PUNCT);
> -	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
> -	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
> -
> -	return rc;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 37ba996539..33b9501c21 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -19,7 +19,6 @@ static struct test_cmd cmds[] =3D {
>  	{ "config", cmd__config },
>  	{ "crontab", cmd__crontab },
>  	{ "csprng", cmd__csprng },
> -	{ "ctype", cmd__ctype },
>  	{ "date", cmd__date },
>  	{ "delta", cmd__delta },
>  	{ "dir-iterator", cmd__dir_iterator },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 8a1a7c63da..b72f07ded9 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -12,7 +12,6 @@ int cmd__chmtime(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
>  int cmd__crontab(int argc, const char **argv);
>  int cmd__csprng(int argc, const char **argv);
> -int cmd__ctype(int argc, const char **argv);
>  int cmd__date(int argc, const char **argv);
>  int cmd__delta(int argc, const char **argv);
>  int cmd__dir_iterator(int argc, const char **argv);
> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index 487bc8d905..a4756fbab9 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -9,10 +9,6 @@ Verify wrappers and compatibility functions.
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
> -test_expect_success 'character classes (isspace, isalpha etc.)' '
> -	test-tool ctype
> -'
> -
>  test_expect_success 'mktemp to nonexistent directory prints filename' '
>  	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
>  	grep "doesnotexist/test" err
> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> new file mode 100644
> index 0000000000..8a215d387a
> --- /dev/null
> +++ b/t/unit-tests/t-ctype.c
> @@ -0,0 +1,77 @@
> +#include "test-lib.h"
> +
> +static int is_in(const char *s, int ch)
> +{
> +	/*
> +	 * We can't find NUL using strchr. Accept it as the first
> +	 * character in the spec -- there are no empty classes.
> +	 */
> +	if (ch =3D=3D '\0')
> +		return ch =3D=3D *s;
> +	if (*s =3D=3D '\0')
> +		s++;
> +	return !!strchr(s, ch);
> +}
> +
> +/* Macro to test a character type */
> +#define TEST_CTYPE_FUNC(func, string)				\
> +static void test_ctype_##func(void)				\
> +{								\
> +	for (int i =3D 0; i < 256; i++) {				\
> +        	if (!check_int(func(i), =3D=3D, is_in(string, i))) 	\
> +        		test_msg("       i: %02x", i);		\
> +        } 							\

This loop is indented with spaces followed by tabs.  The Git project
prefers indenting by tabs and in some cases tabs followed by spaces, but
not the other way array.  git am warns about such whitespace errors and
can actually fix them automatically, so I imagine this wouldn't be a
deal breaker.  But even if it seems picky, respecting the project's
preferences from the start reduces unnecessary friction.

The original test reported the number of a misclassified character
(basically its ASCII code) in both decimal and hexadecimal form.  This
code prints it only in hexadecimal, but without the prefix "0x".  A
casual reader could mistake hexadecimal numbers for decimal ones as a
result.  Printing only one suffices, but I think it's better to either
use decimal notation without any prefix or hexadecimal with the "0x"
prefix to avoid confusion.  There's no reason to be stingy with the
screen space here.

> +}
> +
> +#define DIGIT "0123456789"
> +#define LOWER "abcdefghijklmnopqrstuvwxyz"
> +#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
> +#define ASCII \
> +	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> +	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> +	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
> +	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
> +	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
> +	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
> +	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
> +	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
> +#define CNTRL \
> +	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> +	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> +	"\x7f"
> +
> +TEST_CTYPE_FUNC(isdigit, DIGIT)
> +TEST_CTYPE_FUNC(isspace, " \n\r\t")
> +TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
> +TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
> +TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
> +TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
> +TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~")
> +TEST_CTYPE_FUNC(isascii, ASCII)
> +TEST_CTYPE_FUNC(islower, LOWER)
> +TEST_CTYPE_FUNC(isupper, UPPER)
> +TEST_CTYPE_FUNC(iscntrl, CNTRL)
> +TEST_CTYPE_FUNC(ispunct, PUNCT)
> +TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
> +TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
> +
> +int cmd_main(int argc, const char **argv) {
> +	/* Run all character type tests */
> +	TEST(test_ctype_isspace(), "isspace() works as we expect");
> +	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
> +	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
> +	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
> +	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expe=
ct");
> +	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we ex=
pect");
> +	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we =
expect");
> +	TEST(test_ctype_isascii(), "isascii() works as we expect");
> +	TEST(test_ctype_islower(), "islower() works as we expect");
> +	TEST(test_ctype_isupper(), "isupper() works as we expect");
> +	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
> +	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
> +	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
> +	TEST(test_ctype_isprint(), "isprint() works as we expect");

Each class (e.g. space or digit) is mentioned thrice here: When
declaring its function with TEST_CTYPE_FUNC, when calling said function
and again in the test description.  Adding a new class requires adding
two lines of code.  That's not too bad, but the original implementation
didn't require that repetition and adding a new class only required
adding a single line.

I mentioned this briefly in my review of v1 in
https://lore.kernel.org/git/f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de/
and showed a way to define character classes without repeating their
names.  You don't have to follow that suggestion, but it would be nice
if you could give some feedback about it.

> +
> +	return test_done();
> +}

Ren=C3=A9

