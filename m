From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 10:38:25 +0200
Message-ID: <1113467905.23299.81.camel@nosferatu.lan>
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
	 <1113467335.23299.77.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ba4KE5Yq2CT5lF76rDbA"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzms-0007Kn-V5
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDNIgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDNIgN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:36:13 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.76]:14239 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S261466AbVDNIel
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 04:34:41 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg4.saix.net (Postfix) with ESMTP id 8EBB0B651;
	Thu, 14 Apr 2005 10:34:37 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 1F30D3A26DA;
	Thu, 14 Apr 2005 10:40:42 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19474-17; Thu, 14 Apr 2005 10:40:35 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id B26103A26DB;
	Thu, 14 Apr 2005 10:40:35 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1113467335.23299.77.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Ba4KE5Yq2CT5lF76rDbA
Content-Type: multipart/mixed; boundary="=-P2jKTensT7nf9qJJkYFi"


--=-P2jKTensT7nf9qJJkYFi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 10:28 +0200, Martin Schlemmer wrote:
> On Thu, 2005-04-14 at 08:55 +0200, Martin Schlemmer wrote:
> > On Thu, 2005-04-14 at 00:19 +0200, Petr Baudis wrote:
> > > Dear diary, on Wed, Apr 13, 2005 at 02:15:37PM CEST, I got a letter
> > > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > > On Wed, 2005-04-13 at 11:26 +0200, Petr Baudis wrote:
> > > >> > Dear diary, on Wed, Apr 13, 2005 at 10:41:12AM CEST, I got a let=
ter
> > > > > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > > > > On Wed, 2005-04-13 at 09:54 +0200, Petr Baudis wrote:
> > > > > > PS: not having looked deeper yet, why does fsck-cache always fi=
nd
> > > > > > unreferenced blobs/commits (no matter what tree is tracked, the=
y stay
> > > > > > the same) ?  And trying to remove them leads to more, which lea=
ds to an
> > > > > > empty .git/opjects/ =3D)  Also, leading to this, will adding an=
 option to
> > > > > > remove disconnected commits/blobs from local commits (that was
> > > > > > disconnected with a pull) be a viable option to add?
> > > > >=20
> > > > > fsck-cache is concerned only by the objects database, so all the =
HEADs
> > > > > are unreferenced commits too. This is a right thing, the HEAD tra=
cking
> > > > > should stay purely in the scripts - if we want to make fsck-cache
> > > > > smarter about that, we should implement git fsck or something.
> > > > >=20
> > > > > Killing unreferenced blobs should be safe, I think.
> > > > >=20
> > > > > > First, about the 'git diff' thing I asked yesterday .. what I m=
eant, was
> > > > > > should it actually output this:
> > > > > >=20
> > > > > > ----
> > > > > > COPYING:  fe2a4177a760fd110e78788734f167bd633be8de 33
> > > > > > Makefile:  929aa49a3dbe683ad52094099797bc636a7949a6 33
> > > > > > README:  46c6a9ea48ddd1dda45ca585f49975a6869ffe51 33
> > > > > > ...
> > > > > > ----
> > > > > >=20
> > > > > > Shouldn't it just show actual changes?
> > > > >=20
> > > > > This is an actual change. It's just that it's a change to metadat=
a
> > > > > (somewhat esotherically described by the "33"), not the file cont=
ents.
> > > > >=20
> > > > > BTW, git diff does actually something completely different from g=
it diff
> > > > > with any arguments. It diffs to the directory cache, not to any t=
ree! It
> > > > > just wraps show-diff, which has also a different output format (n=
ot
> > > > > outputting "git diffs"). The worst thing is that it requires a di=
fferent
> > > > > -p option to apply. Someone should purge this wart, I think.
> > > > >=20
> > > >=20
> > > > Check applied patch (also in the new output).
> > >=20
> > > Please send patches inline and properly signed off.
> > >=20
> >=20
> > The new evo have a bad habit of screwing the tabs, but sure.
> >=20
> > > > > > Also on the same note .. should 'git ci' without listed files t=
o be
> > > > > > committed, really add a reference to all files as it currently =
do in the
> > > > > > commit/blob/whatever info, instead of just the changed/added fi=
les (see
> > > > > > the git-seperate-dir.patch you have not yet commented on for re=
ference)?
> > > > >=20
> > > > > ...
> > > > >=20
> > > >=20
> > > > Patch will also resolve this.
> > >=20
> > > Your patch is bad - it removes the pure metadata changes, but you
> > > definitively do not want to do that! If you are annoyed by meaningles=
s
> > > time changes etc, do update-cache --refresh. Ignoring mode changes is=
 a
> > > pure disaster.
> > >=20
> >=20
> > Ahh - and there was light.  I do not have a problem with the mode
> > changes - its just _all_ files was shown after tracked branch was
> > changed.  How about below patch?
> >=20
> > > > > > I know its in its infancy, but I am not sure on what scm you ar=
e basing
> > > > > > it, so not sure how things should behave.
> > > > >=20
> > > > > I'm trying to base it on common sense and principle of least surp=
rise.
> > > > > :-)
> > > > >=20
> > > >=20
> > > > Ok, I'll just bug you then if I am not sure on how you want somethi=
ng ;p
> > >=20
> > > Or do it somehow and I'll bug you back if I don't like it. ;-)
> > >=20
> >=20
> > Ditto
> >=20
> >=20
> > ----
> >=20
> > Normalize show-diff output and make sure we only show real changes afte=
r
> > changing the tracked branch.
> >=20
> > Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> >=20
>=20
> Ok, so I forgot to pull, and missed gitcancel.sh being added.
> How about this one?  (One attached in case evo is brain dead and mangles
> the tabs)
>=20

Urk, forgot the update-cache in gitcancel.sh, and prefix is wrong.  I am
not sure this is needed for gitexport.sh though?

----

Normalize show-diff output, add --update-modes target to update-cache,
and make sure we only show real changes after changing the tracked
branch, as well as update the file modes according to the cache.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
--- ec58f7444a42cd3cbaae919fc68c70a3866420c0/gitcancel.sh
+++ uncommitted/gitcancel.sh
@@ -12,7 +12,8 @@

 # FIXME: Does not revert mode changes!

-show-diff | patch -p0 -R
+show-diff | patch -p1 -R
 rm -f .git/add-queue .git/rm-queue .git/merged

-update-cache --refresh
+# --update-modes need to be before --refresh
+update-cache --update-modes --refresh
gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
--- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
+++ uncommitted/gittrack.sh
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
--- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
+++ uncommitted/show-diff.c
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
--- 62d0a6c41560d40863c44599355af10d9e089312/update-cache.c
+++ uncommitted/update-cache.c
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


--=-P2jKTensT7nf9qJJkYFi
Content-Disposition: attachment; filename=git-show-diff.patch
Content-Type: text/x-patch; name=git-show-diff.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Z2l0Y2FuY2VsLnNoOiAgZWM1OGY3NDQ0YTQyY2QzY2JhYWU5MTlmYzY4YzcwYTM4NjY0MjBjMA0K
LS0tIGVjNThmNzQ0NGE0MmNkM2NiYWFlOTE5ZmM2OGM3MGEzODY2NDIwYzAvZ2l0Y2FuY2VsLnNo
DQorKysgdW5jb21taXR0ZWQvZ2l0Y2FuY2VsLnNoDQpAQCAtMTIsNyArMTIsOCBAQA0KIA0KICMg
RklYTUU6IERvZXMgbm90IHJldmVydCBtb2RlIGNoYW5nZXMhDQogDQotc2hvdy1kaWZmIHwgcGF0
Y2ggLXAwIC1SDQorc2hvdy1kaWZmIHwgcGF0Y2ggLXAxIC1SDQogcm0gLWYgLmdpdC9hZGQtcXVl
dWUgLmdpdC9ybS1xdWV1ZSAuZ2l0L21lcmdlZA0KIA0KLXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gN
CisjIC0tdXBkYXRlLW1vZGVzIG5lZWQgdG8gYmUgYmVmb3JlIC0tcmVmcmVzaA0KK3VwZGF0ZS1j
YWNoZSAtLXVwZGF0ZS1tb2RlcyAtLXJlZnJlc2gNCmdpdHRyYWNrLnNoOiAgMDNkNmRiMWZiM2E3
MDYwNWVmMjQ5YzYzMmMwNGU1NDI0NTdmMDgwOA0KLS0tIDAzZDZkYjFmYjNhNzA2MDVlZjI0OWM2
MzJjMDRlNTQyNDU3ZjA4MDgvZ2l0dHJhY2suc2gNCisrKyB1bmNvbW1pdHRlZC9naXR0cmFjay5z
aA0KQEAgLTUxLDYgKzUxLDggQEANCiANCiAJcmVhZC10cmVlICQodHJlZS1pZCAiJG5hbWUiKQ0K
IAlnaXRkaWZmLnNoIGxvY2FsICIkbmFtZSIgfCBnaXRhcHBseS5zaA0KKwkjIC0tdXBkYXRlLW1v
ZGVzIG5lZWQgdG8gYmUgYmVmb3JlIC0tcmVmcmVzaA0KKwl1cGRhdGUtY2FjaGUgLS11cGRhdGUt
bW9kZXMgLS1yZWZyZXNoDQogDQogZWxzZQ0KIAlbICIkdHJhY2tpbmciIF0gfHwgXA0KQEAgLTYx
LDYgKzYzLDggQEANCiAJaWYgWyAtcyAiLmdpdC9IRUFELmxvY2FsIiBdOyB0aGVuDQogCQlnaXRk
aWZmLnNoICIkdHJhY2tpbmciIGxvY2FsIHwgZ2l0YXBwbHkuc2gNCiAJCXJlYWQtdHJlZSAkKHRy
ZWUtaWQgbG9jYWwpDQorCQkjIC0tdXBkYXRlLW1vZGVzIG5lZWQgdG8gYmUgYmVmb3JlIC0tcmVm
cmVzaA0KKwkJdXBkYXRlLWNhY2hlIC0tdXBkYXRlLW1vZGVzIC0tcmVmcmVzaA0KIA0KIAkJaGVh
ZD0kKGNhdCAuZ2l0L0hFQUQpDQogCQlicmFuY2hoZWFkPSQoY2F0IC5naXQvaGVhZHMvJHRyYWNr
aW5nKQ0Kc2hvdy1kaWZmLmM6ICBhNTMxY2E0MDc4NTI1ZDFjOGRjZjg0YWFlMGJmYTg5ZmVkNmU1
ZDk2DQotLS0gYTUzMWNhNDA3ODUyNWQxYzhkY2Y4NGFhZTBiZmE4OWZlZDZlNWQ5Ni9zaG93LWRp
ZmYuYw0KKysrIHVuY29tbWl0dGVkL3Nob3ctZGlmZi5jDQpAQCAtNSwxMyArNSwxOCBAQA0KICAq
Lw0KICNpbmNsdWRlICJjYWNoZS5oIg0KIA0KLXN0YXRpYyB2b2lkIHNob3dfZGlmZmVyZW5jZXMo
Y2hhciAqbmFtZSwNCitzdGF0aWMgdm9pZCBzaG93X2RpZmZlcmVuY2VzKHN0cnVjdCBjYWNoZV9l
bnRyeSAqY2UsDQogCXZvaWQgKm9sZF9jb250ZW50cywgdW5zaWduZWQgbG9uZyBsb25nIG9sZF9z
aXplKQ0KIHsNCiAJc3RhdGljIGNoYXIgY21kWzEwMDBdOw0KKwlzdGF0aWMgY2hhciBzaGExWzQx
XTsNCisJaW50IG47DQogCUZJTEUgKmY7DQogDQotCXNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCks
ICJkaWZmIC1MICVzIC11IC1OICAtICVzIiwgbmFtZSwgbmFtZSk7DQorCWZvciAobiA9IDA7IG4g
PCAyMDsgbisrKQ0KKwkJc25wcmludGYoJihzaGExW24qMl0pLCAzLCAiJTAyeCIsIGNlLT5zaGEx
W25dKTsNCisJc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgImRpZmYgLUwgJXMvJXMgLUwgdW5j
b21taXR0ZWQvJXMgLXUgLU4gIC0gJXMiLA0KKwkJc2hhMSwgY2UtPm5hbWUsIGNlLT5uYW1lLCBj
ZS0+bmFtZSk7DQogCWYgPSBwb3BlbihjbWQsICJ3Iik7DQogCWlmIChvbGRfc2l6ZSkNCiAJCWZ3
cml0ZShvbGRfY29udGVudHMsIG9sZF9zaXplLCAxLCBmKTsNCkBAIC05OSw3ICsxMDQsNyBAQA0K
IAkJCWNvbnRpbnVlOw0KIA0KIAkJbmV3ID0gcmVhZF9zaGExX2ZpbGUoY2UtPnNoYTEsIHR5cGUs
ICZzaXplKTsNCi0JCXNob3dfZGlmZmVyZW5jZXMoY2UtPm5hbWUsIG5ldywgc2l6ZSk7DQorCQlz
aG93X2RpZmZlcmVuY2VzKGNlLCBuZXcsIHNpemUpOw0KIAkJZnJlZShuZXcpOw0KIAl9DQogCXJl
dHVybiAwOw0KdXBkYXRlLWNhY2hlLmM6ICA2MmQwYTZjNDE1NjBkNDA4NjNjNDQ1OTkzNTVhZjEw
ZDllMDg5MzEyDQotLS0gNjJkMGE2YzQxNTYwZDQwODYzYzQ0NTk5MzU1YWYxMGQ5ZTA4OTMxMi91
cGRhdGUtY2FjaGUuYw0KKysrIHVuY29tbWl0dGVkL3VwZGF0ZS1jYWNoZS5jDQpAQCAtMjEwLDYg
KzIxMCwzOSBAQA0KIAl9DQogfQ0KIA0KK3N0YXRpYyBzdHJ1Y3QgY2FjaGVfZW50cnkgKnVwZGF0
ZV9maWxlX21vZGUoc3RydWN0IGNhY2hlX2VudHJ5ICpjZSkNCit7DQorCXN0cnVjdCBzdGF0IHN0
Ow0KKwlpbnQgY2hhbmdlZDsNCisNCisJaWYgKHN0YXQoY2UtPm5hbWUsICZzdCkgPCAwKQ0KKwkJ
cmV0dXJuIE5VTEw7DQorDQorCWNoYW5nZWQgPSBjYWNoZV9tYXRjaF9zdGF0KGNlLCAmc3QpOw0K
KwlpZiAoIWNoYW5nZWQpDQorCQlyZXR1cm4gY2U7DQorDQorCWlmIChjaGFuZ2VkICYgTU9ERV9D
SEFOR0VEKQ0KKwkJaWYgKGNobW9kKGNlLT5uYW1lLCBjZS0+c3RfbW9kZSkpDQorCQkJcmV0dXJu
IE5VTEw7DQorDQorCXJldHVybiBjZTsNCit9DQorDQorc3RhdGljIHZvaWQgdXBkYXRlX21vZGVz
KHZvaWQpDQorew0KKwlpbnQgaTsNCisNCisJZm9yIChpID0gMDsgaSA8IGFjdGl2ZV9ucjsgaSsr
KSB7DQorCQlzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlID0gYWN0aXZlX2NhY2hlW2ldOw0KKw0KKwkJ
aWYgKCF1cGRhdGVfZmlsZV9tb2RlKGNlKSkgew0KKwkJCXByaW50ZigiJXM6IG5lZWRzIHVwZGF0
ZVxuIiwgY2UtPm5hbWUpOw0KKwkJCWNvbnRpbnVlOw0KKwkJfQ0KKwl9DQorfQ0KKw0KIC8qDQog
ICogV2UgZnVuZGFtZW50YWxseSBkb24ndCBsaWtlIHNvbWUgcGF0aHM6IHdlIGRvbid0IHdhbnQN
CiAgKiBkb3Qgb3IgZG90LWRvdCBhbnl3aGVyZSwgYW5kIGluIGZhY3QsIHdlIGRvbid0IGV2ZW4g
d2FudA0KQEAgLTI4Miw2ICszMTUsMTAgQEANCiAJCQkJcmVmcmVzaF9jYWNoZSgpOw0KIAkJCQlj
b250aW51ZTsNCiAJCQl9DQorCQkJaWYgKCFzdHJjbXAocGF0aCwgIi0tdXBkYXRlLW1vZGVzIikp
IHsNCisJCQkJdXBkYXRlX21vZGVzKCk7DQorCQkJCWNvbnRpbnVlOw0KKwkJCX0NCiAJCQlkaWUo
InVua25vd24gb3B0aW9uICVzIiwgcGF0aCk7DQogCQl9DQogCQlpZiAoIXZlcmlmeV9wYXRoKHBh
dGgpKSB7DQo=


--=-P2jKTensT7nf9qJJkYFi--

--=-Ba4KE5Yq2CT5lF76rDbA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXiwBqburzKaJYLYRAiYVAJ9pzk74NekPYFzZ5Avy8YKTgE7MfACfcnMC
P6TR8aaTDwyHRiPx4YzbYyc=
=9hhE
-----END PGP SIGNATURE-----

--=-Ba4KE5Yq2CT5lF76rDbA--

