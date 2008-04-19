From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 15:54:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain>
 <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:54:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLxQ-0003ut-IS
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbYDSWyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYDSWyL
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:54:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52220 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503AbYDSWyK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 18:54:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMs50o032121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 15:54:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMs4u1003928;
	Sat, 19 Apr 2008 15:54:04 -0700
In-Reply-To: <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.442 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79932>



On Sat, 19 Apr 2008, Linus Torvalds wrote:
> 
> This patch will help.

Pieter? Assuming the lstat() cost is the dominant one, it should cut down 
your "git status ." cost by about 15-20% or so. Can you confirm?

		Linus
