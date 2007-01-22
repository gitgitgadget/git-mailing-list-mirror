From: Junio C Hamano <junkio@cox.net>
Subject: Re: error in tuto2?
Date: Sun, 21 Jan 2007 21:21:49 -0800
Message-ID: <7vwt3fvdoy.fsf@assigned-by-dhcp.cox.net>
References: <20070122020414.GA2399@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 06:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8rcw-0003tm-5u
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 06:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXAVFVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 00:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAVFVv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 00:21:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38506 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbXAVFVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 00:21:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122052150.CBVL15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 00:21:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E5N71W00w1kojtg0000000; Mon, 22 Jan 2007 00:22:08 -0500
To: calmar <mac@calmar.ws>
In-Reply-To: <20070122020414.GA2399@localhost> (mac@calmar.ws's message of
	"Mon, 22 Jan 2007 03:04:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37395>

calmar <mac@calmar.ws> writes:

> close at the end: git cat-file blob a6b11f7a
>
> shouldn't that be: git cat-file blob 8b9743b  ?

Interesting.  Indeed 'a6b11f7a' spells "goodbye, word" so the
example is at least internally consistent but still is wrong.

Thanks for catching.

---
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index f48894c..f363d17 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -343,8 +343,8 @@ And, as you can see with cat-file, this new entry refers to the
 current contents of the file:
 
 ------------------------------------------------
-$ git cat-file blob a6b11f7a
-goodbye, word
+$ git cat-file blob 8b9743b2
+goodbye, world
 ------------------------------------------------
 
 The "status" command is a useful way to get a quick summary of the
