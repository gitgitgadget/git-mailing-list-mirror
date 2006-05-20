From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk highlight feature
Date: Sat, 20 May 2006 10:07:28 +1000
Message-ID: <17518.24000.952384.563448@cargo.ozlabs.ibm.com>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
	<Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
	<17496.7073.507895.484698@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 02:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhF0L-0006Td-OQ
	for gcvg-git@gmane.org; Sat, 20 May 2006 02:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWETAHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWETAHf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 20:07:35 -0400
Received: from ozlabs.org ([203.10.76.45]:35299 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751441AbWETAHe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 20:07:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id DA1DB67A64; Sat, 20 May 2006 10:07:33 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20367>

Linus Torvalds writes:

> But the real thing I found is that when I decided I wanted to highlight, I 
> didn't actually want to highlight by "git-rev-list" at all. At least not 
> most of the time.

I just pushed some changes to the "new" branch of the gitk.git
repository which change the way we do highlighting.  There is now a
row of controls across the middle of the window, just below the row
containing the sha1 ID, "Find" button, etc., which controls the
highlighting.  There are (currently) three ways to do highlighting: by
path, by view, and by author/committer.  The author/committer matching
is case-insensitive (since I'm clearly an insensitive sort of guy :)
and matches any of the given strings anywhere in the author and
committer fields.  The path and author/committer entry widgets take a
whitespace-delimited list of paths or names of interest, using shell
quoting rules, so you can put for example:

"david s. miller" benh

in there and you'll get commits from either davem or benh highlighted.

Do people think this is useful and on the right track interface-wise?

Paul.
