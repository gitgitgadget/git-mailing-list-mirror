From: Francis Galiegue <fg@one2team.net>
Subject: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 15:22:13 +0100
Organization: One2team
Message-ID: <200811101522.13558.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 15:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzXgI-00039k-9B
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 15:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYKJOWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 09:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYKJOWj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 09:22:39 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:43886 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbYKJOWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 09:22:39 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-18-7.w90-8.abo.wanadoo.fr [90.8.225.7])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 79D8292C003;
	Mon, 10 Nov 2008 15:22:30 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100524>

Hello,

A very nice git feature, without even going as far as merges, is the cherry 
pick feature.

For this to be doable from within the Eclipse Git plugin, a diff/patch 
implementation needs to be found, in a license compatible with the current 
JGit license (3-clause BSD, as far as I can tell). Or a new implementation 
can be rewritten from scratch, of course.

I found this:

http://code.google.com/p/google-diff-match-patch

Its license is the Apache 2.0 license. It implements the same algorithm than 
git's internal diff engine ("An O(ND) Difference Algorithm and its 
Variations", by Eugene Myers), and as far as I can tell so far (IANAL, far 
from it), it is compatible with JGit's current license.

Could this be a viable candidate?

-- 
fge
