From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] t: add blame -e tests for mailmap
Date: Tue, 14 Feb 2012 18:11:32 +0200
Message-ID: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 17:12:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxKzp-00034t-4u
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 17:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2BNQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 11:12:41 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51541 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756249Ab2BNQMf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 11:12:35 -0500
Received: by lagu2 with SMTP id u2so116469lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dCT8r7+msZ8ktJLMvxE4CD7plUHkL45UyzXKfuppEiA=;
        b=xBCODTPhe3XO7hJDN7khjFkrVZzjptTDi6Xd+xxvnvGoP+knuN4BqIPQqsab56yxfI
         +pPb4al9Z0JAIIRFHBkf8k1dLzynSapODykY7Upff+dvmYtqgOgvcX+b8gGF/5KcDdiQ
         T6vcb/vyvoy7XzvzrcM8dMsN6hX6bpomEqB7I=
Received: by 10.152.125.12 with SMTP id mm12mr14979143lab.48.1329235954024;
        Tue, 14 Feb 2012 08:12:34 -0800 (PST)
Received: from localhost (a91-153-255-128.elisa-laajakaista.fi. [91.153.255.128])
        by mx.google.com with ESMTPS id w10sm17016979lbe.14.2012.02.14.08.12.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 08:12:33 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190724>

I sent both the fix and the tests. Another fix was applied, but we are still
missing the tests.

These are good before, and after the fix.

Felipe Contreras (2):
  t: mailmap: add 'git blame -e' tests
  t: mailmap: add simple name translation test

 t/t4203-mailmap.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

-- 
1.7.9.1.g97f7d
