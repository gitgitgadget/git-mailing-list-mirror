From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config
 module
Date: Tue, 8 Jun 2010 22:50:29 +0200
Message-ID: <20100608205029.GB3408@machine.or.cz>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
 <201006081446.22587.jnareb@gmail.com>
 <20100608141321.GP20775@machine.or.cz>
 <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
 <20100608195552.GA3408@machine.or.cz>
 <AANLkTimKsdn8Vww_4U4YQDPlpr_BgbVszwG64lEYl-cE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:50:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5ks-0001Nu-BY
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab0FHUud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 16:50:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48684 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab0FHUuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:50:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6EC4386208F; Tue,  8 Jun 2010 22:50:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimKsdn8Vww_4U4YQDPlpr_BgbVszwG64lEYl-cE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148715>

On Wed, Jun 09, 2010 at 01:54:34AM +0530, Pavan Kumar Sunkara wrote:
> On Wed, Jun 9, 2010 at 1:25 AM, Petr Baudis <pasky@suse.cz> wrote:
> > On Wed, Jun 09, 2010 at 12:52:11AM +0530, Pavan Kumar Sunkara wrote=
:
> >> =A0 Gitweb::Parse
> >
> > What will this module do?
>=20
> This module contains all the parse_* subroutines

Ok, that makes sense. It might be also possible to have them in
Gitweb::Git, but I see href() invocations and such that would probably
create layering violations.

> Gitweb::Format contains all the format_* subroutines

Here, I'm less decided. I would have put these in Gitweb::HTML, but I
have no hard opinion, maybe that's clumping things too much - so no nac=
k
from me personally.

> >> =A0 Gitweb::Util
> >
> > What will this module do?
>=20
> This modules contains all the git utility functions.

Can you give an example, please?

> I still have until this week in the timeline. Don't I ?
> I strongly hope that I will be able to finalise the patch queue by
> this week and will move on to develop write functionalities.

Sure, my only concern is that if the queue of patches your future work
will depend on gets too long and gets delayed too much in merging in,
it will get much more difficult to produce further patches, get them
reviewed and get them on the merging track.

--=20
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
