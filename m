From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 15:03:23 +0100
Message-ID: <20081113140323.GA10267@neumann>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
	<2008-11-13-14-23-19+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 15:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0d3J-0002Y8-6p
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 15:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYKMOSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 09:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbYKMOSi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 09:18:38 -0500
Received: from francis.fzi.de ([141.21.7.5]:43146 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751530AbYKMOSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 09:18:37 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2008 09:18:37 EST
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 13 Nov 2008 15:03:22 +0100
Content-Disposition: inline
In-Reply-To: <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 13 Nov 2008 14:03:22.0588 (UTC) FILETIME=[96E7A9C0:01C94598]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100875>

Hi,

On Thu, Nov 13, 2008 at 02:23:19PM +0100, Samuel Tardieu wrote:
> >>>>> "Anders" =3D=3D Anders Melchiorsen <mail@cup.kalibalik.dk> writ=
es:
>=20
> Anders> I have tested the script with Git 1.6.0.2, but the real
> Anders> scenario that made this appear seems to also fail with master
> Anders> and next from git.git.
>=20
> I confirm that your test case also fails with the current "next".

Yeah, and it can be bisected to commit 621ff675 (rev-parse: fix
meaning of rev~ vs rev~0, 2008-03-14), which is from Linus, so put him
on Cc.


Best,
G=E1bor
