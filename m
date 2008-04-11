From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: backdated tag bug
Date: Fri, 11 Apr 2008 13:36:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804111333270.3143@woody.linux-foundation.org>
References: <loom.20080411T193913-700@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkPzY-0007Ja-Po
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 22:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511AbYDKUgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 16:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbYDKUgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 16:36:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33255 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759292AbYDKUgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 16:36:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3BKa5Gp021649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2008 13:36:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3BKa4OR003227;
	Fri, 11 Apr 2008 13:36:04 -0700
In-Reply-To: <loom.20080411T193913-700@post.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79295>



On Fri, 11 Apr 2008, Eric Blake wrote:
>
> According to 'git tag --help', it should be possible to create a signed, back-
> dated tag.  But I can't get it to work.  Am I doing something wrong, or is this 
> a git bug?  Shell transcript follows:

Tags don't have an "author". They have a "tagger", and it's taken from the 
normal committer information. So you should use GIT_COMMITTER_DATE instead 
of GIT_AUTHOR_DATE and it should work.

		Linus
