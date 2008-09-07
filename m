From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] RevWalk: Fix RevSort.REVERSE combined with
	RevSort.TOPO
Date: Sun, 7 Sep 2008 14:32:27 -0700
Message-ID: <20080907213227.GB15460@spearce.org>
References: <1220821208-13420-1-git-send-email-spearce@spearce.org> <200809072321.59789.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 23:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcRxk-0001qI-1Y
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 23:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYIGVc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2008 17:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYIGVc2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 17:32:28 -0400
Received: from george.spearce.org ([209.20.77.23]:39256 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYIGVc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 17:32:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8A7283835C; Sun,  7 Sep 2008 21:32:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809072321.59789.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95179>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=C3=B6ndagen den 7 september 2008 23.00.08 skrev Shawn O. Pearce:
> > From: Shawn O. Pearce <sop@google.com>
> >=20
> > The reverse sort was using the initial pending queue, not the
> > generator that comes before it in the workflow.  This caused
> > a combination of TOPO and REVERSE to return no commits.
>=20
> Some unit tests to back this up would be nice. We running low on
> coverage in this section of code.

Yea, I know.  Its way back on my things-to-do list.  Right now I'm
a bit too swamped with day-job to try and put unit tests into the
revwalk package.  There's two open issues on the issue tracker that
tests should be able to cover and permit debugging of.

I'll come back to revwalk tests.  I did some tests for treewalk
not too long ago, but even more are still need there too.  And lets
not even mention the transport package.  ;-)

I ran into this bug because I was relying on RevWalk in my day-job
project.  When it barfed I fixed it, and moved on.
=20
> > Signed-off-by: Shawn O. Pearce <sop@google.com>
>=20
> No idea Google employees had this short email addresses.  Ok, 27x27x2=
7 =3D 19683=20
> would be sufficient in theory, I'd suppose.

Yea, you can get a short address if you ask nicely.  Given that
everything is email based its nice having a short address.  Makes it
easy to tell others in person how to reach me.  Fortunately most
of the company uses longer addresses, so three (and four) letter
words are still available.

I must not have my egit.git repository configured right on my
work laptop.  I usually don't do egit work there.

--=20
Shawn.
