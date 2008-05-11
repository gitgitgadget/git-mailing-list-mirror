From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 09:52:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>  <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org> <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve French <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEnL-0003We-GQ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbYEKQwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYEKQwP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:52:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35879 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566AbYEKQwO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 12:52:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BGqBwI024283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 May 2008 09:52:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BGqAq3014918;
	Sun, 11 May 2008 09:52:10 -0700
In-Reply-To: <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81792>



On Sun, 11 May 2008, Steve French wrote:
>
> I am puzzled why I see multiple messages like:
> 
> Merge branch 'master' of /.../torvalds/linux-2.6
> 
> when using:
> 
> git-request-pull origin
> git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
> 
> I only pulled once (the initial pull after your previous merge of
> cifs-2.6.git tree, but before I added more patches).

You definitely pulled more than once. There's four merges by you. They 
don't happen by themselves. There's one on April 25, one on the 27th, one 
on the 28th, and then a final one on May 6th.

Maybe you'd just forgotten that you did the three previous ones, because 
there's a delay of a week between those and the last one.

		Linus
