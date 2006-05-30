From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bisects that are neither good nor bad
Date: Mon, 29 May 2006 17:46:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291744390.5623@g5.osdl.org>
References: <20060529225632.7073.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paul@permanentmail.com, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 02:46:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FksNl-0005sy-NR
	for gcvg-git@gmane.org; Tue, 30 May 2006 02:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWE3Aqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWE3Aqq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 20:46:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751266AbWE3Aqp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 20:46:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U0kX2g029275
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 17:46:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U0kWd8022844;
	Mon, 29 May 2006 17:46:32 -0700
To: linux@horizon.com
In-Reply-To: <20060529225632.7073.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21002>



On Mon, 29 May 2006, linux@horizon.com wrote:
> 
> It's also worth repeating some advice from the manual:
> 
> >> You can further cut down the number of trials if you know what part of
> >> the tree is involved in the problem you are tracking down, by giving
> >> paths parameters when you say bisect start, like this:
> >>
> >> $ git bisect start arch/i386 include/asm-i386

I'm not 100% sure this works - I think it has problems with the ending 
condition because there always ends up being more commits in between when 
the commit space isn't dense, so the "no commits left" thing doesn't 
trigger. But "git bisect visualize" should hopefully help make it obvious

		Linus
