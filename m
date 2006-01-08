From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I apply a single "change"
Date: Sat, 7 Jan 2006 18:24:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601071823550.3169@g5.osdl.org>
References: <20060108005152.46315.qmail@web31813.mail.mud.yahoo.com>
 <43C06892.2030709@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ltuikov@yahoo.com, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 03:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvQEg-0006PT-5w
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 03:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWAHCYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 21:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWAHCYn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 21:24:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161143AbWAHCYm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 21:24:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k082OYDZ009539
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 7 Jan 2006 18:24:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k082OVAi004528;
	Sat, 7 Jan 2006 18:24:33 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C06892.2030709@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14305>



On Sun, 8 Jan 2006, Andreas Ericsson wrote:
> 
> You can't. cherry-pick doesn't work on remote repos, so you need to pull that
> branch to a local one first.

"fetch", not "pull".

It's easy enough to get confused anyway, so we should be careful.

		Linus
