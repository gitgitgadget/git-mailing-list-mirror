From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Submodule idea
Date: Sat, 29 Sep 2007 15:04:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709291442430.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 21:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbhcY-0007tp-Ur
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 21:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbXI2TEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbXI2TEv
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 15:04:51 -0400
Received: from iabervon.org ([66.92.72.58]:55124 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073AbXI2TEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 15:04:51 -0400
Received: (qmail 8982 invoked by uid 1000); 29 Sep 2007 19:04:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Sep 2007 19:04:50 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59487>

I *think* that it would be a great benefit if "git submodule update" would 
leave you on a branch if (a) you were on that branch before, and (b) 
pulling on that branch would update it to the commit that the superproject 
specifies for that submodule.

Or maybe there should be a "git submodule fetch" which fetches from the 
remote, and replaces FETCH_HEAD with the superproject's index entry, and 
"git submodule pull" would merge it? (With the model being that the entry 
in the superproject is an additional remote that you both track and 
publish to)

	-Daniel
*This .sig left intentionally blank*
