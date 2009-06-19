From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: help, bunch of extra files in "git status" output
Date: Thu, 18 Jun 2009 18:18:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906181817360.16802@localhost.localdomain>
References: <4A3AE5E6.6010404@nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 03:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHSkj-0005OG-DK
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 03:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbZFSBSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 21:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZFSBSj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 21:18:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbZFSBSj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 21:18:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5J1IchC016434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 18:18:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5J1Ib4u017614;
	Thu, 18 Jun 2009 18:18:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A3AE5E6.6010404@nortel.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.471 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121880>



On Thu, 18 Jun 2009, Chris Friesen wrote:
> 
> Now when I do "git status" it shows about 600 filenames in the
> "Untracked files" section.  How do I return my tree to a clean state?
> Can I just delete all these files?

Yes. You can do "git clean -dqfx" and it will delete any files that aren't 
listed in the index.

		Linus
