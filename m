From: larsxschneider@gmail.com
Subject: [PATCH v2] Documentation: add setup instructions for Travis CI
Date: Mon,  2 May 2016 10:12:12 +0200
Message-ID: <1462176732-5163-1-git-send-email-larsxschneider@gmail.com>
References: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com>
Cc: gitster@pobox.com, sbeller@google.com,
	Matthieu.Moy@grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 10:12:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax8xq-0006K1-FR
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 10:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbcEBIMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 04:12:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35727 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEBIMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 04:12:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id e201so97342994wme.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/PnfdxyogD+4Ic8IMnvItjZvx/cipEgKCWdwKiNRBg=;
        b=JY4y7Xk6/WYC88ex8c2DLAQqmarkpW7gNPWVtz5sVxZhvh7lKvc7KV56DE4JoXISzd
         uk7gE+rqpLTdLSe2AGSwvYmMs7aurtT3UUL1Iaiq9+t8EM50OkuRSzuRAxZ0nBDzvwtc
         6++fP22y8j5YLR2fvtUVDaoQa2X1GjPaDCAbOev66msc36ZivEXeSr07nsa6IkZ2CjBI
         iL+0Cyb9xq1FITNsCcmjefnfksvmE1mH5enV40mbrDbCAqr2EkdUOKhOxduAKEa2lozV
         XWluAJS05vfLghe7kI0LT5he86wnWnrEdLZHsdmlcyIV0v/zWVUHW4jPe1XSFgUcihsN
         IMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/PnfdxyogD+4Ic8IMnvItjZvx/cipEgKCWdwKiNRBg=;
        b=i2aKyECKy8CIZgClKA1pC9Q31ygIykw90CMUeGUXYp8OzNgHjWDny8zUK9afYeUTE5
         ZR0yjWuFCLzI4eN2SpEhu7FgIlL2FcojRcPHIT+eKxni1DUqPsPGEyCzuTdHOt4NjDZj
         XbXA8qRK7c9voUtuGOVlKh97BPa14sLRWq/1PVnQdqhWSBMnDNk3vSmMnj+4eOpzoPao
         VKKYj3HduSfzg0Ljv9kxp27NtpQkyPsEv+6oU3kXVuqYlAp+dduhcumTLo0Ew8vohZqh
         HpK78G57/GSKBDhcK+cEl6OBb60rDb0Aew7QgE76CQA6dWdyepgK2ahaul7ZnefrIX3l
         KIhA==
X-Gm-Message-State: AOPr4FVhe69G5mJHMPIesj+c+kEE/EPv/3ZqxisOb6PkvTCsaRYaH+VtWOios3z8Ml0RaA==
X-Received: by 10.194.173.132 with SMTP id bk4mr11526244wjc.92.1462176734615;
        Mon, 02 May 2016 01:12:14 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB77EC.dip0.t-ipconnect.de. [93.219.119.236])
        by smtp.gmail.com with ESMTPSA id w3sm29016317wjt.0.2016.05.02.01.12.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 01:12:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293229>

From: Lars Schneider <larsxschneider@gmail.com>

Also change UK english "behaviour" to US english "behavior".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

diff to v1:

* remind the reader to check documentation set formatting
* do not call Travis CI as "our infrastructure"
* do not make it sound as we want to make everyone a GitHub customer
* move detailed Travis CI instructions to a separate section
  (I thought about a separate file but I think there is not enough
  content at this point to justify it)

Thanks Junio, Stefan, and Matthieu for the review,
Lars


 Documentation/SubmittingPatches | 80 ++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 98fc4cc..60e0e55 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -61,23 +61,28 @@ Make sure that you have tests for the bug you are fixing.  See
 t/README for guidance.

 When adding a new feature, make sure that you have new tests to show
-the feature triggers the new behaviour when it should, and to show the
-feature does not trigger when it shouldn't.  Also make sure that the
-test suite passes after your commit.  Do not forget to update the
-documentation to describe the updated behaviour.
-
-Speaking of the documentation, it is currently a liberal mixture of US
-and UK English norms for spelling and grammar, which is somewhat
-unfortunate.  A huge patch that touches the files all over the place
-only to correct the inconsistency is not welcome, though.  Potential
-clashes with other changes that can result from such a patch are not
-worth it.  We prefer to gradually reconcile the inconsistencies in
-favor of US English, with small and easily digestible patches, as a
-side effect of doing some other real work in the vicinity (e.g.
-rewriting a paragraph for clarity, while turning en_UK spelling to
-en_US).  Obvious typographical fixes are much more welcomed ("teh ->
-"the"), preferably submitted as independent patches separate from
-other documentation changes.
+the feature triggers the new behavior when it should, and to show the
+feature does not trigger when it shouldn't.  After any code change, make
+sure that the entire test suite passes.
+
+If you have an account at GitHub (and you can get one for free to work
+on open source projects), you can use their Travis CI integration to
+test your changes on Linux, Mac, and (hopefully soon) Windows.  See
+GitHub-Travis CI hints section for details.
+
+Do not forget to update the documentation to describe the updated
+behavior and make sure that the resulting documentation set formats
+well. It is currently a liberal mixture of US and UK English norms for
+spelling and grammar, which is somewhat unfortunate.  A huge patch that
+touches the files all over the place only to correct the inconsistency
+is not welcome, though.  Potential clashes with other changes that can
+result from such a patch are not worth it.  We prefer to gradually
+reconcile the inconsistencies in favor of US English, with small and
+easily digestible patches, as a side effect of doing some other real
+work in the vicinity (e.g. rewriting a paragraph for clarity, while
+turning en_UK spelling to en_US).  Obvious typographical fixes are much
+more welcomed ("teh -> "the"), preferably submitted as independent
+patches separate from other documentation changes.

 Oh, another thing.  We are picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
@@ -370,6 +375,47 @@ Know the status of your patch after submission
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.

+--------------------------------------------------
+GitHub-Travis CI hints
+
+With an account at GitHub (you can get one for free to work on open
+source projects), you can use Travis CI to test your changes on Linux,
+Mac, and (hopefully soon) Windows.  You can find a successful example
+test build here: https://travis-ci.org/git/git/builds/120473209
+
+Follow these steps for the initial setup:
+
+ (1) Fork https://github.com/git/git to your GitHub account.
+     You can find detailed instructions how to fork here:
+     https://help.github.com/articles/fork-a-repo/
+
+ (2) Open the Travis CI website: https://travis-ci.org
+
+ (3) Press the "Sign in with GitHub" button.
+
+ (4) Grant Travis CI permissions to access your GitHub account.
+     You can find more information about the required permissions here:
+     https://docs.travis-ci.com/user/github-oauth-scopes
+
+ (5) Open your Travis CI profile page: https://travis-ci.org/profile
+
+ (6) Enable Travis CI builds for your Git fork.
+
+After the initial setup, Travis CI will run whenever you push new changes
+to your fork of Git on GitHub.  You can monitor the test state of all your
+branches here: https://travis-ci.org/<Your GitHub handle>/git/branches
+
+If a branch did not pass all test cases then it is marked with a red
+cross.  In that case you can click on the failing Travis CI job and
+scroll all the way down in the log.  Find the line "<-- Click here to see
+detailed test output!" and click on the triangle next to the log line
+number to expand the detailed test output.  Here is such a failing
+example: https://travis-ci.org/git/git/jobs/122676187
+
+Fix the problem and push your fix to your Git fork.  This will trigger
+a new Travis CI build to ensure all tests pass.
+
+
 ------------------------------------------------
 MUA specific hints

--
2.5.1
