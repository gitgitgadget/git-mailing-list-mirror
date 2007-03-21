From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Libification project (SoC)
Date: Wed, 21 Mar 2007 10:24:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211020070.6730@woody.linux-foundation.org>
References: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319025636.GE11371@thunk.org> <Pine.LNX.4.64.0703190912190.6730@woody.linux-foundation.org>
 <46011450.4000200@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4Xz-0000t4-Nw
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbXCURYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933193AbXCURYZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:24:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45087 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbXCURYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:24:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LHO8cD029577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 10:24:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LHO7nu031171;
	Wed, 21 Mar 2007 09:24:07 -0800
In-Reply-To: <46011450.4000200@op5.se>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42807>



On Wed, 21 Mar 2007, Andreas Ericsson wrote:

> Linus Torvalds wrote:
> > 
> > I'm a *huge* believer in "Worse is Better" (for people who don't know it, 
> > just google for that phrase, with the quotes around it).
> 
> I just did, and having read the first page of the document found at 
> http://www.jwz.org/doc/worse-is-better.html, I must say "worse-is-better"
> sounds an awful lot like evolution; "Start with something that works. When
> something else works better, jump train and embrace The New Thing".

Yeah. I'm a huge believer in evolution too (and not just the biological 
kind ;)

The thing is, most "designers" are just totally clueless. Even the 
smartest people that have done something similar five times before are 
prone to totally mis-design something if they start from scratch and try 
to "think it through". You tend to concentrate on the problems of the 
previous generation, and not even think about everything that worked 
wonderfully well, because that wasn't something you *needed* to think 
about.

So "designing" stuff is way overrated. You can spend years designing 
somethign that is total crap, just because you didn't actually try it out 
and _realize_ that it wasn't what the user wanted (it may have been what 
the user _thought_ and _claimed_ that he wanted, but that was before 
actually tried to use it, and realized that he was wrong).

			Linus
