From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: C# Git Implementation
Date: Sat, 29 Nov 2008 20:55:20 +0100
Message-ID: <200811292055.20416.robin.rosenberg.lists@dewire.com>
References: <001501c9515e$66e8ac70$34ba0550$@com> <alpine.DEB.2.00.0811291308120.17643@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JD Guzman <jd@jdguzman.com>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 20:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Vw0-0006NT-Aq
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 20:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYK2Tzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Nov 2008 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYK2Tzk
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 14:55:40 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:43377 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308AbYK2Tzj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 14:55:39 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C501C9F60C; Sat, 29 Nov 2008 20:55:23 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <alpine.DEB.2.00.0811291308120.17643@vellum.laroia.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101924>

l=F6rdag 29 november 2008 19:08:58 skrev Asheesh Laroia:
> On Fri, 28 Nov 2008, JD Guzman wrote:
>=20
> > I read in the archives that there was once talk of porting Git over=
 to=20
> > C# and was wondering if anything ever came of this?  I realize ther=
e=20
> > were some that didn't see the use for this but as Git is becoming m=
ore=20
> > and more popular a more native implementation of Git for windows us=
ers=20
> > would be a good endevour IMHO.
>=20
> Is it possible to compile the Java-language jgit with the Common Lang=
uage=20
> Runtime and access that from a C# application?
>=20
> -- Asheesh.
>=20

I tried it half a year ago. Recompiling and running was easy, Unfortuna=
tely it hung on reading
blobs and  the stacktrace showed it was stuck in deflate. It's not very=
 high on my list of priorities,
but I assume fixing the problem is probably not hard if you decide to g=
et your editor dirty.

-- robin
