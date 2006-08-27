From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 13/19] gitweb: Add invisible hyperlink to from-file/to-file
 diff header
Date: Sat, 26 Aug 2006 20:38:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608262033000.11811@g5.osdl.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252105.07500.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 05:38:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHBU3-0006Z5-T5
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 05:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWH0Dih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 23:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWH0Dih
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 23:38:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbWH0Dig (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 23:38:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7R3cXnW028092
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 20:38:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7R3cWdL013579;
	Sat, 26 Aug 2006 20:38:33 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608252105.07500.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.934 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26084>



On Fri, 25 Aug 2006, Jakub Narebski wrote:
>
> Change replacing hashes as from-file/to-file with filenames from
> difftree to adding invisible (except underlining on hover/mouseover)
> hyperlink to from-file/to-file blob.  /dev/null as from-file or
> to-file is not changed (is not hyperlinked).

Wouldn't it be even better to have the hyperlink (or a new, separate one) 
point to the history for that file, too?

That way, you can go to the commit-diff, and when you see a diff for a 
file, you can easily just ask for the whole history for that file. As it 
is, you can get that, but only by going to the "commit" thing, not from 
the "commit-diff" thing.

Alternatively, maybe commit-diff should have a header with the files it 
changes (ie it would truly be a superset of the "commit" case)? That might 
be even nicer, since you'd not have to scroll through a potentially big 
diff for other files in order to get to the one you care about.

(If you do the "header with changed files", each file could have the same 
three buttons as in the "commit" view: "blob" (pointing to the blob), 
"diff" (which just points to _within_ the current window, so that you can 
get to the start of that particular file diff) and "history" (which 
obviously does what the "commit" case does too - generate a history page).

			Linus
