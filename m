Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD21224FB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE0WxnsE"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F298F
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 05:46:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d292d38c0so3993742a91.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698238012; x=1698842812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1KxaORqsQQIBE6lbr8mjcHQ62l7PNJ6xRged/Aon+8=;
        b=dE0WxnsEJ/bxprQrKLhUvzYXmUmHrZtlb8zIOQikSIX2agp+hNZnvvc8IEU+TI5IJk
         cTDJO7dkHOV1TwIu+YmYXLgr571stfX4rvt/W2/3pUHf3HO3w6bxk1b2zHBjhyrybgdu
         eYVPgzMZ4Mkke0XJHM/QpsGa0Zta2IoZdl1HhvegIfPaHjdw3on6K3ocJh5fpPrcUXtU
         29uKrWTonW5S7IhkZC69nVTqh4fpJoiPOBukTS/JCKc697zMx4Yp64d4+bWxtSClIfwB
         TBS3QKh0Ebj6SOT2wnZIohnvRbWXqZNGIwEQfiZkqSVGiz8lTObqOF2Dr71q60H1PiY8
         dKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238012; x=1698842812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1KxaORqsQQIBE6lbr8mjcHQ62l7PNJ6xRged/Aon+8=;
        b=grCLEyIJV3DoufZyb3iDWiVhl2VEQU3ksuGXGCjvWuUnycHwMAZ7lo/5zNLQuwH65S
         2cgvT61vDtw9FVDEEgepnlYtJ0S9NI1a1+SR8hI2WLnvtCvdjYRuRzDQmhqONWaGnCd6
         6p+dPb9VnMkopWVACb+OHV/Wxt4fmwqYOOq8xbiMakim6ESY4bVsO+iYPP9WrtsMGtdE
         cAHhCqB3YPTKV6KhaNYgfmezCuDeEO4XUxHa0gRBuj/6HzR2v0BIECCbKo9vr54uNBM6
         4KFcslZL0GxzeQgnWRjbqno/e4fH5ehX8zSamDM3j153SQUOTw17h2cUm3xqmNdAjpNB
         04qg==
X-Gm-Message-State: AOJu0YyddRgwtoXAuYIlU2ME2F1R+zqIo67ZakyF3SRmh4SfGAgi+e7d
	YXxwDvIF31C1wbRuLyoedpOoO7mg2TnKH8c8GS7JjEOUCQ1lsequ
X-Google-Smtp-Source: AGHT+IFHAMY+4d2VFa5EGaRXz73ohhF7ah5vqvIzE/JDJB8fVRn3lI27UMuwD8k6cYYsPX9e2NhFGuVYRBH4BAgNF2E=
X-Received: by 2002:a17:90b:1c82:b0:27f:df1e:198e with SMTP id
 oo2-20020a17090b1c8200b0027fdf1e198emr1349088pjb.26.1698238011455; Wed, 25
 Oct 2023 05:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
 <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
In-Reply-To: <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Wed, 25 Oct 2023 13:45:20 +0100
Message-ID: <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:24=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Oct 19, 2023 at 11:26=E2=80=AFAM Isoken Ibizugbe <isokenjune@gmai=
l.com> wrote:
> >
> > Dear Git Community and Mentors,
> >
> > I hope you're doing well. I'm excited to share my application draft
> > for the Outreachy program with the Git project. Your feedback is
> > invaluable, and I'm eager to align the project with the community's
> > needs. Please review the attached draft and share your insights.
>
> Thanks for your project application!
>
> [...]
>
> > Why am I interested in working with the Git chosen project?
> >
> > Git has been a cornerstone for software development, enabling
> > developers worldwide to collaborate, innovate, and create exceptional
> > software. I would say without Git, my journey to pursuing my software
> > engineering career would be impossible, as I use it almost every day.
> > Yet, in this constantly evolving landscape, there is always room for
> > improvement, even in a well-established project. The Git project
> > currently relies on end-to-end tests, and this is where I see an
> > opportunity to make a profound impact. Being able to test libraries in
> > isolation via unit tests or mocks speeds up determining the root cause
> > of bugs. I am deeply passionate about contributing to this project and
> > firmly believe in the power of open-source software and the collective
> > intelligence of the community. A successful completion of this project
> > will significantly improve Git's testing capabilities and bring the
> > benefits of fewer errors, faster work and better testing for all
> > parts.
>
> Ok.
>
> [...]
>
> > Contributions to Git
> >
> > I have actively participated in Git's mailing list discussions and
> > contributed to a micro-project;
> >
> > - builtin/branch.c: Adjust error messages such as die(), error(), and
> > warning() messages used in branch, to conform to coding guidelines
> > (https://lore.kernel.org/git/20231019084052.567922-1-isokenjune@gmail.c=
om/)
> > - Implemented changes to fix broken tests based on reviews from the
> > community (https://lore.kernel.org/git/20231019084052.567922-1-isokenju=
ne@gmail.com/)
> > - In review.
>
> Nice!
>
> > Project Goals:
> >
> > - Improve Testing Efficiency: Transitioning from end-to-end tests to
> > unit tests will enable more efficient testing of error conditions.
> > - Codebase Stability: Unit tests enhance code stability and facilitate
> > easier debugging through isolation.
> > - Simplify Testing: Writing unit tests in pure C simplifies test
> > setup, data passing, and reduces testing runtime by eliminating
> > separate processes for each test.
>
> Ok.
>
> > Project Milestones:
> >
> > - Add useful tests of library-like code
> > - Integrate with stdlib work
>
> Not sure what you call "stdlib" here.
>
> > - Run alongside regular make test target
> >
> > Project Timeline:
> >
> > 1. Oct 2 - Nov 20: Community Bonding
> >
> > - Understanding the structure of Git
> > - Getting familiar with the code
>
> I think some of this time is also spent on working on a microproject,
> writing an application and perhaps doing other things that regular Git
> developers do.
>
> > 2. Dec 4 - Jan 15: Add useful tests of library-like code
> >
> > - Identify and document the current state of the tests in the Git
> > t/helper directory.
>
> It would be nice if you could already take a look at that and tell us
> about it in your application. There are different things in t/helper.
> Some are worth porting and others are not. You might not want (or have
> time to) to classify everything right now, but if you can identify a
> few of each kind, and use those, or just one of them, as an example,
> that would be great.
>
> > - Confirm the licensing and compatibility requirements for the chosen
> > unit testing framework.
>
> I think those who have been working on the unit test framework have
> already done this.

Thank you for the review. I have made changes to the project plan and
it emphasizes the critical tasks of identifying, selecting, and
porting tests, making it more concise and aligned with the project's
scope.

- Community Bonding (Oct 2 - Nov 20): Microproject contribution, Git
project application, get familiar with the Git codebase and testing
ecosystem.
-Identify and Select Tests: Identify and prioritize tests worth
porting, and document the selected tests. (I would classify tests that
are worth porting according to the following for now;

Relevance: Prioritize tests that are relevant to the current Git codebase.
Coverage: Focus on tests that cover core functionality or critical code pat=
hs.
Usage Frequency: Port tests that are frequently used or run in Git's
development process.
Isolation: Choose tests that can be easily ported and run independently.

- Write Unit Tests: Write unit tests for the identified test cases
using the Git custom test framework.
- Port Existing Tests: Port selected test cases from the t/helper
directory to the unit testing framework, by modifying them to work
within the custom TAP framework.
- Test Execution and Debugging: Execute the newly written unit tests
and the ported tests using the test framework.
- Seek Feedback: Share the progress with mentors and the Git
community, and address any concerns or suggestions provided by the
community.
- Documentation and Reporting: Document the entire process of
migrating Git's tests to the unit testing framework, and prepare a
final project report summarizing the work done, challenges faced, and
lessons learned.

What is the custom TAP framework?

According to this patch
(https://lore.kernel.org/git/ca284c575ece0aee7149641d5fb1977ccd7e7873.16922=
29626.git.steadmon@google.com/)
by Phillip Wood, which contains an example implementation for writing
unit tests with TAP output. The custom TAP framework is a Test
Anything Protocol (TAP) framework that allows for clear reporting of
test results, aiding in debugging and troubleshooting.

The framework contains the following features:

- Test Structure: Unit tests are defined as functions containing
multiple checks. The tests are run using the TEST() macro. If any
checks within a test fail, the entire test is marked as failed.
- Output Format: The output of the test program follows the TAP
format. It includes a series of messages describing the test's status.
For passed tests, it reports "ok," and for failed tests, it reports
"not ok." Each test is numbered, e.g., "ok 1 - static initialization
works," to indicate success or failure.
- Check Functions: Several check functions are available, including
check() for boolean conditions, check_int(), check_uint(), and
check_char() for comparing values using various operators. check_str()
is used to compare strings.
- Skipping Tests: Tests can be skipped using test_skip() and can
include a reason for skipping, which is printed as part of the report.
- Diagnostic Messages: Tests can generate diagnostic messages using
test_msg() to provide additional context or explanations for test
failures.
- Planned Failing Tests: Tests that are known to fail can be marked
with TEST_TODO(). These tests will still run, and the failures will be
reported, but they will not cause the entire suite to fail.
- Building and Running: The unit tests can be built with "make
unit-tests" (with some additional Makefile changes), and they can be
executed manually or using a tool like prove.

Using the formerly given criteria, test-ctype.c is suitable for
porting because it tests character type checks used extensively in
Git. These tests cover various character types and their expected
behaviour, ensuring the correctness and reliability of Git's
operations, and test-ctype.c isolation makes it suitable for porting
without relying on multiple libraries.


Here is a sample of the implementation of how I would write the unit
test following the custom TAP framework taking t/helper/test-ctype.c

- Create and rename the new .c file;
I would rename it according to the convention done in the t/unit-test
directory, by starting the name with a =E2=80=9Ct-=E2=80=9D prefix e.g t-ct=
ype.c

- Document the tests and include the necessary headers:
/**
 *Tests the behavior of ctype
 *functions
*/
#include "test-lib.h"
#include "ctype.h"

- Define test functions:
#define DIGIT "0123456789"

static void t_digit_type(void)
{
    int i;
    const char *digits =3D DIGIT;
    for (i =3D 0; digits[i]; i++)
   {
         check_int(isdigit(digits[i]), =3D=3D, 0);
   }

- Include main function which will call the test functions using the TEST m=
acro;
int main(void)
{
    TEST(t_digit_type(), "Character is a digit");
    return test_done();
}

- Run the tests:
=E2=80=98make && make=E2=80=99 unit-tests can be used build and run the uni=
t tests
Or run the test binaries directly:
./t/unit-tests/t-ctype.c

The Makefile will be modified to add the file;
UNIT_TEST_PROGRAMS +=3D t-ctype
The test output will be in the TAP format and will indicate which
tests passed(ok) and which failed(not ok), along with diagnostic
messages in case of failures.

ok 1 - Character is a digit

1..1

>
> > - Develop unit tests for these library-like components.
>
> Not sure what are "these library-like components". An example would
> perhaps help.
>
> > - Execute the tests and ensure they cover various scenarios, including
> > error conditions.
> > - Run the tests and address any initial issues or bugs to ensure they
> > work as intended.
>
> Ok.
>
> > - Document the new tests and their coverage.
>
> What kind of documentation would that be?
>
> > - Seek feedback  and support from mentors and the Git community
> >
> > 3. Jan 15 - Feb 15: Integrate with Stdlib Work
> >
> > - Collaborate with the team working on standard library integration.
>
> Not sure what "standard library". Actually, maybe you are talking
> about the goal of having a "standard library" implementation for Git
> which is described in this report from the Virtual Contributor's
> Summit:
>
> https://lore.kernel.org/git/ZRrfN2lbg14IOLiK@nand.local/
>
> It's true that the unit test framework would help with that goal. So
> yeah maybe you will have to collaborate with the team working on that
> goal. I am not sure at what step the work on this library will be when
> the internship will start though.
>
> > - Ensure that the tests for library-like code align with stdlib work.
> > - Verify that the tests effectively check the compatibility and
> > interaction of the code with standard libraries.
> > - Gather feedback and insights from the Git community on the
> > integrated tests, addressing any concerns or suggestions.
>
> Ok, but I think it would be more interesting to follow the steps with
> an example test.
>
> > 4. Feb 15 - March 1: Run Alongside Regular 'make test' Target and final=
ize
> >
> > - Configure the testing framework to run alongside the regular 'make
> > test' target.
>
> I think others will likely take care of that sooner.
>
> > - Ensure that the new tests are included in the standard testing suite.
> > - Execute 'make test' with the new tests and verify that they pass succ=
essfully.
> > - Document the integration process and how the new tests are included
> > in the standard testing procedure.
> > - Perform comprehensive testing of the entire unit testing framework.
> > - Ensure all migrated tests are working correctly within the new framew=
ork.
> > - Document the entire process of migrating Git's tests
> > - Prepare a final project report
>
> Ok, but here also following an example test would be more interesting.

>
> > Technical Requirements
> >
> > According to the documentation on the unit test project
> > (https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation=
/technical/unit-tests.adoc),
> > the suggested best framework for the Git project is the "Custom TAP
> > framework" (Phillip Wood's TAP implementation), as it aligns with
> > Git's licensing requirements, is vendorable, and can be customized by
> > Git's developers as needed, but it may require some additional
> > development work for features like parallel execution and mock
> > support, but it offers a strong foundation for unit testing within the
> > Git project.
>
> Yeah, right. Thanks for summarizing that document!
>
> > Relevant Projects
> >
> > Simple shell -  A project based on emulating a shell. It was a
> > collaborative project which we managed using Git.
> > (https://github.com/Junie06/simple_shell).
> > This project was written in C, which allowed me to apply my C language
> > knowledge, essential for Git projects.
> > I'm proficient in using Shell for scripting, redirections, and
> > permissions, as shown in my work
> > (https://github.com/Junie06/alx-system_engineering-devops).
> > Creating the simple shell project deepened my understanding of how
> > shells work, and I even attempted to replicate a shell environment.
> > Collaborating on the Simple Shell project reinforced my Git skills.
>
> Ok, nice!
>
> Best,
> Christian.
