From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH] git-add.txt: document 'add.ignoreErrors'
Date: Wed, 4 May 2011 21:58:17 +0200
Message-ID: <20110504195817.GL2211@kudu.in-berlin.de>
References: <20110501045140.GA13387@sigill.intra.peff.net> <1304343872-1654-3-git-send-email-valentin.haenel@gmx.de> <7v1v0hngs9.fsf@alter.siamese.dyndns.org> <20110503153857.GC2211@kudu.in-berlin.de> <7vbozjipmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 21:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHiDX-0002uo-GI
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1EDT6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 15:58:33 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:45087 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab1EDT6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 15:58:32 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p44JwITn019424;
	Wed, 4 May 2011 21:58:18 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p44JwHXM019423;
	Wed, 4 May 2011 21:58:17 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin.haenel@gmx.de using -f
Content-Disposition: inline
In-Reply-To: <7vbozjipmp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172765>

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Noticed-by: Junio C Hamano <gitster@pobox.com>
---

* Junio C Hamano <gitster@pobox.com> [110503]:
> Valentin Haenel <valentin.haenel@gmx.de> writes:
> >>  	If some files could not be added because of errors indexing
> >>  	them, do not abort the operation, but continue adding the
> >>  	others. The command shall still exit with non-zero status.
> >> +	The configuration variable `add.ignoreErrors` can be set to
> >> +	true to make this the default behaviour.
> >
> > Its unrelated to 'interactive.singlekey', can i 'stuff' it into the
> > series too, or better make a seperate one?
> 
> Yes, this is totally unrelated; I just wanted to write it down so somebody
> remembers.  Please make it a separate patch that comes before anything
> else.

here you go.

 Documentation/git-add.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7eebbef..35cb5d3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -134,6 +134,8 @@ subdirectories.
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
+	The configuration variable `add.ignoreErrors` can be set to
+	true to make this the default behaviour.
 
 --ignore-missing::
 	This option can only be used together with --dry-run. By using
-- 
1.7.1
