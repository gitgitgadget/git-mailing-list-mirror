From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Clean up sha1 file writing
Date: Sun, 4 Jun 2006 11:39:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041136180.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <E1Fixs4-0005pD-10@moooo.ath.cx>
 <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org> <44808710.1080000@zytor.com>
 <Pine.LNX.4.64.0606021416040.5498@g5.osdl.org> <4483259A.7090806@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 04 20:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmxVf-0000GV-7A
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 20:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWFDSjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFDSjW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 14:39:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750897AbWFDSjV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 14:39:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54IdH2g004025
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 11:39:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54IdGsU021520;
	Sun, 4 Jun 2006 11:39:16 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4483259A.7090806@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21275>



On Sun, 4 Jun 2006, H. Peter Anvin wrote:
> 
> Or if you're getting a SIGWINCH in the middle of it.
> 
> Any POSIX system will interrupt the transfer and return a short read on
> receiving a signal.

Only for interruptible fd's, though, which normally a real "file" won't 
be.

		Linus
