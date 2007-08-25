From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-kompare
Date: Sat, 25 Aug 2007 12:25:07 +0200
Message-ID: <200708251225.08141.robin.rosenberg.lists@dewire.com>
References: <46CE6F56.70803@csiro.au> <200708242152.09176.robin.rosenberg.lists@dewire.com> <46CF7509.5080206@csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jean-Marc Valin <jean-marc.valin@csiro.au>
X-From: git-owner@vger.kernel.org Sat Aug 25 23:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP39R-0005Ws-Ti
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXHYV0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 25 Aug 2007 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXHYV0P
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 17:26:15 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2881 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbXHYV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 17:26:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C20F6802664;
	Sat, 25 Aug 2007 23:18:27 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30148-08; Sat, 25 Aug 2007 23:18:27 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 8164F80264B;
	Sat, 25 Aug 2007 23:18:27 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46CF7509.5080206@csiro.au>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56651>

l=F6rdag 25 augusti 2007 skrev Jean-Marc Valin:
> > Adding the patch to your version isn't hard. Just download the sour=
ce package
> > and add the patch in the patches section and rebuild. That's how I =
lived with
> > the fix until Mandriva delivered a newer KDE version. Thanks to the=
 kdesdk src
> > rpm I could rebuild the package fairly easily without dowloading, c=
onfiguring
> > and builing most of KDE. The src rpm declare the dependencies I nee=
d. My=20
> > guess is that is about as easy with dpkg, ebuilds or ports.
>=20
> Unless I missed something, there are more things to work around than =
the
> one that was fixed in your patch, no? For example, the fact that komp=
are
> doesn't understand when the filename is /dev/null. As for upgrading

I'm on 3.5.7 now so I cannot easily test 3.5.6 with the patch anymore, =
but
on *my machine* diffs (including git diffs) with /dev/null work just fi=
ne.

-- robin

> kompare, I'm all for the idea, but the KDE folks aren't making that
> easy. The only link in the Kompare download section is for www.kde.or=
g,
> which isn't making the source code any easier to find (including a 40=
4
> link for "Source code" on the front page!). Any direct link?

I suggested *not* to upgrade completely. Go to ubunu's home page
and look for package sources and how to modify them. Ubuntu uses
the same package format as Debian so instructions for Debian will
most likely apply for Ubuntu.

- robin
