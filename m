From: Sean Boudreau <seanb@qnx.com>
Subject: Re: Git on QNX
Date: Wed, 16 Dec 2009 20:37:39 -0500
Message-ID: <20091217013739.GG17970@qnx.com>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com> <7v6387zzfi.fsf@alter.siamese.dyndns.org> <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com> <loom.20091216T233122-388@post.gmane.org> <905315640912161703u3920178cm93851ddc8480ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	mkraai@beckman.com
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 02:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL5Pj-0000t9-Gn
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 02:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936120AbZLQBno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 20:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762556AbZLQBni
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 20:43:38 -0500
Received: from qnxmail.qnx.com ([209.226.137.76]:2436 "EHLO qnxmail.qnx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758559AbZLQBne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 20:43:34 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2009 20:43:33 EST
Received: from Nebula.ott.qnx.com (nebula.ott.qnx.com [10.42.3.30])
	by hub.ott.qnx.com (8.9.3/8.9.3) with ESMTP id UAA07299;
	Wed, 16 Dec 2009 20:37:33 -0500
Received: from qnx.com ([192.168.20.114]) by Nebula.ott.qnx.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Dec 2009 20:37:41 -0500
Received: (from seanb@localhost)
	by qnx.com (8.14.3/8.14.3/Submit) id nBH1bd0O005805;
	Wed, 16 Dec 2009 20:37:39 -0500
Content-Disposition: inline
In-Reply-To: <905315640912161703u3920178cm93851ddc8480ac8@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 17 Dec 2009 01:37:41.0596 (UTC) FILETIME=[860451C0:01CA7EB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135354>

On Wed, Dec 16, 2009 at 05:03:16PM -0800, Tarmigan wrote:
> On Wed, Dec 16, 2009 at 2:38 PM, Sean Boudreau <seanb@qnx.com> wrote:
> > What version of qnx is this on. =A0<strings.h> is
> > now brought in by <string.h> and the lock() /
> > unlock() prototypes have been removed from <unistd.h>
> > AS OF 6.4.1 (the current release).
>=20
> Ahh, that's nice.  At a client's request, I have been working on QNX =
6.3.2.
>=20
> I just installed 6.4.1 in another VM, and it's a bit different.  The
> common way to handle binary packages (iconv and perl) seems to have
> changed to pkg_add so the PATHs I had set might not make sense
> anymore.
>=20
> Also the weird failing test at t0000.42 seems to be fixed.  Funny.
>=20
> As I might be the only person to run git on 6.3.2 instead of a more
> modern QNX, it might make sense for me to just submit the minimum
> patches needed for QNX 6.4.1 and then carry the strings.h,
> getpagesize, and lock() changes for 6.3.2 on my own.

That's why I spoke up :)

>=20
> > There's a package for git-4.3.20 here that also has a work around
> > for the SA_RESTART issue.
>=20
> I think that might be a different program that also used to be named
> "git".  I think it has now been renamed gnuit.

You're probably right, try this one:

ftp://ftp.netbsd.org/pub/pkgsrc/packages/QNX/i386/6.4.1_head_20090724/A=
ll/scmgit-base-1.6.2.5.tgz


-seanb=20
