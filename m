From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: I just pulled and built 'next'...
Date: Wed, 10 Jan 2007 14:24:16 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070110132416.GA13156@informatik.uni-freiburg.de>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org> <20070109032124.GA1904@spearce.org> <20070109173501.GA3732@cepheus> <20070110000600.GE30023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 14:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4dRT-0002h9-3C
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 14:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbXAJNYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 10 Jan 2007 08:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAJNYX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 08:24:23 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63088 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932469AbXAJNYW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jan 2007 08:24:22 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H4dRF-0003gb-LP; Wed, 10 Jan 2007 14:24:21 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0ADOHmF013220;
	Wed, 10 Jan 2007 14:24:17 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0ADOGNc013219;
	Wed, 10 Jan 2007 14:24:16 +0100 (MET)
To: "Shawn O. Pearce" <spearce@spearce.org>
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070110000600.GE30023@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36507>

Hello,

Shawn O. Pearce wrote:
> Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de> wrote:
> > Shawn O. Pearce wrote:
> > >   $ git rev-list v1.5.0-rc0..next | wc -l
> > >   687
> > >   $ git rev-list v1.4.4.4..next | wc -l
> > >   1051
> > >=20
> > > So what about doing Junio's suggestion of going by topology and
> > > coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
> > > right now), and if more than one is found compute the number of
> > > commits between each tag and the requested revision, and take the
> > > tag that has a smallest number of commits?
> >
> > One scenario where this will fail is when a bugfix is commited on t=
op of
> > v1.4.4.4 and then is merged into v1.5.0-rc0+gabcdef.
>=20
> Actually it still works, and does what you want.  The scenario you
> are describing is exactly the one that caused this bug to appear,
> and is the one my suggestion is trying to offer a partly sane
> solution to.
OK, I got it.  I thought in "shortest ways", but that's obviously
different from "commits inbetween".  Thanks for that one more
explanation.  Now it really makes sense to me.

Best regards
Uwe
--=20
Uwe Kleine-Koenig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
