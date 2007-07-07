From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Minor bug in git-apply's patch-cleaning
Date: Fri, 6 Jul 2007 22:21:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 04:21:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6zvU-0002w0-OG
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 04:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbXGGCVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 22:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbXGGCVe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 22:21:34 -0400
Received: from iabervon.org ([66.92.72.58]:1045 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbXGGCVe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 22:21:34 -0400
Received: (qmail 12939 invoked by uid 1000); 7 Jul 2007 02:21:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jul 2007 02:21:33 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51801>

If you apply in reverse a patch which adds junk (e.g., terminal 
whitespace), it complains about the junk you're adding, even though (since 
it's in reverse) you're actually removing that junk.

It's arguable as to whether it should complain about junk in - lines with 
--reverse; it's likely that you care more about getting the patch 
unapplied exactly than not reintroducing removed whitespace. But 
complaining about junk in + lines is actually confusing.

	-Daniel
*This .sig left intentionally blank*
