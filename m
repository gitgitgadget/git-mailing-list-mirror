From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 09:11:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702020908150.15057@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <200702021759.22603.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 18:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD1wh-00067A-Vt
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 18:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbXBBRLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 12:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbXBBRLY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 12:11:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59231 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945963AbXBBRLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 12:11:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12HBI43010003
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 09:11:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12HBGVh012958;
	Fri, 2 Feb 2007 09:11:17 -0800
In-Reply-To: <200702021759.22603.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.42 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38516>



On Fri, 2 Feb 2007, Jakub Narebski wrote:
> 
> Well, in git you can have private tags (anything not under refs/tags
> or under refs/heads is by default private), but I think you can only
> have not published branches (which are not pushed to public repository).
> If it is not true, then how one can have private branches 
> (i.e. branches which 'push --all' would not push)?

I have private branches, I just don't push them. The same thing is true of 
tags. 

Anybody who actually publishes his own git directory *directly* to pthers 
is probably insane. It's like showing your home directory. You just 
shouldn't do it. So anything in a real development archive is - by 
definition - "private". Only when you actually expose it explicitly (by 
exporting it at some public place) do things become public.

But if you tie your tags to history, you *have* to push them as you push 
the history.

So again, this is not about private vs public. The bug is not there. The 
bug is thinking that you should make tags part of your history.

		Linus
