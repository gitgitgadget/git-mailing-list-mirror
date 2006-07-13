From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fmt-merge-message problem..
Date: Wed, 12 Jul 2006 22:29:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607122222310.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org>
 <7vlkqyw0om.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 13 07:29:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0tlS-0000Us-O4
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWGMF31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGMF31
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:29:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751387AbWGMF31 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 01:29:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6D5TJnW010036
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 22:29:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6D5TETT012193;
	Wed, 12 Jul 2006 22:29:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkqyw0om.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23815>



On Wed, 12 Jul 2006, Junio C Hamano wrote:
> 
> Yes, this is a simple mistranslation from Perl to C.  A patch
> will follow shortly.

On a similar vein, how about this?

I always end up editing the revert sentence by hand to make grammatical 
sense.

I think we always talk about "commit xyz".

We never talk about "xyz commit", except when we end up talking about a 
commit as a branch head (notably, I would say "the HEAD commit", or 
possibly "the top-of-master commit", but here $commit is a SHA1 name, not 
anything else).

Hmm?

		Linus

---

diff --git a/git-revert.sh b/git-revert.sh
index de8b5f0..2bf35d1 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -84,7 +84,7 @@ revert)
 		s/^[^ ]* /Revert "/
 		s/$/"/'
 	echo
-	echo "This reverts $commit commit."
+	echo "This reverts commit $commit."
 	test "$rev" = "$commit" ||
 	echo "(original 'git revert' arguments: $@)"
 	base=$commit next=$prev
