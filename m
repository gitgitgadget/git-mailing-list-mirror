From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 12:22:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261221530.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261207520.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262117160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 21:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLmMW-0006PM-BF
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbXBZUWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbXBZUWR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:22:17 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60534 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161010AbXBZUWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:22:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QKMAhB005409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 12:22:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QKM9kF030217;
	Mon, 26 Feb 2007 12:22:10 -0800
In-Reply-To: <Pine.LNX.4.63.0702262117160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.446 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40663>



On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> 
> > So I'd rather have it return true if it matches, rather than false if it 
> > matches and -1/1 if it doesn't. But that's water under the bridge.
> 
> In that case, you'd have to name it has_prefix() or hasprefix() rather 
> than prefixcmp(), which C programmers used to the semantics of strcmp() 
> expect to return a tristate result.

Sure. Or "match_prefix()" or whatever. I agree.

		Linus
