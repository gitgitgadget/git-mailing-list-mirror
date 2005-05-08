From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH 0/2] core-git documentation update
Date: Sun, 08 May 2005 22:26:02 +0100
Message-ID: <427E83EA.2000104@dgreaves.com>
References: <427E4AE1.2040105@dgreaves.com> <7vd5s15up8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030307070505090605000203"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 23:21:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtB5-0007De-SQ
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVEHV0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVEHV0P
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:26:15 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:39335 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262980AbVEHV0I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:26:08 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 25502E6D4F; Sun,  8 May 2005 22:25:09 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26635-16; Sun,  8 May 2005 22:25:09 +0100 (BST)
Received: from oak.dgreaves.com (modem-413.leopard.dialup.pol.co.uk [217.135.145.157])
	by mail.ukfsn.org (Postfix) with ESMTP
	id E5264E6A8B; Sun,  8 May 2005 22:25:07 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUtHm-00062o-SK; Sun, 08 May 2005 22:26:02 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5s15up8.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307070505090605000203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:

>David, thanks for taking time to update the document.  I ended
>up hand merging your two patches since I had a bit more
>documentation updates in git-jc tree, so I'd like you to
>proofread the result.
>  
>
This merged fine.
Purely for editorial consistency I added "" around the command - see patch

The intention now was for me to go through Linus' HEAD and verify the
docs actually documented the HEAD.
Then I think comparing the HEAD to jit-jc and preparing patches for that?

>It is my understanding that if I have a correct patch result
>from your patch 1 and patch 2, I can throw away this message:
>
>    Subject: [FILES] core-git documentation update
>
>Am I correct?
>  
>
yes - that was just to assist people in reading the docs without having
to apply patches etc etc.

>I intend to keep not-so-controvercial stuff in git-jc tree, so
>that when Linus returns he can pull from it instead of patching
>from a pile of e-mails, potentially risking to leave good stuff
>in his mailbox during that process.
>  
>
I had hoped you'd pick this up in that manner - thanks

David
PS Removed Linus from cc

Add quotes for editorial consistency

Signed-off-by: David Greaves <david@dgreaves.com>
---




--------------030307070505090605000203
Content-Type: text/x-patch;
 name="core-git_editorial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="core-git_editorial.patch"

Documentation/core-git.txt: needs update
Index: Documentation/core-git.txt
===================================================================
--- 08cd7ce14ca4da7db37dce88e416e67b01f3452a/Documentation/core-git.txt  (mode:100644 sha1:e046119fcdd948dec81b11376ec9198e76a109af)
+++ uncommitted/Documentation/core-git.txt  (mode:100644)
@@ -503,7 +503,7 @@
 -m::
 	By default, files recorded in the index but not checked
 	out are reported as deleted.  This flag makes
-	git-diff-cache say that all non-checked-out files are up
+	"git-diff-cache" say that all non-checked-out files are up
 	to date.
 
 Output format

--------------030307070505090605000203--
