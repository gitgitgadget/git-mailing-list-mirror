From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Another question about importing SVN with fast-import
Date: Mon, 16 Jul 2007 22:11:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 23:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXqt-0007Ua-5K
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbXGPVL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758957AbXGPVL2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:11:28 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49546 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758868AbXGPVL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 17:11:27 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 386C6C6105
	for <git@vger.kernel.org>; Mon, 16 Jul 2007 22:11:26 +0100 (BST)
Received: (qmail 32242 invoked by uid 103); 16 Jul 2007 22:11:25 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3678. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.0322 secs); 16 Jul 2007 21:11:25 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Jul 2007 22:11:25 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52722>

First off, I would just like to say fast-import rocks.  It's well named 
too ...

Now the question.  Shawn recently added C and R operations - almost as 
soon as they were asked for too.  However, how do you copy a file from a 
particular revision?  I have just hit a point where someone deleted a 
directory, and then copied one of the files from that directory back from 
an old revision (as two separate commits).  Since I'm not tracking any 
branch contents in my front-end, and the copy operation only works from 
the current branch head I seem to be stuck ... or have I missed something?

-- 
Julian

  ---
What I want to find out is -- do parrots know much about Astro-Turf?
