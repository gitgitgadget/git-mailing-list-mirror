From: Jeff King <peff@peff.net>
Subject: [PATCH] cat-file: document -p option
Date: Wed, 24 May 2006 21:22:32 -0400
Message-ID: <20060525012232.GA14486@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <7vslmz5ewt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605241631340.5623@g5.osdl.org> <7virnv3qi6.fsf@assigned-by-dhcp.cox.net> <20060524203108.70b6c596.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 03:22:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj4Yh-0001J5-5l
	for gcvg-git@gmane.org; Thu, 25 May 2006 03:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWEYBWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 21:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWEYBWf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 21:22:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:51193 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S964802AbWEYBWe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 21:22:34 -0400
Received: (qmail 12814 invoked from network); 25 May 2006 01:22:32 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 25 May 2006 01:22:32 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2006 21:22:32 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060524203108.70b6c596.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20715>

---
On Wed, May 24, 2006 at 08:31:08PM -0400, Sean wrote:
> $ meld sha1_file.c <(git cat-file -p c2f493a4ae:sha1_file.c)

I had never seen the -p option, and it wasn't in the Documentation. Let
me know if I've gotten its function completely wrong. :)

-Peff

 Documentation/git-cat-file.txt |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 504eb1b..5e9cbf8 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -8,12 +8,12 @@ git-cat-file - Provide content or type i
 
 SYNOPSIS
 --------
-'git-cat-file' [-t | -s | -e | <type>] <object>
+'git-cat-file' [-t | -s | -e | -p | <type>] <object>
 
 DESCRIPTION
 -----------
 Provides content or type of objects in the repository. The type
-is required unless '-t' is used to find the object type,
+is required unless '-t' or '-p' is used to find the object type,
 or '-s' is used to find the object size.
 
 OPTIONS
@@ -33,6 +33,9 @@ OPTIONS
 	Suppress all output; instead exit with zero status if <object>
 	exists and is a valid object.
 
+-p::
+	Pretty-print the contents of <object> based on its type.
+
 <type>::
 	Typically this matches the real type of <object> but asking
 	for a type that can trivially be dereferenced from the given
@@ -49,6 +52,8 @@ If '-s' is specified, the size of the <o
 
 If '-e' is specified, no output.
 
+If '-p' is specified, the contents of <object> are pretty-printed.
+
 Otherwise the raw (though uncompressed) contents of the <object> will
 be returned.
 
-- 
1.3.3.g4d548
