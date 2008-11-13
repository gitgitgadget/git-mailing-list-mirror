From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 19:09:31 +0100
Message-ID: <20081113180931.GE29274@neumann>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
	<2008-11-13-14-23-19+trackit+sam@rfc1149.net>
	<20081113140323.GA10267@neumann>
	<2008-11-13-15-26-33+trackit+sam@rfc1149.net>
	<20081113145325.GD29274@neumann>
	<57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0geb-0003qY-7o
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 19:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYKMSJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 13:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYKMSJc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 13:09:32 -0500
Received: from francis.fzi.de ([141.21.7.5]:12785 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751530AbYKMSJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 13:09:32 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 13 Nov 2008 19:09:29 +0100
Content-Disposition: inline
In-Reply-To: <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 13 Nov 2008 18:09:29.0940 (UTC) FILETIME=[F8EEC140:01C945BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100893>

On Thu, Nov 13, 2008 at 06:06:52PM +0100, Anders Melchiorsen wrote:
> SZEDER G=E1bor wrote:
> > It doesn't matter.  The test script errors out at the merge, and no=
t
> > at the checkout.  Furthermore, it doesn't matter, whether HEAD~,
> > HEAD~, or HEAD^ is checked out, the results are the same.
>=20
> Just to be sure, I tried reverting the commit that you bisected -- an=
d my
> test case still fails.

Well, oddly enough, your second test case behaves somewhat differently
than the first one, at least as far as bisect is concerned.  Bisect
nails down the second test case to 0d5e6c97 (Ignore merged status of
the file-level merge, 2007-04-26; put Alex on Cc).  Reverting this
commit on master makes both of your test cases pass.

G=E1bor
