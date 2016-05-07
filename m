From: "=?UTF-8?B?5p2O5LiJMDE1OQ==?=" <lip@dtdream.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSB1dGY4OiBmaXggZHVwbGljYXRlIHdvcmRzIG9mICJ0aGUi?=
Date: Sat, 07 May 2016 23:10:26 +0800
Message-ID: <bac71936-2381-4249-9cfe-def87026a14f.lip@dtdream.com>
References: <1462537893-18493-1-git-send-email-lip@dtdream.com>	<20160506130922.GA5051@sigill.intra.peff.net>	<xmqqoa8j3xk7.fsf@gitster.mtv.corp.google.com>,xmqqa8k33upk.fsf@gitster.mtv.corp.google.com,cdd85576-68f4-479a-b034-051706f3d9c5.lip@dtdream.com
Reply-To: "=?UTF-8?B?5p2O5LiJMDE1OQ==?=" <lip@dtdream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>, "git" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 17:10:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az3sZ-0008DI-Uo
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 17:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcEGPKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 11:10:47 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:38247 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbcEGPKr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 May 2016 11:10:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=-0.02509455|-1;FP=12554045776630157266|3|3|4|0|-1|-1|-1;HT=e02c03294;MF=lip@dtdream.com;NM=1;PH=DW;RN=3;RT=3;SR=0;TI=W4_4616781_10.194.100.202_1462633733665_TP-Processor42036;
Received: from WS-web (lip@dtdream.com[124.64.125.69]) by e01l04446.eu6 at Sat, 07 May 2016 23:10:26 +0800
X-Mailer: Alimail-Mailagent revision 2716202
In-Reply-To: cdd85576-68f4-479a-b034-051706f3d9c5.lip@dtdream.com
x-aliyun-mail-creator: W4_4616781_o0NTW96aWxsYS81LjAgKFgxMTsgTGludXggeDg2XzY0OyBydjo0NS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzQ1LjA=yd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293900>

Good job.Cleaner now.
I found these typos by aspell, and duplicate words by grep -rnIE  '\b(\=
w+)\s+\1\b' :)
Thanks!



------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJunio C Hamano <gitster@pobox.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2016=E5=B9=B45=E6=9C=887=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E5=85=AD) 02:30
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=9D=8E=E4=B8=890159 <lip@dtdream=
=2Ecom>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AJeff King <peff@peff.net>; git <git=
@vger.kernel.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH] utf8: fix duplicate wor=
ds of "the"


Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>>
>> IMHO it would be fine to just do all of these in a single patch. The=
y're
>> different files, yes, but it's all conceptually the same change.
>
> I can squash them into a single one.  So far, everything except two
> I saw was good.

So I tentatively queued this.

-- >8 --
=46rom: Li Peng <lip@dtdream.com>
Date: Fri, 6 May 2016 20:36:46 +0800
Subject: [PATCH] typofix: assorted typofixes in comments, documentation=
 and
 messages

Many instances of duplicate words (e.g. "the the path") and
a few typoes are fixed, originally in multiple patches.

    wildmatch: fix duplicate words of "the"
    t: fix duplicate words of "output"
    transport-helper: fix duplicate words of "read"
    Git.pm: fix duplicate words of "return"
    path: fix duplicate words of "look"
    pack-protocol.txt: fix duplicate words of "the"
    precompose-utf8: fix typo of "sequences"
    split-index: fix typo
    worktree.c: fix typo
    remote-ext: fix typo

Signed-off-by: Li Peng <lip@dtdream.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 builtin/remote-ext.c                      | 2 +-
 compat/precompose_utf8.c                  | 2 +-
 path.c                                    | 2 +-
 perl/Git.pm                               | 2 +-
 split-index.c                             | 2 +-
 t/t0000-basic.sh                          | 2 +-
 transport-helper.c                        | 2 +-
 wildmatch.c                               | 2 +-
 worktree.c                                | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index c6977bb..8b36343 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -526,7 +526,7 @@ Push Certificate
=20
 A push certificate begins with a set of header lines.  After the
 header and an empty line, the protocol commands follow, one per
-line. Note that the the trailing LF in push-cert PKT-LINEs is _not_
+line. Note that the trailing LF in push-cert PKT-LINEs is _not_
 optional; it must be present.
=20
 Currently, the following header fields are defined:
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 7457c74..88eb8f9 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -168,7 +168,7 @@ static int command_loop(const char *child)
   size_t i;
   if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
    if (ferror(stdin))
-    die("Comammand input error");
+    die("Command input error");
    exit(0);
   }
   /* Strip end of line characters. */
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index dfbe6d8..4293b53 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -147,7 +147,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PRE=
C_DIR *prec_dir)
     if (errno || inleft) {
      /*
       * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-      * MacOS X avoids illegal byte sequemces.
+      * MacOS X avoids illegal byte sequences.
       * If they occur on a mounted drive (e.g. NFS) it is not worth to
       * die() for that, but rather let the user see the original name
      */
diff --git a/path.c b/path.c
index 969b494..a5e953f 100644
--- a/path.c
+++ b/path.c
@@ -134,7 +134,7 @@ static struct common_dir common_list[] =3D {
  * definite
  * definition
  *
- * The trie would look look like:
+ * The trie would look like:
  * root: len =3D 0, children a and d non-NULL, value =3D NULL.
  *    a: len =3D 2, contents =3D bc, value =3D (data for "abc")
  *    d: len =3D 2, contents =3D ef, children i non-NULL, value =3D (d=
ata for "def")
diff --git a/perl/Git.pm b/perl/Git.pm
index 49eb88a..ce7e4e8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -393,7 +393,7 @@ sub command_close_pipe {
 Execute the given C<COMMAND> in the same way as command_output_pipe()
 does but return both an input pipe filehandle and an output pipe fileh=
andle.
=20
-The function will return return C<($pid, $pipe_in, $pipe_out, $ctx)>.
+The function will return C<($pid, $pipe_in, $pipe_out, $ctx)>.
 See C<command_close_bidi_pipe()> for details.
=20
 =3Dcut
diff --git a/split-index.c b/split-index.c
index 968b780..3c75d4b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -60,7 +60,7 @@ static void mark_base_index_entries(struct index_stat=
e *base)
   * To keep track of the shared entries between
   * istate->base->cache[] and istate->cache[], base entry
   * position is stored in each base entry. All positions start
-  * from 1 instead of 0, which is resrved to say "this is a new
+  * from 1 instead of 0, which is reserved to say "this is a new
   * entry".
   */
  for (i =3D 0; i < base->cache_nr; i++)
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 79b9074..60811a3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -98,7 +98,7 @@ check_sub_test_lib_test () {
 }
=20
 check_sub_test_lib_test_err () {
- name=3D"$1" # stdin is the expected output output from the test
+ name=3D"$1" # stdin is the expected output from the test
  # expected error output is in descriptior 3
  (
   cd "$name" &&
diff --git a/transport-helper.c b/transport-helper.c
index b934183..13b7a57 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1152,7 +1152,7 @@ static void udt_close_if_finished(struct unidirec=
tional_transfer *t)
 }
=20
 /*
- * Tries to read read data from source into buffer. If buffer is full,
+ * Tries to read data from source into buffer. If buffer is full,
  * no data is read. Returns 0 on success, -1 on error.
  */
 static int udt_do_read(struct unidirectional_transfer *t)
diff --git a/wildmatch.c b/wildmatch.c
index f91ba99..57c8765 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -136,7 +136,7 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
     /*
      * Try to advance faster when an asterisk is
      * followed by a literal. We know in this case
-     * that the the string before the literal
+     * that the string before the literal
      * must belong to "*".
      * If match_slash is false, do not look past
      * the first slash as it cannot belong to '*'.
diff --git a/worktree.c b/worktree.c
index 6181a66..89ebe67 100644
--- a/worktree.c
+++ b/worktree.c
@@ -18,7 +18,7 @@ void free_worktrees(struct worktree **worktrees)
=20
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detatched (is not detached).
+ * set is_detached to 1 (0) if the ref is detached (is not detached).
  *
  * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR=
 so
  * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
--=20
2.8.2-507-g43e827d
