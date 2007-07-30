From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] per-user ignore file
Date: Mon, 30 Jul 2007 16:28:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 22:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFbr1-00058G-Ud
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938338AbXG3U2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937745AbXG3U2Y
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 16:28:24 -0400
Received: from iabervon.org ([66.92.72.58]:2012 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761449AbXG3U2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 16:28:23 -0400
Received: (qmail 29410 invoked by uid 1000); 30 Jul 2007 20:28:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2007 20:28:13 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54260>

It would be nice to have a per-user ignore file, so that emacs users can 
ignore "*~", "#*#", and ".#*". Probably this should be in the form of 
having a config option for additional ignore file names, so that the user 
can decide where to put it. (E.g., ~/.gitignore would be an issue if the 
user is tracking their home directory with git and wants to ignore some 
files in the home directory repository but track similarly named files in 
some other repository). Are there any fundamental issues with this, or is 
it just that nobody's been sufficiently motivated to do it?

	-Daniel
*This .sig left intentionally blank*
