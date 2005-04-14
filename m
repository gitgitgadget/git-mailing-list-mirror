From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 08:55:54 +0200
Message-ID: <1113461754.23299.68.camel@nosferatu.lan>
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
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZLrf7HKObLjjkJMlLMJc"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 08:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLyAs-0000V9-UP
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 08:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVDNGxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 02:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVDNGxL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 02:53:11 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:29608 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261439AbVDNGwQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 02:52:16 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id 319DE6493;
	Thu, 14 Apr 2005 08:52:08 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id F2B543A26DB;
	Thu, 14 Apr 2005 08:58:12 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07258-12; Thu, 14 Apr 2005 08:58:06 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id ABF5C3A26DA;
	Thu, 14 Apr 2005 08:58:06 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050413221936.GI25711@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ZLrf7HKObLjjkJMlLMJc
Content-Type: multipart/mixed; boundary="=-FK3a23QLTYlCmbm5M/w/"


--=-FK3a23QLTYlCmbm5M/w/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 00:19 +0200, Petr Baudis wrote:
> Dear diary, on Wed, Apr 13, 2005 at 02:15:37PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > On Wed, 2005-04-13 at 11:26 +0200, Petr Baudis wrote:
> >> > Dear diary, on Wed, Apr 13, 2005 at 10:41:12AM CEST, I got a letter
> > > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > > On Wed, 2005-04-13 at 09:54 +0200, Petr Baudis wrote:
> > > > PS: not having looked deeper yet, why does fsck-cache always find
> > > > unreferenced blobs/commits (no matter what tree is tracked, they st=
ay
> > > > the same) ?  And trying to remove them leads to more, which leads t=
o an
> > > > empty .git/opjects/ =3D)  Also, leading to this, will adding an opt=
ion to
> > > > remove disconnected commits/blobs from local commits (that was
> > > > disconnected with a pull) be a viable option to add?
> > >=20
> > > fsck-cache is concerned only by the objects database, so all the HEAD=
s
> > > are unreferenced commits too. This is a right thing, the HEAD trackin=
g
> > > should stay purely in the scripts - if we want to make fsck-cache
> > > smarter about that, we should implement git fsck or something.
> > >=20
> > > Killing unreferenced blobs should be safe, I think.
> > >=20
> > > > First, about the 'git diff' thing I asked yesterday .. what I meant=
, was
> > > > should it actually output this:
> > > >=20
> > > > ----
> > > > COPYING:  fe2a4177a760fd110e78788734f167bd633be8de 33
> > > > Makefile:  929aa49a3dbe683ad52094099797bc636a7949a6 33
> > > > README:  46c6a9ea48ddd1dda45ca585f49975a6869ffe51 33
> > > > ...
> > > > ----
> > > >=20
> > > > Shouldn't it just show actual changes?
> > >=20
> > > This is an actual change. It's just that it's a change to metadata
> > > (somewhat esotherically described by the "33"), not the file contents=
.
> > >=20
> > > BTW, git diff does actually something completely different from git d=
iff
> > > with any arguments. It diffs to the directory cache, not to any tree!=
 It
> > > just wraps show-diff, which has also a different output format (not
> > > outputting "git diffs"). The worst thing is that it requires a differ=
ent
> > > -p option to apply. Someone should purge this wart, I think.
> > >=20
> >=20
> > Check applied patch (also in the new output).
>=20
> Please send patches inline and properly signed off.
>=20

The new evo have a bad habit of screwing the tabs, but sure.

> > > > Also on the same note .. should 'git ci' without listed files to be
> > > > committed, really add a reference to all files as it currently do i=
n the
> > > > commit/blob/whatever info, instead of just the changed/added files =
(see
> > > > the git-seperate-dir.patch you have not yet commented on for refere=
nce)?
> > >=20
> > > ...
> > >=20
> >=20
> > Patch will also resolve this.
>=20
> Your patch is bad - it removes the pure metadata changes, but you
> definitively do not want to do that! If you are annoyed by meaningless
> time changes etc, do update-cache --refresh. Ignoring mode changes is a
> pure disaster.
>=20

Ahh - and there was light.  I do not have a problem with the mode
changes - its just _all_ files was shown after tracked branch was
changed.  How about below patch?

> > > > I know its in its infancy, but I am not sure on what scm you are ba=
sing
> > > > it, so not sure how things should behave.
> > >=20
> > > I'm trying to base it on common sense and principle of least surprise=
.
> > > :-)
> > >=20
> >=20
> > Ok, I'll just bug you then if I am not sure on how you want something ;=
p
>=20
> Or do it somehow and I'll bug you back if I don't like it. ;-)
>=20

Ditto


----

Normalize show-diff output and make sure we only show real changes after
changing the tracked branch.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gittrack.sh:  a9d7c3d117390787e562a0450deb14c7cbf4b565 33
--- a9d7c3d117390787e562a0450deb14c7cbf4b565/gittrack.sh
+++ uncommitted/gittrack.sh
@@ -49,6 +49,7 @@

        read-tree $(tree-id "$name")
        gitdiff.sh local "$name" | gitapply.sh
+       update-cache --refresh

 else
        [ "$tracking" ] || \
@@ -59,6 +60,7 @@
        if [ -s ".git/HEAD.local" ]; then
                gitdiff.sh "$tracking" local | gitapply.sh
                read-tree $(tree-id local)
+               update-cache --refresh

                head=3D$(cat .git/HEAD)
                branchhead=3D$(cat .git/HEAD.$tracking)
show-diff.c:  136ec315b82d10d33ff9b4517f1b8ab91e3dcabc 33
--- 136ec315b82d10d33ff9b4517f1b8ab91e3dcabc/show-diff.c
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
@@ -98,7 +103,7 @@

                fflush(stdout);
                new =3D read_sha1_file(ce->sha1, type, &size);
-               show_differences(ce->name, new, size);
+               show_differences(ce, new, size);
                free(new);
        }
        return 0;


--=20
Martin Schlemmer


--=-FK3a23QLTYlCmbm5M/w/
Content-Disposition: attachment; filename=git-show-diff.patch
Content-Type: text/x-patch; name=git-show-diff.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Z2l0dHJhY2suc2g6ICBhOWQ3YzNkMTE3MzkwNzg3ZTU2MmEwNDUwZGViMTRjN2NiZjRiNTY1IDMz
DQotLS0gYTlkN2MzZDExNzM5MDc4N2U1NjJhMDQ1MGRlYjE0YzdjYmY0YjU2NS9naXR0cmFjay5z
aA0KKysrIHVuY29tbWl0dGVkL2dpdHRyYWNrLnNoDQpAQCAtNDksNiArNDksNyBAQA0KIA0KIAly
ZWFkLXRyZWUgJCh0cmVlLWlkICIkbmFtZSIpDQogCWdpdGRpZmYuc2ggbG9jYWwgIiRuYW1lIiB8
IGdpdGFwcGx5LnNoDQorCXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCiANCiBlbHNlDQogCVsgIiR0
cmFja2luZyIgXSB8fCBcDQpAQCAtNTksNiArNjAsNyBAQA0KIAlpZiBbIC1zICIuZ2l0L0hFQUQu
bG9jYWwiIF07IHRoZW4NCiAJCWdpdGRpZmYuc2ggIiR0cmFja2luZyIgbG9jYWwgfCBnaXRhcHBs
eS5zaA0KIAkJcmVhZC10cmVlICQodHJlZS1pZCBsb2NhbCkNCisJCXVwZGF0ZS1jYWNoZSAtLXJl
ZnJlc2gNCiANCiAJCWhlYWQ9JChjYXQgLmdpdC9IRUFEKQ0KIAkJYnJhbmNoaGVhZD0kKGNhdCAu
Z2l0L0hFQUQuJHRyYWNraW5nKQ0Kc2hvdy1kaWZmLmM6ICAxMzZlYzMxNWI4MmQxMGQzM2ZmOWI0
NTE3ZjFiOGFiOTFlM2RjYWJjIDMzDQotLS0gMTM2ZWMzMTViODJkMTBkMzNmZjliNDUxN2YxYjhh
YjkxZTNkY2FiYy9zaG93LWRpZmYuYw0KKysrIHVuY29tbWl0dGVkL3Nob3ctZGlmZi5jDQpAQCAt
NSwxMyArNSwxOCBAQA0KICAqLw0KICNpbmNsdWRlICJjYWNoZS5oIg0KIA0KLXN0YXRpYyB2b2lk
IHNob3dfZGlmZmVyZW5jZXMoY2hhciAqbmFtZSwNCitzdGF0aWMgdm9pZCBzaG93X2RpZmZlcmVu
Y2VzKHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UsDQogCXZvaWQgKm9sZF9jb250ZW50cywgdW5zaWdu
ZWQgbG9uZyBsb25nIG9sZF9zaXplKQ0KIHsNCiAJc3RhdGljIGNoYXIgY21kWzEwMDBdOw0KKwlz
dGF0aWMgY2hhciBzaGExWzQxXTsNCisJaW50IG47DQogCUZJTEUgKmY7DQogDQotCXNucHJpbnRm
KGNtZCwgc2l6ZW9mKGNtZCksICJkaWZmIC1MICVzIC11IC1OICAtICVzIiwgbmFtZSwgbmFtZSk7
DQorCWZvciAobiA9IDA7IG4gPCAyMDsgbisrKQ0KKwkJc25wcmludGYoJihzaGExW24qMl0pLCAz
LCAiJTAyeCIsIGNlLT5zaGExW25dKTsNCisJc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgImRp
ZmYgLUwgJXMvJXMgLUwgdW5jb21taXR0ZWQvJXMgLXUgLU4gIC0gJXMiLA0KKwkJc2hhMSwgY2Ut
Pm5hbWUsIGNlLT5uYW1lLCBjZS0+bmFtZSk7DQogCWYgPSBwb3BlbihjbWQsICJ3Iik7DQogCWlm
IChvbGRfc2l6ZSkNCiAJCWZ3cml0ZShvbGRfY29udGVudHMsIG9sZF9zaXplLCAxLCBmKTsNCkBA
IC05OCw3ICsxMDMsNyBAQA0KIA0KIAkJZmZsdXNoKHN0ZG91dCk7DQogCQluZXcgPSByZWFkX3No
YTFfZmlsZShjZS0+c2hhMSwgdHlwZSwgJnNpemUpOw0KLQkJc2hvd19kaWZmZXJlbmNlcyhjZS0+
bmFtZSwgbmV3LCBzaXplKTsNCisJCXNob3dfZGlmZmVyZW5jZXMoY2UsIG5ldywgc2l6ZSk7DQog
CQlmcmVlKG5ldyk7DQogCX0NCiAJcmV0dXJuIDA7DQo=


--=-FK3a23QLTYlCmbm5M/w/--

--=-ZLrf7HKObLjjkJMlLMJc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXhP6qburzKaJYLYRAg3zAJ0bxu/wllxSLEHpnbKnWfPY46yCHACfTLBh
0Q2EEsUWRmHLJEeSXQsA/JY=
=wKFZ
-----END PGP SIGNATURE-----

--=-ZLrf7HKObLjjkJMlLMJc--

