From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Editing Git Log
Date: Thu, 18 Sep 2008 08:21:16 +0200
Message-ID: <20080918062116.GB32670@atjola.homenet>
References: <48D1ECB4.9080808@tensilica.com> <48D1F19E.60907@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piet Delaney <piet.delaney@tensilica.com>,
	Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCv8-0003Zl-Ae
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYIRGVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 02:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYIRGVV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:21:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:47809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751146AbYIRGVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:21:20 -0400
Received: (qmail invoked by alias); 18 Sep 2008 06:21:18 -0000
Received: from i577B97EF.versanet.de (EHLO atjola.local) [87.123.151.239]
  by mail.gmx.net (mp061) with SMTP; 18 Sep 2008 08:21:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Ub/8jVUEUJ5Q/j9gWMO7VS12Ww2mIs06Dcj6S7s
	4BRuGc5lEd8EvH
Content-Disposition: inline
In-Reply-To: <48D1F19E.60907@panasas.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96165>

On 2008.09.18 09:13:50 +0300, Boaz Harrosh wrote:
> Piet Delaney wrote:
> > I think I recall reading that a feature of git was the prevention o=
f the=20
> > git commits
> > from being changed. I noticed today that a couple of us have checke=
d in=20
> > files
> > without our customary [XTENSA] architecture prefixed to the 1st lin=
e of our
> > Commit Messages.
> >=20
> > I couldn't find a way to do this, other than our reverting back to =
a=20
> > earlier repository
> > and recommitting (each?) change with the slightly changed Commit Me=
ssage;
> > not an attractive investment of our time.
> >=20
> > Any suggestions?
> >=20
> > -piet
> > --
>=20
> git rebase --interactive FIRST_BAD_COMMIT^ will effectively do the sa=
me
> as above but in a nice automated way. Just change pick =3D> edit on t=
hese
> patches that need fixing, you'll see.

git filter-branch with a suited msg-filter is even more automated :-)

Bj=F6rn
