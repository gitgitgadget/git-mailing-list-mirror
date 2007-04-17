From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Tue, 17 Apr 2007 22:55:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
References: <20070417161720.GA3930@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdvdz-0001D2-RZ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031264AbXDQVzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031266AbXDQVzU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:55:20 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43598 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031264AbXDQVzT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 17:55:19 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id CF6F4C629F
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 22:55:17 +0100 (BST)
Received: (qmail 9843 invoked by uid 103); 17 Apr 2007 22:54:36 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.037966 secs); 17 Apr 2007 21:54:36 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 22:54:36 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070417161720.GA3930@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44835>

On Tue, 17 Apr 2007, Peter Baumann wrote:

> running git-gc or git-gc --prune isn't save because e.g. all the tags
> are packed and .git/packed-refs isn't shared on the several workdirs.

Do you mean that the link wasn't created?  Or that the link was removed 
and replaced with a file when you ran gc from a workdir?

-- 
Julian

  ---
My mother is a fish.
- William Faulkner
