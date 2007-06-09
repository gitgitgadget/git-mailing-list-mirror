From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: That improved git-gui blame viewer..
Date: Sat, 9 Jun 2007 11:26:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5eN-0005Ah-OK
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbXFIS06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbXFIS06
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:26:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55200 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756782AbXFIS05 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 14:26:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l59IQoYg007735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jun 2007 11:26:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l59IQj37010062;
	Sat, 9 Jun 2007 11:26:45 -0700
X-Spam-Status: No, hits=-2.76 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49602>


Shawn, could you please push it out somewhere else than just "pu", and 
convince Junio to merge it? Right now, "git gui blame" is almost useless 
in the standard git tree, and maybe the new one has some bugs, but it's at 
least _useful_ (and about a million times prettier than it used to be), so 
I don't think you can possibly regress in this area.

That said, I do have one comment about the state of git-gui "pu".. I think 
it's fairly pretty, and definitely useful, but one feature I end up really 
wishing for is a "search" button (or Ctrl-F). I might not know what 
line-number I'm looking for, I'm more likely to know which function I want 
to look at, and the most natural way to find it is with a simple ctrl-F.

Maybe it exists, but if so, I didn't find it.

But the old git-gui blame viewer didn't have that either, so this 
shouldn't hold up getting a useable git-gui into the standard git distro..

		Linus
