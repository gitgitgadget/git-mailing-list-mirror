From: Nicolas Pitre <nico@cam.org>
Subject: bug with gitweb on kernel.org
Date: Thu, 19 Apr 2007 23:02:21 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 05:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HejOU-0008WH-Ny
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 05:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbXDTDCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 23:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXDTDCX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 23:02:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbXDTDCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 23:02:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGS00K5I0FX82F0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Apr 2007 23:02:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45059>

Almost 2 months ago we discussed about gitweb not properly detecting the 
client's ability to deal with application/xhtml+xml, something to do 
with the caching of a previous request from a client which did support 
it and serving the same content to a subsequent client which does not.

Right now www.kernel.org/git is unusable for me with lynx as it keeps 
prompting:

	application/xhtml+xml  D)ownload, or C)ancel

Is there any plan to have that fixed?


Nicolas
