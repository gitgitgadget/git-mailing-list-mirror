From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFD PATCH] git-fetch--tool and "insanely" long actions
Date: Fri, 20 Apr 2007 08:40:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704200837460.29434@beast.quantumfyre.co.uk>
References: <462811F6.9060503@gmail.com> <20070420013411.26401.77137.julian@quantumfyre.co.uk>
 <46281D0B.7080802@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 09:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HenjY-0004pN-Vb
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 09:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbXDTHkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 03:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbXDTHkl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 03:40:41 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40941 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754046AbXDTHkk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 03:40:40 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id ECF3DC61AE
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 08:40:39 +0100 (BST)
Received: (qmail 10904 invoked by uid 103); 20 Apr 2007 08:39:52 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3135. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.040015 secs); 20 Apr 2007 07:39:52 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Apr 2007 08:39:52 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <46281D0B.7080802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45071>

On Thu, 19 Apr 2007, A Large Angry SCM wrote:

> Julian Phillips wrote:
>>  On Thu, 19 Apr 2007, A Large Angry SCM wrote:
>> 
>> >  This fixes a problem my repository mirroring script has been having 
>> >  since
>> >  the git-fetch--tool was added to master in the middle of March. However,
>> >  it is not a proper fix since it causes actual errors from snprintf() to 
>> >  be
>> >  ignored. A proper fix is complicated by the lack of a consistent 
>> >  indicator
>> >  that the buffer is too small across snprintf() implementations.

>
> See the last sentence in my original message. Yours also ignores errors from 
> snprintf().
>

Well your last sentence was about the buffer being too small.  The change 
I made means it won't ever be too small.  True that it doesn't check for 
other errors.

-- 
Julian

  ---
You will be successful in your work.
