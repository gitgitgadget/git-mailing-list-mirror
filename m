From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] Add git_project_index, improve href()
Date: Fri, 15 Sep 2006 04:53:41 +0200
Message-ID: <200609150453.42231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 04:59:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO3vj-0007mF-EK
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 04:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWIOC7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIOC7O
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 22:59:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:60796 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751463AbWIOC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 22:59:14 -0400
Received: by ug-out-1314.google.com with SMTP id o38so121424ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:59:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=elMFRc8QMguGm7mMvs2MdDIiqcd+yxHTzAnUX4iu5wXZsOJBNCYCUUp9P/0v2KIoEAnLVzHK4vLr1EFgmcfGO9qSUep+QmPz8FYMdIHn1ET0NhDEZkjz2yhECvbz1iMgvPDiv1TwMQbL3w9jbC/Vl7ElMU7BD4JiLSjm/rUk1Cg=
Received: by 10.66.216.6 with SMTP id o6mr5209742ugg;
        Thu, 14 Sep 2006 19:59:12 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id b23sm1017606ugd.2006.09.14.19.59.11;
        Thu, 14 Sep 2006 19:59:12 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27058>

This series of patches introduces "project_index" view, which is text/plain
equivalent of projects list view, again. This time it is accompanied by
the patch which adds links to this view.

"project_index" view has at least two uses: first, to automatically generate
gitweb project index file (which we then edit, e.g. removing some projects
from being visible from gitweb and correcting ownership information).
Second, to get list of projects for scripts, in very easily parseable form.

Even if patches 1 and 3 got discarded, patch 2 is I think worth applying.
It finishes consolidation of URL generation.

Shortlog:
 [PATCH 1/3] gitweb: Add git_project_index for generating index.aux
 [PATCH 2/3] gitweb: Allow for href() to be used for projectless links
 [PATCH 3/3] gitweb: Add link to "project_index" view to "project_list" page

Diffstat:
 gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 44 insertions(+), 7 deletions(-)

P.S. Should shortlog be before, or after diffstat (if it matters)?
-- 
Jakub Narebski
ShadeHawk on #git
Poland
