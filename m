Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+uZ9tIU"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B0D59
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so11629465e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796921; x=1701401721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh8+iLdoEdbBA3RscNtSNWVJEVFbnjU3UXockyxuf3o=;
        b=Q+uZ9tIUQHzb2TG4b4JB5/O1/DLcanSRKTaTO3gzzQR8QBooOUZRL/eDLQRHL7olXH
         lCFQEXb86sHBCuxFlDdSRLJ2KjnhvY6E1i7LsiYjPneCYJD0JMK3Zue1yk4vuzBh3Apa
         9ZWRCZ54s1P3sH2jmrvSLsFRRwUrM7ptZ75xvV3vP95BjeYedCgKmMyjOGUU14QoxCaX
         vQB1uTwrWeMxW+XrDGuU5ziqfUbW9ChYO7r9z8zIE4AaHWnkO+qoEokGNUL61FxX7Rsn
         zlkF5ZQAOBP0lmFkaER8GpaIZRtfVrymRmIWrpaVQ/kxpxpVEl7LME3XqcgVUQPt+vMJ
         HVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796921; x=1701401721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh8+iLdoEdbBA3RscNtSNWVJEVFbnjU3UXockyxuf3o=;
        b=NgmDgV8EtVdY7SDh5Rew+M7KET+/XsvPi6tbXHbIvAruQ4wlns8orhxtfsda55ObTV
         Xc7qYCsL/tszWNFYZxyA8dfCPEpF6DLH40MzAU1lfvpoOmzg49ezzfe7FtAJUFW17p3J
         PQ0TFc+3dxzH8WedyQ7XmdKtiMWlScB9GgGoZ+Nx5mKyAIyuevmGxLC6pTGea7USiz4+
         OIsUTdjS/7CUnyO3N6oy9CoENJACL1T+hfHHBkkNsV4CV6ffWYhp4bHEkQlAaEOAbQT8
         xwnWSMg2Z+DnQe++i964BY19ZgdLRQbQY/PK4xhYF5c/b3dXkPBaE8d+PLxQJDs8EH8M
         9+yQ==
X-Gm-Message-State: AOJu0YxzjcxEV+9KmXHp/mUOLqQ2gXJcwM0SuMtzn0RuXbQ5PbTSB4Bv
	n5YuZ/sOkfzyhzfdTf6708XBEpDueIw=
X-Google-Smtp-Source: AGHT+IFFrzlnNCIyiszFQPs8M+SLTcC67B8I+dQ6fwZEWs2YIA5p2ONO/Rmf4MrD8uLt14My52Ng7w==
X-Received: by 2002:a05:600c:1c9d:b0:40b:3933:f994 with SMTP id k29-20020a05600c1c9d00b0040b3933f994mr1090424wms.25.1700796919942;
        Thu, 23 Nov 2023 19:35:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id df2-20020a5d5b82000000b003317796e0e3sm3087671wrb.65.2023.11.23.19.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:35:19 -0800 (PST)
Message-ID: <cd44658f4085d3c7a90dbe60c7fa10a1b0389f79.1700796916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
	<pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 03:35:13 +0000
Subject: [PATCH v3 2/4] doc: switch links to https
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
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

These sites offer https versions of their content.
Using the https versions provides some protection for users.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/MyFirstContribution.txt                  | 2 +-
 Documentation/git-cvsimport.txt                        | 2 +-
 Documentation/git-imap-send.txt                        | 2 +-
 Documentation/git-send-email.txt                       | 2 +-
 Documentation/gitcore-tutorial.txt                     | 2 +-
 Documentation/gitprotocol-http.txt                     | 4 ++--
 Documentation/gitweb.conf.txt                          | 2 +-
 Documentation/gitweb.txt                               | 2 +-
 Documentation/howto/keep-canonical-history-correct.txt | 2 +-
 Documentation/signoff-option.txt                       | 2 +-
 INSTALL                                                | 2 +-
 Makefile                                               | 4 ++--
 README.md                                              | 2 +-
 git-cvsimport.perl                                     | 2 +-
 git-gui/git-gui.sh                                     | 4 ++--
 git-gui/lib/encoding.tcl                               | 2 +-
 git-gui/po/README                                      | 2 +-
 git-instaweb.sh                                        | 4 ++--
 gitk-git/gitk                                          | 2 +-
 gitweb/gitweb.perl                                     | 4 ++--
 gitweb/static/js/lib/common-lib.js                     | 8 ++++----
 graph.h                                                | 4 ++--
 imap-send.c                                            | 2 +-
 json-writer.h                                          | 2 +-
 kwset.c                                                | 2 +-
 kwset.h                                                | 2 +-
 list.h                                                 | 2 +-
 perl/FromCPAN/Error.pm                                 | 2 +-
 perl/Git/SVN.pm                                        | 2 +-
 protocol.h                                             | 2 +-
 sh-i18n--envsubst.c                                    | 4 ++--
 t/README                                               | 4 ++--
 t/helper/test-regex.c                                  | 2 +-
 t/perf/perf-lib.sh                                     | 2 +-
 t/t9114-git-svn-dcommit-merge.sh                       | 2 +-
 t/t9801-git-p4-branch.sh                               | 2 +-
 t/test-lib-functions.sh                                | 2 +-
 t/test-lib-github-workflow-markup.sh                   | 2 +-
 t/test-lib-junit.sh                                    | 2 +-
 t/test-lib.sh                                          | 2 +-
 trace.c                                                | 2 +-
 utf8.c                                                 | 2 +-
 utf8.h                                                 | 6 +++---
 43 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 7cfed60c2e9..279f6a3e7ca 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -833,7 +833,7 @@ Johannes Schindelin to make life as a Git contributor easier for those used to
 the GitHub PR workflow. It allows contributors to open pull requests against its
 mirror of the Git project, and does some magic to turn the PR into a set of
 emails and send them out for you. It also runs the Git continuous integration
-suite for you. It's documented at http://gitgitgadget.github.io.
+suite for you. It's documented at https://gitgitgadget.github.io/.
 
 [[create-fork]]
 === Forking `git/git` on GitHub
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ac03d7686cb..90fdc2551a3 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -221,7 +221,7 @@ Problems related to tags:
 If you suspect that any of these issues may apply to the repository you
 want to import, consider using cvs2git:
 
-* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
+* cvs2git (part of cvs2svn), `https://subversion.apache.org/`
 
 GIT
 ---
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index f7b18515141..c8a89d7243b 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -135,7 +135,7 @@ flames ridiculing you if you don't check this.
 
 Thunderbird in particular is known to be problematic.  Thunderbird
 users may wish to visit this web page for more information:
-  http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
+  https://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
 
 SEE ALSO
 --------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465011bad50..30deb7fe2a4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -454,7 +454,7 @@ have been specified, in which case default to 'compose'.
 			998 characters unless a suitable transfer encoding
 			('auto', 'base64', or 'quoted-printable') is used;
 			this is due to SMTP limits as described by
-			http://www.ietf.org/rfc/rfc5322.txt.
+			https://www.ietf.org/rfc/rfc5322.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index c0b95256cc8..2122aeb9769 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1089,7 +1089,7 @@ the remote repository URL in the local repository's config file
 like this:
 
 ------------------------------------------------
-$ git config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
+$ git config remote.linus.url https://git.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
 and use the "linus" keyword with 'git pull' instead of the full URL.
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.txt
index 21b73b7a1f5..836b3490ccd 100644
--- a/Documentation/gitprotocol-http.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -529,8 +529,8 @@ TODO: Document this further.
 REFERENCES
 ----------
 
-http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
-http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
+https://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
+https://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
 
 SEE ALSO
 --------
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index b078fef6f5c..20df3f0e253 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -820,7 +820,7 @@ filesystem (i.e. "$projectroot/$project"), `%h` to the current hash
 (\'h' gitweb parameter) and `%b` to the current hash base
 (\'hb' gitweb parameter); `%%` expands to \'%'.
 +
-For example, at the time this page was written, the http://repo.or.cz[]
+For example, at the time this page was written, the https://repo.or.cz[]
 Git hosting site set it to the following to enable graphical log
 (using the third party tool *git-browser*):
 +
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 1030e9667ea..ddd4a0fc705 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -28,7 +28,7 @@ Gitweb provides a web interface to Git repositories.  Its features include:
   revisions one at a time, viewing the history of the repository.
 * Finding commits whose commit messages match a given search term.
 
-See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
+See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
 browsed using gitweb itself.
 
 
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
index 35d48ef714e..5f800fd85a3 100644
--- a/Documentation/howto/keep-canonical-history-correct.txt
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -213,4 +213,4 @@ The procedure will result in a history that looks like this:
 		 B0--B1---------B2
 ------------
 
-See also http://git-blame.blogspot.com/2013/09/fun-with-first-parent-history.html
+See also https://git-blame.blogspot.com/2013/09/fun-with-first-parent-history.html
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index 12aa2333e46..d98758f3cb7 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -9,7 +9,7 @@ endif::git-commit[]
 	the committer has the rights to submit the work under the
 	project's license or agrees to some contributor representation,
 	such as a Developer Certificate of Origin.
-	(See http://developercertificate.org for the one used by the
+	(See https://developercertificate.org for the one used by the
 	Linux kernel and Git projects.)  Consult the documentation or
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
diff --git a/INSTALL b/INSTALL
index 4b422888828..020eba62afb 100644
--- a/INSTALL
+++ b/INSTALL
@@ -124,7 +124,7 @@ Issues of note:
 	  interacting with svn repositories with "git svn").  If you can
 	  live without these, use NO_PERL.  Note that recent releases of
 	  Redhat/Fedora are reported to ship Perl binary package with some
-	  core modules stripped away (see http://lwn.net/Articles/477234/),
+	  core modules stripped away (see https://lwn.net/Articles/477234/),
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
 	  Net::SMTP, and Time::HiRes.
diff --git a/Makefile b/Makefile
index 03adcb5a480..1618ee27d28 100644
--- a/Makefile
+++ b/Makefile
@@ -186,7 +186,7 @@ include shared.mak
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
-# as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
+# as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
@@ -2723,7 +2723,7 @@ $(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
-# See <http://gcc.gnu.org/gcc-3.0/features.html>.
+# See <https://gcc.gnu.org/gcc-3.0/features.html>.
 dep_files_present := $(wildcard $(dep_files))
 ifneq ($(dep_files_present),)
 include $(dep_files_present)
diff --git a/README.md b/README.md
index 7ce4f05bae8..2c3de2f9c80 100644
--- a/README.md
+++ b/README.md
@@ -42,7 +42,7 @@ string translations (localization l10) should see [po/README.md][]
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org (not the Git list). The mailing
 list archives are available at <https://lore.kernel.org/git/>,
-<http://marc.info/?l=git> and other archival sites.
+<https://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
 the Git Security mailing list <git-security@googlegroups.com>.
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7bf3c12d678..da77a1bf157 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -329,7 +329,7 @@ sub conn {
 			# Use a HTTP Proxy. Only works for HTTP proxies that
 			# don't require user authentication
 			#
-			# See: http://www.ietf.org/rfc/rfc2817.txt
+			# See: https://www.ietf.org/rfc/rfc2817.txt
 
 			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort => $proxyport);
 			die "Socket to $proxyhost: $!\n" unless defined $s;
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 2cbeaa483bb..507fb2b6826 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -24,7 +24,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
-along with this program; if not, see <http://www.gnu.org/licenses/>.}]
+along with this program; if not, see <https://www.gnu.org/licenses/>.}]
 
 ######################################################################
 ##
@@ -3052,7 +3052,7 @@ if {$doc_path ne {}} {
 if {[file isfile $doc_path]} {
 	set doc_url "file:$doc_path"
 } else {
-	set doc_url {http://www.kernel.org/pub/software/scm/git/docs/}
+	set doc_url {https://www.kernel.org/pub/software/scm/git/docs/}
 }
 
 proc start_browser {url} {
diff --git a/git-gui/lib/encoding.tcl b/git-gui/lib/encoding.tcl
index 32668fc9c6d..d2e0fa60c3b 100644
--- a/git-gui/lib/encoding.tcl
+++ b/git-gui/lib/encoding.tcl
@@ -3,7 +3,7 @@
 # (Copied from gitk, commit fd8ccbec4f0161)
 
 # This list of encoding names and aliases is distilled from
-# http://www.iana.org/assignments/character-sets.
+# https://www.iana.org/assignments/character-sets.
 # Not all of them are supported by Tcl.
 set encoding_aliases {
     { ANSI_X3.4-1968 iso-ir-6 ANSI_X3.4-1986 ISO_646.irv:1991 ASCII
diff --git a/git-gui/po/README b/git-gui/po/README
index 2514bc22abf..116233100d7 100644
--- a/git-gui/po/README
+++ b/git-gui/po/README
@@ -39,7 +39,7 @@ in your language?
 If you do not know what your language should be named, you need to find
 it.  This currently follows ISO 639-1 two letter codes:
 
-	http://www.loc.gov/standards/iso639-2/php/code_list.php
+	https://www.loc.gov/standards/iso639-2/php/code_list.php
 
 For example, if you are preparing a translation for Afrikaans, the
 language code is "af".  If there already is a translation for your
diff --git a/git-instaweb.sh b/git-instaweb.sh
index c68f49454cd..994431c8872 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -432,7 +432,7 @@ mongoose_conf() {
 # Mongoose web server configuration file.
 # Lines starting with '#' and empty lines are ignored.
 # For detailed description of every option, visit
-# http://code.google.com/p/mongoose/wiki/MongooseManual
+# https://code.google.com/p/mongoose/wiki/MongooseManual
 
 root		$root
 ports		$port
@@ -458,7 +458,7 @@ plackup_conf () {
 #!$PERL
 
 # gitweb - simple web interface to track changes in git repositories
-#          PSGI wrapper and server starter (see http://plackperl.org)
+#          PSGI wrapper and server starter (see https://plackperl.org)
 
 use strict;
 
diff --git a/gitk-git/gitk b/gitk-git/gitk
index dd80ab8f3ba..7a087f123d7 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11956,7 +11956,7 @@ proc formatdate {d} {
 }
 
 # This list of encoding names and aliases is distilled from
-# http://www.iana.org/assignments/character-sets.
+# https://www.iana.org/assignments/character-sets.
 # Not all of them are supported by Tcl.
 set encoding_aliases {
     { ANSI_X3.4-1968 iso-ir-6 ANSI_X3.4-1986 ISO_646.irv:1991 ASCII
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9bad..d23468690ed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -122,9 +122,9 @@ our $favicon = "++GITWEB_FAVICON++";
 our $javascript = "++GITWEB_JS++";
 
 # URI and label (title) of GIT logo link
-#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_url = "https://www.kernel.org/pub/software/scm/git/docs/";
 #our $logo_label = "git documentation";
-our $logo_url = "http://git-scm.com/";
+our $logo_url = "https://git-scm.com/";
 our $logo_label = "git homepage";
 
 # source of projects list
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 0fdbc25728d..99e3eb8c3d9 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -123,8 +123,8 @@ function addCssRule(selector, style) {
  * NOTE that there are limits and differences compared to native
  * getElementsByClassName as defined by e.g.:
  *   https://developer.mozilla.org/en/DOM/document.getElementsByClassName
- *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-getelementsbyclassname
- *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-document-getelementsbyclassname
+ *   https://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-getelementsbyclassname
+ *   https://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-document-getelementsbyclassname
  *
  * Namely, this implementation supports only single class name as
  * argument and not set of space-separated tokens representing classes,
@@ -133,9 +133,9 @@ function addCssRule(selector, style) {
  * (via getElementsByTagName).
  *
  * Based on
- *   http://code.google.com/p/getelementsbyclassname/
+ *   https://code.google.com/p/getelementsbyclassname/
  *   http://www.dustindiaz.com/getelementsbyclass/
- *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
+ *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
  *
  * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
  *
diff --git a/graph.h b/graph.h
index e88632a0140..3fd1dcb2e94 100644
--- a/graph.h
+++ b/graph.h
@@ -130,7 +130,7 @@ void graph_setup_line_prefix(struct diff_options *diffopt);
  * This functions must be called BEFORE graph_init() is called.
  *
  * NOTE: This function isn't used in Git outside graph.c but it is used
- * by CGit (http://git.zx2c4.com/cgit/) to use HTML for colors.
+ * by CGit (https://git.zx2c4.com/cgit/) to use HTML for colors.
  */
 void graph_set_column_colors(const char **colors, unsigned short colors_max);
 
@@ -196,7 +196,7 @@ int graph_is_commit_finished(struct git_graph const *graph);
  * graph_update() is called.
  *
  * NOTE: This function isn't used in Git outside graph.c but it is used
- * by CGit (http://git.zx2c4.com/cgit/) to wrap HTML around graph lines.
+ * by CGit (https://git.zx2c4.com/cgit/) to wrap HTML around graph lines.
  */
 int graph_next_line(struct git_graph *graph, struct strbuf *sb);
 
diff --git a/imap-send.c b/imap-send.c
index 3d6fdf64868..448ca64c052 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -18,7 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 #include "git-compat-util.h"
diff --git a/json-writer.h b/json-writer.h
index 75f4f99ab00..04413bd1afd 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -3,7 +3,7 @@
 
 /*
  * JSON data structures are defined at:
- * [1] http://www.ietf.org/rfc/rfc7159.txt
+ * [1] https://www.ietf.org/rfc/rfc7159.txt
  * [2] https://www.json.org/
  *
  * The JSON-writer API allows one to build JSON data structures using a
diff --git a/kwset.c b/kwset.c
index bbfcf815a56..695e47b7ccf 100644
--- a/kwset.c
+++ b/kwset.c
@@ -18,7 +18,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>. */
+   along with this program; if not, see <https://www.gnu.org/licenses/>. */
 
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/kwset.h b/kwset.h
index d42a793a301..c722664e5a7 100644
--- a/kwset.h
+++ b/kwset.h
@@ -20,7 +20,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>. */
+   along with this program; if not, see <https://www.gnu.org/licenses/>. */
 
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/list.h b/list.h
index 362a4cd7f5f..98428010f4d 100644
--- a/list.h
+++ b/list.h
@@ -19,7 +19,7 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see
- * <http://www.gnu.org/licenses/>.
+ * <https://www.gnu.org/licenses/>.
  */
 
 #ifndef LIST_H
diff --git a/perl/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
index d82b71325c6..5b97e0315d6 100644
--- a/perl/FromCPAN/Error.pm
+++ b/perl/FromCPAN/Error.pm
@@ -1025,7 +1025,7 @@ C<:warndie> handlers added by Paul Evans <leonerd@leonerd.org.uk>
 
 =head1 MAINTAINER
 
-Shlomi Fish, L<http://www.shlomifish.org/> .
+Shlomi Fish, L<https://www.shlomifish.org/> .
 
 =head1 PAST MAINTAINERS
 
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 6ce2e283c8d..7721708ce5d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1752,7 +1752,7 @@ sub tie_for_persistent_memoization {
 END {
 	# Force cache writeout explicitly instead of waiting for
 	# global destruction to avoid segfault in Storable:
-	# http://rt.cpan.org/Public/Bug/Display.html?id=36087
+	# https://rt.cpan.org/Public/Bug/Display.html?id=36087
 	unmemoize_svn_mergeinfo_functions();
 }
 
diff --git a/protocol.h b/protocol.h
index de66bf80f84..1e574bbd80b 100644
--- a/protocol.h
+++ b/protocol.h
@@ -18,7 +18,7 @@
  * with Linus Torvalds <torvalds@osdl.org> as the point of
  * contact. September 2005.
  *
- * See http://www.iana.org/assignments/port-numbers
+ * See https://www.iana.org/assignments/port-numbers
  */
 #define DEFAULT_GIT_PORT 9418
 
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 133496bd4d9..f69fd166105 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -31,7 +31,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   along with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 /* closeout.c - close standard output and standard error
    Copyright (C) 1998-2007 Free Software Foundation, Inc.
@@ -47,7 +47,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   along with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 #include <errno.h>
 #include <stdio.h>
diff --git a/t/README b/t/README
index a0ebe294848..36463d07425 100644
--- a/t/README
+++ b/t/README
@@ -32,7 +32,7 @@ the tests.
     ok 2 - plain with GIT_WORK_TREE
     ok 3 - plain bare
 
-Since the tests all output TAP (see http://testanything.org) they can
+Since the tests all output TAP (see https://testanything.org) they can
 be run with any TAP harness. Here's an example of parallel testing
 powered by a recent version of prove(1):
 
@@ -1278,7 +1278,7 @@ Devel::Cover module. To install it do:
    sudo aptitude install libdevel-cover-perl
 
    # From the CPAN with cpanminus
-   curl -L http://cpanmin.us | perl - --sudo --self-upgrade
+   curl -L https://cpanmin.us/ | perl - --sudo --self-upgrade
    cpanm --sudo Devel::Cover
 
 Then, at the top-level:
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index bd871a735b4..80042eafc20 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -30,7 +30,7 @@ static int test_regex_bug(void)
 	if (regexec(&r, str, 1, m, 0))
 		die("no match of pattern '%s' to string '%s'", pat, str);
 
-	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
+	/* https://sourceware.org/bugzilla/show_bug.cgi?id=3957 */
 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=1");
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e7786775a90..def22e70aed 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -15,7 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # These variables must be set before the inclusion of test-lib.sh below,
 # because it will change our working directory.
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 32317d6bca5..e06538b1c85 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -27,7 +27,7 @@ cat << EOF
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 EOF
 }
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 73cca0d143d..c598011635a 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -466,7 +466,7 @@ test_expect_success 'git p4 clone complex branches with excluded files' '
 	)
 '
 
-# From a report in http://stackoverflow.com/questions/11893688
+# From a report in https://stackoverflow.com/questions/11893688
 # where --use-client-spec caused branch prefixes not to be removed;
 # every file in git appeared into a subdirectory of the branch name.
 test_expect_success 'use-client-spec detect-branches setup' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b268..03292602fb0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 9c5339c577a..970c6538cba 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 #
 # The idea is for `test-lib.sh` to source this file when run in GitHub
 # workflows; these functions will then override (empty) functions
diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 79c31c788b9..76cbbd3299d 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -15,7 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 #
 # The idea is for `test-lib.sh` to source this file when the user asks
 # for JUnit XML; these functions will then override (empty) functions
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1656c9eed00..876b99562a3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -13,7 +13,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
diff --git a/trace.c b/trace.c
index 971a68abe84..8669ddfca25 100644
--- a/trace.c
+++ b/trace.c
@@ -18,7 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 #include "git-compat-util.h"
diff --git a/utf8.c b/utf8.c
index 6a0dd25b0fe..6bfaefa28eb 100644
--- a/utf8.c
+++ b/utf8.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 
-/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
+/* This code is originally from https://www.cl.cam.ac.uk/~mgk25/ucs/ */
 
 static const char utf16_be_bom[] = {'\xFE', '\xFF'};
 static const char utf16_le_bom[] = {'\xFF', '\xFE'};
diff --git a/utf8.h b/utf8.h
index b68efef6f43..35df76086a6 100644
--- a/utf8.h
+++ b/utf8.h
@@ -83,7 +83,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
  * The function returns true if this rule is violated.
  *
- * [1] http://unicode.org/faq/utf_bom.html#bom10
+ * [1] https://unicode.org/faq/utf_bom.html#bom10
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
@@ -99,8 +99,8 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
  * Therefore, strictly requiring a BOM seems to be the safest option for
  * content in Git.
  *
- * [1] http://unicode.org/faq/utf_bom.html#gen6
- * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ * [1] https://unicode.org/faq/utf_bom.html#gen6
+ * [2] https://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
  *     Section 3.10, D98, page 132
  * [3] https://encoding.spec.whatwg.org/#utf-16le
  */
-- 
gitgitgadget

