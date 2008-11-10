From: Francis Galiegue <fg@one2team.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 17:16:28 +0100
Organization: One2team
Message-ID: <200811101716.29029.fg@one2team.net>
References: <200811101522.13558.fg@one2team.net> <200811101656.35887.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 17:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzZSs-0007gQ-BE
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 17:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYKJQQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 11:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbYKJQQ4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 11:16:56 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:51120 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYKJQQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 11:16:55 -0500
Received: from erwin.kitchen.eel (unknown [90.63.83.161])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id E832592C003;
	Mon, 10 Nov 2008 17:16:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811101656.35887.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100530>

Le Monday 10 November 2008 16:56:35 Robin Rosenberg, vous avez =E9crit=A0=
:
[...]
> >
> > I found this:
> >
> > http://code.google.com/p/google-diff-match-patch
> >
> > Its license is the Apache 2.0 license. It implements the same algor=
ithm
> > than git's internal diff engine ("An O(ND) Difference Algorithm and=
 its
> > Variations", by Eugene Myers), and as far as I can tell so far (IAN=
AL,
> > far from it), it is compatible with JGit's current license.
> >
> > Could this be a viable candidate?
>
> Our approach was to do just that, for the very reasons you mention.
> I'll have a look. Thanks for doing some research for us. That project=
 was
> unknown to me..
>
> -- robin

Well, this API has a problem from the get go, since it does... Char by =
char=20
comparison. Ouch.

I'll try and hack it so that it does line by line, but given my Java sk=
ills,=20
uh...

--=20
fge
