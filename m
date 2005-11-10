From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: cg-admin-setuprepo fails to make a cg-clone'able repo
Date: 10 Nov 2005 08:32:35 -0800
Message-ID: <86wtjg31lo.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 10 17:36:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaFLw-0001SD-Je
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 17:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKJQcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVKJQcl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 11:32:41 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:47951 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751049AbVKJQck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 11:32:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5583F8F61F
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 08:32:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 32382-01-3 for <git@vger.kernel.org>;
 Thu, 10 Nov 2005 08:32:35 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D5F778F68B; Thu, 10 Nov 2005 08:32:35 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.12.14.2; tzolkin = 6 Ik; haab = 0 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11490>


Repeat by:

        cg-admin-setuprepo repo
        cg-clone $(PWD)/repo myview

Results:

    defaulting to local storage area
    Hard links don't work - using copy
    cp: illegal option -- b
    usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
           cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
    cg-fetch: unable to get the HEAD branch
    cg-clone: fetch failed

Did I just hold my mouth wrong?  I can't put a HEAD branch in, because
there's no local view in the repo.
-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
