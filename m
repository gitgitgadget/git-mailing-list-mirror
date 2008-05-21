From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Git-new-workdir
Date: Wed, 21 May 2008 13:57:56 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794301FC8B24@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com> <20080521184446.GA23924@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Wed May 21 20:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JytWn-0005M5-4G
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYEUS57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 14:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757237AbYEUS57
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:57:59 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:10747 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbYEUS56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 14:57:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20080521184446.GA23924@bit.office.eurotux.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-new-workdir
Thread-Index: Aci7csG+/c71xK3wSXi1YKNri7wo/gAAUwvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82565>

=20

> From: Luciano Rocha [mailto:luciano@eurotux.com]=20
> On Wed, May 21, 2008 at 01:21:22PM -0500, Craig L. Ching wrote:
> > Hi all,
> >=20

[stuff about why we want to use git-new-workdir]

>=20
> Personally, I'd clone a local rep for each build, with the -s=20
> option to clone.
>=20
> Something like:
>=20
> git clone server:/rep ~/master
> git clone -s ~/master build/abc
> git clone -s ~/master build/foo
> ...
>=20
> The -s option should reduce disk-usage considerably.
>=20
Yeah, I neglected to mention that the other good thing about git-new-wo=
rkdir is that the origin is set to the origin of the remote repository =
so to push changes to our central repository, you only need one push.  =
Otherwise you have to push twice, right?  Well now (thinking out loud h=
ere), maybe you don't.  That was the impression I got from the IRC conv=
ersation, but maybe you could just push from the original clone?  Still=
, seems easier if all the shared repositories and the original clone pu=
shed to the same place, at least for us.

> --
> Luciano Rocha <luciano@eurotux.com>
> Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>
>=20
>=20

Thanks for the feedback, it's making me think about the problem ;-)

Cheers,
Craig
