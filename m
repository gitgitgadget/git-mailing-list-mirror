From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 19:43:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704181939220.10528@reaper.quantumfyre.co.uk>
References: <20070417161720.GA3930@xp.machine.xx>
 <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
 <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
 <20070418081122.GB32634@xp.machine.xx> <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
 <7vfy6xird9.fsf@assigned-by-dhcp.cox.net> <20070418174350.GB5913@xp.machine.xx>
 <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net> <20070418183156.GF5913@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeF7j-0003hJ-W1
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993001AbXDRSnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993006AbXDRSnV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:43:21 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43082 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993001AbXDRSnU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 14:43:20 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7B33CC6475
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 19:43:19 +0100 (BST)
Received: (qmail 9619 invoked by uid 103); 18 Apr 2007 19:42:33 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036542 secs); 18 Apr 2007 18:42:33 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 19:42:33 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070418183156.GF5913@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44928>

On Wed, 18 Apr 2007, Peter Baumann wrote:

> Yes. That's my motivation and it works right now
>
> 	git init a
> 	<hack, hack, hack,>
> 	git commit -a
>
> 	git-new-workdir a b 	# allowed
> 	git-new-workdir a c	# allowed
>
> 	git-new-workdir b d	# NOT ALLOWED

btw, if you copy git-new-workdir to $GIT_EXEC_PATH then you can do

 	git new-workdir a b

(and the bash completion script works too. :D)

It's cunning stuff this git program ...

-- 
Julian

  ---
All the world's a stage and most of us are desperately unrehearsed.
 		-- Sean O'Casey
