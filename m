From: Clark Williams <clark.williams@gmail.com>
Subject: [PATCH stgit] revised patch for importing series from tarball
Date: Sun, 19 Oct 2008 14:16:13 -0500
Message-ID: <20081019141613.05cbd93e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/3+S5DJt/C5eSfy3DIS2kJX5"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:43:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krdme-0006wZ-5m
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 21:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYJSTQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYJSTQd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 15:16:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:23575 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbYJSTQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 15:16:32 -0400
Received: by ey-out-2122.google.com with SMTP id 6so468066eyi.37
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type;
        bh=7QlMxsQlcUWZ/AZevZpEFwTv1JTyDp8XL4DqTiBesIM=;
        b=mmX7yS8sIZIodHjWnuDGdCeyZipRM9qpjVrU+9eRKMJxIr7awuMcmkDXWNrUr7doiL
         QHWAbWYl4LahM6gxQtX60b5c1mJiLqXsW8CR20vVd7Je9Ew/k81kTr8mEW6oToLxcohg
         1deGMjxBY9rKkluyaZQlV0Mml8GThiCbQqybg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type;
        b=QFUBU04KVg1ToHb97YMvUXBjuzauXONMLru9ZbhDR2plQJSe30EY6uZGYMsXxXHoKU
         Uq00LKZ8f9EmL0e+GtJWY1dDmJfxVg/9FKAL9wQ7KlGibiFKFGgdSi1f4GG7TUr4TaQY
         3KbfAhdq1Eh4EVG0+Kdk+HToYYVncRJGTrZww=
Received: by 10.210.141.4 with SMTP id o4mr7694580ebd.57.1224443789097;
        Sun, 19 Oct 2008 12:16:29 -0700 (PDT)
Received: from localhost.localdomain ([64.89.120.34])
        by mx.google.com with ESMTPS id 5sm8788711eyh.2.2008.10.19.12.16.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 12:16:27 -0700 (PDT)
X-Mailer: Claws Mail 3.6.0 (GTK+ 2.14.3; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98648>

--MP_/3+S5DJt/C5eSfy3DIS2kJX5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpDYXRhbGlu
LA0KDQpBdHRhY2hlZCBpcyBteSByZXZpc2VkIHBhdGNoICh2MiBJIGJlbGlldmUpIGZvciBpbXBv
cnRpbmcgYSBzZXJpZXMgZGlyZWN0bHkgZnJvbSBhIHRhcmJhbGwuIEkgbG9va2VkIGF0IHRoZSBj
cml0aXF1ZSBvZmZlcmVkIGJ5IEthcmwgKHByZXR0eSBoYXJkIGFjdHVhbGx5KSwgYnV0IEkgZGVj
aWRlZCBpbiB0aGUgZW5kIHRvIGtlZXAgZXh0cmFjdGluZyB0aGUgdGFyYmFsbCB0byBhIHRlbXAg
ZGlyZWN0b3J5LiBJdCdzIHBvc3NpYmxlIHRoYXQgaXQgd291bGQgYmUgZGVzaXJhYmxlIHRvIGV4
dHJhY3QgbWVtYmVycyBkaXJlY3RseSBmcm9tIGEgdGFyYmFsbCAoYWx0aG91Z2ggYXMgZmFyIGFz
IEkgY2FuIHRlbGwsIHlvdSBzdGlsbCBoYXZlIHRvIGV4dHJhY3QgdGhlbSB0byBhIGZpbGUpIGJ1
dCBJIGRpZG4ndCBqdWRnZSB0aGUgY2h1cm4gaW4gaW1wcnQucHkgdG8gYmUgd29ydGggaXQgZm9y
IG5vdy4gVGhpcyB2ZXJzaW9uIGlzIHByZXR0eSBzaW1wbGUsIGluIHRoYXQgeW91IGp1c3QgZGV0
ZWN0IHRoYXQgdGhlIGlucHV0IHRvIHRvIGltcG9ydF9zZXJpZXMgaXMgYSB0YXJiYWxsLCBjYWxs
IGltcG9ydF90YXJmaWxlLCB0aGVuIHJldHVybi4gDQoNCkkgYWRkZWQgYSBzaW1wbGUgdGVzdCB0
byB0aGUgdGVzdCBoYXJuZXNzIGZvciBpbXBvcnQgYXMgd2VsbC4gDQoNCk9oIGFuZCBJIGFkZGVk
ICcqLmVsYycgdG8gdGhlIC5naXRpZ25vcmUgZmlsZS4gTWF5IG5vdCBiZSB0aGF0IG1hbnkgZm9s
a3MgdXNpbmcgZW1hY3Mgd2l0aCBzdGdpdCwgYnV0IGhleSwgSSBhbSEgOikNCg0KQ2xhcmsNCi0t
LS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tDQpWZXJzaW9uOiBHbnVQRyB2Mi4wLjkgKEdOVS9M
aW51eCkNCg0KaUVZRUFSRUNBQVlGQWtqN2g0UUFDZ2tRcUE0SlZiNjFiOWRxNEFDYkI5dGwwRmJI
cTVpZ05JUEliekFMaHlMZg0KQXc4QW4zd2VUTnllN3l6US93VTJIeXQxYWd6Q3pUdEMNCj03V2pW
DQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

--MP_/3+S5DJt/C5eSfy3DIS2kJX5
Content-Type: text/x-patch; name=tarfiles.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=tarfiles.patch

patch to allow importing a series from a tar archive

From: Clark Williams <williams@redhat.com>

Signed-off-by: Clark Williams <williams@redhat.com>
---
 .gitignore                                      |    1=20
 stgit/commands/imprt.py                         |   47 +++++++++++++++++++=
+++-
 t/t1800-import.sh                               |   12 ++++++
 t/t1800-import/patches/attribution.patch        |   21 ++++++++++
 t/t1800-import/patches/delete-extra-lines.patch |   22 +++++++++++
 t/t1800-import/patches/fifth-stanza.patch       |   22 +++++++++++
 t/t1800-import/patches/first-stanza.patch       |   18 +++++++++
 t/t1800-import/patches/fourth-stanza.patch      |   22 +++++++++++
 t/t1800-import/patches/second-stanza.patch      |   22 +++++++++++
 t/t1800-import/patches/series                   |   10 +++++
 t/t1800-import/patches/seventh-stanza.patch     |   24 ++++++++++++
 t/t1800-import/patches/sixth-stanza.patch       |   22 +++++++++++
 t/t1800-import/patches/third-stanza.patch       |   22 +++++++++++
 13 files changed, 263 insertions(+), 2 deletions(-)
 create mode 100644 t/t1800-import/patches/attribution.patch
 create mode 100644 t/t1800-import/patches/delete-extra-lines.patch
 create mode 100644 t/t1800-import/patches/fifth-stanza.patch
 create mode 100644 t/t1800-import/patches/first-stanza.patch
 create mode 100644 t/t1800-import/patches/fourth-stanza.patch
 create mode 100644 t/t1800-import/patches/second-stanza.patch
 create mode 100644 t/t1800-import/patches/series
 create mode 100644 t/t1800-import/patches/seventh-stanza.patch
 create mode 100644 t/t1800-import/patches/sixth-stanza.patch
 create mode 100644 t/t1800-import/patches/third-stanza.patch

diff --git a/.gitignore b/.gitignore
index 91dbad2..f0e5d30 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,3 +6,4 @@ patches-*
 release.sh
 setup.cfg.rpm
 snapshot.sh
+*.elc
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 227743f..6860d0e 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -19,6 +19,7 @@ import sys, os, re, email
 from mailbox import UnixMailbox
 from StringIO import StringIO
 from optparse import OptionParser, make_option
+import tarfile
=20
 from stgit.commands.common import *
 from stgit.utils import *
@@ -52,7 +53,7 @@ options =3D [make_option('-m', '--mail',
                        help =3D 'import a series of patches from an mbox f=
ile',
                        action =3D 'store_true'),
            make_option('-s', '--series',
-                       help =3D 'import a series of patches',
+                       help =3D 'import a series of patches from a series =
file or a tar archive',
                        action =3D 'store_true'),
            make_option('-u', '--url',
                        help =3D 'import a patch from a URL',
@@ -87,7 +88,7 @@ options =3D [make_option('-m', '--mail',
            make_option('--commname',
                        help =3D 'use COMMNAME as the committer name'),
            make_option('--commemail',
-                       help =3D 'use COMMEMAIL as the committer e-mail')
+                       help =3D 'use COMMEMAIL as the committer e-mail'),
            ] + make_sign_options()
=20
=20
@@ -234,6 +235,9 @@ def __import_series(filename, options):
     applied =3D crt_series.get_applied()
=20
     if filename:
+        if tarfile.is_tarfile(filename):
+            __import_tarfile(filename, options)
+            return
         f =3D file(filename)
         patchdir =3D os.path.dirname(filename)
     else:
@@ -287,6 +291,45 @@ def __import_url(url, options):
     urllib.urlretrieve(url, filename)
     __import_file(filename, options)
=20
+def __import_tarfile(tar, options):
+    """Import patch series from a tar archive
+    """
+    import tempfile
+    import shutil
+
+    if not tarfile.is_tarfile(tar):
+        raise CmdException, "%s is not a tarfile!" % tar
+
+
+    t =3D tarfile.open(tar, 'r')
+    names =3D t.getnames()
+
+    # verify paths in the tarfile are safe
+    for n in names:
+        if n.startswith('/'):
+            raise CmdException, "Absolute path found in %s" % tar
+        if n.find("..") > -1:
+            raise CmdException, "Relative path found in %s" % tar
+
+    # find the series file
+    seriesfile =3D '';
+    for m in names:
+        if m.endswith('/series') or m =3D=3D 'series':
+            seriesfile =3D m
+            break
+    if seriesfile =3D=3D '':
+        raise CmdException, "no 'series' file found in %s" % tar
+
+    # unpack into a tmp dir
+    tmpdir =3D tempfile.mkdtemp('.stg')
+    t.extractall(tmpdir)
+
+    # apply the series
+    __import_series(os.path.join(tmpdir, seriesfile), options)
+
+    # cleanup the tmpdir
+    shutil.rmtree(tmpdir)
+
 def func(parser, options, args):
     """Import a GNU diff file as a new patch
     """
diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index 1352743..5a3384f 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -122,4 +122,16 @@ test_expect_success \
     stg delete ..
     '
=20
+test_expect_success \
+    'apply a series from a tarball' \
+    '
+    rm -f jabberwocky.txt && touch jabberwocky.txt &&
+    git add jabberwocky.txt && git commit -m "empty file" jabberwocky.txt =
&&
+    (cd ../t1800-import; tar -cjf jabberwocky.tar.bz2 patches) &&
+    stg import --series ../t1800-import/jabberwocky.tar.bz2
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree 2c33937252a21f1550c0bf21f1de534b68f69635") =3D 1 ]=
 &&
+    rm ../t1800-import/jabberwocky.tar.bz2
+    '
+   =20
 test_done
diff --git a/t/t1800-import/patches/attribution.patch b/t/t1800-import/patc=
hes/attribution.patch
new file mode 100644
index 0000000..2b7c8f9
--- /dev/null
+++ b/t/t1800-import/patches/attribution.patch
@@ -0,0 +1,21 @@
+attribution
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    4 ++++
+ 1 files changed, 4 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index 066d2e8..a9dd1f3 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -32,3 +32,7 @@ O frabjous day! Callooh! Callay!'
+   Did gyre and gimble in the wabe;
+ All mimsy were the borogoves,
+   And the mome raths outgrabe.
++
++	JABBERWOCKY
++	Lewis Carroll
++	(from Through the Looking-Glass and What Alice Found There, 1872)=20
diff --git a/t/t1800-import/patches/delete-extra-lines.patch b/t/t1800-impo=
rt/patches/delete-extra-lines.patch
new file mode 100644
index 0000000..e5b7a65
--- /dev/null
+++ b/t/t1800-import/patches/delete-extra-lines.patch
@@ -0,0 +1,22 @@
+delete extra lines
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    2 --
+ 1 files changed, 0 insertions(+), 2 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index 98cb716..066d2e8 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -28,8 +28,6 @@ He left it dead, and with its head
+ O frabjous day! Callooh! Callay!'
+   He chortled in his joy.
+=20
+-
+-
+ `Twas brillig, and the slithy toves
+   Did gyre and gimble in the wabe;
+ All mimsy were the borogoves,
diff --git a/t/t1800-import/patches/fifth-stanza.patch b/t/t1800-import/pat=
ches/fifth-stanza.patch
new file mode 100644
index 0000000..4f0e77c
--- /dev/null
+++ b/t/t1800-import/patches/fifth-stanza.patch
@@ -0,0 +1,22 @@
+fifth stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index b1c2ad3..f1416dc 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -17,3 +17,8 @@ And, as in uffish thought he stood,
+   The Jabberwock, with eyes of flame,
+ Came whiffling through the tulgey wood,
+   And burbled as it came!
++
++One, two! One, two! And through and through
++  The vorpal blade went snicker-snack!
++He left it dead, and with its head
++  He went galumphing back.
diff --git a/t/t1800-import/patches/first-stanza.patch b/t/t1800-import/pat=
ches/first-stanza.patch
new file mode 100644
index 0000000..ee7818f
--- /dev/null
+++ b/t/t1800-import/patches/first-stanza.patch
@@ -0,0 +1,18 @@
+first stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    4 ++++
+ 1 files changed, 4 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index e69de29..fba24dc 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -0,0 +1,4 @@
++`Twas brillig, and the slithy toves
++  Did gyre and gimble in the wabe:
++All mimsy were the borogoves,
++  And the mome raths outgrabe.
diff --git a/t/t1800-import/patches/fourth-stanza.patch b/t/t1800-import/pa=
tches/fourth-stanza.patch
new file mode 100644
index 0000000..eb2f8f2
--- /dev/null
+++ b/t/t1800-import/patches/fourth-stanza.patch
@@ -0,0 +1,22 @@
+fourth stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index 6405f36..b1c2ad3 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -12,3 +12,8 @@ He took his vorpal sword in hand:
+   Long time the manxome foe he sought --
+ So rested he by the Tumtum tree,
+   And stood awhile in thought.
++
++And, as in uffish thought he stood,
++  The Jabberwock, with eyes of flame,
++Came whiffling through the tulgey wood,
++  And burbled as it came!
diff --git a/t/t1800-import/patches/second-stanza.patch b/t/t1800-import/pa=
tches/second-stanza.patch
new file mode 100644
index 0000000..bec1622
--- /dev/null
+++ b/t/t1800-import/patches/second-stanza.patch
@@ -0,0 +1,22 @@
+second stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index fba24dc..9ed0b49 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -2,3 +2,8 @@
+   Did gyre and gimble in the wabe:
+ All mimsy were the borogoves,
+   And the mome raths outgrabe.
++
++"Beware the Jabberwock, my son!
++  The jaws that bite, the claws that catch!
++Beware the Jubjub bird, and shun
++  The frumious Bandersnatch!"
diff --git a/t/t1800-import/patches/series b/t/t1800-import/patches/series
new file mode 100644
index 0000000..5945c98
--- /dev/null
+++ b/t/t1800-import/patches/series
@@ -0,0 +1,10 @@
+# This series applies on GIT commit 6a8b6f6e2ecbcab26de7656b66b7f30eeba1ee=
96
+first-stanza.patch
+second-stanza.patch
+third-stanza.patch
+fourth-stanza.patch
+fifth-stanza.patch
+sixth-stanza.patch
+seventh-stanza.patch
+delete-extra-lines.patch
+attribution.patch
diff --git a/t/t1800-import/patches/seventh-stanza.patch b/t/t1800-import/p=
atches/seventh-stanza.patch
new file mode 100644
index 0000000..555c200
--- /dev/null
+++ b/t/t1800-import/patches/seventh-stanza.patch
@@ -0,0 +1,24 @@
+seventh stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    7 +++++++
+ 1 files changed, 7 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index bf732f5..98cb716 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -27,3 +27,10 @@ He left it dead, and with its head
+   Come to my arms, my beamish boy!
+ O frabjous day! Callooh! Callay!'
+   He chortled in his joy.
++
++
++
++`Twas brillig, and the slithy toves
++  Did gyre and gimble in the wabe;
++All mimsy were the borogoves,
++  And the mome raths outgrabe.
diff --git a/t/t1800-import/patches/sixth-stanza.patch b/t/t1800-import/pat=
ches/sixth-stanza.patch
new file mode 100644
index 0000000..2349b7e
--- /dev/null
+++ b/t/t1800-import/patches/sixth-stanza.patch
@@ -0,0 +1,22 @@
+sixth stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index f1416dc..bf732f5 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -22,3 +22,8 @@ One, two! One, two! And through and through
+   The vorpal blade went snicker-snack!
+ He left it dead, and with its head
+   He went galumphing back.
++
++"And, has thou slain the Jabberwock?
++  Come to my arms, my beamish boy!
++O frabjous day! Callooh! Callay!'
++  He chortled in his joy.
diff --git a/t/t1800-import/patches/third-stanza.patch b/t/t1800-import/pat=
ches/third-stanza.patch
new file mode 100644
index 0000000..d942353
--- /dev/null
+++ b/t/t1800-import/patches/third-stanza.patch
@@ -0,0 +1,22 @@
+third stanza
+
+From: Clark Williams <williams@redhat.com>
+
+
+---
+ jabberwocky.txt |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/jabberwocky.txt b/jabberwocky.txt
+index 9ed0b49..6405f36 100644
+--- a/jabberwocky.txt
++++ b/jabberwocky.txt
+@@ -7,3 +7,8 @@ All mimsy were the borogoves,
+   The jaws that bite, the claws that catch!
+ Beware the Jubjub bird, and shun
+   The frumious Bandersnatch!"
++
++He took his vorpal sword in hand:
++  Long time the manxome foe he sought --
++So rested he by the Tumtum tree,
++  And stood awhile in thought.

--MP_/3+S5DJt/C5eSfy3DIS2kJX5--
