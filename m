From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 16:19:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041615430.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <200606042144.45385.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0606041256480.5498@g5.osdl.org> <200606042325.58884.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 01:19:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn1sV-0000Ut-KG
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 01:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWFDXTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 19:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWFDXTY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 19:19:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbWFDXTY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 19:19:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54NJG2g013956
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 16:19:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54NJEa4027179;
	Sun, 4 Jun 2006 16:19:15 -0700
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <200606042325.58884.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21294>



On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
>
> Your patch assumes all files are text and the transformation doesn't corrupt 
> the file, which isn't true.

How do you think things get done? You test the _technology_ first, and 
then if that is shown to be workable in a real environment, _then_ do you 
actually add the polish to make it useful.

That was all the patch was. A technology demonstration. I'd really like to 
hear whether it works in a simple CR/LF environment, because if it 
doesn't, then it needs some totally different approach.

And yes, I could test it myself, but (a) I'm way too lazy and (b) I 
consciously try to get others involved because it's a better long-term 
strategy (because I expect to be ay too lazy in the future too)

		Linus
