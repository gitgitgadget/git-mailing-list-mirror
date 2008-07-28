From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Improve the placement of core.trustctime in the
	documentation
Date: Mon, 28 Jul 2008 23:47:16 +0200
Message-ID: <20080728214716.GB3721@blimp.local>
References: <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728162043.GG32184@machine.or.cz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiQQ-0007v7-Nq
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbYG2GKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYG2GKL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:10:11 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:14866 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYG2GKH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:10:07 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf50O7
Received: from tigra.home (Fae3d.f.strato-dslnet.de [195.4.174.61])
	by post.webmailer.de (fruni mo63) (RZmta 16.47)
	with ESMTP id 203b95k6T23RhX ; Tue, 29 Jul 2008 08:10:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id A385A277C6;
	Tue, 29 Jul 2008 08:10:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 0466636D19; Mon, 28 Jul 2008 23:47:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080728162043.GG32184@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90588>

Accidentally, it split a _chapter_ about a file data corrup...
conversion for a weird, but common operating system.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Petr Baudis, Mon, Jul 28, 2008 18:20:43 +0200:
> On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 1a13abc..552c134 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -149,6 +149,13 @@ core.safecrlf::
> >  	`core.autocrlf`, git will reject the file.  The variable can
> >  	be set to "warn", in which case git will only warn about an
> >  	irreversible conversion but continue the operation.
> > +
> > +core.trustctime::
> > +	If false, the ctime differences between the index and the
> > +	working copy are ignored; useful when the inode change time
> > +	is regularly modified by something outside Git (file system
> > +	crawlers and some backup systems).
> > +	See linkgit:git-update-index[1]. True by default.
> >  +
> >  CRLF conversion bears a slight chance of corrupting data.
> >  autocrlf=true will convert CRLF to LF during commit and LF to
> 
> Somehow, this particular position of the new hunk does not feel like the
> best choice. ;-)
> 

It's alphabetical. Why? Oh, shit... Screw alphabetical

 Documentation/config.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 552c134..61c3760 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,6 +117,13 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See linkgit:git-update-index[1]. True by default.
 
+core.trustctime::
+	If false, the ctime differences between the index and the
+	working copy are ignored; useful when the inode change time
+	is regularly modified by something outside Git (file system
+	crawlers and some backup systems).
+	See linkgit:git-update-index[1]. True by default.
+
 core.quotepath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
@@ -149,13 +156,6 @@ core.safecrlf::
 	`core.autocrlf`, git will reject the file.  The variable can
 	be set to "warn", in which case git will only warn about an
 	irreversible conversion but continue the operation.
-
-core.trustctime::
-	If false, the ctime differences between the index and the
-	working copy are ignored; useful when the inode change time
-	is regularly modified by something outside Git (file system
-	crawlers and some backup systems).
-	See linkgit:git-update-index[1]. True by default.
 +
 CRLF conversion bears a slight chance of corrupting data.
 autocrlf=true will convert CRLF to LF during commit and LF to
-- 
1.6.0.rc0.76.g581e
