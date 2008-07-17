From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/RelNotes-1.6.0.txt: Expand on the
	incompatible packfiles
Date: Thu, 17 Jul 2008 19:20:51 +0200
Message-ID: <20080717172051.GY32184@machine.or.cz>
References: <20080717170118.14083.87086.stgit@localhost> <g5nue6$3ek$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJXB8-00005w-MG
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbYGQRUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbYGQRUy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:20:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42692 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbYGQRUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:20:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 07852393A2E2; Thu, 17 Jul 2008 19:20:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g5nue6$3ek$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88889>

On Thu, Jul 17, 2008 at 07:10:32PM +0200, Jakub Narebski wrote:
> Petr Baudis wrote:
>=20
> > +introduced in v1.5.2 and v1.4.4.5. =A0If you want to keep your rep=
ositories
> > +backwards compatible past these versions, set repack.useDeltaBaseO=
ffset
> > +to false or pack.indexVersion to 1, respectively.
>=20
> 'or'? Not 'and'?
>=20
> You shouldn't have, I think, this "respectively" here.  You need it o=
nly
> if you are writing "a, b, c, then a', b', c', respectively".

The "respectively" means that the two options relate each to one of the
two new features. I'm unclear about the 'or'-'and' question, though.

				Petr "Pasky" Baudis
