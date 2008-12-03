From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv3 0/2] gitweb: patch view
Date: Wed,  3 Dec 2008 23:59:46 +0100
Message-ID: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 00:00:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80i7-00073c-IV
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbYLCW7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYLCW7a
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:59:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:62936 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYLCW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:59:29 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3564554ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=B/TPxiWO1Zv0a6U+LMCZOuJn42c2ddN8DEZghKO20Wc=;
        b=SNepaQZ3IqVEBPH0T1AEoBu1P99v0l113bgOrXu6ehKmO+qPISV4WUrlDoXMOnEPK5
         aulTjsHY5yfPiXQb+p1GAYrH813oN1clbsQbGo4s6mCQfpCD7VfZLyvGWKbNlwP1V8EN
         WAJxvTH8wIuyi+iyixzecZpWL0FPEItyiF3WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OTs80lb1ptlQl7LZFHn/YEslN5UtLxDuJ9CyjtYWwcdtzqAANBK6MogFQUluVUFXZf
         isDe27W9iBpINHNiPh59OsFymYqo0kzsdMRnwPEUDokCoDjmVN0LmQU3BfMjpRY4Ewch
         s/MbfesFSmR6nT7mr3XrvP1GaBBU4+7GPiBZc=
Received: by 10.103.249.19 with SMTP id b19mr6519427mus.86.1228345167730;
        Wed, 03 Dec 2008 14:59:27 -0800 (PST)
Received: from localhost ([94.37.11.168])
        by mx.google.com with ESMTPS id c28sm12989451fka.30.2008.12.03.14.59.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 14:59:27 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102299>

Another go at the patch view feature. I'm marking this as RFC because
there are still a couple of points that need to be agreed on, esp. wrt
to the patch limiting and the insertion of extra X-Git-* email headers.

Giuseppe Bilotta (2):
  gitweb: add patch view
  gitweb: links to patch action in commitdiff and shortlog view

 gitweb/gitweb.perl |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 1 deletions(-)
