From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Problems importing branches and tags
Date: Fri, 08 Jun 2007 12:35:45 +1000
Message-ID: <4668C081.8020303@usherbrooke.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 04:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwUL8-0002lr-Ow
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 04:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763753AbXFHCgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 22:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbXFHCgb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 22:36:31 -0400
Received: from panoramix.CeNTIE.NET.au ([202.9.6.85]:44675 "EHLO
	panoramix.centie.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763753AbXFHCgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 22:36:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by panoramix.centie.net.au (Postfix) with ESMTP id 7EDD6CFA15
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 12:35:45 +1000 (EST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49426>

Hi,

I've been trying to pull the Speex svn into Git with tags and branches.
Unfortunately, every time I try that, I end up pulling the history of
every other project in the repository as well. The command line I use is:
% git-svn clone http://svn.xiph.org/ -T trunk/speex -b
branches/speex-branches -t tags/speex-tags

For some reason, the most recent tags (that were created with svn) get
pulled fine. However, when the older ones (created with CVS and
converted to SVN) get pulled, they end up pulling all the other projects
in the repository (vorbis, mgm, ...).

As you can see from the repository above, the branches/speex-branches
and tags/speex-tags directories only contain Speex stuff, so I can't
understand where the problem comes from. Can anyone help?

	Jean-Marc
