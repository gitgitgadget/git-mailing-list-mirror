From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 0/2] add--interactive: better mode change handling
Date: Thu, 27 Mar 2008 09:34:00 +0100
Message-ID: <C96B3392-9B17-4703-A4BC-250A70108924@wincent.com>
References: <20080327072931.GA22444@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 09:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jena4-0008CU-Nk
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 09:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbYC0IeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 04:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758787AbYC0IeR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 04:34:17 -0400
Received: from wincent.com ([72.3.236.74]:47715 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758747AbYC0IeO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 04:34:14 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2R8Y1gT024819;
	Thu, 27 Mar 2008 03:34:02 -0500
In-Reply-To: <20080327072931.GA22444@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78342>

El 27/3/2008, a las 8:29, Jeff King escribi=F3:

> There may potentially be a "[3/2] change the name of the 'p'atch
> command" since it is now not just about the patch (actually, since gi=
t
> patches _do_ include mode changes, it maybe is appropriate). Wincent
> suggested "pick" which I think is reasonable. I'm not planning on =20
> doing
> such a 3/2, but I'm sure some industrious soul can make arguments =20
> for or
> against changing the name. I will let them handle the ensuing bikeshe=
d
> jamboree.

I don't really want to participate in such a jamboree either, but I =20
will add this one last comment that I should have mentioned in my =20
previous email: one thing to bear in mind when considering changing =20
the subcommand name is that "git add" itself has a "--patch" option =20
since a couple of releases ago, and that means that changing the =20
subcommand name either means introducing a mismatch between the option =
=20
name and subcommand name, or going through a deprecate/rename cycle =20
for the option name too, which we just introduced.

I don't really care either way. My muscle memory is trained for =20
"patch" at this point, but changing wouldn't be a problem either.

In any case, your patches 1 and 2 look pretty sane to me.

Cheers,
Wincent
