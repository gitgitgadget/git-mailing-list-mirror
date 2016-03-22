From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the
 origin of a config value
Date: Tue, 22 Mar 2016 15:44:00 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603221247470.4690@virtualbox>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com> <1455873362-66998-5-git-send-email-larsxschneider@gmail.com> <56D723F0.7020106@kdbg.org> <07435444-0C35-4615-A403-9E124AFC9427@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 15:44:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiNXw-0004FK-JH
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 15:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbcCVOoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 10:44:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:65483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbcCVOoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 10:44:30 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lb5nF-1a2TGs0abZ-00kfZY; Tue, 22 Mar 2016 15:44:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <07435444-0C35-4615-A403-9E124AFC9427@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:toJYwem7A1DhpIpDyGGoIKvwbhUBHPqaf7MgEfv034wq7Nuh2Ta
 NqL0LdysS0tt8A00AyoiOuflvePyJHq4xdcQRLMi0oSSXVveWN3hDBzy1sI6wFf+Lz11Dms
 XKMNxoOSVW5MIwRws5z6rko53ICMTIORDbw55rPZcSDBgLcDmv1MidmxifCmlOJpDWlRglC
 dRNino/8QX0KFawJTCKBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OYXIIT4kR6c=:n6upw3o9vBpCELg+8uiYAZ
 DUYuqvlB5w3F+PUMtBzkQNJEyZF3f9M3WbqbXJyMk+14O+cpmYimWnT3KTbIMt1IJLuEZkbSj
 B9IFQ435wgEePkATNWF3FECvxw7BIYCs0NSbGurFa0bE5UqXTDZn47N3T48hH+XDCbO6fo2gr
 we4vYuP0JDfaHTRYUbCCPn7v+glYHbcmu+8lEuJ4w1ZY7xot1O0dL/D71U6aUgLN6YtaGJXLU
 t+HO0QTen5K0p4dSYurBHCmZzeIM36aUU0V/A4nbbZDwSMJIrKjIj3cBsLo9jTDQQlUe1D6wo
 9CMmJ5/i3znCC1EwSm8OgkYDg7c95EfoJBgKVKluLxbPh4rp3kC18AT6u6STUYnJmPzfK7vAd
 OYiFClFxwnU4yQiXDoDiDPLTZiioRU3eA8azPHWeqAnN4G+ZOFIx0NoLV5bzoQTTN/qr+Dno0
 fLpge072e2r47k+16j6QQMVNSKdWt+qIeZYpBR/T2oX2vgPnrbDP/qrhPhrJwRTVjFZ5spQ0W
 J4sJXFMw9B6yfV9BY+qxIP3HMPri8OZhsXGZiSY0p5HQW+5pnYxvCX45ohCWzrU4maoSyxed6
 qgBFP8wNVbLfRxLOq0UEq9Dc+qVwOEqUMvOlt8jfb7qVLygwdN3m5h8UHHCg1HWFFCP8n3jV5
 UGzlcfjA5jq4UKtalIPvZLgdtXg8ClsU7FDm4CtCV0ehWyYHLtVUfbAWfcBmln9Um7HbZaQ2z
 3p3SwEv7UYG9yx58DEccsOlrDFae82FnjbXieA0ZwnuUAAH7IhfG4a8QcyrBKdtPfhERlmCL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289505>

Hi Lars,

On Thu, 3 Mar 2016, Lars Schneider wrote:

> > On 02 Mar 2016, at 18:33, Johannes Sixt <j6t@kdbg.org> wrote:
> > 
> > Am 19.02.2016 um 10:16 schrieb larsxschneider@gmail.com:
> >> +test_expect_success '--show-origin with --list' '
> >> +	cat >expect <<-EOF &&
> >> +		file:$HOME/.gitconfig	user.global=true
> >> +		file:$HOME/.gitconfig	user.override=global
> >> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> > 
> > On Windows, this injects POSIX-style paths in the expected output, but
> > git.exe produces mangled paths (with a drive letter). The pattern I
> > use to fix this is:
> > 
> > 		file:$(pwd)/.gitconfig	user.override=global
>
> OK, I try to fix it that way.

I am trying to make the upgrade of Git for Windows to 2.8.0 less painful
by rebasing already to -rc4 (and hopefully catching most, if not all,
problems early). In the course, I encountered this problem and see that it
is still there.

However, I also see that the `file:$(pwd)` trick does not work: for some
reason, my Git's output has quotes around the path, probably because the
path contains *back*slashes.

BTW this points to a larger problem with this test: it will fail if
anybody is cloning git.git into a directory whose path somehow requires
quoting.

So I worked around this with two ugly patches, one that makes sure that
the backslashes in the values of the environment variables HOME and
PROGRAMDATA are converted to forward slashes before being used by the
config machinery, and the other patch being this:

-- snip --
[PATCH] t1300: fix the new --show-origin tests on Windows

On Windows, we have that funny situation where the test script can refer
to POSIX paths because it runs in a shell that uses a POSIX emulation
layer ("MSYS2 runtime"). Yet, git.exe does *not* understand POSIX paths
at all but only pure Windows paths.

So let's just convert the POSIX paths to Windows paths before passing
them on to Git, using MSYS2's `cygpath` utility.

While fixing the new tests on Windows, we also have to exclude the tests
that want to write a file with a name that is illegal on Windows
(unfortunately, there is more than one test trying to make use of that
file).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-repo-config.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 73afbf7..93f9065 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1232,6 +1232,14 @@ test_expect_success 'set up --show-origin tests' '
 	EOF
 '
 
+if test_have_prereq MINGW
+then
+	HOME="$(cygpath -m "$HOME")"
+	INCLUDE_DIR="$(cygpath -m "$INCLUDE_DIR")"
+	export HOME INCLUDE_DIR
+	git config -f .gitconfig include.path
"$INCLUDE_DIR/absolute.include"
+fi
+
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfig	user.global=true
@@ -1304,7 +1312,7 @@ test_expect_success 'set up custom config file' '
 	EOF
 '
 
-test_expect_success '--show-origin escape special file name characters' '
+test_expect_success !MINGW '--show-origin escape special file name
characters' '
 	cat >expect <<-\EOF &&
 		file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
@@ -1333,7 +1341,7 @@ test_expect_success '--show-origin stdin with file
include' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob' '
+test_expect_success !MINGW '--show-origin blob' '
 	cat >expect <<-\EOF &&
 		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08
user.custom=true
 	EOF
@@ -1342,7 +1350,7 @@ test_expect_success '--show-origin blob' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob ref' '
+test_expect_success !MINGW '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
 		blob:"master:file\" (dq) and spaces.conf"
user.custom=true
 	EOF
-- 
2.7.4.windows.1
-- snap --

> Thanks for making me aware of the Windows problems. I can reproduce them
> with the Git for Windows SDK (super easy to setup, great work Dscho!)
> and I will try to fix them.

Good that you find it easy to set up the SDK. I poured quite the effort
into making it easy.

I fixed them here and will push the changes out shortly. I imagine that
Hannes will scream murder when he finds out that I used the `cygpath`
utility that his MSys environment lacks. Maybe I can prod him into fixing
my patch in a way that is compatible with that environment.

> I am fairly new to the Git for Windows SDK (+ an inexperienced Windows
> user) and therefore I wonder if you can help me with the following
> questions:
> 
> (1) If I have a Git core branch with a some changes that builds and
> tests clean on Linux and OSX. How do I apply all the necessary Git for
> Windows specific changes to this branch?

Happily, my patch series that introduce support for building Git in the
Git for Windows SDK (or for that matter, building MINGW Git with MSYS2)
made it into 2.8.0-rc0. So there is not really any need any longer to
apply any patches to make the test suite pass.

> (2) During my testing with Windows I noticed that the git config paths
> look funny by adding  ("\\" and "/"). I mentioned the problem in the Git
> for Windows forum:
> https://groups.google.com/forum/#!topic/git-for-windows/zTv60HhfnYk
> Duy suggested a solution in that thread. Is this the default way to deal
> with the paths? Would the list accept this solution?

The proposed solution looks very klunky to me. I went with a much less
intrusive version (the first patch I mentioned above):

-- snip --
[PATCH] config --show-origin: report paths with forward slashes

On Windows, the backslash is the native directory separator, but all
supported Windows versions also accept the forward slash in most
circumstances.

Our tests expect forward slashes.

Relative paths are generated by Git using forward slashes.

So let's try to be consistent and use forward slashes in the $HOME and
the $PROGRAMDATA part of the paths reported by `git config
--show-origin`, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 +++-
 compat/mingw.h | 6 ++++++
 path.c         | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d64f41c..74f7c99 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2808,8 +2808,10 @@ const char *program_data_config(void)
 			env = mingw_getenv("ALLUSERSPROFILE");
 			extra = "/Application Data";
 		}
-		if (env)
+		if (env) {
 			strbuf_addf(&path, "%s%s/Git/config", env, extra);
+			convert_slashes(path.buf);
+		}
 		initialized = 1;
 	}
 	return *path.buf ? path.buf : NULL;
diff --git a/compat/mingw.h b/compat/mingw.h
index 7e33b83..aa989e3 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -433,6 +433,12 @@ static inline char *mingw_find_last_dir_sep(const
char *path)
 			ret = (char *)path;
 	return ret;
 }
+static inline void convert_slashes(char *path)
+{
+	for (; *path; path++)
+		if (*path == '\\')
+			*path = '/';
+}
 #define find_last_dir_sep mingw_find_last_dir_sep
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
diff --git a/path.c b/path.c
index c4d8d21..a1ce940 100644
--- a/path.c
+++ b/path.c
@@ -589,6 +589,9 @@ char *expand_user_path(const char *path)
 			if (!home)
 				goto return_null;
 			strbuf_addstr(&user_path, home);
+#ifdef GIT_WINDOWS_NATIVE
+			convert_slashes(user_path.buf);
+#endif
 		} else {
 			struct passwd *pw = getpw_str(username,
username_len);
 			if (!pw)
-- 
2.7.4.windows.1
-- snap --

> (3) The tests on Windows seemed very slow to me. Are there tricks to
> speed them up? Did you try a RAM disk? If yes, how do you do it?

The tests *do* run very slowly on Windows. The reason is that the test
suite makes extensive use of POSIX tools, and they all have to run through
the POSIX emulation layer.

To make it utterly clear how much of a difference this makes: on my work
machine, the test suite requires about 45 minutes to run in up to 15
parallel processes on Windows. On the same machine, in a Linux VM, with
only up to 5 parallel processes, the same Git version's test suite passes
in less than 4 minutes.

So yes, running the test suite on Windows is unbearably slow.

What can you do to speed them up?

Hannes mentioned a couple of tricks.

Another trick is: avoid running the tests you do not even need. For
example, if you comment out all tests in t1300 from the second one until
the one before the one that sets up the show-origin tests, you can run the
relevant tests much, much faster.

Also, testing with GIT_TEST_INSTALLED is faster because it avoids one
(POSIX emulation layer incurring) redirection.

I still want to find time to make Git for Windows work with dash instead
of Bash (if I am not mistaken, dash has a much more native way to execute
programs, avoiding the POSIX emulation layer altogether).

And of course all of the work to convert the scripts into truly portable C
code also will help.

Ciao,
Dscho
