From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unable to index file
Date: Fri, 12 Dec 2008 12:33:42 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812121232561.3340@localhost.localdomain>
References: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com>  <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain> <f25d5ad20812121227o77cf2bw34e6bc15d9801215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ramon Tayag <ramon.tayag@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:35:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBEjZ-0004Aq-Sn
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 21:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYLLUeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYLLUeN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 15:34:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46096 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512AbYLLUeM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 15:34:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCKXhD2030315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 12:33:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCKXgrA025095;
	Fri, 12 Dec 2008 12:33:42 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f25d5ad20812121227o77cf2bw34e6bc15d9801215@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.425 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102942>



On Sat, 13 Dec 2008, Ramon Tayag wrote:
> 
> I'm on Ubuntu 8.10.  The files I'm working on live on an NTFS drive
> (my "storage" drive; yes, I still have to boot into Windows).  If it
> being on NTFS makes a difference I'll try this on ext3 and let you
> know what happens :)

Ok, it's almost certainly the NTFS part.

And at the same time, I'm almost certain that my patch should fix it and 
is the right thing for git to do anyway. 

		Linus
