From: Daniel Barkalow <barkalow@iabervon.org>
Subject: fact-import: failed to apply delta
Date: Mon, 9 Feb 2009 22:26:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902092218050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 04:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWjHl-0007Mp-IG
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 04:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZBJD0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 22:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZBJD0S
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 22:26:18 -0500
Received: from iabervon.org ([66.92.72.58]:54621 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbZBJD0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 22:26:17 -0500
Received: (qmail 17896 invoked by uid 1000); 10 Feb 2009 03:26:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 03:26:16 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109177>

I'm getting a "fatal: failed to apply delta" from fast-import. I'm using a 
lot of checkpoints, and I haven't had it happen without making progress, 
so I was eventually able to import what I was importing (bunch of stuff I 
can't distribute, imported from perforce with the latest version of my p4 
importer that I'm still working on). Also, everything that was saved by 
the checkpoints was valid and correct (at least after the fact).

I'm going to see if it's reproducable, and, if so, if I can get a test 
case that I can distribute, but I wanted to post to see if anyone had any 
special debugging advice for this error message and program combination.

	-Daniel
*This .sig left intentionally blank*
