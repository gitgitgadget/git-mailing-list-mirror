From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sun, 04 Nov 2007 15:01:03 +0100
Message-ID: <20071104140103.GF26269@artemis.corp>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <20071104045800.GB12359@segfault.peff.net> <Pine.LNX.4.64.0711041313020.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oFbHfjnMgUMsrGjO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iog2Y-00017r-30
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbXKDOBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbXKDOBK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:01:10 -0500
Received: from pan.madism.org ([88.191.52.104]:43467 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503AbXKDOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:01:09 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6C265258FA;
	Sun,  4 Nov 2007 15:01:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 189B7435B33; Sun,  4 Nov 2007 15:01:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711041313020.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63404>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 01:13:40PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 4 Nov 2007, Jeff King wrote:
>=20
> > On Sat, Nov 03, 2007 at 01:32:48AM -0400, Nicolas Pitre wrote:
> >=20
> > > This makes the fetch output much more terse and prettier on a 80 colu=
mn=20
> > > display, based on a consensus reached on the mailing list.  Here's an=
=20
> > > example output:
> >=20
> > Thank you for this; it was at the end of a very long todo list for me.
> >=20
> > > Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> > > Resolving deltas: 100% (4604/4604), done.
> > > From git://git.kernel.org/pub/scm/git/git
> > >  ! [rejected]        html -> origin/html  (non fast forward)
> > >    136e631..f45e867  maint -> origin/maint  (fast forward)
> > >    9850e2e..44dd7e0  man -> origin/man  (fast forward)
> > >    3e4bb08..e3d6d56  master -> origin/master  (fast forward)
> > >    fa3665c..536f64a  next -> origin/next  (fast forward)
> > >  + 4f6d9d6...768326f pu -> origin/pu  (forced update)
> > >  * [new branch]      todo -> origin/todo
> >=20
> > One nice thing about this format is that it works equally well for
> > "push" (changing "From" to "To" and reversing the order of the
> > branches). Comments?
>=20
> I would like that, too.

  Seconded.

btw I believe that an even best attempt to align columns could be done

    Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
    Resolving deltas: 100% (4604/4604), done.
    From git://git.kernel.org/pub/scm/git/git
     ! [rejected]        html   -> origin/html   (non fast forward)
       136e631..f45e867  maint  -> origin/maint  (fast forward)
       9850e2e..44dd7e0  man    -> origin/man    (fast forward)
       3e4bb08..e3d6d56  master -> origin/master (fast forward)
       fa3665c..536f64a  next   -> origin/next   (fast forward)
     + 4f6d9d6...768326f pu     -> origin/pu     (forced update)
     * [new branch]      todo   -> origin/todo

This is way easier to read (for me at least).  Of course, perfect
alignment of the first column needs to know the lengths of refnames
prior to the fetch, which is not the case, and would be an overkill. A
10 char column looks quite ok to me.

I'd also argue that (fast forward) does not need to be mentioned after
the "if things work, say nothing"-unixish-philosophy. those
parenthesized words catch my attention, to read that it was a fast
forward after all. So my even preferred output would be:

    Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
    Resolving deltas: 100% (4604/4604), done.
    From git://git.kernel.org/pub/scm/git/git
     ! [rejected]        html      -> origin/html (non fast forward)
       136e631..f45e867  maint     -> origin/maint
       9850e2e..44dd7e0  man       -> origin/man
       3e4bb08..e3d6d56  master    -> origin/master
       fa3665c..536f64a  next      -> origin/next
     + 4f6d9d6...768326f pu        -> origin/pu (forced update)
     * [new branch]      todo      -> origin/todo

  Something like the following should do it.

Author: Pierre Habouzit <madcoder@debian.org>
Date:   Sun Nov 4 14:59:28 2007 +0100

    builtin-fetch: be even quieter, more column-formatting
   =20
    Signed-off-by: Pierre Habouzit <madcoder@debian.org>

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 12b1c4b..92d789f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -156,6 +156,7 @@ static int s_update_ref(const char *action,
 }
=20
 #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+#define REFCOL_WIDTH  10
=20
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
@@ -185,8 +186,9 @@ static int update_local_ref(struct ref *ref,
=20
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbose)
-			sprintf(display, "=3D %-*s %s -> %s", SUMMARY_WIDTH,
-				"[up to date]", remote, pretty_ref);
+			sprintf(display, "=3D %-*s %-*s -> %s", SUMMARY_WIDTH,
+				"[up to date]", REFCOL_WIDTH, remote,
+				pretty_ref);
 		return 0;
 	}
=20
@@ -198,15 +200,17 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		sprintf(display, "! %-*s %s -> %s  (can't  fetch in current branch)",
-			SUMMARY_WIDTH, "[rejected]", remote, pretty_ref);
+		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)",
+			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+			pretty_ref);
 		return 1;
 	}
=20
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		sprintf(display, "- %-*s %s -> %s",
-			SUMMARY_WIDTH, "[tag update]", remote, pretty_ref);
+		sprintf(display, "- %-*s %-*s -> %s",
+			SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
+			pretty_ref);
 		return s_update_ref("updating tag", ref, 0);
 	}
=20
@@ -224,8 +228,8 @@ static int update_local_ref(struct ref *ref,
 			what =3D "[new branch]";
 		}
=20
-		sprintf(display, "* %-*s %s -> %s",
-			SUMMARY_WIDTH, what, remote, pretty_ref);
+		sprintf(display, "* %-*s %-*s -> %s", SUMMARY_WIDTH, what,
+			REFCOL_WIDTH, remote, pretty_ref);
 		return s_update_ref(msg, ref, 0);
 	}
=20
@@ -234,20 +238,21 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV=
));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-		sprintf(display, "  %-*s %s -> %s  (fast forward)",
-			SUMMARY_WIDTH, quickref, remote, pretty_ref);
+		sprintf(display, "  %-*s %-*s -> %s", SUMMARY_WIDTH, quickref,
+			REFCOL_WIDTH, remote, pretty_ref);
 		return s_update_ref("fast forward", ref, 1);
 	} else if (force || ref->force) {
 		char quickref[84];
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV=
));
 		strcat(quickref, "...");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-		sprintf(display, "+ %-*s %s -> %s  (forced update)",
-			SUMMARY_WIDTH, quickref, remote, pretty_ref);
+		sprintf(display, "+ %-*s %-*s -> %s  (forced update)",
+			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote, pretty_ref);
 		return s_update_ref("forced-update", ref, 1);
 	} else {
-		sprintf(display, "! %-*s %s -> %s  (non fast forward)",
-			SUMMARY_WIDTH, "[rejected]", remote, pretty_ref);
+		sprintf(display, "! %-*s %-*s -> %s  (non fast forward)",
+			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+			pretty_ref);
 		return 1;
 	}
 }

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLdCfvGr7W6HudhwRArcYAJ4sb7uMiVl/QSiU39zlKtv97CYspwCgjFb2
gEEP2sU/0AlELRdlsjd/vRU=
=GP65
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
