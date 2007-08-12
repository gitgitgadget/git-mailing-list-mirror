From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 21:51:26 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070812195126.GA17914@informatik.uni-freiburg.de>
References: <85ir7kq42k.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org> <854pj4o8k5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJTS-000129-I8
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937456AbXHLTva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 15:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937020AbXHLTva
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:51:30 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48192 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937456AbXHLTv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:51:29 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IKJTE-0005AH-Cs; Sun, 12 Aug 2007 21:51:28 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7CJpQ5f018155;
	Sun, 12 Aug 2007 21:51:26 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7CJpQra018154;
	Sun, 12 Aug 2007 21:51:26 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <854pj4o8k5.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55712>

David Kastrup wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Sun, 12 Aug 2007, Linus Torvalds wrote:
> >>=20
> >> A newsreader is mis-designed for all the same reasons SVN is misde=
signed:=20
> >> it sees the messages (commits) as a _tree_.
> >
> > Side note: the lack of this bug is what makes showing large
> > histories graphically be expensive in the first place.
>=20
> Not really.
>=20
> dak@lola:/home/tmp/emacs$ time git-rev-list --parents --topo-order --=
all>/dev/null
>=20
> real    0m9.042s
> user    0m8.801s
> sys     0m0.168s
>=20
> This does not even start to _think_ of swapping.
rev-list doesn't try to draw a line from each commit to its parents.
That's the really intensive part.  So when gitk reads

	d56871cb0e6ceeca8e5435ff95409d78bed014f0 a046fe0cb8697bc97993b2e609688=
ff5e89e3e9

it must remember this line at least until it sees a line starting with
a046fe0cb8697bc97993b2e609688ff5e89e3e9.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

dd if=3D/proc/self/exe bs=3D1 skip=3D1 count=3D3 2>/dev/null
