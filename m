From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 10:28:55 +0200
Message-ID: <1113467335.23299.77.camel@nosferatu.lan>
References: <20050411135758.GA3524@pasky.ji.cz>
	 <1113310045.23299.15.camel@nosferatu.lan>
	 <20050412130250.GG22614@pasky.ji.cz>
	 <1113311595.23299.17.camel@nosferatu.lan>
	 <20050412132307.GH22614@pasky.ji.cz>
	 <1113375277.23299.25.camel@nosferatu.lan>
	 <20050413075441.GD16489@pasky.ji.cz>
	 <1113381672.23299.47.camel@nosferatu.lan>
	 <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o9HlpIXZhp48bAxCvKxk"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzcr-0005ZK-Ve
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDNI0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVDNI0T
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:26:19 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.76]:37778 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S261462AbVDNIZT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 04:25:19 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg4.saix.net (Postfix) with ESMTP id 544DCB391;
	Thu, 14 Apr 2005 10:25:10 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id A38943A26DA;
	Thu, 14 Apr 2005 10:31:14 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10767-16; Thu, 14 Apr 2005 10:31:06 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 2C6363A26DB;
	Thu, 14 Apr 2005 10:31:06 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1113461754.23299.68.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-o9HlpIXZhp48bAxCvKxk
Content-Type: multipart/mixed; boundary="=-mlijg8g+dFRH8oSthMFu"


--=-mlijg8g+dFRH8oSthMFu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 08:55 +0200, Martin Schlemmer wrote:
> On Thu, 2005-04-14 at 00:19 +0200, Petr Baudis wrote:
> > Dear diary, on Wed, Apr 13, 2005 at 02:15:37PM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > On Wed, 2005-04-13 at 11:26 +0200, Petr Baudis wrote:
> > >> > Dear diary, on Wed, Apr 13, 2005 at 10:41:12AM CEST, I got a lette=
r
> > > > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > > > On Wed, 2005-04-13 at 09:54 +0200, Petr Baudis wrote:
> > > > > PS: not having looked deeper yet, why does fsck-cache always find
> > > > > unreferenced blobs/commits (no matter what tree is tracked, they =
stay
> > > > > the same) ?  And trying to remove them leads to more, which leads=
 to an
> > > > > empty .git/opjects/ =3D)  Also, leading to this, will adding an o=
ption to
> > > > > remove disconnected commits/blobs from local commits (that was
> > > > > disconnected with a pull) be a viable option to add?
> > > >=20
> > > > fsck-cache is concerned only by the objects database, so all the HE=
ADs
> > > > are unreferenced commits too. This is a right thing, the HEAD track=
ing
> > > > should stay purely in the scripts - if we want to make fsck-cache
> > > > smarter about that, we should implement git fsck or something.
> > > >=20
> > > > Killing unreferenced blobs should be safe, I think.
> > > >=20
> > > > > First, about the 'git diff' thing I asked yesterday .. what I mea=
nt, was
> > > > > should it actually output this:
> > > > >=20
> > > > > ----
> > > > > COPYING:  fe2a4177a760fd110e78788734f167bd633be8de 33
> > > > > Makefile:  929aa49a3dbe683ad52094099797bc636a7949a6 33
> > > > > README:  46c6a9ea48ddd1dda45ca585f49975a6869ffe51 33
> > > > > ...
> > > > > ----
> > > > >=20
> > > > > Shouldn't it just show actual changes?
> > > >=20
> > > > This is an actual change. It's just that it's a change to metadata
> > > > (somewhat esotherically described by the "33"), not the file conten=
ts.
> > > >=20
> > > > BTW, git diff does actually something completely different from git=
 diff
> > > > with any arguments. It diffs to the directory cache, not to any tre=
e! It
> > > > just wraps show-diff, which has also a different output format (not
> > > > outputting "git diffs"). The worst thing is that it requires a diff=
erent
> > > > -p option to apply. Someone should purge this wart, I think.
> > > >=20
> > >=20
> > > Check applied patch (also in the new output).
> >=20
> > Please send patches inline and properly signed off.
> >=20
>=20
> The new evo have a bad habit of screwing the tabs, but sure.
>=20
> > > > > Also on the same note .. should 'git ci' without listed files to =
be
> > > > > committed, really add a reference to all files as it currently do=
 in the
> > > > > commit/blob/whatever info, instead of just the changed/added file=
s (see
> > > > > the git-seperate-dir.patch you have not yet commented on for refe=
rence)?
> > > >=20
> > > > ...
> > > >=20
> > >=20
> > > Patch will also resolve this.
> >=20
> > Your patch is bad - it removes the pure metadata changes, but you
> > definitively do not want to do that! If you are annoyed by meaningless
> > time changes etc, do update-cache --refresh. Ignoring mode changes is a
> > pure disaster.
> >=20
>=20
> Ahh - and there was light.  I do not have a problem with the mode
> changes - its just _all_ files was shown after tracked branch was
> changed.  How about below patch?
>=20
> > > > > I know its in its infancy, but I am not sure on what scm you are =
basing
> > > > > it, so not sure how things should behave.
> > > >=20
> > > > I'm trying to base it on common sense and principle of least surpri=
se.
> > > > :-)
> > > >=20
> > >=20
> > > Ok, I'll just bug you then if I am not sure on how you want something=
 ;p
> >=20
> > Or do it somehow and I'll bug you back if I don't like it. ;-)
> >=20
>=20
> Ditto
>=20
>=20
> ----
>=20
> Normalize show-diff output and make sure we only show real changes after
> changing the tracked branch.
>=20
> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
>=20

Ok, so I forgot to pull, and missed gitcancel.sh being added.
How about this one?  (One attached in case evo is brain dead and mangles
the tabs)

----

Normalize show-diff output, add --update-modes target to update-cache,
and make sure we only show real changes after changing the tracked
branch, as well as update the file modes according to the cache.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
--- gitcancel.sh
+++ gitcancel.sh        2005-04-14 10:26:49.000000000 +0200
@@ -12,7 +12,7 @@

 # FIXME: Does not revert mode changes!

-show-diff | patch -p0 -R
+show-diff | patch -p1 -R
 rm -f .git/add-queue .git/rm-queue .git/merged

 update-cache --refresh
gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
--- gittrack.sh
+++ gittrack.sh 2005-04-14 10:26:49.000000000 +0200
@@ -51,6 +51,8 @@

        read-tree $(tree-id "$name")
        gitdiff.sh local "$name" | gitapply.sh
+       # --update-modes need to be before --refresh
+       update-cache --update-modes --refresh

 else
        [ "$tracking" ] || \
@@ -61,6 +63,8 @@
        if [ -s ".git/HEAD.local" ]; then
                gitdiff.sh "$tracking" local | gitapply.sh
                read-tree $(tree-id local)
+               # --update-modes need to be before --refresh
+               update-cache --update-modes --refresh

                head=3D$(cat .git/HEAD)
                branchhead=3D$(cat .git/heads/$tracking)
show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
--- show-diff.c
+++ show-diff.c 2005-04-14 10:26:49.000000000 +0200
@@ -5,13 +5,18 @@
  */
 #include "cache.h"

-static void show_differences(char *name,
+static void show_differences(struct cache_entry *ce,
        void *old_contents, unsigned long long old_size)
 {
        static char cmd[1000];
+       static char sha1[41];
+       int n;
        FILE *f;

-       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
+       for (n =3D 0; n < 20; n++)
+               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
+       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u -N  =
- %s",
+               sha1, ce->name, ce->name, ce->name);
        f =3D popen(cmd, "w");
        if (old_size)
                fwrite(old_contents, old_size, 1, f);
@@ -99,7 +104,7 @@
                        continue;

                new =3D read_sha1_file(ce->sha1, type, &size);
-               show_differences(ce->name, new, size);
+               show_differences(ce, new, size);
                free(new);
        }
        return 0;
update-cache.c:  62d0a6c41560d40863c44599355af10d9e089312
--- update-cache.c
+++ update-cache.c      2005-04-14 10:27:07.000000000 +0200
@@ -210,6 +210,39 @@
        }
 }

+static struct cache_entry *update_file_mode(struct cache_entry *ce)
+{
+       struct stat st;
+       int changed;
+
+       if (stat(ce->name, &st) < 0)
+               return NULL;
+
+       changed =3D cache_match_stat(ce, &st);
+       if (!changed)
+               return ce;
+
+       if (changed & MODE_CHANGED)
+               if (chmod(ce->name, ce->st_mode))
+                       return NULL;
+
+       return ce;
+}
+
+static void update_modes(void)
+{
+       int i;
+
+       for (i =3D 0; i < active_nr; i++) {
+               struct cache_entry *ce =3D active_cache[i];
+
+               if (!update_file_mode(ce)) {
+                       printf("%s: needs update\n", ce->name);
+                       continue;
+               }
+       }
+}
+
 /*
  * We fundamentally don't like some paths: we don't want
  * dot or dot-dot anywhere, and in fact, we don't even want
@@ -282,6 +315,10 @@
                                refresh_cache();
                                continue;
                        }
+                       if (!strcmp(path, "--update-modes")) {
+                               update_modes();
+                               continue;
+                       }
                        die("unknown option %s", path);
                }
                if (!verify_path(path)) {



--=20
Martin Schlemmer


--=-mlijg8g+dFRH8oSthMFu
Content-Disposition: attachment; filename=git-show-diff.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=git-show-diff.patch; charset=UTF-8

Z2l0Y2FuY2VsLnNoOiAgZWM1OGY3NDQ0YTQyY2QzY2JhYWU5MTlmYzY4YzcwYTM4NjY0MjBjMA0K
LS0tIGdpdGNhbmNlbC5zaA0KKysrIGdpdGNhbmNlbC5zaAkyMDA1LTA0LTE0IDEwOjI2OjQ5LjAw
MDAwMDAwMCArMDIwMA0KQEAgLTEyLDcgKzEyLDcgQEANCiANCiAjIEZJWE1FOiBEb2VzIG5vdCBy
ZXZlcnQgbW9kZSBjaGFuZ2VzIQ0KIA0KLXNob3ctZGlmZiB8IHBhdGNoIC1wMCAtUg0KK3Nob3ct
ZGlmZiB8IHBhdGNoIC1wMSAtUg0KIHJtIC1mIC5naXQvYWRkLXF1ZXVlIC5naXQvcm0tcXVldWUg
LmdpdC9tZXJnZWQNCiANCiB1cGRhdGUtY2FjaGUgLS1yZWZyZXNoDQpnaXR0cmFjay5zaDogIDAz
ZDZkYjFmYjNhNzA2MDVlZjI0OWM2MzJjMDRlNTQyNDU3ZjA4MDgNCi0tLSBnaXR0cmFjay5zaA0K
KysrIGdpdHRyYWNrLnNoCTIwMDUtMDQtMTQgMTA6MjY6NDkuMDAwMDAwMDAwICswMjAwDQpAQCAt
NTEsNiArNTEsOCBAQA0KIA0KIAlyZWFkLXRyZWUgJCh0cmVlLWlkICIkbmFtZSIpDQogCWdpdGRp
ZmYuc2ggbG9jYWwgIiRuYW1lIiB8IGdpdGFwcGx5LnNoDQorCSMgLS11cGRhdGUtbW9kZXMgbmVl
ZCB0byBiZSBiZWZvcmUgLS1yZWZyZXNoDQorCXVwZGF0ZS1jYWNoZSAtLXVwZGF0ZS1tb2RlcyAt
LXJlZnJlc2gNCiANCiBlbHNlDQogCVsgIiR0cmFja2luZyIgXSB8fCBcDQpAQCAtNjEsNiArNjMs
OCBAQA0KIAlpZiBbIC1zICIuZ2l0L0hFQUQubG9jYWwiIF07IHRoZW4NCiAJCWdpdGRpZmYuc2gg
IiR0cmFja2luZyIgbG9jYWwgfCBnaXRhcHBseS5zaA0KIAkJcmVhZC10cmVlICQodHJlZS1pZCBs
b2NhbCkNCisJCSMgLS11cGRhdGUtbW9kZXMgbmVlZCB0byBiZSBiZWZvcmUgLS1yZWZyZXNoDQor
CQl1cGRhdGUtY2FjaGUgLS11cGRhdGUtbW9kZXMgLS1yZWZyZXNoDQogDQogCQloZWFkPSQoY2F0
IC5naXQvSEVBRCkNCiAJCWJyYW5jaGhlYWQ9JChjYXQgLmdpdC9oZWFkcy8kdHJhY2tpbmcpDQpz
aG93LWRpZmYuYzogIGE1MzFjYTQwNzg1MjVkMWM4ZGNmODRhYWUwYmZhODlmZWQ2ZTVkOTYNCi0t
LSBzaG93LWRpZmYuYw0KKysrIHNob3ctZGlmZi5jCTIwMDUtMDQtMTQgMTA6MjY6NDkuMDAwMDAw
MDAwICswMjAwDQpAQCAtNSwxMyArNSwxOCBAQA0KICAqLw0KICNpbmNsdWRlICJjYWNoZS5oIg0K
IA0KLXN0YXRpYyB2b2lkIHNob3dfZGlmZmVyZW5jZXMoY2hhciAqbmFtZSwNCitzdGF0aWMgdm9p
ZCBzaG93X2RpZmZlcmVuY2VzKHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UsDQogCXZvaWQgKm9sZF9j
b250ZW50cywgdW5zaWduZWQgbG9uZyBsb25nIG9sZF9zaXplKQ0KIHsNCiAJc3RhdGljIGNoYXIg
Y21kWzEwMDBdOw0KKwlzdGF0aWMgY2hhciBzaGExWzQxXTsNCisJaW50IG47DQogCUZJTEUgKmY7
DQogDQotCXNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCksICJkaWZmIC1MICVzIC11IC1OICAtICVz
IiwgbmFtZSwgbmFtZSk7DQorCWZvciAobiA9IDA7IG4gPCAyMDsgbisrKQ0KKwkJc25wcmludGYo
JihzaGExW24qMl0pLCAzLCAiJTAyeCIsIGNlLT5zaGExW25dKTsNCisJc25wcmludGYoY21kLCBz
aXplb2YoY21kKSwgImRpZmYgLUwgJXMvJXMgLUwgdW5jb21taXR0ZWQvJXMgLXUgLU4gIC0gJXMi
LA0KKwkJc2hhMSwgY2UtPm5hbWUsIGNlLT5uYW1lLCBjZS0+bmFtZSk7DQogCWYgPSBwb3Blbihj
bWQsICJ3Iik7DQogCWlmIChvbGRfc2l6ZSkNCiAJCWZ3cml0ZShvbGRfY29udGVudHMsIG9sZF9z
aXplLCAxLCBmKTsNCkBAIC05OSw3ICsxMDQsNyBAQA0KIAkJCWNvbnRpbnVlOw0KIA0KIAkJbmV3
ID0gcmVhZF9zaGExX2ZpbGUoY2UtPnNoYTEsIHR5cGUsICZzaXplKTsNCi0JCXNob3dfZGlmZmVy
ZW5jZXMoY2UtPm5hbWUsIG5ldywgc2l6ZSk7DQorCQlzaG93X2RpZmZlcmVuY2VzKGNlLCBuZXcs
IHNpemUpOw0KIAkJZnJlZShuZXcpOw0KIAl9DQogCXJldHVybiAwOw0KdXBkYXRlLWNhY2hlLmM6
ICA2MmQwYTZjNDE1NjBkNDA4NjNjNDQ1OTkzNTVhZjEwZDllMDg5MzEyDQotLS0gdXBkYXRlLWNh
Y2hlLmMNCisrKyB1cGRhdGUtY2FjaGUuYwkyMDA1LTA0LTE0IDEwOjI3OjA3LjAwMDAwMDAwMCAr
MDIwMA0KQEAgLTIxMCw2ICsyMTAsMzkgQEANCiAJfQ0KIH0NCiANCitzdGF0aWMgc3RydWN0IGNh
Y2hlX2VudHJ5ICp1cGRhdGVfZmlsZV9tb2RlKHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UpDQorew0K
KwlzdHJ1Y3Qgc3RhdCBzdDsNCisJaW50IGNoYW5nZWQ7DQorDQorCWlmIChzdGF0KGNlLT5uYW1l
LCAmc3QpIDwgMCkNCisJCXJldHVybiBOVUxMOw0KKw0KKwljaGFuZ2VkID0gY2FjaGVfbWF0Y2hf
c3RhdChjZSwgJnN0KTsNCisJaWYgKCFjaGFuZ2VkKQ0KKwkJcmV0dXJuIGNlOw0KKw0KKwlpZiAo
Y2hhbmdlZCAmIE1PREVfQ0hBTkdFRCkNCisJCWlmIChjaG1vZChjZS0+bmFtZSwgY2UtPnN0X21v
ZGUpKQ0KKwkJCXJldHVybiBOVUxMOw0KKw0KKwlyZXR1cm4gY2U7DQorfQ0KKw0KK3N0YXRpYyB2
b2lkIHVwZGF0ZV9tb2Rlcyh2b2lkKQ0KK3sNCisJaW50IGk7DQorDQorCWZvciAoaSA9IDA7IGkg
PCBhY3RpdmVfbnI7IGkrKykgew0KKwkJc3RydWN0IGNhY2hlX2VudHJ5ICpjZSA9IGFjdGl2ZV9j
YWNoZVtpXTsNCisNCisJCWlmICghdXBkYXRlX2ZpbGVfbW9kZShjZSkpIHsNCisJCQlwcmludGYo
IiVzOiBuZWVkcyB1cGRhdGVcbiIsIGNlLT5uYW1lKTsNCisJCQljb250aW51ZTsNCisJCX0NCisJ
fQ0KK30NCisNCiAvKg0KICAqIFdlIGZ1bmRhbWVudGFsbHkgZG9uJ3QgbGlrZSBzb21lIHBhdGhz
OiB3ZSBkb24ndCB3YW50DQogICogZG90IG9yIGRvdC1kb3QgYW55d2hlcmUsIGFuZCBpbiBmYWN0
LCB3ZSBkb24ndCBldmVuIHdhbnQNCkBAIC0yODIsNiArMzE1LDEwIEBADQogCQkJCXJlZnJlc2hf
Y2FjaGUoKTsNCiAJCQkJY29udGludWU7DQogCQkJfQ0KKwkJCWlmICghc3RyY21wKHBhdGgsICIt
LXVwZGF0ZS1tb2RlcyIpKSB7DQorCQkJCXVwZGF0ZV9tb2RlcygpOw0KKwkJCQljb250aW51ZTsN
CisJCQl9DQogCQkJZGllKCJ1bmtub3duIG9wdGlvbiAlcyIsIHBhdGgpOw0KIAkJfQ0KIAkJaWYg
KCF2ZXJpZnlfcGF0aChwYXRoKSkgew0K


--=-mlijg8g+dFRH8oSthMFu--

--=-o9HlpIXZhp48bAxCvKxk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXinHqburzKaJYLYRAuV3AJ9Q8mypsE2Wl7fcIh24GhMFLAvgfQCeO4KG
5zbzRTSXyH4cBNkLskUkzDI=
=+NtR
-----END PGP SIGNATURE-----

--=-o9HlpIXZhp48bAxCvKxk--

