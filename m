From: alan <alan@clueserver.org>
Subject: [OT] Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 14:33:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
 <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOI8-0000qi-EC
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbXDJVyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 17:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965558AbXDJVyR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 17:54:17 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:41441 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911AbXDJVyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 17:54:16 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2007 17:54:16 EDT
Received: by clueserver.org (Postfix, from userid 500)
	id 0A703E78002; Tue, 10 Apr 2007 14:33:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 05A6BE80001;
	Tue, 10 Apr 2007 14:33:54 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44183>

On Tue, 10 Apr 2007, Linus Torvalds wrote:

>
>
> On Tue, 10 Apr 2007, Junio C Hamano wrote:
>>
>> One thing that people need to be careful about is which SMTP
>> server they use.
>
> ABSOLUTELY!
>
> There are a ton of spam blockers that simply *refuse* to accept email from
> people who just randomly send to port 25.
>
> For example, I will personally never see email that comes directly to my
> email address though an open mail relay *or* from something that appears
> to be just a random botnet PC (I forget the exact rule, since I'm hapily
> ignorant of MIS, but I think it boils down to requiring a good reverse DNS
> lookup).

Depending on your definition of "good".

I run my mail server off my DSL line.  I prefer having control over my 
mail server instead of being chained to what my ISP provides.  (The 
problems of having been a sysadmin for way too many years.) I don't have 
control over the reverse ip address, but I do over my DNS resolution. 
(Well, most of it. A couple domains are sitting on really old dns servers 
from years past.)

> That's getting much more common. Most spam is done through botnets, and
> they still try to do the direct-to-port-25 thing, exactly because if you
> go through a *real* SMTP host, your ISP will generally shut you down
> pretty quickly if you're spamming.

Which makes Greylisting a useful tool.  However, some people define a 
"real SMTP host" as being the one your ISP provides and no other.  No 
matter how good your OS or how stringent your rulesets for sending mail 
are.

> So special spammers with their own machines will work with ISP's that
> don't care (they make money off the spammers), but botnets depend on
> cracked Windows machines, and those often have ISP's that *do* care,
> because they get complaints and it costs them money if they don't.

And the various RBL lists will just nuke everyone in the same class c. (I 
have seen it happen for people at colos.  Someone on the class c get 
compromised, sends spam and the whole address space gets blocked. 
Sometimes I think the anti-spam methods are as obnoxious as the spammers. 
Almost.)

>> I had an impression (I do not use send-email myself) that it defaulted
>> to local MTA, so the mail trail would look like your local MTA receives
>> from the MUA (which is send-email), which forwards it to whereever
>> destination (or intermediaries).
>
> A lot of people configure their MUA to send specially, and never even
> configure their MTA at all apart from whatever default configuration it
> has.

But the people who use git are probably the exceptions.  (At least I hope 
so...)

A number of programs assume that the local MTA can send mail.  (The bug 
handling software for Gnome is an example of that.)

This sounds more like a distro problem though.  The MTA configuration 
should be a proper part of an install, not something that you have to 
uncover and piece together later.

Of course I also believe that Sendmail configuration was designed by an 
organic chemistry major as part of an "experiment" in ergot derivitives.

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
