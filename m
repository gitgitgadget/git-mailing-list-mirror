From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a working
 directory
Date: Tue, 27 Mar 2007 13:59:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0703271356590.1024@reaper.quantumfyre.co.uk>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
 <20070327003033.4226.8413.julian@quantumfyre.co.uk> <1174963350.6018.3.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 14:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWBGf-0007R2-Fk
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 14:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbXC0M7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 08:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbXC0M7E
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 08:59:04 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34535 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832AbXC0M7B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 08:59:01 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D0794C60E0
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 13:59:00 +0100 (BST)
Received: (qmail 9233 invoked by uid 103); 27 Mar 2007 13:59:00 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2937. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031034 secs); 27 Mar 2007 12:59:00 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 27 Mar 2007 13:59:00 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <1174963350.6018.3.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43271>

On Mon, 26 Mar 2007, Eric Lesh wrote:

> On Tue, 2007-03-27 at 00:15 +0100, Julian Phillips wrote:
>> +# want to make sure that what is pointed to has a .git directory ...
>> +test -d ${orig_git}/.git || die "${original_git} is not a git repository!";
>> +
>
> Shouldn't this be made to work with bare repositories as well?

I guess that depends ...

There's probably no reason that it couldn't, but it wasn't something that 
I was interested in seeing it do.  I don't have any bare repositories on 
my development machine, and don't anticipate having any in the future.

-- 
Julian

  ---
"Contrary to popular belief, penguins are not the salvation of modern
technology.  Neither do they throw parties for the urban proletariat."
