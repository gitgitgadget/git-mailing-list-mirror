From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in git.git (stable)
Date: Sun, 4 Feb 2007 11:12:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
 <20070204185144.GB24368@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 20:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDmn3-0008Tg-HV
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 20:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbXBDTMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 14:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbXBDTMk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 14:12:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47256 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbXBDTMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 14:12:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l14JCZQ5014646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Feb 2007 11:12:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l14JCYBZ002708;
	Sun, 4 Feb 2007 11:12:34 -0800
In-Reply-To: <20070204185144.GB24368@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.381 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38701>



On Sun, 4 Feb 2007, Jeff King wrote:
> 
> Just a thought, but it might be useful to blame the contents of an
> arbitrary file (but starting the history at a given pathname). Something
> like "git blame --contents /tmp/foo.c file.c", with contents defaulting
> to "file.c". There's much discussion of editor interfaces, and this
> leaves the possibility of git-blaming the contents of the editor buffer
> (after writing it out to a temp file) without having to save changes to
> the working tree file.

I agree, that probably would make most sense. If we do this at all. On the 
other hand, I suspect that most editors would probably want to pipe the 
contents to the program, not write it to a temp-file.

(I think it's a worthy feature, but Junio's patch wasn't exactly pretty, 
so the question boils down to whether it's really worth it).

		Linus
