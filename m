From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/5] Teach receive-pack to run pre-receive/post-receive
 hooks
Date: Wed, 7 Mar 2007 15:31:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703071522030.5963@woody.linux-foundation.org>
References: <20070307215205.GE28649@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:32:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5cN-0002Fo-II
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992741AbXCGXcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992740AbXCGXcE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:32:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37881 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965740AbXCGXcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:32:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l27NVvq8005999
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Mar 2007 15:31:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l27NVukV012883;
	Wed, 7 Mar 2007 15:31:56 -0800
In-Reply-To: <20070307215205.GE28649@spearce.org>
X-Spam-Status: No, hits=-0.984 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41703>



On Wed, 7 Mar 2007, Shawn O. Pearce wrote:
> 
> To help this situation I am introducing two new hooks to the
> receive-pack flow: pre-receive and post-receive.  These new hooks
> are invoked only once per receive-pack execution and are passed
> three arguments per ref (refname, old-sha1, new-sha1).

Can you give a concise explanation of how "pre-receive" differ from the 
old "update", and how does "post-receive" differ from the old 
"post-update"?

		Linus
