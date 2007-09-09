From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Sun, 09 Sep 2007 02:37:18 +0200
Message-ID: <20070909003718.GE13385@artemis.corp>
References: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz> <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz> <fbsbul$dg0$1@sea.gmane.org> <46E3354A.7030407@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HnQK338I3UIa/qiP";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOE-0003oI-LE
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:34 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAtS-0002IZ-E5
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:43:18 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAtL-000380-Rt
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbXIIAhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbXIIAhV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:37:21 -0400
Received: from pan.madism.org ([88.191.52.104]:52396 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbXIIAhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:37:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BF5271EB29;
	Sun,  9 Sep 2007 02:37:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 419F43033; Sun,  9 Sep 2007 02:37:18 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46E3354A.7030407@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.8, required=12.0, autolearn=disabled, AWL=1.174,UIO_VGER=-3)
X-UiO-Scanned: 5EE90409EF8F227A09583B425FF542A8247A4EAD
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -17 maxlevel 200 minaction 2 bait 0 mail/h: 30 total 517816 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58151>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2007 at 11:50:34PM +0000, Andreas Ericsson wrote:
> Walter Bright wrote:
> > David Kastrup wrote:
> > > Again, C won't keep you from shooting yourself in the foot.
> > Right, it won't. A good systems language should do what it can to=20
> > prevent the programmer from *inadvertently* shooting himself in the=20
> > foot, while allowing him to *deliberately* shoot himself in the foot.
>
> No, a good systems language should do exactly what it's told.
> Supporting tools should tell the programmer if he's risking shooting
> himself in the foot.

  I beg to differ. I mean, knowing enough of D, I think that what Walter
tries to say is that a good language should provide constructions that
when used prevent the programmer to shoot himself in both foot at the
same time.

  D supports most of the C constructions, so when you want to juggle
with razor blades, you're free to do so in D. Though, the language
provides idioms that prevent you to write stupid mistakes when used. And
that is great.

  D is not Java, you have pointers, you can deal with memory
explicitely, you can do whatever you can do in C with no or very little
overhead. Or you can use higher level D, at your own discretion.

> > > You can tell C compilers to
> > > check all array accesses, but that is a performance issue.
> > Runtime checking of arrays in D is a performance issue too, so it is=20
> > selectable via a command line switch.
>
> Same as in C then.

  HAHAHAHAHAHA. Please, who do you try to convince here ? Except in the
local scope, there is few differences between a foo* and a foo[] in C.

> > But more importantly,
> > 2) For dynamically sized arrays, the dimension of the array is carried
> > with the array, so loops automatically loop the correct number of times.
> > No runtime check is necessary, and it's easier for the code reviewer to
> > visually check the code for correctness.
>
> But this introduces handy but, strictly speaking, unnecessary overhead
> as well, meaning, in short; 'D is slower than C, but easier to write
> code in'.

  That's BS. See the strbuf API I've been pushing recently ? It has
simplified git's code a lot, because each time git had to deal with a
growing string, it had to deal with at least three variables: the buffer
pointer, the current occupied length, and its allocated size. That was
three thing to have variable names for, and to pass to functions.

  Now instead, it's just one struct. D gives that gratis. There is no
performance loss because you _need_ to do the same. How do you deal with
dynamic arrays if you dont't store their lenght and size somewhere ? Or
are you the kind of programmer that write:

  /* 640kb should be enough for everyone=E2=80=A6 */
  some_type *array =3D malloc(640 << 10);


> So in essence, it's a bit like Python, but a teensy bit faster and a
> lot easier to shoot yourself in the foot with.

> What was the niche you were going for when you thought up D? It can't
> have been systems programming, because *any* extra baggage is baggage
> one would like to get rid of. If it was application programming I fail
> to see how one more language would help, as there will be portability
> problems galore and it's still considerably slower to develop in than
> fe Python, while at the same time being considerably easier to mess up
> in.

  Right now I'm just laughing. There is for sure overheads in some
places of D, but the example you take, and what you try to attack in D
is definitely not where you lose any kind of performance. You could have
attacked the GC instead (which is after all an easy classical target).

  Just to evaluate the silliness of your arguments:
  * http://www.digitalmars.com/d/comparison.html so that you can tell
    what the D features really are,
  * http://shootout.alioth.debian.org/gp4/benchmark.php?test=3Dall&lang=3Da=
ll
    so that you can know what the D performance really is about. Of
    course those are only micro benchmarks, but well, python is "just"
    15 times slower than D, and D seems to be 10% slower. Well then I'm
    okay with D, I'm ready to buy 10% faster CPUs and avoid a lot of
    painful debugging time. In my world, 10% faster hardware is cheaper
    by many orders of magnitude than skilled programmers, but YMMV.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG40A+vGr7W6HudhwRAhKMAJ0XpvMG3ae11PguF6stAdfrGUn6mACfUwXB
+iq9MqhY2hPQUnWGCmUdsE4=
=ixoG
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
