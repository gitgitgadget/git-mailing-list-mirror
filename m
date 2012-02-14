From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/2] t: add blame -e tests for mailmap
Date: Wed, 15 Feb 2012 01:32:26 +0200
Message-ID: <1329262348-9546-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 00:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRsI-0001w0-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761338Ab2BNXd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:33:26 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:50956 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757386Ab2BNXdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 18:33:25 -0500
Received: by lbom4 with SMTP id m4so236946lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 15:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oe8FcwcCGqNna5WaV3Af+KG/7ws3qOQvCiHtwy4twS0=;
        b=dPtosHkJpkX61PH0XtxHgDyL7/qmnl1qjNflkqY6JZHAl5fm7bkG1AuGiqihkgITFc
         YxcSbLaXxZEfy4tRZuYARz0XXMGXtmYxMEGYYobhNnZLb+An1sI43lagFxW3ouEcPyVf
         YdYRxSNaMX77YltttHHxHYA1lj2xGvnALKv1U=
Received: by 10.112.11.10 with SMTP id m10mr7929580lbb.11.1329262404282;
        Tue, 14 Feb 2012 15:33:24 -0800 (PST)
Received: from localhost (a91-153-255-128.elisa-laajakaista.fi. [91.153.255.128])
        by mx.google.com with ESMTPS id os5sm968439lab.13.2012.02.14.15.33.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 15:33:23 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190797>

I sent both the fix and the tests. Another fix was applied, but we are still
missing the tests.

These are good before, and after the fix.

Since v2 (which I forgot to prefix):

 1) Be _a bit_ more explicit about the fact that the new tests where missing.
    Also state in the output that these are for blame show-email.
 2) Explain why the existing tests are not enough, and what fixed one of them

Felipe Contreras (2):
  t: mailmap: add missing 'git blame -e' tests
  t: mailmap: add simple name translation test

 t/t4203-mailmap.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

-- 
1.7.9
