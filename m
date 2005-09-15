From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 11:15:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151106200.26803@g5.osdl.org>
References: <7255.1126583985@kao2.melbourne.sgi.com>
 <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain>
 <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org> <43290486.5020301@zytor.com>
 <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net> <u5tvf12sp1v.fsf@lysator.liu.se>
 <Pine.LNX.4.58.0509150905070.26803@g5.osdl.org> <u5toe6uql1w.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 20:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFyKE-0002IC-D8
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVIOSTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 14:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVIOSTH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:19:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030507AbVIOSTG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 14:19:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FIFsBo006717
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 11:15:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FIFqP0015630;
	Thu, 15 Sep 2005 11:15:53 -0700
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5toe6uql1w.fsf@lysator.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8620>



On Thu, 15 Sep 2005, David K=E5gedal wrote:
>=20
> No, you read my message wrong, or I failed to describe it properly.

No, I did get it.

It's the Debian people who don't get it.

Expecting other software projects to make cludges for Debian-specific=20
packages is _insane_.

In other word, no sane package will ever use "sensible-pager", because
it's not a sensible thing to do. Once Debian maintainers are "Big Poo-B=
ah
And OverLord of the KnownUniverse" and can force everybody else to have
"sensible-pager" too, maybe -then- it might make sense, but until then
it's just an odd-ball Debian thing that makes Debian maintainers either
(a) maintain stupid patches to teach other programs about it or (b) hav=
e=20
normal programs that use the _standard_ pagers in the absense of $PAGER=
=2E

And like it or not, there are two standard pages: "more" and "less". In=
=20
the immortal words: "To two shall you count. You shall not count to one=
,=20
except on your way to two. And you shall definitely NOT count to three,=
=20
not call it 'sensible-pager'".

The fact is, we HAVE a sensible-pager, and it is called "less".

And for old programs that assume that sensible-pager is "more", we eith=
er=20
install that _too_, or we make a symlink that points to "less".

And for people who want something else, everybody already supports the=20
STANDARD way of saying so: "$PAGER".

In other words, "sensible-pager" buys you absolutely _nothing_. Except =
for=20
confusion and extra work.

> The advantage is, I guess, consistency.  Different programs don't hav=
e
> to encode their own default pager.

No. That's NOT an advantage. It's a disadvantage. Different programs su=
re=20
as hell will not do silly Debian-only things, so it just means that if=20
Debian tries to enforce this, they're only causing more work for their =
own=20
maintainers.

They're also causing more work and discomfort for their users, since no=
w=20
their users will have to live with the fact that they are used to=20
non-standard behaviour.

And it has _zero_ upsides. Exactly because it's not standard. There's a=
=20
lot to be said for "do it like others do it".

			Linus
