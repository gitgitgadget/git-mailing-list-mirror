From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 22:30:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703142225110.14109@beast.quantumfyre.co.uk>
References: <17912.16608.852664.321837@lisa.zopyra.com>
 <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
 <17912.29057.435478.123662@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRbzi-000372-By
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 23:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbXCNWac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 18:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbXCNWac
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 18:30:32 -0400
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:43130 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422695AbXCNWab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 18:30:31 -0400
Received: (qmail 2217 invoked by uid 103); 14 Mar 2007 22:30:29 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2833. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032082 secs); 14 Mar 2007 22:30:29 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Mar 2007 22:30:29 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <17912.29057.435478.123662@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42241>

On Wed, 14 Mar 2007, Bill Lear wrote:

> On Wednesday, March 14, 2007 at 21:05:37 (+0000) Julian Phillips writes:
>> ...
>> I don't think there is anything that needs changing with the git daemon
>> ... or at least I was able to successfully clone over an SSH port forward.
>>
>> I did get the same error as you originally, but this was due to SSH
>> failing to setup the tunnel connection (checking the logs showed that I
>> had got the hostname in the forward wrong).
>
> Ok, so were you doing something like this:
>
> % git clone git://localhost:5700/project

yup.

I was even watching netstat on the server too ... ;)
(I did setup the tunnel from the client though, since I can't ssh into my 
desktop machine - so I was using LocalForward 5700 <server_ip>:9418)

>
> etc.?  and not using the ssh protocol, like this:
>
> % git clone ssh://...

nope.

-- 
Julian

  ---
I want to marry a girl just like the girl that married dear old dad.
 		-- Freud
