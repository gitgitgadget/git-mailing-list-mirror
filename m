From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Sun, 13 May 2007 14:01:28 -0700
Message-ID: <20070513210128.GA13428@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle> <200705131949.38051.list-receive@mneisen.org> <20070513182405.GA13618@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Eisenhardt <martin.eisenhardt@mneisen.org>,
	git <git@vger.kernel.org>, Matthieu.Moy@imag.fr
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 13 23:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnLCC-0006LC-KN
	for gcvg-git@gmane.org; Sun, 13 May 2007 23:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXEMVBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbXEMVBa
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 17:01:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53612 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbXEMVBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 17:01:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8CB467DC0A3;
	Sun, 13 May 2007 14:01:28 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 14:01:28 -0700
Content-Disposition: inline
In-Reply-To: <20070513182405.GA13618@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47181>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-13 19:49:34 +0200, Martin Eisenhardt wrote:
>=20
> > Another case where I stumbled upon said error message was when I
> > added an empty (sub)directory to a project in subversion and then
> > used git to track that project. Since git cannot track an empty
> > directory, it did not appear in my git working copy. When I mkdir'd
> > the directory locally (in my git wc) and then tried to add files
> > within that repository, I got exactly the same error as Matthieu.

Interesting.  I don't think git-svn currently checks for that case.

> It might be a net win to let git-svn handle empty directories by
> creating an empty .git-svn-empty-dir file in them, instead of
> pretending they don't exist.

No.  This is *WAY* too ugly.

--=20
Eric Wong
