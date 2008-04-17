From: David Mansfield <david@cobite.com>
Subject: Re: Man pages lack of exit status information
Date: Thu, 17 Apr 2008 13:38:12 -0400
Organization: Cobite
Message-ID: <1208453892.16608.44.camel@gandalf.cobite.com>
References: <38b2ab8a0804170045xa542274pa9f1e434f428b1cd@mail.gmail.com>
	 <BE732D9B-D2C2-4578-BC9D-52473C37EA74@wincent.com>
	 <38b2ab8a0804170138u717fb753me45ead12720c9e3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:15:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmY4s-00008m-AS
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 19:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763453AbYDQRiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760472AbYDQRiV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 13:38:21 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:32930 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754566AbYDQRiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 13:38:20 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id 7FEADE166F;
	Thu, 17 Apr 2008 13:38:19 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4Ag66Yg44qu; Thu, 17 Apr 2008 13:38:13 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 17655E166C;
	Thu, 17 Apr 2008 13:38:13 -0400 (EDT)
In-Reply-To: <38b2ab8a0804170138u717fb753me45ead12720c9e3d@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79805>


On Thu, 2008-04-17 at 10:38 +0200, Francis Moreau wrote:
> On Thu, Apr 17, 2008 at 10:17 AM, Wincent Colaiuta <win@wincent.com> =
wrote:
> > El 17/4/2008, a las 9:45, Francis Moreau escribi=C3=B3:
> > > I checked on a couple of git commands' man pages and I couldn't f=
ind
> > > the exit status of these commands.
> > >
> > > For example: git-status, git-diff man pages don't tell anything.
> > >
> > > Am I missing something ?
> > >
> >
> >  The "git-diff" man page documents this under the --exit-code optio=
n. It
> > probably would be nice to have an "EXIT STATUS" section added to th=
e man
> > pages of those commands for which it would be interesting (like "gi=
t-diff")
> > and perhaps to the main "git" man page as well (with general info).
> >
> >  If there is interest in this I'll whip up a doc patch.
> >
>=20
> I think it makes sense to have such section specially since git plumb=
ings are
> also designed to be used in higher level scripts.
>=20
> I really use to searching for RETURN VALUE section in man pages when =
I need
> what a command returns. And it's a pain to have to read the whole man=
 page for
> finding such important information.
>=20

+1 for adding a RETURN VALUE section to the docs.

Yes, please!  We need this.  I got burned because git-status does
something which is non-intuitive, and just yesterday I was asking about
git-merge, which I can only assume returns (exits) with 1 if there was =
a
conflict.

David
