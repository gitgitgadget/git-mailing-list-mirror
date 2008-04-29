From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 19:14:13 -0700
Message-ID: <20080428191413.6aa79054.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
	<20080428143501.7d6e3ad0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
	<alpine.LFD.1.10.0804281512110.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 04:15:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqfN2-0003oN-AP
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 04:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYD2COQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 22:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYD2COQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 22:14:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54497 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909AbYD2COP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 22:14:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3T2EDNM029450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 19:14:14 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3T2EDBm028819;
	Mon, 28 Apr 2008 19:14:13 -0700
In-Reply-To: <alpine.LFD.1.10.0804281512110.3119@woody.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.773 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80640>

On Mon, 28 Apr 2008 15:14:20 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Mon, 28 Apr 2008, Linus Torvalds wrote:
> > 
> > I don't actually see what was wrong with the old script.  The merge was
> > really oddly done, but apart from that, something like this should work
> > (just your old script with some trivial fixes to 'git merge' and using
> > somewhat saner arguments):
> 
> Side note: you are still going to have *exactly* the same issue if you 
> have other git trees (not origin) that contain the same patch. 
> 

yup.  The same-patch-in-two-trees problem is surprisingly rare.
