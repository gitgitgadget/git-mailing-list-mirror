From: fuz@fuz.su
Subject: Re: git archive should use vendor extension in pax header
Date: Thu, 28 Jan 2016 10:14:18 +0100
Message-ID: <20160128091418.GA6875@fuz.su>
References: <20160124155909.GA16847@fuz.su>
 <56A7EDE1.1020909@web.de>
 <20160127114634.GA1976@fuz.su>
 <56A92913.3030909@web.de>
 <20160127234512.GA5453@fuz.su>
 <alpine.DEB.2.20.1601280906340.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:08:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiZU-0004Ct-K1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbcA1JIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 04:08:52 -0500
Received: from fuz.su ([5.135.162.8]:32789 "EHLO fuz.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965240AbcA1JIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 04:08:46 -0500
Received: by fuz.su (Postfix, from userid 1000)
	id CCBCB20227; Thu, 28 Jan 2016 10:14:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1601280906340.2964@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285003>

Hello,

> > > Users can always go back to the original format.  At least I don'=
t
> > > expect this new format becoming the default too quickly.
>
> This is the most crucial issue here, as far as I am concerned: there =
are
> already tons of .zip files out there that were created by git archive=
, and
> there will inevitably be loads of tons more *having the current pax h=
eader
> format*.
>=20
> So tools wanting to deal with Git archives will have to handle those =
as
> well, i.e. do *precisely* as Ren=E9 suggested and use get-tar-commit-=
id. As
> such, the value of changing the format *now* is a bit like closing th=
e
> barn's door after pretty much all of the horses left (except the old =
one
> that has a few troubles getting up in the morning but that is too nic=
e to
> the kids to shoot).

That's not really an argument.  The situation you describes applies to
all file formats and it always ends in the same way:  A new file format
is designed and then slowly adopted by the rest of the users, in case o=
f
git I imagine this to be a quick process taking maybe a year or two.
Newly created files use the new file format and old files still hang
around but their importance is dwindling until you can safely support
only the new format.  But to get there, a new file format has to be
adopted in the first place.

> > Sure thing.  If this is going to be implemented, I would add option=
s
> > to choose what / what style of metadata to include.
>=20
> Why not put your money where your mouth is? I.e. get your head down i=
nto
> the code and come up with a patch (because otherwise it is unlikely t=
hat
> your idea will go anywhere)?

I'd love to but I prefer to ask if there is interest in such a change i=
n
the first place.  I'm not going to waste my time implementing this and
then being told that the git project is not interested in this kind of
functionality.  So can someone give me a clear signal?

> Ciao,
> Johannes

Yours sincerely,
Robert Clausecker

--=20
()  ascii ribbon campaign - for an 8-bit clean world=20
/\  - against html email  - against proprietary attachments
