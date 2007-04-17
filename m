From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] remove shortlog from git-commit output
Date: Tue, 17 Apr 2007 08:27:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704170823040.16002@beast.quantumfyre.co.uk>
References: <20070404070135.GF31984@mellanox.co.il> <7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
 <20070415223909.GG15208@mellanox.co.il> <7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
 <20070416053435.GA23255@mellanox.co.il> <7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
 <20070416144038.GA32515@mellanox.co.il> <Pine.LNX.4.64.0704161554540.5400@reaper.quantumfyre.co.uk>
 <20070416182323.GC32515@mellanox.co.il> <Pine.LNX.4.64.0704162119130.13400@beast.quantumfyre.co.uk>
 <20070417060243.GB4507@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdi6w-0006jN-DJ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 09:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbXDQH16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 03:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXDQH16
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 03:27:58 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49392 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064AbXDQH1b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 03:27:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 81FEFC6282
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 08:27:29 +0100 (BST)
Received: (qmail 17503 invoked by uid 103); 17 Apr 2007 08:26:49 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035812 secs); 17 Apr 2007 07:26:49 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 08:26:49 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070417060243.GB4507@mellanox.co.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44737>

On Tue, 17 Apr 2007, Michael S. Tsirkin wrote:

>> I use git add -i quite a lot, so often the same file shows up in both the
>> files that are being committed and in the list of files that have
>> uncomitted changes.  The shortstat gives me confidence that the commit was
>> about the right size.
>
> If so, it would make more sense to show the diffstat inside
> the editor, where it's not too late to cancel the commit.

In git, it's not too late after running commit ... ;)

>
> Would it be better to show it before or after the list of files?

Well, the files to be committed are listed first, and untracked files 
last.  Next to the files to be committed would seem more sensible.

-- 
Julian

  ---
Man's unique agony as a species consists in his perpetual conflict between
the desire to stand out and the need to blend in.
 		-- Sydney J. Harris
