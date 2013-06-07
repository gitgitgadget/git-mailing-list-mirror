From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 20:55:37 +0200
Message-ID: <20130607185537.GC25731@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:55:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1pA-0002bu-IU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab3FGSzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 14:55:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:53023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab3FGSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:55:39 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M8QOg-1UOhml20vK-00vxzv; Fri, 07 Jun 2013 20:55:37 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:aJp0Gt9Iprlp2HOr9o4KfJo30SCC8UNlipmW4466+lC
 zajLhJptcwysdjS/pYofnRkB5VMYGIyBXPKg2Fuze/QYFq+Wh4
 rcsm/x7RRnOVR0HIdKR1RveXEorrJBdDDjAIPzDYMe3oEMfx7w
 xrwuOX9jPRtp83RjnZ9bqzMetxQRqpc1JBADkbpC2uo8wFfzUB
 9k7dUU9P2aJWnZcjsn5NmuOnTOmH0Lb66jetMXMUv1vTykeIK4
 ptC8Q+Mks9RQr4YFbSYdYwRwf5vNyD+3T3/1eh6g99ea9/Cima
 XInWnq++6+IANTAk+nk7LqiMR2ausbX23B6QKO5U7N94Sjj9HB
 BSaZdVDIvBya/+FLsWYgM7RcexTkHSS5fDdmZZYpX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226670>

On Fri, Jun 07, 2013 at 11:00:14PM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > the one at the top because
> > of the reasons given in $gmane/226272
>=20
> Sorry about the delay: I went to sleep for a couple of days :P
>=20
> > the one at the bottom because
> > of the misleading commit message (__git_complete_file() always
> > completed refs first as part of the ref:file notation, so it worked
> > just fine except for the ref1...ref2 notation; the real reason for
> > calling __git_complete_revlist_file() for difftool is to make clear
> > that difftool takes ref1...ref2:file, too).
>=20
> How am I (or anyone else) supposed to know the "intended" meaning
> __git_complete_file()?  The implementation is just an alias to
> __git_complete_revlist_file(), so I looked at the name and guessed
> that it was supposed to complete files; now you tell me that it was
> intended to complete any revspec except revision ranges (what does
> that have to do with "file" again?).  I suppose digging through the
> history would've told me, but I really didn't bother for such a
> trivial non-functional change.

Yeah, I suppose it's always wise to do a bit of history digging before
you go on to remove a function you don't know what it is doing, even
though a simple git log -Sfuncname perhaps doesn't even qualifies for
"digging" ;)
