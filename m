From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 12:09:17 -0700
Message-ID: <20080428120917.dd9f01e8.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
	<20080428114509.240ef4ae.akpm@linux-foundation.org>
	<alpine.DEB.1.00.0804281948270.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:11:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYl3-00042c-N9
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966436AbYD1TJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966432AbYD1TJq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:09:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52635 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966419AbYD1TJp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 15:09:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJ9HTT020908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2008 12:09:18 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3SJ9HF4010553;
	Mon, 28 Apr 2008 12:09:17 -0700
In-Reply-To: <alpine.DEB.1.00.0804281948270.19187@eeepc-johanness>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80588>

On Mon, 28 Apr 2008 19:49:28 +0100 (BST) Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Mon, 28 Apr 2008, Andrew Morton wrote:
> 
> > hm, weirdness.
> > 
> > y:/usr/src/git26> git-diff origin...git-ia64   
> > y:/usr/src/git26> git-log origin...git-ia64 | wc -l
> > 15574
> > 
> > I'd have expected git-log to operate on the same patches as git-diff.
> > 
> > I'm sure there's a logical explanation for this ;)
> 
> Yes.  git-diff with "..." will show you the diff of git-ia64 since the 
> branch point, whereas log will show you _all_ the logs (both in origin and 
> in git-ia64) since the branch point.
> 

That's missing the "logical" bit :)

Oh well.  Can you suggest how I can extract the changelogs for the patches
which `git-diff origin...git-ia64' will print out?

Thanks.
