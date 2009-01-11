From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH 0/3] Support for importing in builtin-fetch
Date: Sun, 11 Jan 2009 15:12:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901110318530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6gu-0008Ht-77
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZAKUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZAKUMF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:12:05 -0500
Received: from iabervon.org ([66.92.72.58]:48380 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbZAKUME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:12:04 -0500
Received: (qmail 30911 invoked by uid 1000); 11 Jan 2009 20:12:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:12:01 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105212>

This series is an attempt to standardize importers and exporters for 
non-git upstream repositories, and to allow the normal git programs to use 
them transparently when configured to do so. So far, it only includes 
fetch/import, but the implementation there is sufficient to get "git 
fetch" to import data from a foreign system, set the configured remotes/ 
refs, and produce a working FETCH_HEAD (so "git pull" also works).

Part 4/3 is yet another p4 importer, which is mostly interesting as an 
example (although it does do a passable job of supporting integrates, 
which I haven't seen in another client-side p4 importer).

	-Daniel
*This .sig left intentionally blank*
