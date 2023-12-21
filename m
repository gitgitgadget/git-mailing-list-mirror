Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E336084
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwH8O35h"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so10075145e9.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176867; x=1703781667; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KJjJrQqnipA1iN2ZwbEdJjM3Y/XXHdpYv680rDOpac=;
        b=QwH8O35hPea0AcmsoNIEG04G4FSu07US0ewsGNlFmSXvxOrEtPb/g+ftyiZ5kDwlEW
         ee7pRNPFujLKsdd2zzMKP6aUA7XNrsIes4pn4AGr1c87MDyppqfDexoFmE/Ix4RqxSZu
         s8B0+66H1YFL2zaZfSe+IiT+ZcegJDRRCae8FOuoxAJqGMyOt4MNBeXpkMV4xdCdcRaV
         kfnmCUeThpbAbiP+YYlyLm6MOEnmooVEGlx+dscidHen9Jh3e7dHBJI8EYWEtcCE60bJ
         GTKqEu6OCxpE4JWjkmplsr65SQGUE3OP6qUsQwbvHIK84fXj4akldT8CgxeJHXht68sy
         iWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176867; x=1703781667;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KJjJrQqnipA1iN2ZwbEdJjM3Y/XXHdpYv680rDOpac=;
        b=uCBETkj8riu4aTNnh9uzMtYHamFHawSkU+rPN9EUi1rehe28R2UWZa9pCXWTKM+Bmt
         Fr+3O45fEjxLpOQ8uaDy0mgtgGCJY3GkKdy/aUGHm7FzG9PLskuOx+F3oKPBPW5O1Thg
         9ZHtpT0DEE7WRffukAYE3HURgRiQxlVO01R+qoeGRIemr9V5jOhOGISrMDV3VuP/jf4s
         Xb0tbqiiOSuLtDF0CfkRRR1QGczJoR77yCkDK6FZz6WO3EprsrFVeebqQeRuFHpBJZGu
         jVt+6oSadIyHMXd7ZObDrvD9O+BQo0NUyTo4Tl+zeOVIDIRcYsyn5/EuaOkWoojVgNp+
         bcZQ==
X-Gm-Message-State: AOJu0YyanNK6G2OsU8fnI9z7aMzLFiylWt0IhYgKtiZFL5oQ0ArWH9uD
	b9BI0irAA0bByuIrYZeWBEmaM/Lq25s=
X-Google-Smtp-Source: AGHT+IG+eVc/iIHbiuc+b0q3JVTMNzMfxBT1zAMbpheW8IOw44S1SUrhnqm4m6gnxIgK3zpQhHddYg==
X-Received: by 2002:a05:600c:4fc9:b0:40d:3130:1db5 with SMTP id o9-20020a05600c4fc900b0040d31301db5mr85wmq.47.1703176866972;
        Thu, 21 Dec 2023 08:41:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cx1-20020a056000092100b00336598903e9sm2386205wrb.58.2023.12.21.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:06 -0800 (PST)
Message-ID: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:40:56 +0000
Subject: [PATCH v2 0/9] Minor improvements to CodingGuidelines and SubmittingPatches
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
  SubmittingPatches: improve extra tags advice
  SubmittingPatches: clarify GitHub visual
  SubmittingPatches: clarify GitHub artifact format
  SubmittingPatches: hyphenate non-ASCII

 Documentation/CodingGuidelines  |  4 ++--
 Documentation/SubmittingPatches | 27 ++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)


base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1623%2Fjsoref%2Fdocumentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1623/jsoref/documentation-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1623

Range-diff vs v1:

  1:  b9a8eb6aa4e =  1:  b9a8eb6aa4e CodingGuidelines: move period inside parentheses
  2:  c0db8336e51 =  2:  c0db8336e51 CodingGuidelines: write punctuation marks
  3:  22d66c5b78a =  3:  22d66c5b78a SubmittingPatches: drop ref to "What's in git.git"
  4:  e5c7f29af43 !  4:  eac2211332f SubmittingPatches: update extra tags list
     @@ Metadata
      Author: Josh Soref <jsoref@gmail.com>
      
       ## Commit message ##
     -    SubmittingPatches: update extra tags list
     +    SubmittingPatches: discourage new trailers
      
     -    Add items with at least 100 uses:
     -    - Co-authored-by
     -    - Helped-by
     -    - Mentored-by
     -    - Suggested-by
     -
     -    Updating the create suggestion to something less commonly used.
     -
     -    git log |
     -      perl -ne 'next unless /^\s+[A-Z][a-z]+-\S+:/;s/^\s+//;s/:.*/:/;print'|
     -      sort|uniq -c|sort -n|grep '[0-9][0-9] '
     -      11 Helped-By:
     -      13 Message-ID:
     -      14 Reported-By:
     -      22 Acked-By:
     -      27 Inspired-by:
     -      29 Requested-by:
     -      35 Original-patch-by:
     -      43 Contributions-by:
     -      47 Signed-Off-By:
     -      65 Based-on-patch-by:
     -      68 Thanks-to:
     -      88 Improved-by:
     -     145 Co-authored-by:
     -     171 Noticed-by:
     -     182 Tested-by:
     -     361 Suggested-by:
     -     469 Mentored-by:
     -    1196 Reported-by:
     -    1727 Helped-by:
     -    2177 Reviewed-by:
     -    2202 Acked-by:
     -    95313 Signed-off-by:
     +    There seems to be consensus amongst the core Git community on a working
     +    set of common trailers, and there are non-trivial costs to people
     +    inventing new trailers (research to discover what they mean/how they
     +    differ from existing trailers) such that inventing new ones is generally
     +    unwarranted and not something to be recommended to new contributors.
      
     +    Suggested-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/SubmittingPatches ##
      @@ Documentation/SubmittingPatches: If you like, you can put extra tags at the end:
     - 
     - . `Reported-by:` is used to credit someone who found the bug that
     -   the patch attempts to fix.
     -+. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
     -+  the item being fixed.
     - . `Acked-by:` says that the person who is more familiar with the area
     -   the patch attempts to modify liked the patch.
     - . `Reviewed-by:`, unlike the other tags, can only be offered by the
     -@@ Documentation/SubmittingPatches: If you like, you can put extra tags at the end:
     -   patch after a detailed analysis.
       . `Tested-by:` is used to indicate that the person applied the patch
         and found it to have the desired effect.
     -+. `Co-authored-by:` is used to indicate that multiple people
     -+  contributed to the work of a patch.
     -+. `Helped-by:` is used to credit someone with helping develop a
     -+  patch.
     -+. `Mentored-by:` is used to credit someone with helping develop a
     -+  patch.
     -+. `Suggested-by:` is used to credit someone with suggesting the idea
     -+  for a patch.
       
     - You can also create your own tag or use one that's in common usage
     +-You can also create your own tag or use one that's in common usage
      -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
     -+such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
     ++While you can also create your own trailer if the situation warrants it, we
     ++encourage you to instead use one of the common trailers in this project
     ++highlighted above.
       
       [[git-tools]]
       === Generate your patch using Git tools out of your commits.
  -:  ----------- >  5:  8848572fe2c SubmittingPatches: update extra tags list
  5:  11688e4360c !  6:  8f16c7caa73 SubmittingPatches: improve extra tags advice
     @@ Commit message
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/SubmittingPatches ##
     -@@ Documentation/SubmittingPatches: If you like, you can put extra tags at the end:
     - You can also create your own tag or use one that's in common usage
     - such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".
     +@@ Documentation/SubmittingPatches: While you can also create your own trailer if the situation warrants it, we
     + encourage you to instead use one of the common trailers in this project
     + highlighted above.
       
      +Extra tags should only capitalize the very first letter, i.e. favor
      +"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
  6:  043d2a24202 !  7:  cdb5fd0957f SubmittingPatches: clarify GitHub visual
     @@ Metadata
       ## Commit message ##
          SubmittingPatches: clarify GitHub visual
      
     -    Some people would expect a cross to be upright, and potentially have
     -    unequal lengths...
     +    GitHub has two general forms for its states, sometimes they're a simple
     +    colored object (e.g. green check or red x), and sometimes there's also a
     +    colored container (e.g. green box or red circle) with containing that
     +    object (e.g. check or x).
      
     -    GitHub uses a white x overlaying a solid red circle to indicate failure.
     +    That's a lot of words to try to describe things, but in general, the key
     +    for a failure is that it's recognized as an `x` and that it's associated
     +    with the color red -- the color of course is problematic for people who
     +    are red-green color-blind, but that's why they are paired with distinct
     +    shapes.
     +
     +    Using the term `cross` doesn't really help.
      
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
  7:  cdab65a4259 !  8:  77576327df8 SubmittingPatches: clarify GitHub artifact format
     @@ Commit message
      
          GitHub wraps artifacts generated by workflows in a .zip file.
      
     -    Internally workflows can package anything they like in them.
     +    Internally, workflows can package anything they like in them.
      
          A recently generated failure artifact had the form:
      
  8:  92469324813 =  9:  a4878f58fe4 SubmittingPatches: hyphenate non-ASCII

-- 
gitgitgadget
