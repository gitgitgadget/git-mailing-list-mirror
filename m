From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately
 to the log message
Date: Thu, 8 Feb 2007 16:29:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702081623460.8424@woody.linux-foundation.org>
References: <200702082158.56463.andyparkins@gmail.com>
 <200702082331.13095.andyparkins@gmail.com> <20070208234153.GB1556@spearce.org>
 <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJdn-0006RF-SF
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbXBIA3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965741AbXBIA3Y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:29:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46937 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965730AbXBIA3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:29:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l190TI3O008069
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 16:29:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l190THL4032061;
	Thu, 8 Feb 2007 16:29:17 -0800
In-Reply-To: <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.437 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39141>



On Thu, 8 Feb 2007, Junio C Hamano wrote:
> 
> This came up before, but when you have more than 9 in your
> series, we _could_ do [PATCH 01/12] ... [PATCH 12/12] to line
> them up in e-mail client of the recipients better.

Not just "line them up". It's more than just a visual thing.

So I long ago I asked Andrew to do that for me in his scripts, because 
when he sends me 150+ patches in one go, and I want to sort them to be in 
order, I can't depend on arrival order (because it won't be reliable) and 
I can't necessarily depend on date order (because he can send more than 
one patch a second), so what do I do? I sort by subject.

But I don't know of a _single_ email reader (and certainly not the one I 
use) that can "sort numerically by subject, using field #2". So it's a lot 
easier if the numbering is sorted _alphabetically_ rather than 
numerically.

Otherwise I tend to see things like

	[PATCH 1/89]
	[PATCH 10/89]
	[PATCH 11/89]
	...
	[PATCH 2/89]
	[PATCH 20/89]
	[PATCH 21/89]
	...

(note that this was mostly a problem just when syncing with Andrew: if the 
patch series is just in the teens or something, it may not sort easily, 
but you can just pick out the individual emails in order. When you have 
hundreds of patches, suddenly you realize that computers sorting them for 
you is really convenient).

			Linus
