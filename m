From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 11:02:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707261101580.3442@woody.linux-foundation.org>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> 
 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org> 
 <200707260115.13234.robin.rosenberg.lists@dewire.com> 
 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org> 
 <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com> 
 <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
 <81b0412b0707260951h57fc91dbsd5a0a126f0e16fee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7gY-0006u9-0N
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934576AbXGZSDd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934631AbXGZSDd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:03:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57913 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934473AbXGZSDc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 14:03:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6QI2vto004029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2007 11:02:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6QI2q6u013074;
	Thu, 26 Jul 2007 11:02:52 -0700
In-Reply-To: <81b0412b0707260951h57fc91dbsd5a0a126f0e16fee@mail.gmail.com>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53850>



On Thu, 26 Jul 2007, Alex Riesen wrote:
> > 
> > HP-UX? No pread()? It wouldn't link if it didn't have pread(). So it
> > clearly has pread(), it's just somehow broken.
> 
> I remember it didn't and was emulated with lseek.

So? The point is, that *works*. We do it ourselves.

"emulated with lseek" is trivial, and should work. It worries me that two 
totally independent systems are showing problems. There's something else 
going on here.

		Linus
