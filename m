From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 17:35:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241733370.29908@reaper.quantumfyre.co.uk>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
 <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com>
 <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>, git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 18:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDNM4-0001GW-Ps
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXGXQfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXGXQfU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 12:35:20 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37728 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbXGXQfS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 12:35:18 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4F1B8C67DC
	for <git@vger.kernel.org>; Tue, 24 Jul 2007 17:35:17 +0100 (BST)
Received: (qmail 11563 invoked by uid 103); 24 Jul 2007 17:35:15 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3747. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030021 secs); 24 Jul 2007 16:35:15 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 24 Jul 2007 17:35:15 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53612>

On Tue, 24 Jul 2007, Patrick Doyle wrote:

>> >  ... and I don't commit until I've completed
>> >  the particular feature I'm working on, I can get a fairly good idea of
>> >  where I am and what I was doing last (which might be 5-7 days ago,
>> >  given high priority interrupts on other projects, summer vacations,
>> >  etc...) just by running a "git status".  I see that there are 7 new
>> >  files, and 2 modified files.  I know that, when I fork my branch, I
>> >  can use "git diff master" to see what's different between my branch
>> >  and the master, but then I get the diff of all of the changes as well,
>> >  which is too much information.  "git diff --name-only" and "git diff
>> >  --summary" are closer, but I can't tell what's been added vs. what's
>> >  been changed.  Any suggestions?
>>
>>  "git log -p ..master", or even simpler "gitk ..master"
> I was hoping for something less verbose than a diff or a patch file --
> something that just listed what has changed -- I'll have to
> investigate whether your "my_status()" macro provides the information
> for which I was looking -- thanks for the pointer.

"git log --stat ..master" perhaps?

-- 
Julian

  ---
The future isn't what it used to be.  (It never was.)
