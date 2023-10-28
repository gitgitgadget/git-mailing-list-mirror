Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BFD442B
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Mw+cx5"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5274AD
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 01:07:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso4776801a12.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698480458; x=1699085258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cepXEFdIHkFUlKRF8TWd74cbmMueJwZOAAe5kYqSVUc=;
        b=V4Mw+cx5Nwno2JV3CwfZqA7QPsMfoN2I5xhSfJN5IXig2zcnSIZe+hGo/GayOogqv6
         rG49H8IqUZ/5hqyMOvEmJYHKyEruxbPNO+hCUvkPqHGd3BTpypP9bxcWUK3HGPWV+g1r
         M2tUMa8FVa7toOv4jkSCl1HHulIv7SRfCW1th/bYnWJcBMjjx49z6csoIa6fCpQdNsHy
         NMcdpVvsQRrMVPyOuHwS/oOICezHXA1BcKIWLUMa+zJ3zmgpnhLDdvh226tx8qI3etSY
         zsnYc6Tw+7M8JZrsrSDYE2zFfKzj8DoxiApEt/BG2NKJwrdNpYdRPzbZ0r/yHoRykVi6
         1IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698480458; x=1699085258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cepXEFdIHkFUlKRF8TWd74cbmMueJwZOAAe5kYqSVUc=;
        b=kviQpIs9DfksQ92lyZFoubMcl33XtoYAqV8uEgBI+G6ADBx5xfUlTlpzKHsqKg2Ch7
         6xrckIqhpfn0C+kt7FfSY2a3o0m9DLKQveSsi0oez1tMBAghXYNNAFoscacmzuOYZf3t
         jGXv5WqQbdgRFc2WXXgGTLOP0Bj/XlMaf2tec7q9QhLnqfrtFeSFs3BXOKHGgAhp1hHu
         5veZME4OhkvNghND2qo6vUlCWKv5rvbtPUVpikMdoyMn5rqYfpObY8j+DR2nr/H5MaJ4
         /ImdIIZoTkqza2PnEwCyiVP62E3Zr1KFUIekOtmf9apjEjQLMExa/WH8iAflIHpJyWPF
         JMWA==
X-Gm-Message-State: AOJu0YycvFYpKGsVmPyA2Ek95sqr6E0hD8zfiHBvWxtoOcBmqP1Q9siK
	MxkaS5Fr3lK4xPIoMWhSN3wRH7hrSf81DhD5EGWfU+cl322s3g==
X-Google-Smtp-Source: AGHT+IEjQ2BNq+IcjBke4wP6hrXd5pmHkwTH75KUGHAnOmDRS4jMKfUK7zyenKO2gBz/H/MI7Qdyu4GOh8YjGdoxdYo=
X-Received: by 2002:a50:9e2c:0:b0:53e:2b80:2f74 with SMTP id
 z41-20020a509e2c000000b0053e2b802f74mr4333372ede.0.1698480457861; Sat, 28 Oct
 2023 01:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
 <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com> <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
In-Reply-To: <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 28 Oct 2023 10:07:25 +0200
Message-ID: <CAP8UFD16OAPiRFJfjZN=soAe3WzDBteyvzv-b3CD67jz6Haqyg@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: Isoken Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 2:46=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.c=
om> wrote:

> Thank you for the review. I have made changes to the project plan and
> it emphasizes the critical tasks of identifying, selecting, and
> porting tests, making it more concise and aligned with the project's
> scope.

Good.

> - Community Bonding (Oct 2 - Nov 20): Microproject contribution, Git
> project application, get familiar with the Git codebase and testing
> ecosystem.
> -Identify and Select Tests: Identify and prioritize tests worth
> porting, and document the selected tests. (I would classify tests that
> are worth porting according to the following for now;
>
> Relevance: Prioritize tests that are relevant to the current Git codebase=
.
> Coverage: Focus on tests that cover core functionality or critical code p=
aths.
> Usage Frequency: Port tests that are frequently used or run in Git's
> development process.
> Isolation: Choose tests that can be easily ported and run independently.

I think the main issue with identification is that now in t/helper/ we
have both:

  1) code that implements helpers that are used by the end-to-end
tests scripts written in shell and named "t/tXXXX-*.sh" where XXXX is
a number, and
  2) code that implements unit tests for some C code in the code base.

So I think only 2) should be ported to the unit test framework, and 1)
should not be ported and stay in t/helper/.

> - Write Unit Tests: Write unit tests for the identified test cases
> using the Git custom test framework.
> - Port Existing Tests: Port selected test cases from the t/helper
> directory to the unit testing framework, by modifying them to work
> within the custom TAP framework.
> - Test Execution and Debugging: Execute the newly written unit tests
> and the ported tests using the test framework.
> - Seek Feedback: Share the progress with mentors and the Git
> community, and address any concerns or suggestions provided by the
> community.
> - Documentation and Reporting: Document the entire process of
> migrating Git's tests to the unit testing framework, and prepare a
> final project report summarizing the work done, challenges faced, and
> lessons learned.
>
> What is the custom TAP framework?
>
> According to this patch
> (https://lore.kernel.org/git/ca284c575ece0aee7149641d5fb1977ccd7e7873.169=
2229626.git.steadmon@google.com/)
> by Phillip Wood, which contains an example implementation for writing
> unit tests with TAP output. The custom TAP framework is a Test
> Anything Protocol (TAP) framework that allows for clear reporting of
> test results, aiding in debugging and troubleshooting.

Ok. Our end-to-end tests scripts written in shell already use TAP,
that's why it's nice to have unit tests also using TAP.

> The framework contains the following features:
>
> - Test Structure: Unit tests are defined as functions containing
> multiple checks. The tests are run using the TEST() macro. If any
> checks within a test fail, the entire test is marked as failed.
> - Output Format: The output of the test program follows the TAP
> format. It includes a series of messages describing the test's status.
> For passed tests, it reports "ok," and for failed tests, it reports
> "not ok." Each test is numbered, e.g., "ok 1 - static initialization
> works," to indicate success or failure.
> - Check Functions: Several check functions are available, including
> check() for boolean conditions, check_int(), check_uint(), and
> check_char() for comparing values using various operators. check_str()
> is used to compare strings.
> - Skipping Tests: Tests can be skipped using test_skip() and can
> include a reason for skipping, which is printed as part of the report.
> - Diagnostic Messages: Tests can generate diagnostic messages using
> test_msg() to provide additional context or explanations for test
> failures.
> - Planned Failing Tests: Tests that are known to fail can be marked
> with TEST_TODO(). These tests will still run, and the failures will be
> reported, but they will not cause the entire suite to fail.
> - Building and Running: The unit tests can be built with "make
> unit-tests" (with some additional Makefile changes), and they can be
> executed manually or using a tool like prove.

Ok.

> Using the formerly given criteria, test-ctype.c is suitable for
> porting because it tests character type checks used extensively in
> Git. These tests cover various character types and their expected
> behaviour, ensuring the correctness and reliability of Git's
> operations, and test-ctype.c isolation makes it suitable for porting
> without relying on multiple libraries.

Ok.

> Here is a sample of the implementation of how I would write the unit
> test following the custom TAP framework taking t/helper/test-ctype.c
>
> - Create and rename the new .c file;
> I would rename it according to the convention done in the t/unit-test
> directory, by starting the name with a =E2=80=9Ct-=E2=80=9D prefix e.g t-=
ctype.c
>
> - Document the tests and include the necessary headers:
> /**
>  *Tests the behavior of ctype
>  *functions
> */
> #include "test-lib.h"
> #include "ctype.h"
>
> - Define test functions:
> #define DIGIT "0123456789"
>
> static void t_digit_type(void)
> {
>     int i;
>     const char *digits =3D DIGIT;
>     for (i =3D 0; digits[i]; i++)
>    {
>          check_int(isdigit(digits[i]), =3D=3D, 0);
>    }

This tests that isdigit() returns 0 for each of the characters in
"0123456789", but first I think isdigit() should return 1, not 0 for
those characters.

And second, I think the test should check the value returned by
isdigit() for each of the 256 possible values of a char, not just for
the characters in "0123456789".

test-ctype.c is doing the right thing regarding those 2 issues.

> - Include main function which will call the test functions using the TEST=
 macro;
> int main(void)
> {
>     TEST(t_digit_type(), "Character is a digit");
>     return test_done();
> }
>
> - Run the tests:
> =E2=80=98make && make=E2=80=99 unit-tests can be used build and run the u=
nit tests
> Or run the test binaries directly:
> ./t/unit-tests/t-ctype.c
>
> The Makefile will be modified to add the file;
> UNIT_TEST_PROGRAMS +=3D t-ctype
> The test output will be in the TAP format and will indicate which
> tests passed(ok) and which failed(not ok), along with diagnostic
> messages in case of failures.
>
> ok 1 - Character is a digit
>
> 1..1

Yeah, this looks right.

Thanks,
Christian.
