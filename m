From: Jon Brisbin <jon.brisbin@npcinternational.com>
Subject: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 10:42:32 -0500
Message-ID: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 17:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uFG-0000iL-3V
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbZELPsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758607AbZELPsg
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:48:36 -0400
Received: from mail.npcinternational.com ([63.76.154.140]:15472 "EHLO
	mail1.npci.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758716AbZELPsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:48:35 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 11:48:35 EDT
Received: from [172.16.0.131] (mail.npcinternational.com [63.76.154.130] (may be forged))
	by mail1.npci.com (MOS 3.10.5-GA)
	with ESMTP id COQ30131;
	Tue, 12 May 2009 10:42:32 -0500 (CDT)
X-Mailer: Apple Mail (2.930.3)
X-Junkmail-Whitelist: YES (by domain whitelist at mail1.npci.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118905>

Folks,

Our development manager was evaluating transitioning our AS400  
department to IBM Rational for the RPG programmers, who currently use  
SEU for all their editing and source code control. I was asked about  
CVS and how it compared to what they're doing now (so they wouldn't  
have to pay quite as much by omitting the source code control part of  
Rational) and I explained why the Java programmers don't use CVS.  
We're transitioning from Subversion to Git at the moment and I tried  
to explain how the paradigm of managing source code using Git was  
different than what they were used to.

Today, an RPG programmer can "check out" a source member and SEU won't  
let anyone else check that same member out (and it tells the developer  
who has it locked). The C++ programmers here also use Visual  
SourceSafe, with this same setting turned on. They are open to  
shifting paradigms away from this development methodology (the "I'm  
working on this source file and I don't want anyone else changing it  
until I'm done") but keep in mind that AS400 programmers are NOT  
cutting-edge and don't keep up with the latest development trends.  
Since we're not going to fire every RPG developer we have, we need an  
upgrade or transition path away from the SEU mindset to a more laissez- 
faire development approach like that encouraged by using Git. But one  
of the first roadblocks is going to be this notion that someone else  
can work on the same file I'm working on and that this lack of control  
invites errors and introduces unnecessary complexity.

How do I argue that a more open, Git-based approach to development is  
"better" than the traditional, SEU-based methodology they use today?  
It may be an "old" way of doing things, but SEU works for them and,  
more importantly, they can understand the process. We don't share any  
of our source code outside our organization and no one who would  
potentially work on the source code is farther than a cubicle or two  
away, so our needs in no way extend to what OpenSource projects  
require, with their large and distributed developer base. Using Git  
seems so open that its difficult to explain and even more difficult to  
defend against traditions that are 20 years old and have an entire  
industry of momentum behind them. Since Rational is eclipse-based, I'm  
assuming the Git plugin for eclipse would work with Rational, but I'm  
on a Mac so I have no way to test this.

I'm just wondering what the Git experts would say to someone wanting  
to transition from say, Visual SourceSafe, and expecting the  
predictability of having source files "locked out" while a developer  
is making changes to them?

Thanks!

Jon Brisbin
Portal Webmaster
NPC International, Inc.
