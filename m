From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 15:30:05 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
References: <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixsrg-0000OL-JR
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 00:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934485AbXK2Xbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934483AbXK2Xbc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 18:31:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35436 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934476AbXK2Xbb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 18:31:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATNU5l4020705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 15:30:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATNU5Ew012849;
	Thu, 29 Nov 2007 15:30:05 -0800
In-Reply-To: <20071129231444.GA9616@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.727 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66571>



On Thu, 29 Nov 2007, Jeff King wrote:
> 
> Yes, I am fine with the user having to go to extra lengths to use the
> dash forms (like adding $(libexecdir) to their path), which I think
> should address your consistency concern.

I agree. If we actually start moving the subcommands into a separate 
directory, I suspect scripts will be fixed up soon enough. Of course 
people *can* do it by just adding the path, but more likely, we'll just 
see people start doign "git xyz" instead of "git-xyz".

And from a consistency standpoint, that would be a *good* thing. There are 
many reasons why the git-xyz format *cannot* be the "consistent" form
(ranging from the flags like --bare and -p to just aliases), so 
encouraging people to move to "git xyz" is just a good idea.

Yeah, yeah, the man-pages need the "git-xyz" form, but on the other hand, 
rather than "man git-xyz", you can just do "git help xyz" instead, and now 
you're consistently avoiding the dash again!

			Linus
