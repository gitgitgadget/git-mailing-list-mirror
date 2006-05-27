From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 20:36:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605262033560.5623@g5.osdl.org>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
 <20060526193325.d2a530a4.tihirvon@gmail.com> <20060526163829.GB10488@pasky.or.cz>
 <1148697382.5599.1.camel@dv> <20060527025750.GM11941@pasky.or.cz>
 <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 05:36:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjpbT-0003R1-Pn
	for gcvg-git@gmane.org; Sat, 27 May 2006 05:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWE0Dgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 23:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWE0Dgg
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 23:36:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751782AbWE0Dgg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 23:36:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4R3aA2g019930
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 May 2006 20:36:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4R3a8vm028864;
	Fri, 26 May 2006 20:36:09 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20833>



On Fri, 26 May 2006, Linus Torvalds wrote:
> 
> So they would do "alias cvs git" in a desperate attempt to save themselves 
> from CVS, and then add
> 
> 	[alias "co"]
> 		cmd = commit -a

That, of course, would be confusing.

It should be "ci" for commit, and "co" for "checkout".

Duh. Chalk it up to me not having used cvs in the last three or four years 
or so (we used it at transmeta, although I can hope that they've since 
seen the light ;).

			Linus
