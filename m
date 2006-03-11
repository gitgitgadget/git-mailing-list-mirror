From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 0/6] http-push updates
Date: Fri, 10 Mar 2006 20:17:49 -0800
Message-ID: <20060311041749.GB3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYP-0004ss-Qe
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWCKER5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbWCKER5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:17:57 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:57294 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750987AbWCKER4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:17:56 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4Holr007618
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:17:50 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4HoMT007616
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:17:50 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17486>

This series fixes a few http transport and http-push bugs, includes some
refactoring, and adds functionality to update remote server info/refs.

I'm considering future support for initializing a remote repo if the
remote url points to an empty directory and the --force arg is present.
Any thoughts?

I'm also planning to add support for using packs to send updates, and
for updating remote server objects/info/packs.  I'm not sure whether it
makes sense to always send packs or to only do so when enough objects
need to be pushed.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
