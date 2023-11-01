Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C61111B0
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBOpBb5+"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27D123
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:31:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so396963276.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698881483; x=1699486283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9/h+NBXBa04KUtGdjIZAqgVL0j4QhBhr7vB0R0PCVU=;
        b=zBOpBb5+awgzaGH74fgwjAPb5+NjqNicbKGRkg4AGdgZ5yxwJfaCe7Cr2Doc82BtFO
         jkqXg+fcKClqUQSRMVnsEMct3zqekXpGdRhpwHx3xhfxidZzWNNw3USMFbOEOHN9bOA0
         z4iC+QJz9hhQAaHP21a8eTqkgl7J9DA+kbe2JodbOE/KJMI2iD5OSfqyt4TvNxQxt7AD
         MT7gWw8Qk9nt9T+vlgr3nEMGbQRf5FDhbhsqiOJtGdSET5NKWtSERWicxeBhcjK0OeCN
         YQjtR8nfRU14dm6h2MT9Z3hL0qNjz1pvN5UTRk3OWRnbQbPn+GqqJ326XH8pegLaqTRQ
         46/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881483; x=1699486283;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9/h+NBXBa04KUtGdjIZAqgVL0j4QhBhr7vB0R0PCVU=;
        b=XMdZJYS8b0tyyEzgHXF1XsC9dBmLRYIRlhRGmgQ9S+CyY8VvKEMToyyAVjQZeTtApY
         0guSm7/8OwtKHsKy2+xMCOK2H8Clqx1IJSykfzEUYpCbISVm4FEHhADkuhvTe72SOnGb
         pnz6yp1xCHcKZtC6EpToO5VPJr7USqxWU3rtKb0hXtSyjqxpAy9dhbnCmd1+EX1dVIG0
         srIgOhStSIigdD1ehqAm7z3rophQjy1Jl7BjZk/1hCsR7UN62aGkWko120MxTR/dRyoB
         tE69GtN9OukNVkHe01AMpc8Al0c0oW1AMHxBws/WH6vGm3qJm0W9ssos3XP2gyioSzkf
         LnmA==
X-Gm-Message-State: AOJu0YyhzB2SgMvh9SFb7Zjw8eDj/kmZYEZfk1vbfLhMTHU/d96p0oDJ
	pUj4DXzBvRXFTUxvI1ircv+nG3dCXQRwmU/xlJzHq9fhqYDZffTTIY43j+g8pkZLFj9PCccnPC5
	My6XUxTG/nDRm3QCIjWPYqCjyv5EO0rMjHMzWrMJEyk8L1IQXROoywJ3Tcx3OdSQ=
X-Google-Smtp-Source: AGHT+IGuxbgvXq/N/O8NVDYTVfWuER1vWmnOZ7AcBRyMnOc9gZi2Fj6zyLRj5pH/mzS6/dAw5/xsQ/g8kElxkQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:fc30:220:f2fb:969])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1788:b0:da0:c9a5:b529 with SMTP
 id ca8-20020a056902178800b00da0c9a5b529mr305238ybb.12.1698881483500; Wed, 01
 Nov 2023 16:31:23 -0700 (PDT)
Date: Wed,  1 Nov 2023 16:31:15 -0700
In-Reply-To: <cover.1698881249.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1698881249.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <f706ba9b682e7c4070d49086ad3af582bf269c79.1698881249.git.steadmon@google.com>
Subject: [PATCH v9 1/3] unit tests: Add a project plan document
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, rsbecker@nexbridge.com, 
	oswald.buddenhagen@gmx.de, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Describe what we hope to accomplish by
implementing unit tests, and explain some open questions and milestones.
Discuss desired features for test frameworks/harnesses, and provide a
comparison of several different frameworks. Finally, document our
rationale for implementing a custom framework.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 240 +++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 Documentation/technical/unit-tests.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b629176d7d..3f2383a12c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS +=3D technical/scalar
 TECH_DOCS +=3D technical/send-pack-pipeline
 TECH_DOCS +=3D technical/shallow
 TECH_DOCS +=3D technical/trivial-merge
+TECH_DOCS +=3D technical/unit-tests
 SP_ARTICLES +=3D $(TECH_DOCS)
 SP_ARTICLES +=3D technical/api-index
=20
diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technic=
al/unit-tests.txt
new file mode 100644
index 0000000000..206037ffb1
--- /dev/null
+++ b/Documentation/technical/unit-tests.txt
@@ -0,0 +1,240 @@
+=3D Unit Testing
+
+In our current testing environment, we spend a significant amount of effor=
t
+crafting end-to-end tests for error conditions that could easily be captur=
ed by
+unit tests (or we simply forgo some hard-to-setup and rare error condition=
s).
+Unit tests additionally provide stability to the codebase and can simplify
+debugging through isolation. Writing unit tests in pure C, rather than wit=
h our
+current shell/test-tool helper setup, simplifies test setup, simplifies pa=
ssing
+data around (no shell-isms required), and reduces testing runtime by not
+spawning a separate process for every test invocation.
+
+We believe that a large body of unit tests, living alongside the existing =
test
+suite, will improve code quality for the Git project.
+
+=3D=3D Definitions
+
+For the purposes of this document, we'll use *test framework* to refer to
+projects that support writing test cases and running tests within the cont=
ext
+of a single executable. *Test harness* will refer to projects that manage
+running multiple executables (each of which may contain multiple test case=
s) and
+aggregating their results.
+
+In reality, these terms are not strictly defined, and many of the projects
+discussed below contain features from both categories.
+
+For now, we will evaluate projects solely on their framework features. Sin=
ce we
+are relying on having TAP output (see below), we can assume that any frame=
work
+can be made to work with a harness that we can choose later.
+
+
+=3D=3D Summary
+
+We believe the best way forward is to implement a custom TAP framework for=
 the
+Git project. We use a version of the framework originally proposed in
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com=
/[1].
+
+See the <<framework-selection,Framework Selection>> section below for the
+rationale behind this decision.
+
+
+=3D=3D Choosing a test harness
+
+During upstream discussion, it was occasionally noted that `prove` provide=
s many
+convenient features, such as scheduling slower tests first, or re-running
+previously failed tests.
+
+While we already support the use of `prove` as a test harness for the shel=
l
+tests, it is not strictly required. The t/Makefile allows running shell te=
sts
+directly (though with interleaved output if parallelism is enabled). Git
+developers who wish to use `prove` as a more advanced harness can do so by
+setting DEFAULT_TEST_TARGET=3Dprove in their config.mak.
+
+We will follow a similar approach for unit tests: by default the test
+executables will be run directly from the t/Makefile, but `prove` can be
+configured with DEFAULT_UNIT_TEST_TARGET=3Dprove.
+
+
+[[framework-selection]]
+=3D=3D Framework selection
+
+There are a variety of features we can use to rank the candidate framework=
s, and
+those features have different priorities:
+
+* Critical features: we probably won't consider a framework without these
+** Can we legally / easily use the project?
+*** <<license,License>>
+*** <<vendorable-or-ubiquitous,Vendorable or ubiquitous>>
+*** <<maintainable-extensible,Maintainable / extensible>>
+*** <<major-platform-support,Major platform support>>
+** Does the project support our bare-minimum needs?
+*** <<tap-support,TAP support>>
+*** <<diagnostic-output,Diagnostic output>>
+*** <<runtime-skippable-tests,Runtime-skippable tests>>
+* Nice-to-have features:
+** <<parallel-execution,Parallel execution>>
+** <<mock-support,Mock support>>
+** <<signal-error-handling,Signal & error-handling>>
+* Tie-breaker stats
+** <<project-kloc,Project KLOC>>
+** <<adoption,Adoption>>
+
+[[license]]
+=3D=3D=3D License
+
+We must be able to legally use the framework in connection with Git. As Gi=
t is
+licensed only under GPLv2, we must eliminate any LGPLv3, GPLv3, or Apache =
2.0
+projects.
+
+[[vendorable-or-ubiquitous]]
+=3D=3D=3D Vendorable or ubiquitous
+
+We want to avoid forcing Git developers to install new tools just to run u=
nit
+tests. Any prospective frameworks and harnesses must either be vendorable
+(meaning, we can copy their source directly into Git's repository), or so
+ubiquitous that it is reasonable to expect that most developers will have =
the
+tools installed already.
+
+[[maintainable-extensible]]
+=3D=3D=3D Maintainable / extensible
+
+It is unlikely that any pre-existing project perfectly fits our needs, so =
any
+project we select will need to be actively maintained and open to acceptin=
g
+changes. Alternatively, assuming we are vendoring the source into our repo=
, it
+must be simple enough that Git developers can feel comfortable making chan=
ges as
+needed to our version.
+
+In the comparison table below, "True" means that the framework seems to ha=
ve
+active developers, that it is simple enough that Git developers can make c=
hanges
+to it, and that the project seems open to accepting external contributions=
 (or
+that it is vendorable). "Partial" means that at least one of the above
+conditions holds.
+
+[[major-platform-support]]
+=3D=3D=3D Major platform support
+
+At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
+
+In the comparison table below, "True" means that it works on all three maj=
or
+platforms with no issues. "Partial" means that there may be annoyances on =
one or
+more platforms, but it is still usable in principle.
+
+[[tap-support]]
+=3D=3D=3D TAP support
+
+The https://testanything.org/[Test Anything Protocol] is a text-based inte=
rface
+that allows tests to communicate with a test harness. It is already used b=
y
+Git's integration test suite. Supporting TAP output is a mandatory feature=
 for
+any prospective test framework.
+
+In the comparison table below, "True" means this is natively supported.
+"Partial" means TAP output must be generated by post-processing the native
+output.
+
+Frameworks that do not have at least Partial support will not be evaluated
+further.
+
+[[diagnostic-output]]
+=3D=3D=3D Diagnostic output
+
+When a test case fails, the framework must generate enough diagnostic outp=
ut to
+help developers find the appropriate test case in source code in order to =
debug
+the failure.
+
+[[runtime-skippable-tests]]
+=3D=3D=3D Runtime-skippable tests
+
+Test authors may wish to skip certain test cases based on runtime circumst=
ances,
+so the framework should support this.
+
+[[parallel-execution]]
+=3D=3D=3D Parallel execution
+
+Ideally, we will build up a significant collection of unit test cases, mos=
t
+likely split across multiple executables. It will be necessary to run thes=
e
+tests in parallel to enable fast develop-test-debug cycles.
+
+In the comparison table below, "True" means that individual test cases wit=
hin a
+single test executable can be run in parallel. We assume that executable-l=
evel
+parallelism can be handled by the test harness.
+
+[[mock-support]]
+=3D=3D=3D Mock support
+
+Unit test authors may wish to test code that interacts with objects that m=
ay be
+inconvenient to handle in a test (e.g. interacting with a network service)=
.
+Mocking allows test authors to provide a fake implementation of these obje=
cts
+for more convenient tests.
+
+[[signal-error-handling]]
+=3D=3D=3D Signal & error handling
+
+The test framework should fail gracefully when test cases are themselves b=
uggy
+or when they are interrupted by signals during runtime.
+
+[[project-kloc]]
+=3D=3D=3D Project KLOC
+
+The size of the project, in thousands of lines of code as measured by
+https://dwheeler.com/sloccount/[sloccount] (rounded up to the next multipl=
e of
+1,000). As a tie-breaker, we probably prefer a project with fewer LOC.
+
+[[adoption]]
+=3D=3D=3D Adoption
+
+As a tie-breaker, we prefer a more widely-used project. We use the number =
of
+GitHub / GitLab stars to estimate this.
+
+
+=3D=3D=3D Comparison
+
+:true: [lime-background]#True#
+:false: [red-background]#False#
+:partial: [yellow-background]#Partial#
+
+:gpl: [lime-background]#GPL v2#
+:isc: [lime-background]#ISC#
+:mit: [lime-background]#MIT#
+:expat: [lime-background]#Expat#
+:lgpl: [lime-background]#LGPL v2.1#
+
+:custom-impl: https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea602755=
7176@gmail.com/[Custom Git impl.]
+:greatest: https://github.com/silentbicycle/greatest[Greatest]
+:criterion: https://github.com/Snaipe/Criterion[Criterion]
+:c-tap: https://github.com/rra/c-tap-harness/[C TAP]
+:check: https://libcheck.github.io/check/[Check]
+
+[format=3D"csv",options=3D"header",width=3D"33%",subs=3D"specialcharacters=
,attributes,quotes,macros"]
+|=3D=3D=3D=3D=3D
+Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or =
ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<ma=
jor-platform-support,Major platform support>>","<<tap-support,TAP support>>=
","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Run=
time- skippable tests>>","<<parallel-execution,Parallel execution>>","<<moc=
k-support,Mock support>>","<<signal-error-handling,Signal & error handling>=
>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
+{custom-impl},{gpl},{true},{true},{true},{true},{true},{true},{false},{fal=
se},{false},1,0
+{greatest},{isc},{true},{partial},{true},{partial},{true},{true},{false},{=
false},{false},3,1400
+{criterion},{mit},{false},{partial},{true},{true},{true},{true},{true},{fa=
lse},{true},19,1800
+{c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{false},{=
false},{false},4,33
+{check},{lgpl},{false},{partial},{true},{true},{true},{false},{false},{fal=
se},{true},17,973
+|=3D=3D=3D=3D=3D
+
+=3D=3D=3D Additional framework candidates
+
+Several suggested frameworks have been eliminated from consideration:
+
+* Incompatible licenses:
+** https://github.com/zorgnax/libtap[libtap] (LGPL v3)
+** https://cmocka.org/[cmocka] (Apache 2.0)
+* Missing source: https://www.kindahl.net/mytap/doc/index.html[MyTap]
+* No TAP support:
+** https://nemequ.github.io/munit/[=C2=B5nit]
+** https://github.com/google/cmockery[cmockery]
+** https://github.com/lpabon/cmockery2[cmockery2]
+** https://github.com/ThrowTheSwitch/Unity[Unity]
+** https://github.com/siu/minunit[minunit]
+** https://cunit.sourceforge.net/[CUnit]
+
+
+=3D=3D Milestones
+
+* Add useful tests of library-like code
+* Integrate with
+  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@google.co=
m/[stdlib
+  work]
+* Run alongside regular `make test` target
--=20
2.42.0.869.gea05f2083d-goog

