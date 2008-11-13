From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 15:53:25 +0100
Message-ID: <20081113145325.GD29274@neumann>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
	<2008-11-13-14-23-19+trackit+sam@rfc1149.net>
	<20081113140323.GA10267@neumann>
	<2008-11-13-15-26-33+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 15:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0daj-0008W1-VB
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 15:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYKMOx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 09:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYKMOx0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 09:53:26 -0500
Received: from francis.fzi.de ([141.21.7.5]:47555 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751064AbYKMOxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 09:53:25 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 13 Nov 2008 15:53:24 +0100
Content-Disposition: inline
In-Reply-To: <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 13 Nov 2008 14:53:24.0510 (UTC) FILETIME=[94309BE0:01C9459F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100878>

Hi,

On Thu, Nov 13, 2008 at 03:26:33PM +0100, Samuel Tardieu wrote:
> * SZEDER G=E1bor <szeder@ira.uka.de> [2008-11-13 15:03:23 +0100]
> | Yeah, and it can be bisected to commit 621ff675 (rev-parse: fix
> | meaning of rev~ vs rev~0, 2008-03-14), which is from Linus, so put =
him
> | on Cc.
>=20
> I think your pinpointed a change of behaviour in "HEAD~", which is
> probably not the problem at hand.  To find the real bug, you should
> update the test script so that it uses "HEAD~1" instead of "HEAD~".

It doesn't matter.  The test script errors out at the merge, and not
at the checkout.  Furthermore, it doesn't matter, whether HEAD~,
HEAD~, or HEAD^ is checked out, the results are the same.

But yes, it's possible that not the bisected commit is the culprit,
but something in or behind merge relies on the old undocumented and
illogical behaviour.

G=E1bor
