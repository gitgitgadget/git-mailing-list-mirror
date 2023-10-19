Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC115AF5
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acb3T6aS"
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B3184
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 02:26:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so2124297a91.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697707597; x=1698312397; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pVycrx+qipHSlcITc6yQLtzzBVhNYRi/sTtIIvJgjPo=;
        b=Acb3T6aSpkUVy6zfwD3LD4yY9IGWEQTJJCFn+cGJYhJiHQwAJnnEK58o0O4vrJicqr
         kHLlPrwdJnoGJJRevmhSmoNnNBljfVKXhd7tguSsGBTWElQiJfwMmtiDcInbUdpXp6jA
         Q8FF3Z2BNi2aJr9Ex3m0G5qNHVB4vtz1r/tEW1HXvOaNfZbvRdvfAn2BTpjdVxB7Bh/T
         K0tJ0K7+pKdzt0lQobNhJk8QrUFn/q+ILIPbtJCfvNmSme3UQIBG05henzQFIXqV4w3P
         FrjYCGBm421lyTXl91/kdVkObzfkp3Di1WgIB2AzMlZiUaW5hay7nAGMsf0/GfwgqVsA
         mDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707597; x=1698312397;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVycrx+qipHSlcITc6yQLtzzBVhNYRi/sTtIIvJgjPo=;
        b=iz2xaJkjNuR9oHMuD1LhEO0Rs9q3/bSaoD0PkHaOQd0b7hF1idVZLOJw0SAj3QZUq3
         4T9ATqCU9qCbTxiiocyjrKodoW0o+BB69U4KFBwye9dpXA9fdfg7mI+I1/Fqx+/bb2n/
         We9BXkS/p7c/AJibH8kjTE3Uap0Tq2S+hoik+9lhJ6/7+La4wNVvL7gm9KHxA//mQgUi
         ilCVKdnPbglBwWEVMSXOgrrkH7p3ZU0EWtHO25n6CnNMz8EDbPUxAYApt9T6qM9M2eOY
         V6b7DOicPZp8PQGD1dlHcF7PArk7j+CyKPmem0arjLfYy5ZhX98L5n9uyzDpGNb5RvX0
         /wsw==
X-Gm-Message-State: AOJu0YykRATWBFLRZbIdRBTVVCnGSv/i9mKWBShPAtbYjMZrIfW9Xh3Y
	IFaydCm5hPDWjFnmiBUvQ253ihCmHha2fvguWAry403yqIy8kZZjWvg=
X-Google-Smtp-Source: AGHT+IEc54ycaHx6tKnKoMbBTAyZ3bNoADjpyDITf1QZvCinQHXWc8YMePKrfsebs5FOeWQuOPkQM2YnBzTdgQ2enjc=
X-Received: by 2002:a17:90a:4f46:b0:27d:3c14:afec with SMTP id
 w6-20020a17090a4f4600b0027d3c14afecmr1425760pjl.48.1697707596658; Thu, 19 Oct
 2023 02:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Thu, 19 Oct 2023 10:25:07 +0100
Message-ID: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
Subject: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Git Community and Mentors,

I hope you're doing well. I'm excited to share my application draft
for the Outreachy program with the Git project. Your feedback is
invaluable, and I'm eager to align the project with the community's
needs. Please review the attached draft and share your insights.

Thank you for your support.

Project Application
----

About Me:

My name is Isoken June Ibizugbe, my language is primarily English, and
I am a resident of Nigeria. I am a student at an online coding school
called African Leadership Xcelerator (ALX), participating in the
software engineering program.

What project am I applying for?

Moving Existing Tests to a Unit Testing Framework

Why am I interested in working with the Git chosen project?

Git has been a cornerstone for software development, enabling
developers worldwide to collaborate, innovate, and create exceptional
software. I would say without Git, my journey to pursuing my software
engineering career would be impossible, as I use it almost every day.
Yet, in this constantly evolving landscape, there is always room for
improvement, even in a well-established project. The Git project
currently relies on end-to-end tests, and this is where I see an
opportunity to make a profound impact. Being able to test libraries in
isolation via unit tests or mocks speeds up determining the root cause
of bugs. I am deeply passionate about contributing to this project and
firmly believe in the power of open-source software and the collective
intelligence of the community. A successful completion of this project
will significantly improve Git's testing capabilities and bring the
benefits of fewer errors, faster work and better testing for all
parts.

My motivation for joining the Git community stemmed from my desire to
immerse myself in the world of open-source software and, ultimately,
to become a part of the Outreachy program. My time spent contributing
to Git has been nothing short of transformative. It has been a
remarkable learning experience that has introduced me to a new form of
collaboration using a mailing list and contributing through patches
rather than the typical Pull Request (PR). This collaborative
atmosphere has been pivotal in my growth as a developer, and I am
eager to continue this journey, making meaningful contributions to
this remarkable open-source project.

Contributions to Git

I have actively participated in Git's mailing list discussions and
contributed to a micro-project;

- builtin/branch.c: Adjust error messages such as die(), error(), and
warning() messages used in branch, to conform to coding guidelines
(https://lore.kernel.org/git/20231019084052.567922-1-isokenjune@gmail.com/)
- Implemented changes to fix broken tests based on reviews from the
community (https://lore.kernel.org/git/20231019084052.567922-1-isokenjune@gmail.com/)
- In review.

Project Goals:

- Improve Testing Efficiency: Transitioning from end-to-end tests to
unit tests will enable more efficient testing of error conditions.
- Codebase Stability: Unit tests enhance code stability and facilitate
easier debugging through isolation.
- Simplify Testing: Writing unit tests in pure C simplifies test
setup, data passing, and reduces testing runtime by eliminating
separate processes for each test.

Project Milestones:

- Add useful tests of library-like code
- Integrate with stdlib work
- Run alongside regular make test target

Project Timeline:

1. Oct 2 - Nov 20: Community Bonding

- Understanding the structure of Git
- Getting familiar with the code

2. Dec 4 - Jan 15: Add useful tests of library-like code

- Identify and document the current state of the tests in the Git
t/helper directory.
- Confirm the licensing and compatibility requirements for the chosen
unit testing framework.
- Develop unit tests for these library-like components.
- Execute the tests and ensure they cover various scenarios, including
error conditions.
- Run the tests and address any initial issues or bugs to ensure they
work as intended.
- Document the new tests and their coverage.
- Seek feedback  and support from mentors and the Git community

3. Jan 15 - Feb 15: Integrate with Stdlib Work

- Collaborate with the team working on standard library integration.
- Ensure that the tests for library-like code align with stdlib work.
- Verify that the tests effectively check the compatibility and
interaction of the code with standard libraries.
- Gather feedback and insights from the Git community on the
integrated tests, addressing any concerns or suggestions.

4. Feb 15 - March 1: Run Alongside Regular 'make test' Target and finalize

- Configure the testing framework to run alongside the regular 'make
test' target.
- Ensure that the new tests are included in the standard testing suite.
- Execute 'make test' with the new tests and verify that they pass successfully.
- Document the integration process and how the new tests are included
in the standard testing procedure.
- Perform comprehensive testing of the entire unit testing framework.
- Ensure all migrated tests are working correctly within the new framework.
- Document the entire process of migrating Git's tests
- Prepare a final project report

Technical Requirements

According to the documentation on the unit test project
(https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/technical/unit-tests.adoc),
the suggested best framework for the Git project is the "Custom TAP
framework" (Phillip Wood's TAP implementation), as it aligns with
Git's licensing requirements, is vendorable, and can be customized by
Git's developers as needed, but it may require some additional
development work for features like parallel execution and mock
support, but it offers a strong foundation for unit testing within the
Git project.

Relevant Projects

Simple shell -  A project based on emulating a shell. It was a
collaborative project which we managed using Git.
(https://github.com/Junie06/simple_shell).
This project was written in C, which allowed me to apply my C language
knowledge, essential for Git projects.
I'm proficient in using Shell for scripting, redirections, and
permissions, as shown in my work
(https://github.com/Junie06/alx-system_engineering-devops).
Creating the simple shell project deepened my understanding of how
shells work, and I even attempted to replicate a shell environment.
Collaborating on the Simple Shell project reinforced my Git skills.
