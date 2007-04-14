From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 20:07:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704141917320.6461@beast.quantumfyre.co.uk>
References: <46206842.80203@gmail.com> <20070414083410.GU6602@sequoia.sous-sol.org>
 <5A4D6434-3DF2-4CC7-B363-260E5F945F72@silverinsanity.com>
 <20070414171908.GU10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcnax-0006cC-72
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 21:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXDNTHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 15:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbXDNTHb
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 15:07:31 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52846 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059AbXDNTHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 15:07:30 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B841CC1F24
	for <git@vger.kernel.org>; Sat, 14 Apr 2007 20:07:28 +0100 (BST)
Received: (qmail 13199 invoked by uid 103); 14 Apr 2007 20:06:55 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3090. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.034422 secs); 14 Apr 2007 19:06:55 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Apr 2007 20:06:55 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070414171908.GU10574@sequoia.sous-sol.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44468>

On Sat, 14 Apr 2007, Chris Wright wrote:

> * Brian Gernhardt (benji@silverinsanity.com) wrote:
>> On Apr 14, 2007, at 4:34 AM, Chris Wright wrote:
>>> I've already put a tree like this up on kernel.org.  The master branch
>>> is Linus' tree, and there's branches for each of the stable releases
>>> called linux-2.6.[12-20].y (I didn't add 2.6.11.y).
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6-stable.git;a=summary
>>
>> Is HEAD for that repo the most recent stable branch, or (as gitweb
>> makes it look) Linus's head.  I'd expect a "-stable" repo to point at
>> the most recent stable commit, not the most recent development
>> commit.  And I'd also expect gitweb's summary page to show the
>> shortlog for HEAd.  One of my assumptions are being broken and I
>> don't like it.  It leaves me all confused...
>
> As I mentioned.  The master branch (HEAD) is Linus' tree, and each
> stable tree is on its own branch.  You'll find shortlog summarizes the
> main branch, so yes, gitweb's summary is a bit confusing based on your
> assumptions.  This is a new tree and hasn't been publicized until now.
> It does make sense to have its head be the newest stable, I'll switch
> that around.

Would it not make more sense to point HEAD at the linux-2.6.20-y branch 
and either let master be Linus' tree or simply not have a master branch? 
Otherwise, what happens to master when the latest stable tree becomes 
linux-2.6.21-y?

-- 
Julian

  ---
Most people want either less corruption or more of a chance to
participate in it.
