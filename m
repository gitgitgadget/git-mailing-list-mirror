From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: gitk memory usage
Date: Tue, 16 Jan 2007 15:49:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701161543260.19083@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue Jan 16 16:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6qZa-0006Zo-VH
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXAPPt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 10:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXAPPt5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 10:49:57 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:38598 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXAPPt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 10:49:56 -0500
Received: (qmail 29383 invoked by uid 103); 16 Jan 2007 15:49:54 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2455. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.028926 secs); 16 Jan 2007 15:49:54 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 16 Jan 2007 15:49:54 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36945>


I wanted to have a quick look at the commits that had been made on a 
particular branch, and rather than use git log I thought I would try gitk.

I was rather surprised to find that after running "gitk 
<start_of_branch_tag>..<branch_head>" (which showed a grand total of 4 
commits) wish had a virtual size of ~1.1G - which on a machine with 1G 
physical RAM is not a good thing.

Does anyone know if this is to be expected from a large repository (~2.5G 
packed), or do I have a buggy version of wish installed?

-- 
Julian

  ---
Get Revenge!  Live long enough to be a problem for your children!
