From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Mon, 1 Nov 2010 16:03:33 -0400
Message-ID: <20101101200333.GG2340@fieldses.org>
References: <20101029083516.GA26290@burratino>
 <vpqzktwv3yx.fsf@bauges.imag.fr>
 <AANLkTiknyZBeWY8Z14EF+uq_2feJxJniVBwpwjUHgdEF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 21:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD0bW-0003Fx-QW
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 21:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab0KAUDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 16:03:38 -0400
Received: from fieldses.org ([174.143.236.118]:58034 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab0KAUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 16:03:36 -0400
Received: from bfields by fieldses.org with local (Exim 4.72)
	(envelope-from <bfields@fieldses.org>)
	id 1PD0bN-0002Y5-4I; Mon, 01 Nov 2010 16:03:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiknyZBeWY8Z14EF+uq_2feJxJniVBwpwjUHgdEF@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160493>

On Sun, Oct 31, 2010 at 05:25:20PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> On Sat, Oct 30, 2010 at 01:55, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> >> Sadly, at least the user manual change suggested below is probably
> >> not suitable, since reset --keep and --merge have not been around
> >> since git 1.5.3 days. =C2=A0Ideas for working around that and othe=
r
> >> comments would be welcome.
> >
> > Do we really want to keep the user manual compatible with 1.5.3
> > forever? It's nice to keep the user manual usable by slightly outda=
ted
> > Gits, but 1.5.3 starts being really old, and older docs are still
> > available on the web (like
> > http://www.kernel.org/pub/software/scm/git/docs/v1.5.3.8/git.html )=
=2E
>=20
> I didn't know we even did this with our user manual. When I read
> manuals for version X (e.g. PostgreSQL, Emacs or libc versions) I
> fully expect the features described to only work on the documented
> version unless otherwise noted.

Yeah, previous versions of the user manual are still around if people
need them.  For a book or an independent website a wider range of
versions would make more sense, but for documentation destributed with
the git source I think we can afford to be more aggressive.

If we think information about old versions is really important maybe
someone could find a way to incorporate it in a way that doesn't intrud=
e
into the main text too much (e.g. footnotes or an appendix.)

--b.
