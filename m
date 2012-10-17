From: Peter Todd <pete@petertodd.org>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Wed, 17 Oct 2012 04:05:30 -0400
Message-ID: <20121017080530.GA6676@savin>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
 <20121016173254.GD27243@sigill.intra.peff.net>
 <20121016175806.GB26650@thunk.org>
 <20121016182751.GA30010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 10:22:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOOtH-0001xu-FV
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 10:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab2JQIV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 04:21:58 -0400
Received: from outmail148161.authsmtp.com ([62.13.148.161]:60708 "EHLO
	outmail148161.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735Ab2JQIVy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2012 04:21:54 -0400
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2012 04:21:54 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt6.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id q9H85esd081990;
	Wed, 17 Oct 2012 09:05:40 +0100 (BST)
Received: from savin (206-248-185-14.dsl.teksavvy.com [206.248.185.14])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id q9H85Uqn081257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Oct 2012 09:05:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20121016182751.GA30010@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Server-Quench: 6db28cbb-1831-11e2-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd2Yg0TA1ZNQRgX IjsJECJaVQIpKltL GxAVKBZePFsRUQkR YgdMdwUUF1YAAgsB AmQbW11eUFh7Wmc7 aQpXcwdZalRPVwB0 UUxWR1pVCwQmQBV5 Dht7E0dyfwREfXk+ Y0NkWXMVWhAod04u EBxJFGUFZHphaTUd TUhYJQpJcANIfBlB agJ3XHBYLwdSbGoH HwI1dw8wOTEXFykd eQwAZXkVRUIKBT87 QQtKEzI1VXYlbmBq eFRmA1hUHUANP18/ KkcgX11QOhkbDhxF HlovSCVIb3MbWiEm RThRXUgTETBHAE8A 
X-Authentic-SMTP: 61633532353630.1015:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 206.248.185.14/587
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207904>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2012 at 02:27:51PM -0400, Jeff King wrote:
> > The one reason why we *might* want to use SHA-3, BTW, is that it is a
> > radically different design from SHA-1 and SHA-2.  And if there is a
> > crypto hash failure which is bad enough that the security of git would
> > be affected, there's a chance that the same attack could significantly
> > affect SHA-2 as well.  The fact that SHA-3 is fundamentally different
> > from a cryptographic design perspective means that an attack that
> > impacts SHA-1/SHA-2 will not likely impact SHA-3, and vice versa.
>=20
> Right. The point of having the SHA-3 contest was that we thought SHA-1's
> breakage meant that SHA-2 was going to fall next. But Schneier's
> comments before the winners were announced were basically "it turns out
> that SHA-2 is not broken like we thought, so there's no reason to ditch
> it, and the fact that it is well-studied and well-deployed may mean it's
> a good choice".
>=20
> So I could go either way. This is not a decision we should make today,
> though, so we can wait and see which direction the world goes before
> picking an algorithm.

Do you really need to pick an algorithm and go through a full-on flag
day ten years down the road all over again? People don't really care
that a git revision is actually the hex-encoded SHA1 hash of a tree.
They just know it's this long string of "stuff" that uniquely identifies
a revison globally somehow. They know if they copy and paste the first
few characters of the string there is a small chance two revisions will
have the same first few characters, and if they copy and paste the whole
string the chance drops to "you're whole dev team will be eaten by
wolves in tragic unrelated incidences" unlikely.

So why bake in a single algorithm? We'll have to extend the length of a
whole revision string anyway - the alternatives start at 256bits - and
people are going to want to be able to specify the whole revision string
at least sometimes. Once you've gone through that pain, why have to
repeat it again in ten years?


Let's make revisions be a long but variable length string. A revision by
itself is meaningless of course. However if if you know of a repo that
contains that revision, you can convert it into something useful, like a
commit and associated tree. If you don't know, well, you'd be stuck
anyway right now.=20

Now when you push and pull from a remote repo what'll happen is the repo
will figure out what type(s) of hash algorithm your client supports. A
Git 3000 user with a repo using SHA3072 can talk to a v0.1 client just
fine: they send the v0.1 client revisions calculated with an algorithm
they support, and when they pull revisions from that repo they calculate
new revisions with their preferred algorithm. If they want to do this a
lot, they maintain the two sets of digest tables next to each other,
with the SHA3072 table marked as preferred, and the rest kept only so
pushes and pulls can be fast. In most cases a project will convert to
one hash algorithm, but by having multi-hash support that conversion
doesn't have to be a flag day, and at the same time it's still easy to
lookup old revisions by their old digests. Meanwhile the crypto-wonks
get to have their fun PGP signing and timestamping long, secure digests.

Note that we don't even have to shut out non-upgraded users from
participating. Machine-to-machine communication is not a problem as
outlined above, but even with stuff like mailing lists we can start
passing around concatenated revisions like the following:=20

da39a3ee5e6b4b0d3255bfef95601890afd80709.e3b0c44298fc1c149afbf4c8996fb92427=
ae41e4649b934ca495991b7852b855

Old users just use the first bit. (the period isn't even required
really) If you think that's too long, there's a simple solution that
keeps <your requirements>-bit security, albeit one whose implications
lead you right to Linus's lines of thinking:

da39a3ee5e6b4b0d3255bfef95601890afd80709

That's just a SHA1 again. Of course, if you actually care about this
stuff you already have cryptographic infrastructure, and that
infrastructure can simply store *trusted* metadata in you're repos
saying that the string 'foo' happens to be a valid alias for the actual
digest that *the user* can specify instead of that digest. It may even
be that for your security needs just timestamping those aliases is
enough. Either way while something needs to be calculating secure
hashes, and preferably Git mainline so push and pull works without
having to examine every last line of code, you can get away without
changing the UI very much.


Anyway, in the short term the people who care can write parallel digest
calculators; I personally have a use-case for one right now. Better code
to handle the cases where individual blobs have colliding hashes is
required as well in the medium term. Finally those who require it could
very well write parallel git's to effectively do the pulling and pushing
of their parallel calculated revision hashes if they really wanted too.

But if this problem gets to the point where git-core has to change the
reality is organizations are not going to be happy if it has to be a big
flag day. Git v2/v3 interoperability *will* be implemented. Once we're
at that point, let's make sure Git 5.0's big feature isn't SHA5000.=20

--=20
'peter'[:-1]@petertodd.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJQfmbJAAoJEH+rEUJn5PoEkbUH/i+k5ahYl/hJ1bGmXF0h7c4+
pEtPconACRxxRc3ZAyVK3+RkZurgOzJ/+3pgTkH5bSDIEWLT0Vj8LFRjh6LxfJ22
oeegcMI6FvBq/aXWG2rxaysyDzF7MZwu7yGcBWL5J9D9oZRv0J2R9D7gmtRgtOch
ns+FvGY5a35DnRtC1nhOFpQNpVrsatDNMKc38apBwua8F2Fx+7eykOn7iDlt6oqm
fi68Wha8rgWpdjEW6qHePYlS460LCzXDAxMlQGR3yl1ohoE9+Q709iK+cw8gnBs0
9wRZs7sH95xLuxjk9S78IcohSlpwU/EqWlj5rV7h01vI2KzLGQ6Kk3lz22ILbrU=
=zh7h
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
