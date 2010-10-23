From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH] CodingGuidelines: add a note to help contributors
 catch some errors earlier.
Date: Sat, 23 Oct 2010 20:48:30 +0200
Message-ID: <20101023184830.GQ4983@home.lan>
References: <1287843434-10890-1-git-send-email-ydirson@altern.org>
 <AANLkTikCr5yRHzetY9-T=_rg+PZM-e8ZnQvL79ucws+6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9j93-0007Ze-Ly
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab0JWSsj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 14:48:39 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60342 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab0JWSsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:48:38 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 81543D480D9;
	Sat, 23 Oct 2010 20:48:31 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9j8o-0003xO-Bu; Sat, 23 Oct 2010 20:48:30 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikCr5yRHzetY9-T=_rg+PZM-e8ZnQvL79ucws+6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159810>

On Sat, Oct 23, 2010 at 03:11:19PM -0200, Thiago Farina wrote:
> On Sat, Oct 23, 2010 at 12:17 PM, Yann Dirson <ydirson@altern.org> wr=
ote:
> > + - C code is expected to compile when the build is launched with t=
he
> > + =A0 following command:
> > +
> > + =A0 make CFLAGS=3D"-Wall -Wdeclaration-after-statement -Werror"
>=20
> Why this is not in the Makefile by default? Also -Wall is already in
> the Makefile.

CFLAGS seems to be used for more than gcc, and -Wall seems to be
portable enough to be overriden only in a couple of cases.  It would
not be the same for those flags.

Also note that -Wdeclaration-after-statement is also mentionned in
SubmittingPatches, but I still think it is a better place in
CodingGuidelines, which contributers are most likely to use as a
checklist before publishing.
