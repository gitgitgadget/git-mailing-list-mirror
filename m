From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Tips for debugging fast-import front-ends
Date: Mon, 16 Jul 2007 13:45:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707161336570.24955@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPx3-0003ZC-KT
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbXGPMpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755744AbXGPMpR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:45:17 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36383 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754266AbXGPMpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 08:45:16 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B680EC616C
	for <git@vger.kernel.org>; Mon, 16 Jul 2007 13:45:14 +0100 (BST)
Received: (qmail 15886 invoked by uid 103); 16 Jul 2007 13:45:13 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3678. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.032752 secs); 16 Jul 2007 12:45:13 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Jul 2007 13:45:13 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52669>

I was wondering if anyone had some handy tips for debugging fast-import 
based importers?

I'm trying to import an SVN repository that was initially created by 
cvs2svn and, since we started using branches quite heavily _before_ 
switching to SVN, there is some quite messy history.

At some point in the "messy" phase I get an error from fast-import saying:

fatal: path foo not in branch

This seems to happen when I attempt to copy a file that is also changed in 
the same commit.  What I would like to do is find out what things look 
like just before that point - the problem is that fast-import seems to not 
create anything on failure.  So, apart restarting the import and stopping 
just before the broken commit, is there any way to find out what 
fast-import thinks the branch looks like?

Also, does anyone have any handy hints 'n' tips for working with 
fast-import?

-- 
Julian

  ---
Air pollution is really making us pay through the nose.
