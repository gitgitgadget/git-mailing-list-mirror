From: Stephen Haberman <stephen@exigencecorp.com>
Subject: pull --preserve-merges
Date: Fri, 7 Nov 2008 16:01:38 -0600
Organization: Exigence
Message-ID: <20081107160138.aa96405c.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:03:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZPt-0006B5-2k
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYKGWBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYKGWBn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:01:43 -0500
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:59015 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYKGWBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:01:43 -0500
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id ACD711D5E3A
	for <git@vger.kernel.org>; Fri,  7 Nov 2008 17:01:42 -0500 (EST)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 494BE1D5E56
	for <git@vger.kernel.org>; Fri,  7 Nov 2008 17:01:42 -0500 (EST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100338>

Hi,

Awhile ago I brought up wanting to have a "rebase with preserve merges"
option for `git pull`:

http://thread.gmane.org/gmane.comp.version-control.git/96513

Andreas had a patch to help by supporting manually typing out `git pull
--rebase --preserve-merges`:

http://thread.gmane.org/gmane.comp.version-control.git/96593

And then I did another small copy/paste patch on top to add a config
setting of `branch.<name>.preservemerges` much like the existing
`branch.<name>.rebase`.

The patches haven't gotten an explicit "no" that I noticed, nor have
they been applied...is there anything I can do to move them along?
Resubmit them or what not?

Thanks,
Stephen
