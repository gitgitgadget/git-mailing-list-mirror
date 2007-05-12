From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3] Remotes library, take 4
Date: Sat, 12 May 2007 11:45:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705121137400.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 17:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmtnj-0003ns-PZ
	for gcvg-git@gmane.org; Sat, 12 May 2007 17:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbXELPpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 11:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754464AbXELPpu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 11:45:50 -0400
Received: from iabervon.org ([66.92.72.58]:3663 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755555AbXELPpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 11:45:50 -0400
Received: (qmail 27710 invoked by uid 1000); 12 May 2007 15:45:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 15:45:48 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47056>

Updated for recent review. If remote section name starts with '/', it is 
ignored (like in 1.5.0). If a remote section option has no value, it is 
also ignored (so it doesn't crash, and to be forward-compatible if we 
introduce a boolean option later).

The struct refspec field and associated variables are spelled "dst".

Part 3 is unchanged.

	-Daniel
*This .sig left intentionally blank*
