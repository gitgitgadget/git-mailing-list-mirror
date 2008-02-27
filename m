From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git svn log: add a note about timezones.
Date: Wed, 27 Feb 2008 14:13:00 +0100
Message-ID: <20080227131300.GT31441@genesis.frugalware.org>
References: <20080226124748.GH31792@mail.stoakes.net> <20080227073244.GB24316@soma> <20080227102631.GJ30300@mail.stoakes.net> <alpine.LSU.1.00.0802271039220.22527@racer.site> <20080227122929.GS31441@genesis.frugalware.org> <alpine.LSU.1.00.0802271231080.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Stoakes <tim@stoakes.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 14:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUM6c-00080j-Qz
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 14:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbYB0NNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 08:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbYB0NNG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 08:13:06 -0500
Received: from virgo.iok.hu ([193.202.89.103]:15140 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603AbYB0NNF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 08:13:05 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1A89B1B2542;
	Wed, 27 Feb 2008 14:13:02 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F2D2444668;
	Wed, 27 Feb 2008 14:10:28 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D6D0111904D7; Wed, 27 Feb 2008 14:13:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802271231080.22527@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75227>

git svn log mimics the timezone converting behaviour of svn log, but
this was undocumented.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Feb 27, 2008 at 12:33:22PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > git svn log mimics the timezone converting behaviour of svn log, but this was
>
> This line is definitely too long.  Please make commit messages readable on
> an 80-character display with a 4-character indent, i.e. 76
> characters/line.

right, corrected.

> Yes, very nice.  Although I find it sad that an opportunity was lost for a
> complainer to make good.

oops :(

> > ++
> > +NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
> > +client converts the UTC time to the local time (or based on the TZ=
> > +environment). This command has the same behaviour.
> >
> >  'blame'::
> >         Show what revision and author last modified each line of a file. This is
>
> I think that this note should come before the "Any other arguments" line.

moved.

 Documentation/git-svn.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 340f1be..bec9acc 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -159,6 +159,10 @@ New features:
 	our version of --pretty=oneline
 --
 +
+NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
+client converts the UTC time to the local time (or based on the TZ=
+environment). This command has the same behaviour.
++
 Any other arguments are passed directly to `git log'
 
 'blame'::
-- 
1.5.4
