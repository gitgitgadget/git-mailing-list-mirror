From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 6 Apr 2007 15:06:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704061502000.6730@woody.linux-foundation.org>
References: <20070406054204.GA13108@Hermes.local> <7v7ispjhtx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwbt-0000b7-E6
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbXDFWHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933264AbXDFWHb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:07:31 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35820 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933176AbXDFWGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:06:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l36M6XPD020191
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Apr 2007 15:06:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l36M6Xca020371;
	Fri, 6 Apr 2007 15:06:33 -0700
In-Reply-To: <7v7ispjhtx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.453 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43932>



On Fri, 6 Apr 2007, Junio C Hamano wrote:
> 
> I always wonder why people pay money to buy case insensitive
> filesystems (MacOS is not free, is it?).
> 
> More mysterious is that there apparently are peole who are paid
> to produce such systems (Apple has paid employees to work on
> MacOS, doesn't it?).

It's doubly strange, because:
 - it's basically impossible to do well
 - even *trying* to do it introduces other (even subtler) problems, like 
   locale-dependencies and trying to force some "canonical" encoding.

People who do it tend to universally do it because they haven't thought it 
through, and are supporting some older behaviour. And in the process they 
make their filesystem less reliable *and* slower.

		Linus
