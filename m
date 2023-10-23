Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3581FD9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqly9MGr"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71C1E4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:41:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be3b66f254so471686566b.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698068477; x=1698673277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7ZdwAPDy4ZT3SiavQNVYQpl05oqCoydcjaUERt9nw4=;
        b=Lqly9MGrLGLRy3taiQrwPN9rUFh/qs+jekTlVDr8ZlDmZBm6IcCA+CcnPiAAFWKq1/
         67yDkYYpRQLA316dk7QtWwBkpDbuHuOs4ZiwdLmKy6D6OsoBi1lKQ1iQpSoa/rHdDhcG
         uBT+ahmlPzkrSIbXXzAu0LoJ0ZmRolZ0+HW656NZghRrfmA5mAc3kxBNez9aTva1aSoo
         E6UEHQq5cTY8WRwrh3hSDorbdbvaW2Nw0VLlR0Kdq3/o12b8urEz7+0yWX5GYFKJw1d8
         pCuQpdIjZJyZu/ft4jlkdEYur1k7GDuuKKYsAnxQq4z8a/feWUNWQ7LueK8tZr1VzeiZ
         s43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068477; x=1698673277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7ZdwAPDy4ZT3SiavQNVYQpl05oqCoydcjaUERt9nw4=;
        b=ZV4vB1RcwSycHk4qMEMDyje/NsHbQr9uULhtdtrpCzgfOEUhldIa7U0IkEal9CIGiR
         lUPhwficImLGWwcT5clwOOS0fVg1ZzC7V5zpfHMQszTo/nuqRzHKMvsy5UzYwYtMYTrY
         KdFTYDsHSkCRxJcKX89K2qfqpx+Or1m8FVPZ60QnqH4o3mF7RGQY5QlZu5/u/rAptlN9
         MVDe/vFwitLZ3y3/k5l38GAhws3Ul2Af5YfS0ogAdqw/Si2geVWRz4g4X6MmVM/SPKS9
         pbrCU8s5Rjw6ErlXa6g1aTA+gA1SeWLkcFGApjzkW9B5hbcoF6qs/g2GIdGKfI3oX1gZ
         +1WQ==
X-Gm-Message-State: AOJu0YzlWiSBNUETFRuFovVyPeduWnzEl5h7hUP4K8N2JdtJNmX5gLLq
	0gLb46qM/T+Rc8S9U91TZdjxfHwWiaugqiQ7NkSLpZSdTuY=
X-Google-Smtp-Source: AGHT+IEUTVxD7UgRz8mzgYlvEITkTJw3NT8ayL5pCDz7AId4MUbzLXds/5te/AZVlDP1e5LBcuTo+Yces0FiH2odKXw=
X-Received: by 2002:a17:907:a45:b0:9b2:ccd8:2d42 with SMTP id
 be5-20020a1709070a4500b009b2ccd82d42mr6290562ejc.32.1698068476907; Mon, 23
 Oct 2023 06:41:16 -0700 (PDT)
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
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Oct 2023 15:41:05 +0200
Message-ID: <CAP8UFD0A_vWCZ5cVAZqdTBebdhZNye_FmNNJF+vA7epUx2JWHQ@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To: Achu Luma <ach.lumap@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 3:16=E2=80=AFPM Achu Luma <ach.lumap@gmail.com> wro=
te:
>
> Dear Git Community and Mentors,
>
> I hope this email finds you well. As a follow-up to my previous applicati=
on, I'd like to provide additional details on the process of migrating exis=
ting unit tests from the t/helper/ directory to the new Git unit test frame=
work.

Thanks for these details!

> -- Identify Target Unit Tests: Start by identifying the specific unit tes=
ts in the t/helper/ directory that we want to port to the new Git unit test=
 framework. Ensure that the tests are suitable for migration and that the b=
enefits of doing so outweigh the effort(By avoiding integration tests). The=
 following points have been developed with on going work on the unit-tests =
framework visible here:
>
> 1- https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1=
688165272.git.steadmon@google.com/
> 2- https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation=
/technical/unit-tests.adoc

Maybe if you have time you could add some descriptions or comments
related to the above emails and documents. For example you could tell
what the new unit test framework will be like, how the unit tests will
look like, etc. Maybe a short overview would be nice.

You could also try to apply the patches in the series that adds the
test framework, or alternatively use the 'seen' branch where the
series has been merged, and start playing with it by writing, or
porting, a small example test.

> -- Create a New C Test File: For each unit test I plan to migrate, create=
 a new C source file (.c) in the Git project's test suite directory(t/unit-=
tests). Name it appropriately to reflect the purpose of the test.

Could you provide an example of what the new name would be for an
existing test that is worth porting?

> --  Include Necessary Headers:In the new C test file, include the necessa=
ry Git unit test framework headers. Typically, this includes headers like "=
test-lib.h" and others relevant to the specific test.
> #include "test-lib.h"

Maybe you could continue the above example and tell which headers
would be needed for it?

> -- Convert Test Logic: Refactor the test logic from the original Shell sc=
ript into the new C-based test format. Use the testing macros provided by t=
he Git unit test framework, such as test_expect_success, test_expect_failur=
e, etc., to define the tests.
> test_expect_success("simple progress display", "{
>     // Test logic here...
> }");

Ok, a simple example would be nice too.

> -- Add Test Descriptions: Provide clear and informative descriptions for =
each test using the testing macros. These descriptions will help in identif=
ying the purpose of each test when the test suite is run.

This would seem to be part of the previous step, as you would have to
provide a description when using the testing macro. But Ok.

> -- Define a Test Entry Point: Create a cmd_main function as the entry poi=
nt for the C-based tests. Inside this function, include the test functions =
using the testing macros.
> int cmd_main(int argc, const char **argv) {
>     // Test functions...
>     return test_done();
> }

Yeah, continuing an example would be nice.

> -- Ensure TAP Format Output: Ensure that the C-based tests produce output=
 in the Test Anything Protocol (TAP) format. This format includes the test =
name, status (ok or not ok), and any diagnostic information.

That means using TEST* macros in the cmd_main() function, as they
should do the right thing or is there more to be done here?

> -- Test Interaction: Ensure that the migrated tests interact correctly wi=
th the new Git unit test framework and any other tests that may be relevant=
. Consider dependencies and interactions with other parts of the Git projec=
t.

I am not sure what work would be needed here. Is there more to do than
compiling the test files? Having an example would be nice.

> -- Test Execution: Run the migrated tests to verify that they produce the=
 expected results when executed as part of the Git project's test suite. Us=
e the Git testing framework's test runners to execute the tests.

Ok.

> -- Documentation Update: Update the Git project's documentation to reflec=
t the changes made during the migration. Include a reference to the origina=
l unit tests in the t/helper/ directory and indicate that these tests have =
been ported to the new Git unit test framework.

I am not sure that we would want that. I think we might instead want
to document things in t/helper/ that we don't want to port to the new
unit test framework and why.

> By following these points, I think I can successfully port existing unit =
tests from the t/helper/ directory to use the new Git unit test framework. =
This migration helps standardize and streamline the testing process within =
the Git project, improving code quality and maintainability.

Yeah!

> Next Steps:
>
> I am eager to discuss these suggestions and collaborate with the Git comm=
unity to ensure the success of this project. I will continue to engage with=
 the community, seek guidance, and refine my proposal as per your suggestio=
ns.
>  I look forward to the opportunity to contribute to the Git project and h=
elp make it even more robust and reliable.

Thanks for this application and sorry for the late answer!

Best,
Christian.
