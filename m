From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 10:04:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704260905100.27947@beast.quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
 <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
 <7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
 <7v647jtvzb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgzte-00074l-Qw
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 11:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbXDZJEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 05:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbXDZJEL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 05:04:11 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44128 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754777AbXDZJEK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 05:04:10 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id BB85AC60FF
	for <git@vger.kernel.org>; Thu, 26 Apr 2007 10:04:08 +0100 (BST)
Received: (qmail 630 invoked by uid 103); 26 Apr 2007 10:03:05 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3162. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.037746 secs); 26 Apr 2007 09:03:05 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 26 Apr 2007 10:03:05 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7v647jtvzb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45624>

On Thu, 26 Apr 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> That way you are not reliant on the user's tools following your rules.
>
> You misunderstood -- what implements the rules is on the
> repository side, not the end users' side.

If your public repo is available via http or rsync, then you can't 
consider anything private ...

If it's available via git:// only, then that's different.

>
>> I don't think it unreasonable to say that anything that is in a public
>> repository is public, and that the way to keep things private is to
>> not push them into a public repository. Or is it?
>
> I wouldn't have bothered to jump into the thread if this were
> about public repositories.  You would not even need a separate
> namespace refs/bm -- you do not have to push that out.

If the repository is not public, where's the problem?  _Everthing_ is 
private then...

(by public I simply mean "availabe for others to fetch from")

>
> But that was not what Andy was talking about.
>
>> I understand that some people may wish to make their working
>> repositories public, but then there isn't any way we can say for sure
>> that things will remain private.  Even if ls-remote was updated, an
>> older version would simply ignore the new "this is private"
>> configuration.
>
> You misunderstood.  I am not talking about updating ls-remote.
> The update to upload-pack/update-server-info is done on the side
> of Andy's repository, not on the client side.

Yeah, that's what I get for trying to think before lunch time ... :$

>
>> or simply expand the current push configuration to accept that syntax,
>> so that you can finely control which refs get pushed to the public
>> repo?
>
> You do not have to update anything on push side, as push just
> pushes what you tell it to, unless you say 'push --all', in
> which case you obviously mean all is all is all, so there is no
> need for exclude.

Having thought about after I sent my email, I agree that the current push 
syntax is already enough.

-- 
Julian

  ---
BOFH Excuse #56:

Electricians made popcorn in the power supply
