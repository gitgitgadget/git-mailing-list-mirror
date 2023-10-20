Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9ECA5D
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A98Sd4pC"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D181A8
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:32:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d922c039so3214845ad.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697776361; x=1698381161; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upHfO5i3vu48grgTZL4fJNuWkT6vWMEJam9EIpI+5Oo=;
        b=A98Sd4pC9tTItQsoIhH56bG4vS9LtrPzeUV4SKT9W0FKQfIPFRIt54ihfvH6o+WBw2
         TK4EnceCl/eoprdjv2vDMbPx3fL2nReXMZAt7yKxB6X4+XgZQyVXaXpteilYuf8y9wOC
         Y6kD/avQMHw/83XrdW/3XLPAktPeVPmPhjzH8RpS/DqDxEOERbo+hTmMSkveF+nifFoQ
         gedtRh5V7bYmf8TUsl/7dzIIEFw8DEBu4nMYrnRMcX2OBaYtEUPzQDmpVXQXnFZ/tAXS
         vrodO6jHpqXkqfR3pt7zxIaEb9BoCjEIPC9FLqi+j086JrmDkWX5KJbIZ4XqGwkHY9ZU
         jykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697776361; x=1698381161;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upHfO5i3vu48grgTZL4fJNuWkT6vWMEJam9EIpI+5Oo=;
        b=O6hSxmqLF2kk1MMLEmp94JQf8aqdnFwm+z5oogYK24gUiqu47gPVR+01HROHPzjJer
         dttRa3TrYAIRxboeA3LkkPxxi53TOK9+e19goBobUiRlqWfpJY0z6Tv6ZJyjx94Z4dED
         xHX1PR2Nx1VlWrYbQucStAxGi4M7GppvG2JMN02NQBwkk8Zf/jv+UcDodDrOVsLnATbl
         iSPJtOGv7hTjBw6Ibp7tKV7XOsJ9t/uoc/ySRUIgIyqkOyXmuTVmLql34Zf9jOVvTihY
         l1JbTz98OFR1BP/qzAjR8b9WMe/dOW0KR6q68E3v2AFr60y//9sXTS0lxhh4xa1bmvoe
         jigA==
X-Gm-Message-State: AOJu0YyVHC7OX//KDFGp09OFLHH7plNTeQhf353olc24fQ/s82ZdC361
	UxYFFoC2eFiSvrY5XrKzD+cSxSREiGV/fCIn48sUNwwxK0Soaw==
X-Google-Smtp-Source: AGHT+IGQ33Gzu8UQYXDqZVh4z/mtKb2bzYTflUmphYHiKEV7g5dEiLNtSwhefeB6/m92/Yvma+r7iwa4VEUDy0imVzU=
X-Received: by 2002:a17:90a:fb48:b0:27d:4259:b7ef with SMTP id
 iq8-20020a17090afb4800b0027d4259b7efmr951427pjb.23.1697776361078; Thu, 19 Oct
 2023 21:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
In-Reply-To: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Fri, 20 Oct 2023 05:31:11 +0100
Message-ID: <CAJHH8bHOYz6Y5=jwcH_F6gsUkvc+FM6bDWLPCRndZvkkfAQ7-Q@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 10:25=E2=80=AFAM Isoken Ibizugbe <isokenjune@gmail.=
com> wrote:
>
> Dear Git Community and Mentors,
>
> I hope you're doing well. I'm excited to share my application draft
> for the Outreachy program with the Git project. Your feedback is
> invaluable, and I'm eager to align the project with the community's
> needs. Please review the attached draft and share your insights.
>
> Thank you for your support.
Hello Christian, I would appreciate a review from you.
>
> Project Application
> ----
>
> About Me:
>
> My name is Isoken June Ibizugbe, my language is primarily English, and
> I am a resident of Nigeria. I am a student at an online coding school
> called African Leadership Xcelerator (ALX), participating in the
> software engineering program.
>
> What project am I applying for?
>
> Moving Existing Tests to a Unit Testing Framework
>
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
>
> My motivation for joining the Git community stemmed from my desire to
> immerse myself in the world of open-source software and, ultimately,
> to become a part of the Outreachy program. My time spent contributing
> to Git has been nothing short of transformative. It has been a
> remarkable learning experience that has introduced me to a new form of
> collaboration using a mailing list and contributing through patches
> rather than the typical Pull Request (PR). This collaborative
> atmosphere has been pivotal in my growth as a developer, and I am
> eager to continue this journey, making meaningful contributions to
> this remarkable open-source project.
>
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
>
> Project Goals:
>
> - Improve Testing Efficiency: Transitioning from end-to-end tests to
> unit tests will enable more efficient testing of error conditions.
> - Codebase Stability: Unit tests enhance code stability and facilitate
> easier debugging through isolation.
> - Simplify Testing: Writing unit tests in pure C simplifies test
> setup, data passing, and reduces testing runtime by eliminating
> separate processes for each test.
>
> Project Milestones:
>
> - Add useful tests of library-like code
> - Integrate with stdlib work
> - Run alongside regular make test target
>
> Project Timeline:
>
> 1. Oct 2 - Nov 20: Community Bonding
>
> - Understanding the structure of Git
> - Getting familiar with the code
>
> 2. Dec 4 - Jan 15: Add useful tests of library-like code
>
> - Identify and document the current state of the tests in the Git
> t/helper directory.
> - Confirm the licensing and compatibility requirements for the chosen
> unit testing framework.
> - Develop unit tests for these library-like components.
> - Execute the tests and ensure they cover various scenarios, including
> error conditions.
> - Run the tests and address any initial issues or bugs to ensure they
> work as intended.
> - Document the new tests and their coverage.
> - Seek feedback  and support from mentors and the Git community
>
> 3. Jan 15 - Feb 15: Integrate with Stdlib Work
>
> - Collaborate with the team working on standard library integration.
> - Ensure that the tests for library-like code align with stdlib work.
> - Verify that the tests effectively check the compatibility and
> interaction of the code with standard libraries.
> - Gather feedback and insights from the Git community on the
> integrated tests, addressing any concerns or suggestions.
>
> 4. Feb 15 - March 1: Run Alongside Regular 'make test' Target and finaliz=
e
>
> - Configure the testing framework to run alongside the regular 'make
> test' target.
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
>
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
>
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
