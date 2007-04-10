From: alan <alan@clueserver.org>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 16:20:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101614370.17260@blackbox.fnordora.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
 <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
 <Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
 <m3wt0j7sm6.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPde-0000ck-OY
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbXDJXUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbXDJXUX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:20:23 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:47435 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbXDJXUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:20:19 -0400
Received: by clueserver.org (Postfix, from userid 500)
	id 60FEFE78002; Tue, 10 Apr 2007 16:20:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 5CF7FF505CC;
	Tue, 10 Apr 2007 16:20:18 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <m3wt0j7sm6.fsf@zoo.weinigel.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44197>

On Tue, 11 Apr 2007, Christer Weinigel wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> It's also possible to just not accept mail if the reverse lookup indicates
>> that the sending IP address is a dynamic address, which you can sometimes
>> see from the hostname. I would suggest you *not* name your hosts to
>> contain a lot of numbers and the string "dhcp", for example ;)
>
> That would be a very bad idea I think.  Doing that would lose quite a
> lot of small companies and individuals such as me that run a mail
> server but are unable to get the ISP to change the reverse DNS.  For
> example I do have a fixed IP, but have an reverse DNS pointer which
> looks like 1-2-3-4-5a.foo.bar.bostream.se.

I am in the same situation.  I also have three domains.  Which one do I 
pick?  I can't afford to get an individual ip address for each.  Virtual 
servers on a single ip also will have similar problems.

> Forcing everybody to send mail through their ISP (and I'm not even
> sure if my ADSL subscription includes such a service) would be a big
> loss.  First of all its a philosophical thing, I think that it's very
> important that small shops or individuals should be able to control
> the services they need, the internet is supposed to be peer to peer.
> Second because the ISP's mess up a lot more often than I do, for
> example Telia, one of the largest ISPs in Sweden have been having
> massive mail server problems during the last week which I'm happily
> unaffected by.

My ISP only reciently started to think about using greylisting.  They 
route all their mail through a filter service that I do not trust.  (Too 
many false positives.  I also expect that all this talk about "forking 
children" would get me on some list somewhere.)

I have more experience running mail servers than the people at my ISP. 
(Not their fault.  They are young.)

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
