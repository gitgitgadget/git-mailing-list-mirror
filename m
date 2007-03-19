From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 11:48:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 19:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTMui-0000Rs-Dx
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 19:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbXCSSs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 14:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXCSSs6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 14:48:58 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48409 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbXCSSs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 14:48:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JImZcD003166
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 11:48:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JImYDG014267;
	Mon, 19 Mar 2007 10:48:34 -0800
In-Reply-To: <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
X-Spam-Status: No, hits=-0.483 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42652>



On Mon, 19 Mar 2007, Nicolas Pitre wrote:
> 
> And some will argue that explicit renames are susceptible to user error 
> misidentifying the rename too, certainly in the 1% figure of all renames 
> if not more.

It's much worse than that. I will *guarantee* that renames are missed when 
they come in as traditional patches, for example. That's a 100% error rate 
right there, not some "1%" one.

And even if people never make mistakes, and people *only* use the native 
SCM "rename" functions, I guarantee that the downsides of thinking that 
files have identities is still much much bigger than the upsides. We've 
already shown that the git "blame" functionality is strictly more powerful 
than anything based on renames.

So learn to love the bomb. Rename tracking is *wrong*. 

		Linus
