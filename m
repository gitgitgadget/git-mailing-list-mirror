From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Fri, 16 Sep 2005 00:08:12 +0200
Message-ID: <1126822093.27951.74.camel@localhost>
References: <7255.1126583985@kao2.melbourne.sgi.com>
	 <1126674993.5681.9.camel@localhost.localdomain>
	 <1126745323.7199.3.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
	 <43290486.5020301@zytor.com> <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net>
	 <u5tvf12sp1v.fsf@lysator.liu.se>
	 <Pine.LNX.4.58.0509150905070.26803@g5.osdl.org>
	 <u5toe6uql1w.fsf@lysator.liu.se>
	 <Pine.LNX.4.58.0509151106200.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?ISO-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 16 00:10:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG1uB-0005Al-LF
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVIOWI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 18:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVIOWI1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:08:27 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:35535 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S932274AbVIOWI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 18:08:26 -0400
Received: from p54a21a4c.dip0.t-ipconnect.de ([84.162.26.76] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.52)
	id 1EG1u1-0007qq-RP; Fri, 16 Sep 2005 00:08:22 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1EG1tu-0006re-Ar; Fri, 16 Sep 2005 00:08:14 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151106200.26803@g5.osdl.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8645>

On Thu, 2005-09-15 at 11:15 -0700, Linus Torvalds wrote:
>=20
> On Thu, 15 Sep 2005, David K=E5gedal wrote:
> >=20
> > No, you read my message wrong, or I failed to describe it properly.
>=20
> No, I did get it.
>=20
> It's the Debian people who don't get it.
>=20
> Expecting other software projects to make cludges for Debian-specific=
=20
> packages is _insane_.

Actually according to Debian policy, sensible-pager is a cludge which
should be used _only_ in the case that the upstream program is hard to
adapt to a PAGER environment approach. Only in this case the upstream
package should be patched to at least use sensible-pager.

>=20
> In other word, no sane package will ever use "sensible-pager", becaus=
e
> it's not a sensible thing to do. Once Debian maintainers are "Big Poo=
-Bah
> And OverLord of the KnownUniverse" and can force everybody else to ha=
ve
> "sensible-pager" too, maybe -then- it might make sense, but until the=
n
> it's just an odd-ball Debian thing that makes Debian maintainers eith=
er
> (a) maintain stupid patches to teach other programs about it or (b) h=
ave=20
> normal programs that use the _standard_ pagers in the absense of $PAG=
ER.
>=20
> And like it or not, there are two standard pages: "more" and "less". =
In=20
> the immortal words: "To two shall you count. You shall not count to o=
ne,=20
> except on your way to two. And you shall definitely NOT count to thre=
e,=20
> not call it 'sensible-pager'".
>=20
> The fact is, we HAVE a sensible-pager, and it is called "less".
>=20
> And for old programs that assume that sensible-pager is "more", we ei=
ther=20
> install that _too_, or we make a symlink that points to "less".

Debian prefers to call the symlink "pager" and let the sysadmin decide
where it should point: less, more, whatever. The e2fsprogs upstream
package for instance supports PAGER->/usr/bin/pager->/usr/bin/less.
Granted /usr/bin/pager is probably Debian only but every upstream autho=
r
deciding whether to use PAGER:more or PAGER:less is not _that_ much
better.=20

Just wanted to nitpick. Now you can reignite your flamethrower ;-)=20



				Christian

>=20
> And for people who want something else, everybody already supports th=
e=20
> STANDARD way of saying so: "$PAGER".
>=20
> In other words, "sensible-pager" buys you absolutely _nothing_. Excep=
t for=20
> confusion and extra work.
>=20
> > The advantage is, I guess, consistency.  Different programs don't h=
ave
> > to encode their own default pager.
>=20
> No. That's NOT an advantage. It's a disadvantage. Different programs =
sure=20
> as hell will not do silly Debian-only things, so it just means that i=
f=20
> Debian tries to enforce this, they're only causing more work for thei=
r own=20
> maintainers.
>=20
> They're also causing more work and discomfort for their users, since =
now=20
> their users will have to live with the fact that they are used to=20
> non-standard behaviour.
>=20
> And it has _zero_ upsides. Exactly because it's not standard. There's=
 a=20
> lot to be said for "do it like others do it".
>=20
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized=20
by rolling up your sleeves.

                (Eihei Dogen Zenji)
