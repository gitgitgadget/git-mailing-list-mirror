From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sun, 29 Jul 2007 09:51:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707290949150.3442@woody.linux-foundation.org>
References: <20070729002427.GA1566@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
 <20070729041159.GA5544@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
 <7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 18:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFBzT-0003x6-8W
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 18:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763928AbXG2Qvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763724AbXG2Qvc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 12:51:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52352 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763431AbXG2Qvb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 12:51:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6TGpN1j008516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 09:51:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6TGpHnk001256;
	Sun, 29 Jul 2007 09:51:17 -0700
In-Reply-To: <7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.726 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54125>



On Sat, 28 Jul 2007, Junio C Hamano wrote:
> 
> However, I think Jeff's patch always makes it recursive even
> when the user asks for --raw, which makes it inappropriate for
> inclusion whether before or after 1.5.3.

Well, that was kind of the point. Yes, it makrs it recursive even for 
--raw, but the fact is, "git diff" is _always_ recursive (even for --raw) 
for most common usage: anything that involves the index.

So "git diff" is fundamentally different from "git log" and "git show" and 
friends. "git diff" can work on the files and index, which "git log" and 
"git show" never do.

		Linus
