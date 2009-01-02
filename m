From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 10:49:05 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901021045290.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain> <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIp73-0007lc-0W
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823AbZABStv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbZABStv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:49:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36923 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757281AbZABStv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 13:49:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02In5GW027202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Jan 2009 10:49:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02In5Yi006041;
	Fri, 2 Jan 2009 10:49:05 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104401>



On Fri, 2 Jan 2009, Johannes Schindelin wrote:
> 
> BTW the "-p" is not necessary with "show", indeed, you cannot even switch 
> it off.

I was just switching back-and-forth between "git log" and "git show" so 
the -p came from just that, and is not necessary.

And you _can_ suppress the patch generation - use "-s".

			Linus
