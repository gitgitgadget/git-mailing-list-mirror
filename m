From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 15:26:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704131525260.12853@reaper.quantumfyre.co.uk>
References: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net> <200704131230.41594.andyparkins@gmail.com>
 <461F6D74.63EF2769@eudaptics.com> <200704131354.57056.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704131007140.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 16:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcMjV-0001wZ-N2
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 16:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbXDMO0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbXDMO0d
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 10:26:33 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45118 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753549AbXDMO0d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2007 10:26:33 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 87720C2E08
	for <git@vger.kernel.org>; Fri, 13 Apr 2007 15:26:31 +0100 (BST)
Received: (qmail 30316 invoked by uid 103); 13 Apr 2007 15:26:00 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03276 secs); 13 Apr 2007 14:26:00 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 13 Apr 2007 15:26:00 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.0.98.0704131007140.28181@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44407>

On Fri, 13 Apr 2007, Nicolas Pitre wrote:

> On Fri, 13 Apr 2007, Andy Parkins wrote:
>
>> If I've understood the attributes system correctly, it's worth bearing
>> in mind that "!diff" is not the same as "nodiff".  The not in "!diff"
>> means "supress the attribute diff", not as you would traditionally
>> imagine "not-diff".  In this case it doesn't matter because there are
>> only two possibilities for the diff engine - show the diff or don't.
>> However, more attributes might get added that aren't so simple.
>>
>> Junio - This makes me think that perhaps "!" is not the right symbol for
>> this - that's going to get read by programmers everywhere as NOT,
>> rather than suppress.  Perhaps it doesn't matter, I might be
>> over-thinking this.
>
> Maybe "-" then?  That better convey the notion of suppression while "!"
> is more about negation.

"-flag" will certainly be a more familiar way to say "disable flag" to 
gentoo users ... ;)

-- 
Julian

  ---
Lie, n.:
 	A very poor substitute for the truth, but the only one
 	discovered to date.
