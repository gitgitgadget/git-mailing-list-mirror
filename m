From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Mon, 24 Sep 2007 01:10:59 +0200
Message-ID: <200709240110.59680.robin.rosenberg.lists@dewire.com>
References: <877imishdp.fsf@catnip.gol.com> <20070923212239.GA7249@potapov> <85ejgpkr13.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@nbs-eng.ru>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaZr-0005oD-Qi
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXIWXJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbXIWXJW
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:09:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25952 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbXIWXJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:09:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 75DE980280F;
	Mon, 24 Sep 2007 01:01:00 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25614-10; Mon, 24 Sep 2007 01:00:47 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6DABA80264D;
	Mon, 24 Sep 2007 01:00:43 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <85ejgpkr13.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58999>

s=F6ndag 23 september 2007 skrev David Kastrup:
> Dmitry Potapov <dpotapov@nbs-eng.ru> writes:
>=20
> > On Sun, Sep 23, 2007 at 09:54:10AM -0700, Linus Torvalds wrote:
> >
> >>  - the stuff C++ *does* have is usually nasty. Implicit
> >>  initializers and destructors and the magic lifetime rules of
> >>  objects etc
> >
> > I am not sure what is wrong with initializers and destructors in
> > C++, but certainly there is no magic lifetime rules in C++, as it i=
s
> > fully determined by the scope.
>=20
> It has been some time since I last looked, but the lifetime of object=
s
> constructed in return statements was a moving target through several
> standards.  The last standard I bothered looking at had the object
> survive until the statement with the function call expression ended:
> quite a strange synchronization point with regard to language design.

The idea is that you should be able to use temporaries by reference and
trust them to be valid over function calls end even function returns, s=
o=20
you can write efficient matrix math libraries that do not copy data muc=
h while
retaining value semantics with overloaded operators. It is a purely pra=
ctical
matter, what actually works and is efficient, not dogmatic language "de=
sign".

Earlier versions failed to make up something useful here.

> > In fact, other high level languages that use GC have much more
> > unpredictable lifetime rules for objects.
>=20
> Mostly objects are alive as long as you can refer to them.  Not reall=
y
> complicated.

What could be simpler, besides all static variables.

-- robin
