From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: how to track multiple upstreams in one repository
Date: Mon, 19 Jan 2009 20:45:07 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0901192044060.6108@reaper.quantumfyre.co.uk>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm> <alpine.LNX.2.00.0901191627480.4115@reaper.quantumfyre.co.uk> <alpine.DEB.1.10.0901191308030.2428@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 19 21:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP12X-0002w9-KH
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 21:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZASUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbZASUqp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 15:46:45 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34949 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752821AbZASUqo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 15:46:44 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6A92F23CD4B
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 20:46:43 +0000 (GMT)
Received: (qmail 28296 invoked by uid 103); 19 Jan 2009 20:45:08 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94.1/8875. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.02922 secs); 19 Jan 2009 20:45:08 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 19 Jan 2009 20:45:08 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.DEB.1.10.0901191308030.2428@asgard.lang.hm>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106390>

On Mon, 19 Jan 2009, david@lang.hm wrote:

> On Mon, 19 Jan 2009, Julian Phillips wrote:
>
>>  On Sun, 18 Jan 2009, david@lang.hm wrote:
>> 
>> >  for linux I want to track both the linus tree and the -stable tree. 
>> >  Ideally I want to be able to do a checkout of tags from either tree from 
>> >  the same directory (along with diffs between items in both trees, etc)
>> > 
>> >  I have found documentation on how to clone from each of them, but I 
>> >  haven't found any simple documentation on how to work with both of them.
>>
>>  You could always just use
>>  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git
>>  ? It already contains both the linus tree and all the stable trees ...
>
> I know it contains the releases, but does it contain the -rc trees?

It seems to contain everything from the main Linus tree as far as I can 
see from the gitweb (haven't actually used it for kernel work).

>
> David Lang
>
>

-- 
Julian

  ---
Stock's Observation:
 	You no sooner get your head above water but what someone pulls
 	your flippers off.
