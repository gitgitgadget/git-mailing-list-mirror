From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 12:38:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com>
 <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
 <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: keithp@keithp.com, hpa@zytor.com, jbglaw@lug-owl.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 21:39:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMWa6-00088W-4T
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 21:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCWUiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 15:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCWUiu
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 15:38:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750926AbWCWUiu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 15:38:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NKcaDZ016679
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 12:38:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NKcXun018207;
	Thu, 23 Mar 2006 12:38:34 -0800
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17867>



On Thu, 23 Mar 2006, sean wrote:
> 
> lol, that sounds like a really good plan.  Perhaps as a two pronged effort
> its worth changing the notion that git is primarily "plumbing".   Adding
> some of the nice features of cogito and other "porcelains" into the core
> git might go a ways toward converting the few naysayers we don't kill.

Actually, as far as I can tell, git already has a hell of a lot more 
porcelain than pretty much any non-IDE type traditional SCM. Certainly 
more than CVS.

Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
SCM" environments, ie just basic SVN or CVS. What are we missing in that 
department? (The only thing I can think of is a diff colorizer, which some 
prople seem to really want).

		Linus
