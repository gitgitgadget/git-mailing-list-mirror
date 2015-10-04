From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sun, 4 Oct 2015 08:31:31 +0200
Message-ID: <5610C7C3.807@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net> <560F6E98.8030305@web.de>
 <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com> <561044AD.8010803@web.de>
 <20151004033713.GB20876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	"dturner@twopensource.com >> David Turner" <dturner@twopensource.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 04 08:31:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zicpk-0008Cx-OT
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 08:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbbJDGbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2015 02:31:40 -0400
Received: from mout.web.de ([212.227.15.3]:64519 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbbJDGbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 02:31:39 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LkVZr-1aKiPG2Sfz-00cUg6; Sun, 04 Oct 2015 08:31:33
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <20151004033713.GB20876@sigill.intra.peff.net>
X-Provags-ID: V03:K0:R0/NIfcY8D2cHcb5zviiPFLNzMHwfrGgzqiM6Lo3/meQf/zcfSO
 SoTTT3Amh35eGXUP0wsr5BT2OpJeriQKgD82pTwU1Gw3uGbMK7+eMTuEw+sb8yOjkctLW0B
 mz3vEZSa2wkf2lk+3JwnSr9BoOP0R+b2z78w2D+idrAswEHJnic7Ddsj68vGJcUiKw4jrrF
 RaSeLSZdQhBx2leNPjSSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pWByUOculUk=:+uO6ZE3u9YVk5hFWKjevBI
 Z2BDQiyFdN53xE8iejn+qWF1ppoNO2UTgyWp6ZZam6ciWMAGZ+orq3VCwHyRanDs9INKUp9Vo
 usitjpI4bvAsDKZ1B0MsvuaeelZD7E8xf6yY9el94I1V6ILNjXw8mjFyqIWDOmDl1vpd5gX+2
 1i6ftQmdvoWVK8bNMf/LwBql+AzsvJqBbWpfI4VYppO68nmNj0fuCziMpOfDEUn1Tih2JaeM9
 AzvhY+lIr70ppoPyph80LqakNLxdseNU5g56Jppz8Jmt5YX/WgronUjcy67g8W8eZFJFZDFMN
 uacHq1gxZlmvRhtm89WkWKKPgZknnDrv+Lkz8hk3KgvGJ4FIxJ1nWWMTEWRT6GircX5ECYa2F
 XbbwqD6/hMuvQyR16Pu76ZvSYnPBx1h+knxvh0GMbPQHxZCcqNy+p2YBZZQQsQjnDJ3QfkL0n
 bXdTOLipuffriawtRjzDOugt+LQq7pDKUJKIVeCVwEDPEl33Q5jpnp8CrKP4AeAC5Lk9r2Lvx
 bGfmhdajoZxwNiDsdroZRnYWHzLlFIoWWSP/MF/qNYSfjb8ikOJviYNy5vEOz931flfvK73yf
 MNeBW4Gi5IJpYUv/bJf4PUNF/Hv2rAmwgG+LwTLmTYvCV8jAsER5EpY/qZO7rB2eCd5YzqGCA
 ZJrPqeYraNVfPexUZEqrZcgmQpHYq3E/UN/LK0Dy31NCxzHTHvDJWxTKsCxGH61YUHcLAq1bn
 jv4tzmj/2y/S2sXc/kQ6soj4iqrWdetosFRE6hTxsvPMqf8vKTiNOYDF/ZctTgL7sUtNrflr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278994>



On 2015-10-04 05.37, Jeff King wrote:
> On Sat, Oct 03, 2015 at 11:12:13PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>>> Hmph, Peff's quick-fix passed the original "CoNfIg" in &buf directl=
y
>>> to probe_utf8_pathname_composition() without changing its signature=
=2E
>> True, ( I was thinking that the test did only work on case insensiti=
ve FS).
>> We can skip that change.
>>
>> Beside that, I later realized, that a better signature could be:
>> +void probe_utf8_pathname_composition(const char *path, size_t len)
>>
>> I can send a proper patch the next days.
> That is the original signature, before my sprintf series. I do not mi=
nd
> leaving that as-is, and simply cleaning up probe_utf8_pathname_compos=
ition
> by using a strbuf internally there. Though I have to wonder if it eve=
n
> needs us to pass _anything_ at that point. It could just call
> git_path_buf("config%s", auml_nfd) itself. The whole reason to pass
> anything was to let it reuse the buffer the caller had.
>
> -Peff
Makes sense, here is V2:
 git diff  07690109b6a252ac7cbede

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 89f2c05..4892579 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -276,7 +276,7 @@ static int create_default_files(const char *templat=
e_path)
         path =3D git_path_buf(&buf, "CoNfIg");
         if (!access(path, F_OK))
             git_config_set("core.ignorecase", "true");
-        probe_utf8_pathname_composition(path);
+        probe_utf8_pathname_composition();
     }
=20
     strbuf_release(&buf);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index b4dd3c7..64b85f2 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
+#include "strbuf.h"
=20
 typedef char *iconv_ibp;
 static const char *repo_encoding =3D "UTF-8";
@@ -36,28 +37,27 @@ static size_t has_non_ascii(const char *s, size_t m=
axlen,
size_t *strlen_c)
 }
=20
=20
-void probe_utf8_pathname_composition(struct strbuf *path)
+void probe_utf8_pathname_composition(void)
 {
+    struct strbuf sbuf =3D STRBUF_INIT;
     static const char *auml_nfc =3D "\xc3\xa4";
     static const char *auml_nfd =3D "\x61\xcc\x88";
-    size_t baselen =3D path->len;
+    const char *path;
     int output_fd;
     if (precomposed_unicode !=3D -1)
         return; /* We found it defined in the global config, respect i=
t */
-    strbuf_addstr(path, auml_nfc);
+    path =3D git_path_buf(&sbuf, "%s", auml_nfc);
     output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
     if (output_fd >=3D 0) {
         close(output_fd);
-        strbuf_setlen(path, baselen);
-        strbuf_addstr(path, auml_nfd);
+        path =3D git_path_buf(&sbuf, "%s", auml_nfd);
         precomposed_unicode =3D access(path, R_OK) ? 0 : 1;
         git_config_set("core.precomposeunicode", precomposed_unicode ?=
 "true" :
"false");
-        strbuf_setlen(path, baselen);
-        strbuf_addstr(path, auml_nfc);
+        path =3D git_path_buf(&sbuf, "%s", auml_nfc);
         if (unlink(path))
             die_errno(_("failed to unlink '%s'"), path);
     }
-    strbuf_setlen(path, baselen);
+    strbuf_release(&sbuf);
 }
=20
=20
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 7fc7be5..a94e7c4 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -27,7 +27,7 @@ typedef struct {
 } PREC_DIR;
=20
 void precompose_argv(int argc, const char **argv);
-void probe_utf8_pathname_composition(struct strbuf *path);
+void probe_utf8_pathname_composition(void);
=20
 PREC_DIR *precompose_utf8_opendir(const char *dirname);
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

And this is fix for David:


diff --git a/refs.h b/refs.h
index f499093..7dee497 100644
--- a/refs.h
+++ b/refs.h
@@ -670,7 +670,6 @@ typedef int (*ref_transaction_verify_fn)(struct
ref_transaction *transaction,
         unsigned int flags, struct strbuf *err);
 typedef int (*ref_transaction_commit_fn)(struct ref_transaction *trans=
action,
                      struct strbuf *err);
-typedef void (*ref_transaction_free_fn)(struct ref_transaction *transa=
ction);
=20
 /* reflog functions */
 typedef int (*for_each_reflog_ent_fn)(const char *refname,
