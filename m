From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 17:44:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181735480.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 02:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0nt-00077I-KQ
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDSAoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWDSAoS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:44:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbWDSAoS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 20:44:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J0iEtH028273
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 17:44:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J0iDmk000412;
	Tue, 18 Apr 2006 17:44:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18893>



On Tue, 18 Apr 2006, Junio C Hamano wrote:
> 
> Yes, I wanted to do this myself for a while.  The only issue I
> might have is what the separator character between rev and path
> should be.

I didn't put a lot of thought into it, but using ':' not only is pretty 
visually pleasing, it also means that shell completion automatically works 
at least on bash, even without any git-specific completion rules.

That's not true for a lot of other special characters: colon really is 
special, exactly because it has been used for things like PATH separators, 
etc.

I'm a total filename completion junkie - I simply cannot type in a 
filename any more. I'll literally press <tab> to complete even short 
filenames, just because it gives me that nice confirmation of the 
existence of the filename (ie I've typed it all in, and the <tab> adds the 
space after the filename).

So to me, ':' is just clearly superior. I can't think of any other 
separator that works with filename completion and has no shell issues, 
_and_ looks logical.

And I thought we already disallowed ':' in branch names because cogito 
uses them for the strange <rev>:<rev> syntax.. 

		Linus
