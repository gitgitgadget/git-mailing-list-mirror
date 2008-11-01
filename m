From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 1 Nov 2008 10:51:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0811011047050.3483@nehalem.linux-foundation.org>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
 <20081028191234.GS24201@genesis.frugalware.org> <20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de> <m3prlffzk2.fsf@localhost.localdomain> <87abcjpvy2.fsf@mid.deneb.enyo.de> <20081101133931.GC8134@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Weimer <fw@deneb.enyo.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:54:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKfo-00035q-IC
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYKARwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYKARwx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:52:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34149 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735AbYKARww (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Nov 2008 13:52:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA1Hpqcv027783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Nov 2008 10:51:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA1HppRa020558;
	Sat, 1 Nov 2008 10:51:51 -0700
In-Reply-To: <20081101133931.GC8134@mit.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.442 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99753>



On Sat, 1 Nov 2008, Theodore Tso wrote:
> 
> .hgtags is stored as a versioned file in Mercurial.  That's one of the
> problems, and it leads to no shortage of headaches.

I told people this was insane long long ago, and I thought the hg people 
had learnt to use local tags. They act sanely, as far as I know (ie they 
act the same way git tags do).

Of course, the problem with hg local tags is that hg apparently has no 
sane way to _propagate_ such local tag-space information from one 
repository to another. But that's purely a problem with hg itself. I don't 
know why that hasn't gotten fixed.

			Linus
