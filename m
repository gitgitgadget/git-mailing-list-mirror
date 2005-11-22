From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Mon, 21 Nov 2005 19:38:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511211931350.13959@g5.osdl.org>
References: <20051122032014.32539.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 04:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeOzO-0001Cd-N7
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 04:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVKVDiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 22:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVKVDiV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 22:38:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750850AbVKVDiV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 22:38:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAM3cDnO028782
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 19:38:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAM3cCii018934;
	Mon, 21 Nov 2005 19:38:12 -0800
To: linux@horizon.com
In-Reply-To: <20051122032014.32539.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12518>



On Mon, 21 Nov 2005, linux@horizon.com wrote:
> 
> Actually, most indentation-sensitive languages have a simpler solution:
> they don't try to convert whitespace strings to a number like "horizontal
> position"; they just compare strings.

Yes, but that doesn't really change the problem: you can't _visually_ see 
what is wrong in most editors (some editors end up showing tabs as 
something that isn't quite whitespace, but that's also really irritating).

This is like Makefiles: if you have spaces in the wrong place, it may all 
_look_ fine, but the Makefile just doesn't work. Really irritating.

And obviously using the file will show the problem (the parser will 
complain with a nice line number and readable error, hopefully), but I 
personally find that to just be too damn late. By then, you're already 
irritated.

So I like the notion of depending on indentation, but I just feel it falls 
down in practice. 

Of course, since I believe that tabs are always exactly 8 characters, I'd 
also be perfectly happy to just declare that anybody who disagrees with me 
is a moron and deserves to die (*).

		Linus

(*) That's obviously true of _anything_ that people disagree with me on,
but at the same time, I have this nagging suspicion that it's just better 
to not depend on indentation.
