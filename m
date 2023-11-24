Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpI3Yh/3"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF677D6E
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso10272845e9.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796919; x=1701401719; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwcSJgwectIwlz0e6e5BFahoA8WIeNzTcvw1XLQaTy4=;
        b=UpI3Yh/3wwN3hRLvgg8FEf9ePGFRz02BSv6IM8JDh3nXSSLS1i9yYz0oyxRwkIZfQX
         LThTZwAPCGSXKZn6JHIIaSCTn63iG/ApO33cq4IRlumGvao0YnyE2QikLCb8OirfXjiW
         a4dKM0niU+K2hvuFQLPg82njI/gVe18pFX+L4H1n3O0Xyyysli++ov2JxXRU8cH90obI
         EQZjgiGOZHwERM5YRbOWEoESDTLkRqiqBiMkuyHqZkXN4UXt2ozJ6BCXZxesGvgxXmuG
         J1Ks4v41L3z/SQ9khalJal4c8OyD9xloFq9qh5Xg8oiPyfdca6l04W0aOZMZjAFIFZTF
         dmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796919; x=1701401719;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwcSJgwectIwlz0e6e5BFahoA8WIeNzTcvw1XLQaTy4=;
        b=gO4c/zIMfKZJINYX4IT6HIqIhofnpbgrZqIJbrOlpgsjYHEX1KgZghyg6OmfCEwcaO
         NY4O3Jx5yuJzdG03u22ZlY95oP8+cxYph6BZNooZ4fGf5F1UH7aZY2sxNKZ+T885ooy3
         OJlQmj8jgilzhI+TAtk3ZI0HQQtMOUGyp2y2joySnifWGOjEsXT38AqkxG8YAdtK+jHq
         iV5E7i3BWgbgJssmLRMezBi+YZJ3905rNPpYjpUrzDIPVAWkKuAx5OonD53mzEgZK9tP
         2LAhye3P6pRlxFaFMoTvaBJxmaAIRdpc56QcohkWbT/OYWpYp0qOy/ZmKXldyN8W9nyL
         eLjw==
X-Gm-Message-State: AOJu0Yy2Telx1fLfNVHob+CvjBuk2yFTgvdCyv61rv2Ue+a2q2TYL0Ab
	F+HfzeZGGXwJF+xeZP74WcocVcXPqFQ=
X-Google-Smtp-Source: AGHT+IEyp7kqm3/x0zNyeFWh8GR9qIh8Hj2XJgjEAXJExFe6kdp3RDj9TDX3ltH4gXYUBIRg06lEyw==
X-Received: by 2002:a5d:484b:0:b0:331:82c4:929f with SMTP id n11-20020a5d484b000000b0033182c4929fmr767492wrs.27.1700796918696;
        Thu, 23 Nov 2023 19:35:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b0033130644c87sm3150007wrp.54.2023.11.23.19.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:35:18 -0800 (PST)
Message-ID: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 03:35:11 +0000
Subject: [PATCH v3 0/4] Switch links to https
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Josh Soref <jsoref@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Josh Soref <jsoref@gmail.com>

There are a couple of categories of http links...

There are four categories worth changing:

 * pages that have jittered a bit but are now available as https:
 * pages which exist at both http: and https: and can be safely switched
 * pages that have jittered a bit and are not available over https:
 * pages that are gone and for which the best source is
   https://web.archive.org

And some categories that aren't being changed:

 * links that are required to be http: because they're copied from something
   that mandates it (the apache license, xml namespaces, xsl docbook
   things?)
 * urls that were imaginary (e.g. http://example.com/repo.git)
 * links in borrowed code where the http: form still works

In order:

 * doc: update links to current pages -- I found the current pages for
   these, it should be easy enough to verify these / reject them
 * doc: switch links to https -- the simplest
 * doc: update links for andre-simon.de -- I've split this out, I don't like
   the idea of having to download binaries over http. If this were my
   project, I'd be tempted to remove the feature or self-host w/ https...
 * doc: refer to internet archive -- the original urls are dead, I've found
   internet archive date links for them. (There are some in git already, so
   this seemed like a very reasonable choice.)

Changes from v1:

 * Commit messages have been adjusted since v1
 * files were dropped based on feedback from Junio

Changes from v2:

 * The first two commits have been swapped (favoring more complicated urls
   over simply switching to https)
 * The archive.org link for atomenabled.org has been dropped, we'll risk
   users getting hacked content from an arbitrary MITM instead of taking
   archived authenticated content based on the last time their web site was
   properly maintained.

Josh Soref (4):
  doc: update links to current pages
  doc: switch links to https
  doc: update links for andre-simon.de
  doc: refer to internet archive

 Documentation/CodingGuidelines                         |  2 +-
 Documentation/MyFirstContribution.txt                  |  2 +-
 Documentation/RelNotes/1.6.2.txt                       |  2 +-
 Documentation/RelNotes/1.6.3.txt                       |  2 +-
 Documentation/RelNotes/1.6.4.txt                       |  2 +-
 Documentation/RelNotes/1.6.5.txt                       |  2 +-
 Documentation/RelNotes/1.6.6.txt                       |  2 +-
 Documentation/git-cvsimport.txt                        |  4 ++--
 Documentation/git-format-patch.txt                     |  4 ++--
 Documentation/git-imap-send.txt                        |  2 +-
 Documentation/git-send-email.txt                       |  2 +-
 Documentation/git.txt                                  |  2 +-
 Documentation/gitcore-tutorial.txt                     |  2 +-
 Documentation/gitprotocol-http.txt                     |  4 ++--
 Documentation/gitweb.conf.txt                          |  4 ++--
 Documentation/gitweb.txt                               |  2 +-
 Documentation/howto/keep-canonical-history-correct.txt |  2 +-
 Documentation/signoff-option.txt                       |  2 +-
 INSTALL                                                |  2 +-
 Makefile                                               |  4 ++--
 README.md                                              |  2 +-
 git-cvsimport.perl                                     |  2 +-
 git-gui/git-gui.sh                                     |  6 +++---
 git-gui/lib/encoding.tcl                               |  2 +-
 git-gui/po/README                                      |  2 +-
 git-instaweb.sh                                        |  4 ++--
 gitk-git/gitk                                          |  4 ++--
 gitweb/INSTALL                                         |  2 +-
 gitweb/gitweb.perl                                     | 10 +++++-----
 gitweb/static/gitweb.css                               |  2 +-
 gitweb/static/js/lib/common-lib.js                     | 10 +++++-----
 graph.h                                                |  4 ++--
 http.c                                                 |  2 +-
 imap-send.c                                            |  4 ++--
 json-writer.h                                          |  4 ++--
 kwset.c                                                |  2 +-
 kwset.h                                                |  2 +-
 list.h                                                 |  2 +-
 perl/FromCPAN/Error.pm                                 |  2 +-
 perl/Git/SVN.pm                                        |  2 +-
 protocol.h                                             |  2 +-
 sh-i18n--envsubst.c                                    |  4 ++--
 sha1dc/sha1.c                                          |  2 +-
 t/README                                               |  4 ++--
 t/helper/test-regex.c                                  |  2 +-
 t/lib-gpg.sh                                           |  2 +-
 t/perf/perf-lib.sh                                     |  2 +-
 t/t9114-git-svn-dcommit-merge.sh                       |  2 +-
 t/t9801-git-p4-branch.sh                               |  2 +-
 t/t9816-git-p4-locked.sh                               |  2 +-
 t/test-lib-functions.sh                                |  2 +-
 t/test-lib-github-workflow-markup.sh                   |  2 +-
 t/test-lib-junit.sh                                    |  2 +-
 t/test-lib.sh                                          |  2 +-
 trace.c                                                |  2 +-
 utf8.c                                                 |  2 +-
 utf8.h                                                 |  6 +++---
 57 files changed, 81 insertions(+), 81 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1589%2Fjsoref%2Fhttps-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1589/jsoref/https-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1589

Range-diff vs v2:

 2:  80eb5da8ed4 ! 1:  54d3861aedf doc: update links to current pages
     @@ Documentation/git-format-patch.txt: Approach #3 (external editor)
       
       The following Thunderbird extensions are needed:
      -AboutConfig from http://aboutconfig.mozdev.org/ and
     +-External Editor from http://globs.org/articles.php?lng=en&pg=8
      +AboutConfig from https://mjg.github.io/AboutConfig/ and
     - External Editor from https://globs.org/articles.php?lng=en&pg=8
     ++External Editor from https://globs.org/articles.php?lng=en&pg=8
       
       1. Prepare the patch as a text file using your method of choice.
     + 
      
       ## Documentation/git.txt ##
      @@ Documentation/git.txt: Authors
     @@ gitk-git/gitk: if {[tk windowingsystem] eq "aqua"} {
       ## gitweb/static/js/lib/common-lib.js ##
      @@ gitweb/static/js/lib/common-lib.js: function addCssRule(selector, style) {
        *   http://www.dustindiaz.com/getelementsbyclass/
     -  *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
     +  *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
        *
      - * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
      + * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
     @@ json-writer.h
      @@
       /*
        * JSON data structures are defined at:
     -  * [1] https://www.ietf.org/rfc/rfc7159.txt
     +  * [1] http://www.ietf.org/rfc/rfc7159.txt
      - * [2] http://json.org/
      + * [2] https://www.json.org/
        *
 1:  71ed1286d7f ! 2:  cd44658f408 doc: switch links to https
     @@ Metadata
       ## Commit message ##
          doc: switch links to https
      
     -    It's somewhat traditional to respect sites' self-identification.
     +    These sites offer https versions of their content.
     +    Using the https versions provides some protection for users.
      
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
     - ## Documentation/CodingGuidelines ##
     -@@ Documentation/CodingGuidelines: code.  For Git in general, a few rough rules are:
     - 
     -    "Once it _is_ in the tree, it's not really worth the patch noise to
     -    go and fix it up."
     --   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
     -+   Cf. https://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
     - 
     -  - Log messages to explain your changes are as important as the
     -    changes themselves.  Clearly written code and in-code comments
     -
       ## Documentation/MyFirstContribution.txt ##
      @@ Documentation/MyFirstContribution.txt: Johannes Schindelin to make life as a Git contributor easier for those used to
       the GitHub PR workflow. It allows contributors to open pull requests against its
     @@ Documentation/git-cvsimport.txt: Problems related to tags:
       GIT
       ---
      
     - ## Documentation/git-format-patch.txt ##
     -@@ Documentation/git-format-patch.txt: Approach #3 (external editor)
     - 
     - The following Thunderbird extensions are needed:
     - AboutConfig from http://aboutconfig.mozdev.org/ and
     --External Editor from http://globs.org/articles.php?lng=en&pg=8
     -+External Editor from https://globs.org/articles.php?lng=en&pg=8
     - 
     - 1. Prepare the patch as a text file using your method of choice.
     - 
     -
       ## Documentation/git-imap-send.txt ##
      @@ Documentation/git-imap-send.txt: flames ridiculing you if you don't check this.
       
     @@ Documentation/gitweb.conf.txt: filesystem (i.e. "$projectroot/$project"), `%h` t
       ## Documentation/gitweb.txt ##
      @@ Documentation/gitweb.txt: Gitweb provides a web interface to Git repositories.  Its features include:
         revisions one at a time, viewing the history of the repository.
     - * Finding commits which commit messages matches given search term.
     + * Finding commits whose commit messages match a given search term.
       
      -See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
      +See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
     @@ gitweb/static/js/lib/common-lib.js: function addCssRule(selector, style) {
      - *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
      + *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
        *
     -  * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
     +  * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
        *
      
       ## graph.h ##
     @@ json-writer.h
        * JSON data structures are defined at:
      - * [1] http://www.ietf.org/rfc/rfc7159.txt
      + * [1] https://www.ietf.org/rfc/rfc7159.txt
     -  * [2] http://json.org/
     +  * [2] https://www.json.org/
        *
        * The JSON-writer API allows one to build JSON data structures using a
      
 3:  7cfd7b244ea = 3:  649ce9a9bd4 doc: update links for andre-simon.de
 4:  9f0bba69492 ! 4:  6d614a00a97 doc: refer to internet archive
     @@ Commit message
      
       ## gitweb/gitweb.perl ##
      @@ gitweb/gitweb.perl: sub git_feed {
     - 	my $format = shift || 'atom';
       	my $have_blame = gitweb_check_feature('blame');
       
     --	# Atom: http://www.atomenabled.org/developers/syndication/
     + 	# Atom: http://www.atomenabled.org/developers/syndication/
      -	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
     -+	# Atom: https://web.archive.org/web/20230815171113/https://www.atomenabled.org/developers/syndication/
      +	# RSS:  https://web.archive.org/web/20030729001534/http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
       	if ($format ne 'rss' && $format ne 'atom') {
       		die_error(400, "Unknown web feed format");

-- 
gitgitgadget
