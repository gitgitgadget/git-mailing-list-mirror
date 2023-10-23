Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D39637
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cswysLLw"
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A7AB3
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:24:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so492213766b.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071056; x=1698675856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnQN97W5kQs5RQsysq4ecHDSro8zbyyXU0TNmNwAL2M=;
        b=cswysLLw27chrjnhHI/BGtR7VDmu6hdcviFPZylEVHQ0nXiTlONe2I8/NiXu9d2sq6
         tZMguOFsw2aCinI3KljGU+pP41koe+TfRb4JeZQk1EXF0G5oyTbS78uAlL3yCPjfeCzn
         CJ/+8QZw6f2hF5ISyLrA0NCm4mgnBaIX2sAB+gFpm3Hx51yX5RlZ0FihTEADvy6Pbtlw
         KRV9CNI3pWkIQP34+dnwn9HTMLtHFIXgERSCk+IGGHJj5B6Jlitd1TyjtkDNXKrveWiw
         wwcMnIvkMqHt280kDVNyEVv3QvJZO2rPHNegP0sVPPks6cDuxLBsDPJWYDIPYI9PMLBb
         YyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071056; x=1698675856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnQN97W5kQs5RQsysq4ecHDSro8zbyyXU0TNmNwAL2M=;
        b=jTDKN7DtUVZocam5KKFPXIwND+mvHvI8ArhbiRZ1OrgfQdfKbyLvHaX//Mr17UByl9
         F6LF1nyNGpN2RDDghmteRMRhUtl+x9fbeLTGnvoBQw3v5nL+WabmiqOjy4/Oly0+dKBe
         knF7cWYh3KPuZLBKCqY84DWnqQEL1MAprUUA5xtkBA4SUYtXP2Xg+F3l064XDdUYJOGR
         OnAmI9DePvw5cmP6NqI7qRoLWwZ0a4YR4aB3pMGTxBlxLmRNWMRB6MZUuB63+3PBJiJf
         jMA8GdETInXX8zdhhrbDxKJg0knrD0UqKyxdOUMtOWYN93j8zHMfDzmDEjX69Eol1TJT
         sqxg==
X-Gm-Message-State: AOJu0YwQSHLjX2nLvnYZGrz5x79hiYbBM4druzYSqE8U+EMlFWd4OttW
	2SZ8qAGd0J3/TQWALl15G9Pp9GAsltYZwlgtI/0=
X-Google-Smtp-Source: AGHT+IEIHBK/C8+3d6mw1BgkfjseFU4vG60Km2u9x+Lqm6IJ2LK3KGfmaykUu3RcB3+gvAV2tsLprPIrRrq8ieaLiXg=
X-Received: by 2002:a17:907:1c93:b0:9bf:70ea:6926 with SMTP id
 nb19-20020a1709071c9300b009bf70ea6926mr7483128ejc.2.1698071055731; Mon, 23
 Oct 2023 07:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
In-Reply-To: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Oct 2023 16:24:03 +0200
Message-ID: <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: Isoken Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:26=E2=80=AFAM Isoken Ibizugbe <isokenjune@gmail.=
com> wrote:
>
> Dear Git Community and Mentors,
>
> I hope you're doing well. I'm excited to share my application draft
> for the Outreachy program with the Git project. Your feedback is
> invaluable, and I'm eager to align the project with the community's
> needs. Please review the attached draft and share your insights.

Thanks for your project application!

[...]

> Why am I interested in working with the Git chosen project?
>
> Git has been a cornerstone for software development, enabling
> developers worldwide to collaborate, innovate, and create exceptional
> software. I would say without Git, my journey to pursuing my software
> engineering career would be impossible, as I use it almost every day.
> Yet, in this constantly evolving landscape, there is always room for
> improvement, even in a well-established project. The Git project
> currently relies on end-to-end tests, and this is where I see an
> opportunity to make a profound impact. Being able to test libraries in
> isolation via unit tests or mocks speeds up determining the root cause
> of bugs. I am deeply passionate about contributing to this project and
> firmly believe in the power of open-source software and the collective
> intelligence of the community. A successful completion of this project
> will significantly improve Git's testing capabilities and bring the
> benefits of fewer errors, faster work and better testing for all
> parts.

Ok.

[...]

> Contributions to Git
>
> I have actively participated in Git's mailing list discussions and
> contributed to a micro-project;
>
> - builtin/branch.c: Adjust error messages such as die(), error(), and
> warning() messages used in branch, to conform to coding guidelines
> (https://lore.kernel.org/git/20231019084052.567922-1-isokenjune@gmail.com=
/)
> - Implemented changes to fix broken tests based on reviews from the
> community (https://lore.kernel.org/git/20231019084052.567922-1-isokenjune=
@gmail.com/)
> - In review.

Nice!

> Project Goals:
>
> - Improve Testing Efficiency: Transitioning from end-to-end tests to
> unit tests will enable more efficient testing of error conditions.
> - Codebase Stability: Unit tests enhance code stability and facilitate
> easier debugging through isolation.
> - Simplify Testing: Writing unit tests in pure C simplifies test
> setup, data passing, and reduces testing runtime by eliminating
> separate processes for each test.

Ok.

> Project Milestones:
>
> - Add useful tests of library-like code
> - Integrate with stdlib work

Not sure what you call "stdlib" here.

> - Run alongside regular make test target
>
> Project Timeline:
>
> 1. Oct 2 - Nov 20: Community Bonding
>
> - Understanding the structure of Git
> - Getting familiar with the code

I think some of this time is also spent on working on a microproject,
writing an application and perhaps doing other things that regular Git
developers do.

> 2. Dec 4 - Jan 15: Add useful tests of library-like code
>
> - Identify and document the current state of the tests in the Git
> t/helper directory.

It would be nice if you could already take a look at that and tell us
about it in your application. There are different things in t/helper.
Some are worth porting and others are not. You might not want (or have
time to) to classify everything right now, but if you can identify a
few of each kind, and use those, or just one of them, as an example,
that would be great.

> - Confirm the licensing and compatibility requirements for the chosen
> unit testing framework.

I think those who have been working on the unit test framework have
already done this.

> - Develop unit tests for these library-like components.

Not sure what are "these library-like components". An example would
perhaps help.

> - Execute the tests and ensure they cover various scenarios, including
> error conditions.
> - Run the tests and address any initial issues or bugs to ensure they
> work as intended.

Ok.

> - Document the new tests and their coverage.

What kind of documentation would that be?

> - Seek feedback  and support from mentors and the Git community
>
> 3. Jan 15 - Feb 15: Integrate with Stdlib Work
>
> - Collaborate with the team working on standard library integration.

Not sure what "standard library". Actually, maybe you are talking
about the goal of having a "standard library" implementation for Git
which is described in this report from the Virtual Contributor's
Summit:

https://lore.kernel.org/git/ZRrfN2lbg14IOLiK@nand.local/

It's true that the unit test framework would help with that goal. So
yeah maybe you will have to collaborate with the team working on that
goal. I am not sure at what step the work on this library will be when
the internship will start though.

> - Ensure that the tests for library-like code align with stdlib work.
> - Verify that the tests effectively check the compatibility and
> interaction of the code with standard libraries.
> - Gather feedback and insights from the Git community on the
> integrated tests, addressing any concerns or suggestions.

Ok, but I think it would be more interesting to follow the steps with
an example test.

> 4. Feb 15 - March 1: Run Alongside Regular 'make test' Target and finaliz=
e
>
> - Configure the testing framework to run alongside the regular 'make
> test' target.

I think others will likely take care of that sooner.

> - Ensure that the new tests are included in the standard testing suite.
> - Execute 'make test' with the new tests and verify that they pass succes=
sfully.
> - Document the integration process and how the new tests are included
> in the standard testing procedure.
> - Perform comprehensive testing of the entire unit testing framework.
> - Ensure all migrated tests are working correctly within the new framewor=
k.
> - Document the entire process of migrating Git's tests
> - Prepare a final project report

Ok, but here also following an example test would be more interesting.

> Technical Requirements
>
> According to the documentation on the unit test project
> (https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/t=
echnical/unit-tests.adoc),
> the suggested best framework for the Git project is the "Custom TAP
> framework" (Phillip Wood's TAP implementation), as it aligns with
> Git's licensing requirements, is vendorable, and can be customized by
> Git's developers as needed, but it may require some additional
> development work for features like parallel execution and mock
> support, but it offers a strong foundation for unit testing within the
> Git project.

Yeah, right. Thanks for summarizing that document!

> Relevant Projects
>
> Simple shell -  A project based on emulating a shell. It was a
> collaborative project which we managed using Git.
> (https://github.com/Junie06/simple_shell).
> This project was written in C, which allowed me to apply my C language
> knowledge, essential for Git projects.
> I'm proficient in using Shell for scripting, redirections, and
> permissions, as shown in my work
> (https://github.com/Junie06/alx-system_engineering-devops).
> Creating the simple shell project deepened my understanding of how
> shells work, and I even attempted to replicate a shell environment.
> Collaborating on the Simple Shell project reinforced my Git skills.

Ok, nice!

Best,
Christian.
