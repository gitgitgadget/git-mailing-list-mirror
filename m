From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] remove shortlog from git-commit output
Date: Mon, 16 Apr 2007 16:02:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704161554540.5400@reaper.quantumfyre.co.uk>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
 <20070404060213.GB31984@mellanox.co.il> <7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
 <20070404070135.GF31984@mellanox.co.il> <7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
 <20070415223909.GG15208@mellanox.co.il> <7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
 <20070416053435.GA23255@mellanox.co.il> <7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
 <20070416144038.GA32515@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdSjV-0007Jt-7h
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbXDPPC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbXDPPC4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:02:56 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:59721 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752844AbXDPPCv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 11:02:51 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 975ECC63B6
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 16:02:50 +0100 (BST)
Received: (qmail 24340 invoked by uid 103); 16 Apr 2007 16:02:11 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036529 secs); 16 Apr 2007 15:02:11 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Apr 2007 16:02:11 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070416144038.GA32515@mellanox.co.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44648>

On Mon, 16 Apr 2007, Michael S. Tsirkin wrote:

> Make git-commit only display --summary since addition/deletion
> are notable events that do not happen with every commit.
>
> Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
>
> ---
>
>>> BTW, Junio, why does git-commit need to display the diffstat?
>>> You just made the commit ...
>>
>> Don't ask me.  It was not my idea.
>>
>> We only had --summary per popular list request, and it made
>> certain amount of sense since addition/deletion are notable
>> events that do not happen with _every_ commit.
>
> So how about this?
>

Personally I quite like the shortstat ... and certainly is/will be more 
useful to me than having the commit subject - despite normally having more 
terminals lying around than is good for my sanity.

Can't we keep it? It's not like it takes up much space ...

-- 
Julian

  ---
BOFH Excuse #134:

because of network lag due to too many people playing deathmatch
