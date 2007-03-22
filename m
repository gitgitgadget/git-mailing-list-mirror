From: Andreas Ericsson <ae@op5.se>
Subject: Re: Libification project (SoC)
Date: Thu, 22 Mar 2007 10:51:23 +0100
Message-ID: <4602519B.7000303@op5.se>
References: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319025636.GE11371@thunk.org> <Pine.LNX.4.64.0703190912190.6730@woody.linux-foundation.org> <46011450.4000200@op5.se> <Pine.LNX.4.64.0703211020070.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUJxR-0000ne-SQ
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbXCVJvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965645AbXCVJva
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:51:30 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:43299 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965913AbXCVJv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:51:29 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 1D6606BCC5; Thu, 22 Mar 2007 10:51:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.179] (unknown [192.168.1.179])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 926A76BCBF; Thu, 22 Mar 2007 10:51:24 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <Pine.LNX.4.64.0703211020070.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42853>

Linus Torvalds wrote:
> 
> On Wed, 21 Mar 2007, Andreas Ericsson wrote:
> 
>> Linus Torvalds wrote:
>>> I'm a *huge* believer in "Worse is Better" (for people who don't know it, 
>>> just google for that phrase, with the quotes around it).
>> I just did, and having read the first page of the document found at 
>> http://www.jwz.org/doc/worse-is-better.html, I must say "worse-is-better"
>> sounds an awful lot like evolution; "Start with something that works. When
>> something else works better, jump train and embrace The New Thing".
> 
> Yeah. I'm a huge believer in evolution too (and not just the biological 
> kind ;)
> 
> So "designing" stuff is way overrated. You can spend years designing 
> somethign that is total crap, just because you didn't actually try it out 
> and _realize_ that it wasn't what the user wanted (it may have been what 
> the user _thought_ and _claimed_ that he wanted, but that was before 
> actually tried to use it, and realized that he was wrong).
> 

Indeed. That's probably why Extreme Programming (silly hype-name, but what
to call it otherwise?) has gained so much popularity from the people that
really understand the concept.

To those that don't wish to google for it, Extreme Programming is about
taking small steps that lead to a diffuse goal ("We shall make a fantasy
video game that millions of people would like to play. Significant lore
is here, here and here"). 

The goal and any of the steps might change along the way. Basically, it
puts "re-think, re-design, re-factor" on the table for corporate software
production and promotes rapid implementation over correctness.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
