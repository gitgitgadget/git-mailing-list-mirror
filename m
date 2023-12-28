Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB315BB
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWFiKYqK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336788cb261so5152464f8f.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739326; x=1704344126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMbuU8sJ3/3YJEzSedILCQg/H9ITX8hr39jZnUJE6SU=;
        b=FWFiKYqKZKH1iweCB3b9TVWtYfxbRBvkb0KRJ99StsKQamcZ0aInJjdqJ35HbmRPMg
         FG1hrK6tOLrTyYTTy6evoSxIzMxwN+Czl1gfPcTkggL4ZAy3E7EhtMpVJKIP3Yb9HtmA
         VLU51wn7+59axFl2nGmZteLbijwlOLXfSoDpa4cwOx2qR91faccJNlEZ1X+Ja/xEnXfQ
         Mf4qhDv+g8BUyxEt9uKhd/5iOu6m1aAK31WAuzNie6rvqDrcuFLqKXMFm5LjA3EHiOnb
         7ZFXxCi8NHJKkSQWpBnPzIKLKJDzx5q1eAmuwxVdb5mPPcbBSJJ2mTye+vuZWD+0Q3kA
         cZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739326; x=1704344126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMbuU8sJ3/3YJEzSedILCQg/H9ITX8hr39jZnUJE6SU=;
        b=PpfwOPV2TbFFNDoHUND7yEU4IMVbiLcjqmrKYfK9PGgow0UnlMli3pLFVaS71ubOGR
         R461apEW/uKTXMBRuKySicWcPKSjYq+jQZSRiAUcD1f21quxz+9ENvTCZ/1mplFqDCxb
         fvq21vp9bicwHzihXddH9frnCK+YeL6PTYQ8hFgGbIM+dN4PFXsJ9TpETtYclJ82pLGj
         OQK6507VwuL1ubI+Llnm6gF+H++Fwjz8AXGYZ+Mtsha4hWH0S50EC6yzaM9mH3QsI/qT
         DDM4sinHIikaETzj/zX+tCeHToB582bhsJO/DTt+6jQMRRAHKU1KFKOhHcRK2pNfsrPB
         q5Wg==
X-Gm-Message-State: AOJu0YywieRRUbfkRHgbUDdxKzDYJnTO9vZRLvXltYc+wBNc5qXOuLoU
	YFR3UFqbz4KeLnOI2CeKPw4J/ImXWdY=
X-Google-Smtp-Source: AGHT+IGNX9oVvIFq11LJkr1tOy60Zh5yss9UZyI1fpe46P1yjb47CRaMKRe71mPNu61ZmNFpHkEFIw==
X-Received: by 2002:a5d:560f:0:b0:336:35f2:9d60 with SMTP id l15-20020a5d560f000000b0033635f29d60mr4983823wrv.39.1703739326126;
        Wed, 27 Dec 2023 20:55:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0033664ffaf5dsm16187168wro.37.2023.12.27.20.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:25 -0800 (PST)
Message-ID: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:15 +0000
Subject: [PATCH v3 0/9] Minor improvements to CodingGuidelines and SubmittingPatches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Dragan Simic <dsimic@manjaro.org>,
    Josh Soref <jsoref@gmail.com>

These are a bunch of things I've run into over my past couple of attempts to
contribute to Git.

 * Incremental punctuation/grammatical improvements
 * Update extra tags suggestions based on common usage
 * drop reference to an article that was discontinued over a decade ago
 * update GitHub references
 * harmonize non-ASCII while I'm here

Note that I'm trying to do things "in the neighborhood". It'll be slower
than me replacing things topically, but hopefully easier for others to
digest. My current estimate is a decade or two :).

Josh Soref (9):
  CodingGuidelines: move period inside parentheses
  CodingGuidelines: write punctuation marks
  SubmittingPatches: drop ref to "What's in git.git"
  SubmittingPatches: discourage new trailers
  SubmittingPatches: update extra tags list
  SubmittingPatches: provide tag naming advice
  SubmittingPatches: clarify GitHub visual
  SubmittingPatches: clarify GitHub artifact format
  SubmittingPatches: hyphenate non-ASCII

 Documentation/CodingGuidelines  |  4 ++--
 Documentation/SubmittingPatches | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)


base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1623%2Fjsoref%2Fdocumentation-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1623/jsoref/documentation-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1623

Range-diff vs v2:

  1:  b9a8eb6aa4e =  1:  b9a8eb6aa4e CodingGuidelines: move period inside parentheses
  2:  c0db8336e51 =  2:  c0db8336e51 CodingGuidelines: write punctuation marks
  3:  22d66c5b78a =  3:  22d66c5b78a SubmittingPatches: drop ref to "What's in git.git"
  4:  eac2211332f =  4:  eac2211332f SubmittingPatches: discourage new trailers
  5:  8848572fe2c =  5:  8848572fe2c SubmittingPatches: update extra tags list
  6:  8f16c7caa73 !  6:  f28c1011ba9 SubmittingPatches: improve extra tags advice
     @@ Metadata
      Author: Josh Soref <jsoref@gmail.com>
      
       ## Commit message ##
     -    SubmittingPatches: improve extra tags advice
     +    SubmittingPatches: provide tag naming advice
      
          Current statistics show a strong preference to only capitalize the first
          letter in a hyphenated tag, but that some guidance would be helpful:
     @@ Documentation/SubmittingPatches: While you can also create your own trailer if t
       encourage you to instead use one of the common trailers in this project
       highlighted above.
       
     -+Extra tags should only capitalize the very first letter, i.e. favor
     ++Only capitalize the very first letter of tags, i.e. favor
      +"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
      +
       [[git-tools]]
  7:  cdb5fd0957f <  -:  ----------- SubmittingPatches: clarify GitHub visual
  8:  77576327df8 !  7:  49cef6f7c20 SubmittingPatches: clarify GitHub artifact format
     @@ Metadata
      Author: Josh Soref <jsoref@gmail.com>
      
       ## Commit message ##
     -    SubmittingPatches: clarify GitHub artifact format
     +    SubmittingPatches: clarify GitHub visual
      
     -    GitHub wraps artifacts generated by workflows in a .zip file.
     +    GitHub has two general forms for its states, sometimes they're a simple
     +    colored object (e.g. green check or red x), and sometimes there's also a
     +    colored container (e.g. green box or red circle) which contains that
     +    object (e.g. check or x).
      
     -    Internally, workflows can package anything they like in them.
     -
     -    A recently generated failure artifact had the form:
     -
     -    windows-artifacts.zip
     -      Length      Date    Time    Name
     -    ---------  ---------- -----   ----
     -     76001695  12-19-2023 01:35   artifacts.tar.gz
     -     11005650  12-19-2023 01:35   tracked.tar.gz
     -    ---------                     -------
     -     87007345                     2 files
     +    That's a lot of words to try to describe things, but in general, the key
     +    for a failure is that it's recognized as an `x` and that it's associated
     +    with the color red -- the color of course is problematic for people who
     +    are red-green color-blind, but that's why they are paired with distinct
     +    shapes.
      
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/SubmittingPatches ##
     -@@ Documentation/SubmittingPatches: branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/ma
     - If a branch did not pass all test cases then it is marked with a red
     - +x+. In that case you can click on the failing job and navigate to
     - "ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
     +@@ Documentation/SubmittingPatches: After the initial setup, CI will run whenever you push new changes
     + to your fork of Git on GitHub.  You can monitor the test state of all your
     + branches here: `https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml`
     + 
     +-If a branch did not pass all test cases then it is marked with a red
     +-cross. In that case you can click on the failing job and navigate to
     +-"ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
      -can also download "Artifacts" which are tarred (or zipped) archives
     -+can also download "Artifacts" which are zip archives containing
     -+tarred (or zipped) archives
     - with test data relevant for debugging.
     +-with test data relevant for debugging.
     ++If a branch does not pass all test cases then it will be marked with a
     ++red +x+, instead of a green check. In that case, you can click on the
     ++failing job and navigate to "ci/run-build-and-tests.sh" and/or
     ++"ci/print-test-failures.sh". You can also download "Artifacts" which
     ++are tarred (or zipped) archives with test data relevant for debugging.
       
       Then fix the problem and push your fix to your GitHub fork. This will
     + trigger a new CI build to ensure all tests pass.
  -:  ----------- >  8:  deb1bf02f3a SubmittingPatches: clarify GitHub artifact format
  9:  a4878f58fe4 =  9:  b1b75cc6a3e SubmittingPatches: hyphenate non-ASCII

-- 
gitgitgadget
