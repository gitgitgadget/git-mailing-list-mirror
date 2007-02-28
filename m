From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 15:30:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQlX-00007Q-A4
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbXB1Par (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbXB1Par
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:30:47 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:49878 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXB1Paq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:30:46 -0500
Received: (qmail 31673 invoked by uid 103); 28 Feb 2007 15:30:44 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2668. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.047437 secs); 28 Feb 2007 15:30:44 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 28 Feb 2007 15:30:44 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200702281522.14965.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40941>

On Wed, 28 Feb 2007, Andy Parkins wrote:

> On Wednesday 2007 February 28 14:53, Paolo Bonzini wrote:
>> As can be seen from my other messages, I'm experimenting a little with
>> git and trying to understand how its workflow compares with arch.  Right
>> now, my procedure for branching off a remote archive is:
>>
>>    git checkout -b branchname remote/upstreambranch
>>    git config --add branch.branchname.remote remote
>>    git config --add branch.branchname.merge refs/heads/upstreambranch
>>
>> Is there a reason why "git branch" and "git checkout -b" should not
>> automatically do the two "git-config --add"s when the source branch is
>> remote?
>
> I can see why that would be handy, but I often make short lived branches off a
> remote; and I wouldn't want my config cluttered up with branch defintions.

How about adding an option to tell checkout/branch that a tracking branch 
is wanted (-t perhaps) - or perhaps a way to say that you don't want to 
track the remote (depending on which is more popular)?

Certainly would be a nice feature to have ...

-- 
Julian

  ---
Meg Griffin:  Somebody's in the closet!
Jeff Foxworthy:  You know you're a redneck when your gun rack has a gun rack on it.
Stewie Griffin:  You suck!
