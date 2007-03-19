From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 21:02:19 +0100
Organization: Dewire
Message-ID: <200703192102.20258.robin.rosenberg.lists@dewire.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <alpine.LFD.0.83.0703191427140.18328@xanadu.home> <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Steven Grimm <koreth@midwinter.com>,
	John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTO1j-0001hE-GV
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXCSUAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Mar 2007 16:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXCSUAN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:00:13 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14738 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbXCSUAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2007 16:00:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B576B8027F8;
	Mon, 19 Mar 2007 20:54:48 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30251-07; Mon, 19 Mar 2007 20:54:48 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id EAB37802651;
	Mon, 19 Mar 2007 20:54:45 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42661>

m=E5ndag 19 mars 2007 19:48 skrev Linus Torvalds:
>=20
> On Mon, 19 Mar 2007, Nicolas Pitre wrote:
> >=20
> > And some will argue that explicit renames are susceptible to user e=
rror=20
> > misidentifying the rename too, certainly in the 1% figure of all re=
names=20
> > if not more.
>=20
> It's much worse than that. I will *guarantee* that renames are missed=
 when=20
> they come in as traditional patches, for example. That's a 100% error=
 rate=20
> right there, not some "1%" one.
>=20
> And even if people never make mistakes, and people *only* use the nat=
ive=20
> SCM "rename" functions, I guarantee that the downsides of thinking th=
at=20
> files have identities is still much much bigger than the upsides. We'=
ve=20
> already shown that the git "blame" functionality is strictly more pow=
erful=20
> than anything based on renames.
>=20
> So learn to love the bomb. Rename tracking is *wrong*.=20
>=20
> 		Linus

How about this simple receipe for defeating rename tracking (real world=
):

User needs to modify A. User renames A to OLD_A within his/her IDE. SCM
records the rename. User now uses SaveAs to restore A, and SCM detects =
the=20
*NEW* file A.

-- robin
