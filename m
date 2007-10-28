From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Sat, 27 Oct 2007 22:34:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 06:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im0n0-0005pt-Qk
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 06:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbXJ1FeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 01:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXJ1FeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 01:34:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60696 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740AbXJ1FeG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2007 01:34:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9S5Y13u019001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Oct 2007 22:34:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9S5Y1ON018928;
	Sat, 27 Oct 2007 22:34:01 -0700
In-Reply-To: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.736 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62522>



On Sun, 28 Oct 2007, Paul Mackerras wrote:
>
> I just pulled the dev branch of gitk into the master branch, so the
> master branch now has the new features and improvements that I have
> been working on, namely:

*Huge* improvements. It is now really nice to start up gitk even on the 
full kernel history.

However, that crazy green bar chasing back-and-forth int he "reading" 
phase is really quite visually distracting. Maybe it looks better in 
Tk8.5, but it does look pretty annoying in the version I have. Can you 
tone that down a bit? 

But this has both the layout performance improvements and the fixes to 
only show selected files in the diff view by default, so I hope this gets 
merged into standard git soon..

		Linus
