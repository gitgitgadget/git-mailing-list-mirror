Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CF2C871
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBCcv/VL"
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560ECE8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:25:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso2518474a12.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698157537; x=1698762337; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pD+4MrNh8hXH2CPDUwIXcfsShDiVFIfrLg+kv7x3/o=;
        b=bBCcv/VLG/w8Ot80KNgYXyqIiul3DlrV3BQ5Z2mcdLuT7ZugOpZWR81ZSw28hRi8Hw
         M5PI9XjcjvAkb+H8cJTCjNrZZdCoiwXWGYuhlyJikH8tBZbmj8GVDdsDE02nN5f7LqCn
         sBuAM0q+ENxxSSzl6e8DSnofmTlvDfjSS7EPG6TtlUsA1IM5DqZN1zSRj70a9xr0gs++
         XBmGQ+EkFfxnGv0ffMiYIp5jpXRC1MJADk/MjM3GTPJ9/797/mn0p0Gk2YBvY9PIbrVR
         NATDvoGRfv9aZElmpRiyACJrKu6yaVFQJJ00/O7Qiz0hLVJAbHYBXiGOMHEjKTGtBBti
         zmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157537; x=1698762337;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pD+4MrNh8hXH2CPDUwIXcfsShDiVFIfrLg+kv7x3/o=;
        b=br3fUhig457siebV24o8HuiANvffR3N1sO+oPL+GouASK5voiFtqNn50APzDck8aIb
         wh/KaZ+BoIQ4+tTiUfWztmKGnyykCZK3Tl2olVngoae+IPu5WwSXVqpmxCETAz5kL98G
         pvsHTV2HV//z3Ijsaw0bclLN0LhJe1D9PFBZshE5SY27nEohuo6k/2/MGUL7IT7PpxvC
         aW9rH/riQzKoFUlkiruC4YTFRNYove4RLwj6ykUboIuErNtwK7cOxVcOgY9JoRab3/++
         DsIzmjTufK/VBjbqG5qG9RnPbWZIxez7aQPGsYmPH/KrWTZJxcadQEuJpAk0w0ztsoLO
         nRqw==
X-Gm-Message-State: AOJu0YzOCHbV2Ripttr6YhZLKQ1Kjq/6fo2txfQ9iHyb3IReJMwwRdVL
	ozwvQowRBNS+D8wM3c9d7X6hfp/tKTKVgvtz3oU=
X-Google-Smtp-Source: AGHT+IEzxLygqxvr3a0N17gSecupNgvURJv80vzIXl4O0GZHPNetdbDGNyTdrYeTLqlnsJZfylFKIXm0yRABHwgXEL0=
X-Received: by 2002:a17:90a:6096:b0:27d:46e5:2d7c with SMTP id
 z22-20020a17090a609600b0027d46e52d7cmr9486360pji.26.1698157536481; Tue, 24
 Oct 2023 07:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
 <xmqqedibzgi1.fsf@gitster.g> <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
 <CAFR+8Dz717pcc2Lm_J29xxiBt-kUrMP4JAUbm=3XaJuJPYseHg@mail.gmail.com>
 <CAFR+8Dwxr3iV+R7een0t2sYXUWu1XHhQcLVuqMhOsSg9Bt4wrg@mail.gmail.com> <CAP8UFD0A_vWCZ5cVAZqdTBebdhZNye_FmNNJF+vA7epUx2JWHQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0A_vWCZ5cVAZqdTBebdhZNye_FmNNJF+vA7epUx2JWHQ@mail.gmail.com>
From: Achu Luma <ach.lumap@gmail.com>
Date: Tue, 24 Oct 2023 15:25:26 +0100
Message-ID: <CAFR+8DzdFbwaiHtZSdLMqWYWh=fK0WA4c48+eBug-ZeAgddhcQ@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 2:41=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Oct 20, 2023 at 3:16=E2=80=AFPM Achu Luma <ach.lumap@gmail.com> w=
rote:
> >
> > Dear Git Community and Mentors,
> >
> > I hope this email finds you well. As a follow-up to my previous applica=
tion, I'd like to provide additional details on the process of migrating ex=
isting unit tests from the t/helper/ directory to the new Git unit test fra=
mework.
>
> Thanks for these details!
>
> > -- Identify Target Unit Tests: Start by identifying the specific unit t=
ests in the t/helper/ directory that we want to port to the new Git unit te=
st framework. Ensure that the tests are suitable for migration and that the=
 benefits of doing so outweigh the effort(By avoiding integration tests). T=
he following points have been developed with on going work on the unit-test=
s framework visible here:
> >
> > 1- https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65=
.1688165272.git.steadmon@google.com/
> > 2- https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentati=
on/technical/unit-tests.adoc
>
> Maybe if you have time you could add some descriptions or comments
> related to the above emails and documents. For example you could tell
> what the new unit test framework will be like, how the unit tests will
> look like, etc. Maybe a short overview would be nice.
>
sure,
1- https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.168=
8165272.git.steadmon@google.com/
:
    The emails highlight the significant milestones achieved in
defining and testing the custom TAP
     framework for writing git unit tests. It also contains some
examples of implementation such as
     that of STRBUF_INIT with output:
      ok 1 - static initialization works
     1..1

2-  https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/=
technical/unit-tests.adoc:
     From this technical doc, the new unit test framework in the Git
project represents a significant
     enhancement, introducing a systematic and efficient approach to
unit testing. The custom git
     TAP implementation was selected from several alternatives based
on strict criteria as the most
     suitable test framework for porting the unit tests.
     The unit tests are  written in pure C, eliminating the need for
the previous shell/test-tool helper
     setup, simplifying test configuration, data handling, and
reducing testing runtime.
     Each unit test is encapsulated as a function and employs a range
of predefined check functions
     for validation. These checks can evaluate conditions, compare
integers or characters, validate
     strings, and more, providing comprehensive coverage for test scenarios=
.

    When a test is run using the TEST() macro, it undergoes a series
of checks, and if any check fails,
    a diagnostic message is printed to aid in debugging. This
diagnostic output includes information
    about the specific check that failed, the file and line number
where it occurred, and a clear comparison
    of the expected and actual values. Such detailed reporting
simplifies the identification and resolution
    of issues, contributing to codebase stability.

    Additionally, the framework supports features like skipping tests
with explanations, sending custom
    diagnostic messages using test_msg(), and marking known-to-fail
checks using TEST_TODO().
    This flexibility allows developers to tailor their tests to
specific scenarios while ensuring a
    comprehensive testing suite.

> You could also try to apply the patches in the series that adds the
> test framework, or alternatively use the 'seen' branch where the
> series has been merged, and start playing with it by writing, or
> porting, a small example test.
>
ok, I think I can push a patch for one.
> > -- Create a New C Test File: For each unit test I plan to migrate, crea=
te a new C source file (.c) in the Git project's test suite directory(t/uni=
t-tests). Name it appropriately to reflect the purpose of the test.
>
> Could you provide an example of what the new name would be for an
> existing test that is worth porting?
>
Sure... let's consider an existing unit test in t/helper directory
such as  t/helper/test-date.c or
its shell named t0006-date.sh, which is part of the current
shell-based test suite. In the context
of the new unit testing framework, this test could be reimagined and rename=
d as
"t-date.c". The "t-" prefix is typically used for test program files
in Git, and "date" is retained to
 reflect the nature of the tests within this suite.
> > --  Include Necessary Headers:In the new C test file, include the neces=
sary Git unit test framework headers. Typically, this includes headers like=
 "test-lib.h" and others relevant to the specific test.
> > #include "test-lib.h"
>
> Maybe you could continue the above example and tell which headers
> would be needed for it?
>
> > -- Convert Test Logic: Refactor the test logic from the original Shell =
script into the new C-based test format. Use the testing macros provided by=
 the Git unit test framework, such as test_expect_success, test_expect_fail=
ure, etc., to define the tests.
> > test_expect_success("simple progress display", "{
> >     // Test logic here...
> > }");
>
> Ok, a simple example would be nice too.
>
we can continue with the example used for naming: test-date.c. a
typical t-date.c unit test would look
like the following:
--
#include "test-lib.h"
#include "date.h"
--
date.h here is a necessary header file. Now refactoring the test logic
from the original shell script:
--
#include "test-lib.h"
#include "date.h"

static void test_parse_dates(void)
{
    const char *dates[] =3D { "invalid_date", "2023-10-17 10:00:00 +0200", =
NULL };

    for (const char **argv =3D dates; *argv; argv++) {
        check_int(parse_dates((const char *[]){ *argv, NULL }), 0);
    }
}
--

> > -- Add Test Descriptions: Provide clear and informative descriptions fo=
r each test using the testing macros. These descriptions will help in ident=
ifying the purpose of each test when the test suite is run.
>
> This would seem to be part of the previous step, as you would have to
> provide a description when using the testing macro. But Ok.
>
> > -- Define a Test Entry Point: Create a cmd_main function as the entry p=
oint for the C-based tests. Inside this function, include the test function=
s using the testing macros.
> > int cmd_main(int argc, const char **argv) {
> >     // Test functions...
> >     return test_done();
> > }
>
> Yeah, continuing an example would be nice.
>
Continuing, we can add a test entrance as follows:
--
#include "test-lib.h"
#include "date.h"

static void test_parse_dates(void)
{
    const char *dates[] =3D { "invalid_date", "2023-10-17 10:00:00 +0200", =
NULL };

    for (const char **argv =3D dates; *argv; argv++) {
        check_int(parse_dates((const char *[]){ *argv, NULL }), 0);
    }
}

int main(int argc UNUSED, const char **argv UNUSED)
{
    TEST(test_parse_dates, "Test date parsing");

    return test_done();
}
--

A typical unit tests with the custom TAP framework would look
something like above. This might run in theory
but I have not yet run it as I used it here just for demonstration.
The unit tests can be built using
"make unit-tests." Additionally, Makefile can be modified to add the
file to the build:
--
UNIT_TEST_PROGRAMS +=3D t-date
--
> > -- Ensure TAP Format Output: Ensure that the C-based tests produce outp=
ut in the Test Anything Protocol (TAP) format. This format includes the tes=
t name, status (ok or not ok), and any diagnostic information.
>
> That means using TEST* macros in the cmd_main() function, as they
> should do the right thing or is there more to be done here?
>
> > -- Test Interaction: Ensure that the migrated tests interact correctly =
with the new Git unit test framework and any other tests that may be releva=
nt. Consider dependencies and interactions with other parts of the Git proj=
ect.
>
> I am not sure what work would be needed here. Is there more to do than
> compiling the test files? Having an example would be nice.
>
> > -- Test Execution: Run the migrated tests to verify that they produce t=
he expected results when executed as part of the Git project's test suite. =
Use the Git testing framework's test runners to execute the tests.
>
> Ok.
>
> > -- Documentation Update: Update the Git project's documentation to refl=
ect the changes made during the migration. Include a reference to the origi=
nal unit tests in the t/helper/ directory and indicate that these tests hav=
e been ported to the new Git unit test framework.
>
> I am not sure that we would want that. I think we might instead want
> to document things in t/helper/ that we don't want to port to the new
> unit test framework and why.
>
Ok noted.
> > By following these points, I think I can successfully port existing uni=
t tests from the t/helper/ directory to use the new Git unit test framework=
. This migration helps standardize and streamline the testing process withi=
n the Git project, improving code quality and maintainability.
>
> Yeah!
>
> > Next Steps:
> >
> > I am eager to discuss these suggestions and collaborate with the Git co=
mmunity to ensure the success of this project. I will continue to engage wi=
th the community, seek guidance, and refine my proposal as per your suggest=
ions.
> >  I look forward to the opportunity to contribute to the Git project and=
 help make it even more robust and reliable.
>
> Thanks for this application and sorry for the late answer!
>
> Best,
> Christian.

I look forward to feedback and better understanding of the new testing
framework.

BR,
Achu Luma.
