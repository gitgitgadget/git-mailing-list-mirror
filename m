From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-svn fails to fetch repository
Date: Fri, 23 Jan 2009 09:52:35 +0100
Message-ID: <20090123085235.GA14721@machine.or.cz>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org> <496CD49D.1070201@drmicha.warpmail.net> <loom.20090113T185918-397@post.gmane.org> <20090113203922.GD30404@atjola.homenet> <loom.20090113T204616-845@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vladimir Pouzanov <farcaller@gmail.com>, git@vger.kernel.org
To: B.Steinbrink@gmx.de
X-From: git-owner@vger.kernel.org Fri Jan 23 09:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQHni-0003mV-3R
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZAWIwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 03:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbZAWIwk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:52:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52184 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZAWIwj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:52:39 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 47846204C040; Fri, 23 Jan 2009 09:52:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <loom.20090113T204616-845@post.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106859>

On Tue, Jan 13, 2009 at 08:46:55PM +0000, Vladimir Pouzanov wrote:
> Bj=F6rn Steinbrink <B.Steinbrink <at> gmx.de> writes:
> > Is that Linux box using Gentoo? If so, try emerging subversion with=
 -dso
> > in your build flags.
>=20
> Yeah, that's gentoo. Will try rebuilding svn now.

I have hit the same issue (segfault on Gentoo) and this fixed it for me=
=2E
But do you have any details on why is the segfault caused and how to
prevent it? USE=3Ddso is the default on Gentoo. :-(

--=20
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
