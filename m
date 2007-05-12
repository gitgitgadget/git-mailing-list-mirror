From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] format-patch stuff
Date: Sat, 12 May 2007 11:36:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705121109520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 17:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmteZ-00027s-OV
	for gcvg-git@gmane.org; Sat, 12 May 2007 17:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXELPg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXELPg5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 11:36:57 -0400
Received: from iabervon.org ([66.92.72.58]:4593 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbXELPg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 11:36:57 -0400
Received: (qmail 12140 invoked by uid 1000); 12 May 2007 15:36:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 15:36:54 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47053>

It would be nice if git-format-patch would generate a [PATCH 0/n] message 
at the start of the series if some option were given. This would, of 
course, have to be editted afterwards to include actual information, but 
it would at least be pre-generated in series and with the configured 
headers and such.

Shouldn't the format.headers configuration automatically apply the correct 
line termination? Currently, you need to know to put in \r\n at the end of 
each one, and the example isn't even right (only puts \n).

Once we've got library support for remotes configuration, it would be nice 
to be able to have "mailto:" remotes with emailed patch configuration 
stuff per-destination.

	-Daniel
*This .sig left intentionally blank*
