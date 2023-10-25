Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FB1C6B1
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyVs8wJD"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DBDD
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:19:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1290195a12.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698221943; x=1698826743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jkzRoR/f9peSAZ7njIoWk+2xZdcnqEVgfmG9BpMb+k=;
        b=CyVs8wJDq9Yf3i3G9KEQQjCSvnWYJSPhkD+rv58UYvcgZ5+3CZiShB+dXSbRo97EYS
         ebkXL64u5C6Q6xDHPvQsPkNOG4z8tcAwYNpGZnGN74bg8MwUedFNKT7coAnG+vK412bY
         hfAd8jpj7Ybun+L1x8LYcd83GT5V9YGrE+SJ/kTNDiNBhfB/DfoDXcLf4HdOInzMHdsB
         xhf5yhMmsHHo+TYyn1SyJEmuAlDNi4TkyIVh4XH9h4GzCQa+J9evbaDQsy0cxyI9BqJy
         rY4xUsSl5PU+c/cwZy1VrgS7wYEZdz4fGaA0H/dAsJkWVNjn5hbmV3U4FHR+Q+zCs1Hd
         Khzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221943; x=1698826743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jkzRoR/f9peSAZ7njIoWk+2xZdcnqEVgfmG9BpMb+k=;
        b=TAzVXCCWmPEodYonOTTcRfiWHlZInS/Jww1X88gUzgIeW6A/Hk84mv8Q736CrwfiCi
         +eWM83nXzkf1eGGa6r9R4DrWsPeYGNJhw2pf3JVbEU/UDaVTixJZm/wYCAP2W60PE6a2
         aYjqC9imJXc1r8SBzX9pEkCTQVmaUrzYYafpCzgiokbrVQXiK6xHBmF6pDNmPQI6CDwY
         LbLxokoRIrF0/TQvj+/oOgC6AaJj4dS2N38VaFCSYl/BpikxVe+kiWuSiR1egnSzw4N9
         AZ85Aa2CJuwCttj36M+7jTUfa7nZEH7nx0VKt6KvQer3hVfLirWpEvD3cJuN3CcJDSVl
         LyWQ==
X-Gm-Message-State: AOJu0Ywos6TnmeBGwf8hd45KTO4TnSD0+imZKlMyLdJ6EvLNBScCb5/Y
	n95m3SxwCnhXVhjmtUQ75n55JyZxRFAAllRDVBw=
X-Google-Smtp-Source: AGHT+IFB479Wqa2k96kLLOvEsXtfFSVMGTmTXloGQyxgt9Zn06q9DGuBxsYtef/hek1wJrUbN/lidOr9fU/lPfs0XmA=
X-Received: by 2002:a05:6402:2314:b0:530:ec02:babd with SMTP id
 l20-20020a056402231400b00530ec02babdmr14330380eda.9.1698221943333; Wed, 25
 Oct 2023 01:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
 <xmqqedibzgi1.fsf@gitster.g> <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
 <CAFR+8Dz717pcc2Lm_J29xxiBt-kUrMP4JAUbm=3XaJuJPYseHg@mail.gmail.com>
 <CAFR+8Dwxr3iV+R7een0t2sYXUWu1XHhQcLVuqMhOsSg9Bt4wrg@mail.gmail.com>
 <CAP8UFD0A_vWCZ5cVAZqdTBebdhZNye_FmNNJF+vA7epUx2JWHQ@mail.gmail.com> <CAFR+8DzdFbwaiHtZSdLMqWYWh=fK0WA4c48+eBug-ZeAgddhcQ@mail.gmail.com>
In-Reply-To: <CAFR+8DzdFbwaiHtZSdLMqWYWh=fK0WA4c48+eBug-ZeAgddhcQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Oct 2023 10:18:51 +0200
Message-ID: <CAP8UFD0jJF6dPkC4yu1wtLXLsUg7HqT8oV6yiHzxgxe-mhQaJQ@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:25=E2=80=AFPM Achu Luma <ach.lumap@gmail.com> wro=
te:
>
> On Mon, Oct 23, 2023 at 2:41=E2=80=AFPM Christian Couder
> <christian.couder@gmail.com> wrote:

> > Maybe if you have time you could add some descriptions or comments
> > related to the above emails and documents. For example you could tell
> > what the new unit test framework will be like, how the unit tests will
> > look like, etc. Maybe a short overview would be nice.
> >
> sure,
> 1- https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1=
688165272.git.steadmon@google.com/
> :
>     The emails highlight the significant milestones achieved in
> defining and testing the custom TAP
>      framework for writing git unit tests. It also contains some
> examples of implementation such as
>      that of STRBUF_INIT with output:
>       ok 1 - static initialization works
>      1..1
>
> 2-  https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentatio=
n/technical/unit-tests.adoc:
>      From this technical doc, the new unit test framework in the Git
> project represents a significant
>      enhancement, introducing a systematic and efficient approach to
> unit testing. The custom git
>      TAP implementation was selected from several alternatives based
> on strict criteria as the most
>      suitable test framework for porting the unit tests.
>      The unit tests are  written in pure C, eliminating the need for
> the previous shell/test-tool helper
>      setup, simplifying test configuration, data handling, and
> reducing testing runtime.
>      Each unit test is encapsulated as a function and employs a range
> of predefined check functions
>      for validation. These checks can evaluate conditions, compare
> integers or characters, validate
>      strings, and more, providing comprehensive coverage for test scenari=
os.
>
>     When a test is run using the TEST() macro, it undergoes a series
> of checks, and if any check fails,
>     a diagnostic message is printed to aid in debugging. This
> diagnostic output includes information
>     about the specific check that failed, the file and line number
> where it occurred, and a clear comparison
>     of the expected and actual values. Such detailed reporting
> simplifies the identification and resolution
>     of issues, contributing to codebase stability.
>
>     Additionally, the framework supports features like skipping tests
> with explanations, sending custom
>     diagnostic messages using test_msg(), and marking known-to-fail
> checks using TEST_TODO().
>     This flexibility allows developers to tailor their tests to
> specific scenarios while ensuring a
>     comprehensive testing suite.

Ok, please add all these explanations above as well as those below to
your application document. We prefer that you consider your
application document like a patch. So you would send to the mailing
list several versions of it for review before submitting officially.

> > You could also try to apply the patches in the series that adds the
> > test framework, or alternatively use the 'seen' branch where the
> > series has been merged, and start playing with it by writing, or
> > porting, a small example test.
> >
> ok, I think I can push a patch for one.

I don't think it's necessary to send it to the mailing list for now,
but it should definitely be part of your application document.

> > > -- Create a New C Test File: For each unit test I plan to migrate, cr=
eate a new C source file (.c) in the Git project's test suite directory(t/u=
nit-tests). Name it appropriately to reflect the purpose of the test.
> >
> > Could you provide an example of what the new name would be for an
> > existing test that is worth porting?
> >
> Sure... let's consider an existing unit test in t/helper directory
> such as  t/helper/test-date.c or
> its shell named t0006-date.sh, which is part of the current
> shell-based test suite. In the context
> of the new unit testing framework, this test could be reimagined and rena=
med as
> "t-date.c". The "t-" prefix is typically used for test program files
> in Git, and "date" is retained to
>  reflect the nature of the tests within this suite.

Ok.

> > > --  Include Necessary Headers:In the new C test file, include the nec=
essary Git unit test framework headers. Typically, this includes headers li=
ke "test-lib.h" and others relevant to the specific test.
> > > #include "test-lib.h"
> >
> > Maybe you could continue the above example and tell which headers
> > would be needed for it?
> >
> > > -- Convert Test Logic: Refactor the test logic from the original Shel=
l script into the new C-based test format. Use the testing macros provided =
by the Git unit test framework, such as test_expect_success, test_expect_fa=
ilure, etc., to define the tests.
> > > test_expect_success("simple progress display", "{
> > >     // Test logic here...
> > > }");
> >
> > Ok, a simple example would be nice too.
> >
> we can continue with the example used for naming: test-date.c. a
> typical t-date.c unit test would look
> like the following:
> --
> #include "test-lib.h"
> #include "date.h"
> --
> date.h here is a necessary header file. Now refactoring the test logic
> from the original shell script:
> --
> #include "test-lib.h"
> #include "date.h"
>
> static void test_parse_dates(void)
> {
>     const char *dates[] =3D { "invalid_date", "2023-10-17 10:00:00 +0200"=
, NULL };
>
>     for (const char **argv =3D dates; *argv; argv++) {
>         check_int(parse_dates((const char *[]){ *argv, NULL }), 0);
>     }
> }
> --

Nice!

> > > -- Add Test Descriptions: Provide clear and informative descriptions =
for each test using the testing macros. These descriptions will help in ide=
ntifying the purpose of each test when the test suite is run.
> >
> > This would seem to be part of the previous step, as you would have to
> > provide a description when using the testing macro. But Ok.
> >
> > > -- Define a Test Entry Point: Create a cmd_main function as the entry=
 point for the C-based tests. Inside this function, include the test functi=
ons using the testing macros.
> > > int cmd_main(int argc, const char **argv) {
> > >     // Test functions...
> > >     return test_done();
> > > }
> >
> > Yeah, continuing an example would be nice.
> >
> Continuing, we can add a test entrance as follows:
> --
> #include "test-lib.h"
> #include "date.h"
>
> static void test_parse_dates(void)
> {
>     const char *dates[] =3D { "invalid_date", "2023-10-17 10:00:00 +0200"=
, NULL };
>
>     for (const char **argv =3D dates; *argv; argv++) {
>         check_int(parse_dates((const char *[]){ *argv, NULL }), 0);
>     }
> }
>
> int main(int argc UNUSED, const char **argv UNUSED)
> {
>     TEST(test_parse_dates, "Test date parsing");
>
>     return test_done();
> }
> --
>
> A typical unit tests with the custom TAP framework would look
> something like above. This might run in theory
> but I have not yet run it as I used it here just for demonstration.
> The unit tests can be built using
> "make unit-tests." Additionally, Makefile can be modified to add the
> file to the build:
> --
> UNIT_TEST_PROGRAMS +=3D t-date
> --

Great!

Thanks,
Christian.
