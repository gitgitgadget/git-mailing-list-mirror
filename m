From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: unlink internal index files after operations
Date: Fri, 14 Dec 2007 00:29:45 -0800
Message-ID: <20071214082945.GA19559@soma>
References: <20071213162734.GA18433@soma> <20071213202757.GA2387@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 09:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35vt-0005yi-2O
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 09:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbXLNI3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 03:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbXLNI3r
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 03:29:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59863 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828AbXLNI3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 03:29:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BA2667DC025;
	Fri, 14 Dec 2007 00:29:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071213202757.GA2387@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68263>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-13 08:27:34 -0800, Eric Wong wrote:
>=20
> > Being git, we can generate these very quickly on the fly as needed,
> > so there's no point in wasting space for these things for large
> > projects.
>=20
> Excellent!
>=20
> For existing repos, I assume the correct thing to do is to just blast
> all the existing index files manually?

Yes.  index files inside $GIT_DIR/svn have always been safely deletable
(except while a git-svn is actually running :).

I'll probably work on an automated full migration strategy at some
point (handling rev_db =3D> rev_map, mainly) when I have time.

--=20
Eric Wong
