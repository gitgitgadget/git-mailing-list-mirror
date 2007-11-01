From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Simplify dealing with raw diff output
Date: Thu,  1 Nov 2007 12:38:07 +0100
Message-ID: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 12:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYLC-0001N2-6y
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 12:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbXKALfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 07:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbXKALfo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 07:35:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64868 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306AbXKALfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 07:35:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so450341ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:subject:date:message-id:x-mailer;
        bh=unO7u6CAWs41MAm87IZkLUeeAIah8J+v7glrVNnAEGc=;
        b=apmq7qwYjX5DGPMTS5+W7sinPx7zT8P6F8JdtDjgy5yp5hCbjitphEi8SFNXV/v5UICrz0ScRQdrLHhyo5NAkZaXvCOEKBoNegU9DHQlLcbQbnsQxvDnmTxnZrigC9hJOH1jHhCGOMJBQ9jHysUJym0FzVVG8DppMbmHV1gWXb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=VlKXmuJeWvgr3nbXKFULPxr6RujLr8nzEFCkxrJQOKl60fhJNKR0IRnQMHDz9Pwz69f2sqWn8iEDLRiNiJml6fz0dr6h3rs+ge3LyWRxALiHo3GQvApcpHxw7zTYkPfdiuCq/zWANKNEj6mWvqIeAiO27s1ddo1/CaHwFO8Z5PE=
Received: by 10.66.236.13 with SMTP id j13mr192328ugh.1193916940287;
        Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id o1sm2176533uge.2007.11.01.04.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 04:35:39 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1BcAMd015945
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 12:38:11 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1BcAA4015944
	for git@vger.kernel.org; Thu, 1 Nov 2007 12:38:10 +0100
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62937>

This series of patches simplifies (and improves) gitweb code dealing
with (parsed) raw diff output format.

See individual patches for more detail.


Table of contents:
 [PATCH 1/2] gitweb: Always set 'from_file' and 'to_file'
             in parse_difftree_raw_line 
 [PATCH 2/2] gitweb: Add 'status_str' to parse_difftree_raw_line output

Diffstat:
 gitweb/gitweb.perl |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

-- 
Jakub Narebski
Poland
