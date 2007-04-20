From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 15:19:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704201518170.3277@reaper.quantumfyre.co.uk>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
 <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
 <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
 <E27761F8-7325-433C-89BB-B3475FA802A3@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Aubrey Li <aubreylee@gmail.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 16:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HetxU-0003wq-3i
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767107AbXDTOT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 10:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993255AbXDTOT2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 10:19:28 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47297 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993034AbXDTOT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 10:19:27 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 53C9DC64B0
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 15:19:26 +0100 (BST)
Received: (qmail 21691 invoked by uid 103); 20 Apr 2007 15:18:38 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3135. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.040249 secs); 20 Apr 2007 14:18:38 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 20 Apr 2007 15:18:37 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <E27761F8-7325-433C-89BB-B3475FA802A3@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45108>

On Fri, 20 Apr 2007, Brian Gernhardt wrote:

>
> On Apr 20, 2007, at 9:38 AM, Aubrey Li wrote:
>
>> On 4/20/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> > On Fri, 20 Apr 2007, Aubrey Li wrote:
>> > 
>> > >  I'm behind of a firewall on which the git port is not permitted, so I
>> > >  can only use http protocol. Unfortunately, I can't clone linus' git
>> > >  tree at all.
>> > 
>> > Linus packs his refs, which means that currently you can't clone using
>> > http, with any version of git.
>> 
>> I really don't understand why packed refs or not depend on the protocol.
>> It doesn't make any sense.
>
> I think it's simply because git-http-fetch doesn't look for the packed-refs 
> file.

Yep.

>  Are we actually going to support HTTP fetching?  If so, we should 
> update it to pull the packed-refs file too.  If not, it should be clearly 
> marked as depreciated.  That said, I think HTTP is the easiest way for most 
> people to publish and removing it would be a mistake.  I'd poke at it, but 
> there's not enough spare time in the day at the moment.

I was hoping to find time to poke this over the weekend ... maybe even 
this evening.

-- 
Julian

  ---
Nature always sides with the hidden flaw.
