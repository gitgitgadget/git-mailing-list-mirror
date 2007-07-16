From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: CVS -> SVN -> Git
Date: Mon, 16 Jul 2007 02:13:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160212260.7851@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
 <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
 <46994BDF.6050803@alum.mit.edu> <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
 <469A099E.6060906@alum.mit.edu> <46a038f90707151808u67c4e834lb06ed86c855f58ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Frech <david@nimblemachines.com>, esr@thyrsus.com,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 03:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAF9q-0003z4-OQ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666AbXGPBNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756343AbXGPBNr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:13:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33641 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756054AbXGPBNr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 21:13:47 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E3567C6107
	for <git@vger.kernel.org>; Mon, 16 Jul 2007 02:13:44 +0100 (BST)
Received: (qmail 31120 invoked by uid 103); 16 Jul 2007 02:13:42 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3673. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033762 secs); 16 Jul 2007 01:13:42 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 16 Jul 2007 02:13:42 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <46a038f90707151808u67c4e834lb06ed86c855f58ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52617>

On Mon, 16 Jul 2007, Martin Langhoff wrote:

> On 7/15/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> >  It took a day and half to get the svn dump parsing right (it's an
>> >  egregiously bad format) but only a couple of hours to write the
>> >  fast-import backend.
>>
>>  I'm surprised you think that; I find the svn dump format quite easy and
>>  straightforward.  (Of course it assumes some Subversionisms, like easy
>>  deep directory copies, which I can imagine would be annoying in other
>>  contexts.)  What don't you like about the format?
>
> Is there good doco and samples for it? I wouldn't mind doing things by
> way of an SVN dump parser.

I don't know if it classes as what you call good, but it is documented:

http://svn.collab.net/repos/svn/trunk/notes/fs_dumprestore.txt

>
>>  Yes, fast-import is a very easy-to-write format and looks to be very
>>  well documented.  I don't think that having to write output in
>>  fast-import format would be any kind of a hindrance for such a tool.
>
> Damn! You've now figured out that all my volunteering was for the easy
> part of the job ;-)
>
>
>
>
> m
>
>

-- 
Julian

  ---
This process can check if this value is zero, and if it is, it does
something child-like.
 		-- Forbes Burkowski, CS 454, University of Washington
