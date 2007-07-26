From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: incremental fast-import
Date: Thu, 26 Jul 2007 22:47:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707262242460.14017@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 23:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEBB8-0004dE-LR
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 23:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765948AbXGZVrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763232AbXGZVrX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 17:47:23 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33702 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762970AbXGZVrW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 17:47:22 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D60A1C614B
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 22:47:21 +0100 (BST)
Received: (qmail 15099 invoked by uid 103); 26 Jul 2007 22:47:20 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3770. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030301 secs); 26 Jul 2007 21:47:20 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 26 Jul 2007 22:47:20 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53870>

Sorry to be going on about fast-import again ...

I seem to be missing something though.  I can't seem to get it to work 
when run in an incremental manner.

I have a saved stream of fast-import commands.  Every time I run this 
through fast import I get the exact same marks file out.  This is good.

However if I feed it in in two chunks, then nearly all of the SHA1s 
generated in the second run are different to those produced in a single 
pass.  In addition I get a pair of "warning: Not updating 
refs/heads/BUG_101_BRANCH (new tip <some sha1> does not contain <other 
sha1>)" messages.  This is not so good.

I'm using the --import-marks and --export-marks options.  Is there 
something else I need to do to be able to run fast-import in an 
incremental manner?

-- 
Julian

  ---
A fool must now and then be right by chance.
