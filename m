From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 23:18:56 +0200
Message-ID: <20050918211855.GA1463@schottelius.org>
References: <Pine.LNX.4.63.0509181201220.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:20:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH6ZY-0005Qk-VY
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 23:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIRVTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 17:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVIRVTi
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 17:19:38 -0400
Received: from wg.technophil.ch ([213.189.149.230]:44442 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932206AbVIRVTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 17:19:37 -0400
Received: (qmail 1744 invoked by uid 1000); 18 Sep 2005 21:18:56 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509181201220.23242@iabervon.org> <20050918145434.GA22391@pasky.or.cz> <94fc236b050918073351075bb4@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8810>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

First of all, thanks for that many very good explaining answers.

I'll try to answer all questions/suggestions in one mail
(I hope your MUA supports threading when one e-mail has several In-Reply-To=
s ;-),
still in respect to the good answers, ripping them out to make the mail sho=
rt.

Adrien Beau [Sun, Sep 18, 2005 at 04:33:05PM +0200]:
> [fetch/send]

Got to know the terminology, although every SCM/VCS has a different one :)

> [...]
> In that case, you can ask to transfer one or many refs. All the
> objects that need transfering are packed and then sent. The transfer
> can be local, over SSH, or over a custom Git protocol.

May I ask, how the git-protocol works or may you point me to a document
describing it?

> Note that there is a problem if a Git-unaware daemon is used on the
> server (typical in the case of HTTP and rsync). If someone pulls while
> a push is in progress, references to not-yet-uploaded objects can be
> retrieved.

Well, this will most likely happen often or how do you normally publish
your famous .git-directory?

> > - the documentation is not in sync with the programm (0.99.5 vs. 0.99.6)
>=20
> Actually, the documentation is mostly in sync with the programs,
> except for that version number. There's still room for improvements
> though, patches welcome, or so I've heard.

[22:29] hydrogenium:git-core-0.99.6% ls git-update-*
git-update-cache  git-update-server-info

http://www.kernel.org/pub/software/scm/git/docs/tutorial.html (v0.99.5, Aug=
 2005):

"The first step is trivial: when you want to tell git about any changes to =
your working tree, you use the git-update-index program."

Petr Baudis [Sun, Sep 18, 2005 at 04:54:34PM +0200]:
> [many fixes]

thanks for the fast response!

Daniel Barkalow [Sun, Sep 18, 2005 at 12:56:21PM -0400]:
> >    o excluding *.o seems not to work, neither through .gitignore nor th=
rough
> >      .git/info/exlude
> > - How do I check integrity of files, is signed files somehow implemente=
d?
> >=20
> > I've written some notes down in
> >    http://creme.schottelius.org/~nico/temp/git-erfahrungen
>=20
> (Now at .../git-erfahrungen01)

Sorry, yes, had to move it there, because I wanted to add new experiences
to a new file. It's now 'linked'.

> It looks like you managed to be using an *older* version than the=20
> documentation; git-update-index is the new name, not the old one. I'm not=
=20
> sure how that happened, but I'd guess a "make install" bug or a PATH issu=
e=20
> or something.

See above, if you need more information, tell me.

> Core git doesn't have a .git/info/excludes at all. (And, in general,=20
> .gitignore makes more sense, I think, because you usually want this to be=
=20
> version-controlled; but maybe there should be .git/info/excludes as a=20
> default for new directories?)

So, this is not really clear :)

> .git/description is actually a gitweb feature, not a core git feature.=20
> You'd only set it up for public repositories that you want to describe.

That does not fit to what I see here:

[22:46] hydrogenium:gpm% git-init-db=20
defaulting to local storage area
[22:46] hydrogenium:gpm% ls .git=20
branches  description  HEAD  hooks  info  objects  refs  remotes

> I'd be much obliged if you could tell me where the documentation lost you=
;=20
> it's really hard to document effectively without the assistance of someon=
e=20
> who doesn't already know the program.

Well, my way was:

- find git [http://www.kernel.org/pub/software/scm/git/]
- find documentation [http://www.kernel.org/pub/software/scm/git/docs/]
- find step-by-step doc
   [http://www.kernel.org/pub/software/scm/git/docs/tutorial.html]

So far so fine, than I found the git-update-index/cache thing, which confus=
ed
me, I was not sure, whether this documentation fits only partly to git
or absolutely not. Still, I was continuing with git-update-cache.

Than I saw the examples creating-section and was bored, because I simply
want to test git with cinit.

A `find .git` showed what files exist to me before, so git-cat-file
and co. where not so interesting.

I wanted to know, how to add all files from cinit. Then I was searching
for recursive adding, with exclusion. I did not get that easily
work with git-add-script. So I was searching through the git main
documentation, found cogito and the hint not to use directly. Fine, let's
try cogito.

It look(s|ed) much easier, but had some errors (which pasky now fixed).

Than I tried gitweb.cgi, which seems to have a small bug validating input:

   if ($input =3D~ m/(^|\/)(|\.|\.\.)($|\/)/) {

This also matches a cLinux/cinit.git as far as I can see.
I use '(^|\/)(\.\.|\.)($|\/)' currently, but I am not totally sure, whether
this is correct.

You can see the original version on
http://linux.schottelius.org/cgi-bin/gitweb-orig.cgi
and my modified version on
http://linux.schottelius.org/cgi-bin/gitweb.cgi

But perhaps the logic in gitweb.cgi should be changed:

[...]
if (defined $project) {
   $project =3D validate_input($project);
   if (!defined($project)) {
      die_error(undef, "Invalid project parameter.");
   }
   if (!(-d "$projectroot/$project")) {
      undef $project;
      die_error(undef, "No such directory.");
   }
[...]

Instead of using -d at this section, one should test, whether the project
is in the list of projects. A simple loop through the array
git_read_projects() returns should be enough.

> ".git/remotes" is the current one; ".git/branches" is obsolete.

Will .git/branches be complety removed later?

Hopefully some of you are now as confused as I've been,

Good night,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQy3Zv7OTBMvCUbrlAQIcwQ//d05HPaLbOlBdMU3UBOTjQ4JEj/fp5Nnf
ua/L2AsAlO/etdPtyite7AtQjVTgr1ffOuCugB4RTzM2XP7rngndc2RsU9wwYrvP
Tr392HX90Luhi+sIr0ZwgHs0szUpmlDllko9IiDfd81IKOeb3rFt+3gaRhkoj6Fn
XhcIaHv089hinyE0CkZUMaqG9q69M4iGZ1p3JnW3a5RyhjagdQd1wG/JLD5wX7PT
cAFuCOdG3M+96e3K9y1x08Nof0IuvCUODtHNGpDKfqLUkSjO5D6fpQx9r8kpHDRm
4rgLdS5mowTo+BK9CIv7Cyi0fAcOlphVpItArUm2e7lw5WtMOvncKqAiRQxe6s4a
NSnV4YMrHxPJr3ewIgpnAXktg7ss6zQE6yFa07c5r57rk10InRZo4AnRVn70rHBW
2NaCLk9rPmO9Qku1ihQsbr6tj+FIcoSSSSru8PQJqedzKCr5xzbjF09TlAIjTKxZ
q/dYWBGg4szsyFnG4doy1vvkyzNzZZYzeulnPaD/IjoCTYkwlR9BvmuzmER17ZVt
aGkkSEXCgYuwd3whRIdCyShfELZegIddb1Pi1l9nvXHLAuCoycD4ZS8frbAZpMaZ
lz5riB3ENQGjXW+C72cN3Qw7v8BvhAnhc3RKC5alD3qMTF2adERkw047J2Ubd3w4
9s5dtTKXnRc=
=NOhe
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
