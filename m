From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: CVS -> SVN -> Git
Date: Fri, 13 Jul 2007 15:48:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 16:48:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9MRq-0004GU-3L
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 16:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761520AbXGMOso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761719AbXGMOsn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 10:48:43 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36456 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761300AbXGMOsm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 10:48:42 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2BD31C616A
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 15:48:41 +0100 (BST)
Received: (qmail 31926 invoked by uid 103); 13 Jul 2007 15:48:40 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3652. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.032481 secs); 13 Jul 2007 14:48:40 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 13 Jul 2007 15:48:40 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52397>


Has anyone managed to succssfully import a Subversion repository that was 
initially imported from CVS using cvs2svn using fast-import?

It looks like cvs2svn has created a rather big mess.   It has created 
single commits that change files in more than one branch and/or tag. 
It also creates tags using more than one commit.  Now I come to try and 
import the Subversion history into git and I'm having trouble creating a 
sensible stream to feed into fast-import.

I'm trying to use fast-import because git-svnimport creates a incorrect 
repository that is missing files and even whole directories (I suppose 
this could be due to the confusion from cvs2svn), and git-svn is a) _way_ 
too slow, b) doesn't do merges and c) munges the commit comments.

-- 
Julian

  ---
Riffle West Virginia is so small that the Boy Scout had to double as the
town drunk.
