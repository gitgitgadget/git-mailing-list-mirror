From: Thomas Thurman <tthurman@gnome.org>
Subject: Autodiscovery of git repositories from HTML
Date: Tue, 27 Oct 2009 13:00:00 +0000
Message-ID: <20091027130000.GX30085@Dorothy.plexq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 14:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2lkJ-0002tm-Al
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 14:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZJ0NFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZJ0NFo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 09:05:44 -0400
Received: from dorothy.plexq.com ([174.143.253.158]:54252 "EHLO
	dorothy.plexq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbZJ0NFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 09:05:44 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2009 09:05:44 EDT
Received: by dorothy.plexq.com (Postfix, from userid 1001)
	id 02DD1245F7; Tue, 27 Oct 2009 13:00:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131330>

I have a web page which lives in a git repository so that it can be 
easily mirrored.  I would like to use a "rel" link to the URL of the git 
repository so that it can be automatically discovered, like an RSS feed:

<link rel="alternate" type="???" href="http://example.com/.git"/>

Is there any existing convention as to what the type should be?
Note that this isn't necessarily the same question as what a git 
repository should be served as over HTTP: the Universal Edit Button uses 
a dummy MIME type of "application/x-wiki".

Thomas
-- 
Thomas Thurman - thomas at thurman.org.uk - http://marnanel.org
What if a dragon stole your library books? http://borrowable.net
