From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sat, 28 Jul 2007 19:06:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
References: <20070729002427.GA1566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 04:06:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEyBJ-0001Wv-Kg
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 04:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbXG2CGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 22:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbXG2CGu
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 22:06:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49085 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754708AbXG2CGu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 22:06:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6T26ifN030162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 19:06:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6T26c2N003109;
	Sat, 28 Jul 2007 19:06:39 -0700
In-Reply-To: <20070729002427.GA1566@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.725 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54075>



On Sat, 28 Jul 2007, Jeff King wrote:
> 
> The '-r' now seems to be superfluous.

For diffing against (or using) the index, the "-r" is superfluous.

Why? Because the index is always the *full* list of files. It's "flat".

However, when you diff two trees, the -r makes a difference.

So I think you'd find a difference if you actually diffed two commits 
with "git diff tree2..tree2".

		Linus
