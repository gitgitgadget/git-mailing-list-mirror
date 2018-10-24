Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B1F1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYAya (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:54:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55738 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:54:29 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so6919528itd.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzytoIrYsJVNSmRwvFFZR8A/gdo3pRyxqrbCj8K9wAs=;
        b=smJaHH/oZqZHz94jr7nJWuZb8JM529bfTHaEQm+imUL3GWJSg+MXKuvrhiVVnZ+dWf
         MPV+nflHzdJi8KNY3xpuMbV1f386QdZ1Q2dMuHO6jRc3EJjbAe8c4JSUiqyEF6sxgwy8
         ITdGvHmHEE1h/nD/izcgid1gTmwZx662C/naPWkLOvUGsNsL4qUJa6tebIUHTgasIbyQ
         JLJqE5EKgntNZW1zmTGD/b2QBUPjf1SSv1kChLTkRn7H+eUWDeKlMnwaCXmLsFHrGdRE
         ZaF1EO/BIQtpHyb9sRJF4z0/nlOcl/XTvTdMzvK2Z9yKBB2aIv2/QXSIiShjqG3XAblC
         5NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzytoIrYsJVNSmRwvFFZR8A/gdo3pRyxqrbCj8K9wAs=;
        b=r+SHOtNDuRzZ/CjGQ73F6vn7xcnMyBMTVq/bO3Gt5wAvh8CPTOjH3S9ZOpk3E3TyY5
         R2zgaVmbm42jVHxeclGFnArjcT/iwoHwIGmVyV+gFzaxfQTyDnuS4QGOTMlw6rg01J1e
         et9mfYNhjUHsbcOYD08gepHgaa+UYV65G4Ifij8zlSPUPtskg9XmBo01RWAlBYuHvRJN
         lr7uohEw/ZEgUjdQXF7TNRqK0RpKbJhDrHYycD7RW9kpOnrqFRJ3qEVJnMp4ajHhOBJi
         vFhB/8ysv1anie2BbZYT7jZmpm/+OC6VdGALqbJJuzFjrAo8e/16Qe2NrjxnT/RdyJvp
         G57w==
X-Gm-Message-State: AGRZ1gJwJ1S8Y8yQaloR1DWhksw4PAoXhZH+rK0iGlDOmxjXP6XQTezH
        3abjieJFJFi4E4w3vEuYJg3uhMxE
X-Google-Smtp-Source: AJdET5fs8GptBvuVa+QPbpyxPQdvY3aNZaolpGp/kZsni0gGDN+lUQ0qLWYnXFWB1eZy1p7IX3UcJw==
X-Received: by 2002:a02:a914:: with SMTP id n20-v6mr2352744jam.90.1540398345480;
        Wed, 24 Oct 2018 09:25:45 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id j19-v6sm2823329itj.31.2018.10.24.09.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 09:25:45 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:25:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 3/3] doc: document diff/merge.guitool config keys
Message-ID: <a1009e0721c4f888855e2570d5b082330eb7d1d3.1540398076.git.liu.denton@gmail.com>
References: <b0a5d6926c130c0b143435a96ed956b3ed20dad7.1540360514.git.liu.denton@gmail.com>
 <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/diff-config.txt  | 8 ++++++++
 Documentation/merge-config.txt | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 85bca83c3..e64d983c3 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -177,6 +177,14 @@ diff.tool::
 	Any other value is treated as a custom diff tool and requires
 	that a corresponding difftool.<tool>.cmd variable is defined.
 
+diff.guitool::
+	Controls which diff tool is used by linkgit:git-difftool[1] when
+	the -g/--gui flag is specified. This variable overrides the value
+	configured in `merge.guitool`. The list below shows the valid
+	built-in values. Any other value is treated as a custom diff tool
+	and requires that a corresponding difftool.<guitool>.cmd variable
+	is defined.
+
 include::mergetools-diff.txt[]
 
 diff.indentHeuristic::
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 662c2713c..a7f4ea90c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -63,6 +63,12 @@ merge.tool::
 	Any other value is treated as a custom merge tool and requires
 	that a corresponding mergetool.<tool>.cmd variable is defined.
 
+merge.guitool::
+	Controls which merge tool is used by linkgit:git-mergetool[1] when the
+	-g/--gui flag is specified. The list below shows the valid built-in values.
+	Any other value is treated as a custom merge tool and requires that a
+	corresponding mergetool.<guitool>.cmd variable is defined.
+
 include::mergetools-merge.txt[]
 
 merge.verbosity::
-- 
2.19.1.544.ge0b0585a1.dirty

