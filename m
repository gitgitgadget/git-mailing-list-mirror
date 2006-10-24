From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Improvements to commitdiff oview
Date: Tue, 24 Oct 2006 13:49:54 +0200
Message-ID: <200610241349.54685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 13:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKsX-0005Jy-4D
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWJXLzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWJXLzY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:55:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:870 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030375AbWJXLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 07:55:24 -0400
Received: by ug-out-1314.google.com with SMTP id 32so174700ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 04:55:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZoMU/b0Z5Hta7Rg6Y2ygz1XVKILrikRqMNMgdMNzwO1hmw7g4b2Hu9QwPjBDeKLIehb+RUzPmomAR6dAE2SpzrAkeAfoe/7Y9sKg7a7/IqaEFIV2XkiHnVwIXyX2yB96ugEJc8qf2nSG5rORH1cb6DgUzmka4ZHtalQnzlwGdTE=
Received: by 10.66.216.20 with SMTP id o20mr8636291ugg;
        Tue, 24 Oct 2006 04:55:13 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b35sm582575ugd.2006.10.24.04.55.12;
        Tue, 24 Oct 2006 04:55:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29971>

This series (patch 2 to be more exact) fixes error seen for example in
  a=commitdiff;h=161332a521fe10c41979bcd493d95e2ac562b7f
in git.git repository.

Shortlog:
 [PATCH 1/3] gitweb: Get rid of git_print_simplified_log
 [PATCH 2/3] gitweb: Filter out commit ID from @difftree in git_commit and git_commitdiff
 [PATCH 3/3] gitweb: Print commit message without title in commitdiff only if there is any

Diffstat:
 gitweb/gitweb.perl |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

-- 
Jakub Narebski
Poland
