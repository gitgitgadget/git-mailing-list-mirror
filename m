From: Francis Galiegue <fg@one2team.net>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 02:15:40 +0100
Organization: One2team
Message-ID: <200811060215.40869.fg@one2team.net>
References: <200811060014.57046.fg@one2team.net> <20081105235035.GA10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 06 02:18:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxtWK-0005ZQ-7I
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 02:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYKFBRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 20:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbYKFBRe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 20:17:34 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:57187 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbYKFBRd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 20:17:33 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-121-89.w90-20.abo.wanadoo.fr [90.20.196.89])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 975A592C011;
	Thu,  6 Nov 2008 02:17:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081105235035.GA10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100206>

Le Thursday 06 November 2008 00:50:35 Petr Baudis, vous avez =E9crit=A0=
:
>   Hi,
>
> On Thu, Nov 06, 2008 at 12:14:56AM +0100, Francis Galiegue wrote:
> > * second: even though this may be a "non problem", we use Bonsai, w=
hich
> > has the ability to see what was commited by whom, given a time inte=
rval
> > (from d1 to d2): the base gitweb allows to search by commiter, whic=
h is
> > good, but it has no date boundaries: do tools exist for git that ca=
n do
> > this? If not, that wouldn't be a big deal, however...
>
> 	git log --since=3D'2 months ago' --until=3D'1 month ago'
>
>   There is no gitweb functionality for this right now, but I think an
> implementation of that would be welcome in principle.
>

Well, right now, the search field is only a... field. Implementing such=
 a=20
change would require a whole search page... I don't think anyone would =
want=20
to pollute the bare-bones page with more fields if they're of no use 90=
+% of=20
the time.

A search page would make sense, I guess, since the date criterion is no=
t the=20
only one that you could use... But what other criteria would be useful?=
 And=20
then, if a search page is implemented, what of the current dropdown lis=
t?=20
Drop it altogether and put a "Search commits..." link instead?

> > * third: also Bonsai-related; Bonsai can link to Bugzilla by matchi=
ng
> > (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
> > http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb ha=
ve this
> > built-in? (haven't looked yet) Is this planned, or has it been disc=
ussed
> > and been considered not worth the hassle?
>
>   This is planned and I think there are third-party patches for this
> (cannot find them quickly, though), but upstream gitweb does not have
> the support for this included yet.

I'd love to have a link to these patches, honestly. "Our" commit messag=
es are=20
poor enough that more often than not, the whole commit message is, for=20
instance, "fix bug #xxxx". While I push hard for more explicit commit=20
messages, this is just a pipe dream and that link to Bugzilla is vital =
to=20
us...

--=20
fge
