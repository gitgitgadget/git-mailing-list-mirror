Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F31A727
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDLTvryn"
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1191A8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 06:18:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso587983a12.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697807926; x=1698412726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttETyfs2b9ulXDp66bGy451Tj9pbiKO/xjPFT2gG5oo=;
        b=iDLTvrynjSdWlv0+2+NExa1VQG4SWNx1fVbp62MC0oMk880VE1skbnvOrMzkuii1QJ
         oKnK2ttHgduLV9DeTnPJBOxI+EaeFsqZ468qY7Hu/C+339ugetRG6AHexRYZLazu0Gsz
         G1HVoz7Ql/FzM+1Vhll07SQs8yMvedOLPdsoa0xwQwp/0qidcQug5Oum5De3dp1KumEZ
         761xinL+zM/oPpFaNwibUDiBzgH30bVR/F9tCVWPvZPiXy6N7YrfPFj/E8lZZyenPm9F
         yyOj2mCEM5c5G7/4B/Vgqbuu8pjVru5EAx6rMfxWQttwor/2I0TQCfDb5AzY2rSvHU8k
         SrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807926; x=1698412726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttETyfs2b9ulXDp66bGy451Tj9pbiKO/xjPFT2gG5oo=;
        b=H1EWV+MdiUN34+brYDm4XcFMJwvyu3AeQvEiEtRDbnEltukOl4CbHMWPVn7fsF/Y5N
         hsNvI985x3UPf6ILiNVi1yI0vjVlWflRjIB6WOQ3vRDy4ljUe4KgsduucVd+qL5m188G
         5BLta+Y/l60e535pbSy/a50Hs8fiwHUVnMJkLXXvXiLx7XDIoU+CCBGX/4g1eRymMvSW
         LqmexuGr5AFvdanSU+k65rw3S9zce87HQZgXcC7ZhZoiKNqwH7orLgHBR8NZ4vySAXYl
         qjzfoyQU2NG0R8rbv69nABcUKRNAKfSKpJqFU6WFBgfOS9VAnJQQKvY22xw8jK+jUBYl
         cntw==
X-Gm-Message-State: AOJu0Ywjwdk1NLRbaqXFFn/ObiJILPdH5lYL2cH/7yL4/wgPOJfoZuAE
	4c3O8V81QNiLDDYkIXbrAZCp2RuIa3T7yp60hgI=
X-Google-Smtp-Source: AGHT+IHdOCQJgRAicSLYG3dTb2jBp3MrCyt5HrwwXnujvGS8M9hYyaIG5OvBwcKiNzxf58vYTC2oiP3xRk0A8XLOQgg=
X-Received: by 2002:a17:90a:5286:b0:27c:fe72:6e9 with SMTP id
 w6-20020a17090a528600b0027cfe7206e9mr1879328pjh.27.1697807926265; Fri, 20 Oct
 2023 06:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
 <xmqqedibzgi1.fsf@gitster.g> <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
 <CAFR+8Dz717pcc2Lm_J29xxiBt-kUrMP4JAUbm=3XaJuJPYseHg@mail.gmail.com> <CAFR+8Dwxr3iV+R7een0t2sYXUWu1XHhQcLVuqMhOsSg9Bt4wrg@mail.gmail.com>
In-Reply-To: <CAFR+8Dwxr3iV+R7een0t2sYXUWu1XHhQcLVuqMhOsSg9Bt4wrg@mail.gmail.com>
From: Achu Luma <ach.lumap@gmail.com>
Date: Fri, 20 Oct 2023 14:18:34 +0100
Message-ID: <CAFR+8Dx=0QMOcw8zvRL_+OzvJv5wt3F_t+FZqNvcB-rWqh3oFg@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Community and Mentors,

I hope this email finds you well. As a follow-up to my previous
application, I'd like to provide additional details on the process of
migrating existing unit tests from the t/helper/ directory to the new
Git unit test framework.
-- Identify Target Unit Tests: Start by identifying the specific unit
tests in the t/helper/ directory that we want to port to the new Git
unit test framework. Ensure that the tests are suitable for migration
and that the benefits of doing so outweigh the effort(By avoiding
integration tests). The following points have been developed with on
going work on the unit-tests framework visible here: 1-
https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.168816=
5272.git.steadmon@google.com/
2- https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/t=
echnical/unit-tests.adoc

-- Create a New C Test File: For each unit test I plan to migrate,
create a new C source file (.c) in the Git project's test suite
directory(t/unit-tests). Name it appropriately to reflect the purpose
of the test.

--  Include Necessary Headers:In the new C test file, include the
necessary Git unit test framework headers. Typically, this includes
headers like "test-lib.h" and others relevant to the specific test.
#include "test-lib.h"

-- Convert Test Logic: Refactor the test logic from the original Shell
script into the new C-based test format. Use the testing macros
provided by the Git unit test framework, such as test_expect_success,
test_expect_failure, etc., to define the tests.
test_expect_success("simple progress display", "{
    // Test logic here...
}");

-- Add Test Descriptions: Provide clear and informative descriptions
for each test using the testing macros. These descriptions will help
in identifying the purpose of each test when the test suite is run.

-- Define a Test Entry Point: Create a cmd_main function as the entry
point for the C-based tests. Inside this function, include the test
functions using the testing macros.
int cmd_main(int argc, const char **argv) {
    // Test functions...
    return test_done();
}

-- Ensure TAP Format Output: Ensure that the C-based tests produce
output in the Test Anything Protocol (TAP) format. This format
includes the test name, status (ok or not ok), and any diagnostic
information.

-- Test Interaction: Ensure that the migrated tests interact correctly
with the new Git unit test framework and any other tests that may be
relevant. Consider dependencies and interactions with other parts of
the Git project.

-- Test Execution: Run the migrated tests to verify that they produce
the expected results when executed as part of the Git project's test
suite. Use the Git testing framework's test runners to execute the
tests.

-- Documentation Update: Update the Git project's documentation to
reflect the changes made during the migration. Include a reference to
the original unit tests in the t/helper/ directory and indicate that
these tests have been ported to the new Git unit test framework.

By following these points, I think I can successfully port existing
unit tests from the t/helper/ directory to use the new Git unit test
framework. This migration helps standardize and streamline the testing
process within the Git project, improving code quality and
maintainability.

Next Steps:

I am eager to discuss these suggestions and collaborate with the Git
community to ensure the success of this project. I will continue to
engage with the community, seek guidance, and refine my proposal as
per your suggestions.
 I look forward to the opportunity to contribute to the Git project
and help make it even more robust and reliable.

Best Regards,
Achu Luma


On Fri, Oct 20, 2023 at 2:15=E2=80=AFPM Achu Luma <ach.lumap@gmail.com> wro=
te:
>
> Dear Git Community and Mentors,
>
> I hope this email finds you well. As a follow-up to my previous applicati=
on, I'd like to provide additional details on the process of migrating exis=
ting unit tests from the t/helper/ directory to the new Git unit test frame=
work.
> -- Identify Target Unit Tests: Start by identifying the specific unit tes=
ts in the t/helper/ directory that we want to port to the new Git unit test=
 framework. Ensure that the tests are suitable for migration and that the b=
enefits of doing so outweigh the effort(By avoiding integration tests). The=
 following points have been developed with on going work on the unit-tests =
framework visible here: 1- https://lore.kernel.org/git/0169ce6fb9ccafc089b7=
4ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/
> 2- https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation=
/technical/unit-tests.adoc
>
> -- Create a New C Test File: For each unit test I plan to migrate, create=
 a new C source file (.c) in the Git project's test suite directory(t/unit-=
tests). Name it appropriately to reflect the purpose of the test.
>
> --  Include Necessary Headers:In the new C test file, include the necessa=
ry Git unit test framework headers. Typically, this includes headers like "=
test-lib.h" and others relevant to the specific test.
> #include "test-lib.h"
>
> -- Convert Test Logic: Refactor the test logic from the original Shell sc=
ript into the new C-based test format. Use the testing macros provided by t=
he Git unit test framework, such as test_expect_success, test_expect_failur=
e, etc., to define the tests.
> test_expect_success("simple progress display", "{
>     // Test logic here...
> }");
>
> -- Add Test Descriptions: Provide clear and informative descriptions for =
each test using the testing macros. These descriptions will help in identif=
ying the purpose of each test when the test suite is run.
>
> -- Define a Test Entry Point: Create a cmd_main function as the entry poi=
nt for the C-based tests. Inside this function, include the test functions =
using the testing macros.
> int cmd_main(int argc, const char **argv) {
>     // Test functions...
>     return test_done();
> }
>
> -- Ensure TAP Format Output: Ensure that the C-based tests produce output=
 in the Test Anything Protocol (TAP) format. This format includes the test =
name, status (ok or not ok), and any diagnostic information.
>
> -- Test Interaction: Ensure that the migrated tests interact correctly wi=
th the new Git unit test framework and any other tests that may be relevant=
. Consider dependencies and interactions with other parts of the Git projec=
t.
>
> -- Test Execution: Run the migrated tests to verify that they produce the=
 expected results when executed as part of the Git project's test suite. Us=
e the Git testing framework's test runners to execute the tests.
>
> -- Documentation Update: Update the Git project's documentation to reflec=
t the changes made during the migration. Include a reference to the origina=
l unit tests in the t/helper/ directory and indicate that these tests have =
been ported to the new Git unit test framework.
>
> By following these points, I think I can successfully port existing unit =
tests from the t/helper/ directory to use the new Git unit test framework. =
This migration helps standardize and streamline the testing process within =
the Git project, improving code quality and maintainability.
>
> Next Steps:
>
> I am eager to discuss these suggestions and collaborate with the Git comm=
unity to ensure the success of this project. I will continue to engage with=
 the community, seek guidance, and refine my proposal as per your suggestio=
ns.
>  I look forward to the opportunity to contribute to the Git project and h=
elp make it even more robust and reliable.
>
> Best Regards,
> Achu Luma
>
> On Mon, Oct 9, 2023 at 10:15=E2=80=AFAM Luma <ach.lumap@gmail.com> wrote:
>>
>> Dear Git Community and Mentors,
>>
>> I hope this email finds you well. My name is Achu Luma, and I am
>> excited to submit my application for the Outreachy program with the
>> Git project.
>> I have been a passionate open-source enthusiast and a dedicated Git
>> user for two years, and I am thrilled at the opportunity to contribute
>> to the Git community.
>>
>> Introduction:
>> ----------------
>> I study Computer Science from the University of Bamenda. Over the past
>> 4 years, I have gained experience in software development and have
>> participated in various class projects.
>>
>> Why I am a Good Fit:
>> ----------------------
>> 1. Proficient with Git: I have a good understanding of Git's version
>> control system and have successfully used it in both personal and
>> educational projects.
>>
>> 2. Strong Programming Skills: My programming skills in python, C etc
>> and experience with git, shell etc make me well-prepared to contribute
>> to Git's codebase.
>>
>> 3. Open Source Involvement: I have actively contributed to git
>> open-source project, including
>> https://public-inbox.org/git/20231003174853.1732-1-ach.lumap@gmail.com/T=
/#t
>> , where I have submitted a patch that has been well-received.
>>
>> Project Idea - Moving Existing Tests to a Unit Testing Framework:
>> ------------------------------------------------------------------
>> I am excited about "Moving Existing Tests to a Unit Testing Framework".
>> The objective of this project is to enhance the efficiency and
>> maintainability of Git's testing infrastructure by porting existing
>> unit tests to a unit testing framework.
>>
>> **Project Plan**:
>> - Evaluate the existing tests in the `t/helper/` directory to identify
>> those suitable for migration to the unit testing framework.
>> - Develop a migration strategy and create detailed plans for adapting
>> these tests.
>> - Port the identified tests to the unit testing framework while
>> ensuring they maintain their functionality.
>> - Verify the correctness and reliability of the migrated tests through
>> thorough testing and validation.
>> - Collaborate with the Git community to gather feedback and make
>> necessary adjustments.
>>
>> **Timeline**:
>> - Community Bonding (Oct 2 - Nov 20): Familiarize myself with the Git
>> project and establish communication channels.
>> - Coding Phase (Dec 4 - Jan 15): Implement the migration of tests and
>> seek feedback from mentors and the community.
>> - Testing and Validation (Jan 15 - Feb 15): Rigorously test the
>> migrated tests and make improvements based on feedback.
>> - Documentation and Finalization (Feb 15 - March 1): Document the
>> migration process and finalize the project.
>>
>> **Contribution to Git Community**:
>> I have actively participated in Git's mailing-list discussions and
>> submitted a patch(
>> https://public-inbox.org/git/20231003174853.1732-1-ach.lumap@gmail.com/T=
/#t)
>> for review. I have received positive feedback on my contributions, and
>> it has been queued to be merged into official Git branches maintained
>> by Junio. Additionally, I have been involved in discussions related to
>> the git project.(https://public-inbox.org/git/CAFR+8DyN8vbuvdgZPkSVqS2=
=3Dsqconwhx3QfcpJ0+Wi_oCA=3Ds0w@mail.gmail.com/T/#t)
>>
>> **Proposal Drafts**:
>> I have shared drafts of this proposal on the Git mailing list
>> git@vger.kernel.org  and will incorporate valuable feedback provided
>> by the community.
>>
>> **Next Steps**:
>> I am eager to discuss my proposal further and collaborate with the Git
>> community to ensure the success of this project. I will continue to
>> engage with the community, seek guidance, and refine my proposal as
>> per your suggestions.
>>
>> Thank you for considering my application. I look forward to the
>> opportunity to contribute to the Git project and help make it even
>> more robust and reliable.
>>
>> Best Regards,
>>
>> On Wed, Oct 4, 2023 at 12:36=E2=80=AFAM Luma <ach.lumap@gmail.com> wrote=
:
>> >
>> > oh yes, "Move existing tests to a unit testing framework" was the
>> > only listed project for this current Outreachy cohort. So, I used it
>> > to express my intent.
>> > I appreciate the clarification on authorship identity for patches. I
>> > will update subsequent patches with a legal full name to conform to
>> > the community rules.
>> >
>> > Regards.
>> >
>> > On Tue, Oct 3, 2023 at 7:51=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> > >
>> > > Luma <ach.lumap@gmail.com> writes:
>> > >
>> > > > Hi;
>> > > > My name is Luma, and  I wanted to take a moment to introduce mysel=
f
>> > > > and share some
>> > > > insights on an essential aspect of  avoiding pipes in git related
>> > > > commands in test scripts.
>> > > >
>> > > > I am an outreachy applicant for the December 2023 cohort and look
>> > > > forward to learning from you.
>> > >
>> > > I notice that the title of the message and the immediate topic you
>> > > discuss in the body of the message do not match.  I presume that the
>> > > topic on the title is what you prefer to work on if the unit testing
>> > > framework is ready by the time Outreachy program starts, and the
>> > > mention about "do not clobber exit code of Git with pipes in the
>> > > tests" is your "dip the tip of a toe in water" microproject?
>> > >
>> > > Welcome to the Git development community.
>> > >
>> > > Do you have a single word name?  If so please disregard the below,
>> > > but in case "Luma" is just a nickname (e.g. like I am introducing
>> > > myself to my Git friends "Hi, I am Gitster!") you use online, please
>> > > read on.
>> > >
>> > > For signing off your patches, we'd prefer to see your real name
>> > > used, as Signed-off-by: is meant to have legal significance.  And
>> > > because we also expect the authorship identity to match the
>> > > name/e-mail of the sign-off, it would mean your patch submissions
>> > > are expected to look like:
>> > >
>> > >         From: Luma <ach.lumap@gmail.com>
>> > >         Subject: ... title of the patch goes here ...
>> > >
>> > >         ... body of the proposed commit log message goes here...
>> > >
>> > >         Signed-off-by: Luma <ach.lumap@gmail.com>
>> > >
>> > > but "Luma" replaced with your full real name.
>> > >
>> > > Thanks.
