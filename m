From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 17:59:03 +0100
Message-ID: <200811101759.03864.robin.rosenberg@dewire.com>
References: <200811101522.13558.fg@one2team.net> <200811101656.35887.robin.rosenberg@dewire.com> <200811101716.29029.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kza7k-00017O-Rb
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 18:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbYKJQ7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 11:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYKJQ7I
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 11:59:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:10630 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845AbYKJQ7H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 11:59:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27101147D0C5;
	Mon, 10 Nov 2008 17:59:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Vqu4A8b81iD; Mon, 10 Nov 2008 17:59:04 +0100 (CET)
Received: from sleipner.localnet (sleipner.dewire.com [10.1.2.197])
	by dewire.com (Postfix) with ESMTP id 9D6E080284E;
	Mon, 10 Nov 2008 17:59:04 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200811101716.29029.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100532>

m=E5ndag 10 november 2008 17:16:28 skrev Francis Galiegue:
> Le Monday 10 November 2008 16:56:35 Robin Rosenberg, vous avez =E9cri=
t :
> [...]
> > >
> > > I found this:
> > >
> > > http://code.google.com/p/google-diff-match-patch
> > >
> > > Its license is the Apache 2.0 license. It implements the same alg=
orithm
> > > than git's internal diff engine ("An O(ND) Difference Algorithm a=
nd its
> > > Variations", by Eugene Myers), and as far as I can tell so far (I=
ANAL,
> > > far from it), it is compatible with JGit's current license.
> > >
> > > Could this be a viable candidate?
> >
> > Our approach was to do just that, for the very reasons you mention.
> > I'll have a look. Thanks for doing some research for us. That proje=
ct was
> > unknown to me..
> >
> > -- robin
>=20
> Well, this API has a problem from the get go, since it does... Char b=
y char=20
> comparison. Ouch.
>=20
> I'll try and hack it so that it does line by line, but given my Java =
skills,=20
> uh...
>=20
We might want a byte-oriented version. Converting to char first is way=20
too slow.

-- robin
