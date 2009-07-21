From: Jeff Moyer <jmoyer@redhat.com>
Subject: [RFE] allow git bisect to figure out in which revision a bug was fixed
Date: Tue, 21 Jul 2009 16:16:50 -0400
Message-ID: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Bacik <josef@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 22:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLll-0008Nu-NO
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbZGUUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbZGUUQw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:16:52 -0400
Received: from mx2.redhat.com ([66.187.237.31]:59253 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbZGUUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:16:52 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKGqT8029056
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 16:16:52 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6LKGpsB006647;
	Tue, 21 Jul 2009 16:16:51 -0400
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.16.60.26])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKGoXu023238;
	Tue, 21 Jul 2009 16:16:50 -0400
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123692>

Hi,

As a distro kernel grunt, I sometimes find myself in the situation of
having to track down the commit that fixed a given problem so that I can
backport it to an older kernel.  Sometimes I'm smart enough to figure it
out myself, other times I'm not.  ;-)  It would be helpful if git bisect
could help figure out in what commit a bug was fixed as opposed to
introduced.  Is there any interest in implementing such a feature?

Thanks,
Jeff
