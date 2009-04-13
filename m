From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] Documentation: fix a grammatical error in api-builtin.txt
Date: Mon, 13 Apr 2009 14:11:21 -0400
Message-ID: <20090413181121.GA8851@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQef-0002GU-73
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbZDMSLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZDMSL3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:11:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:30085 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZDMSL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:11:28 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2285984ywb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=gM8JIRSV0S3DjZMyJluBYUVzN8HREV0eLL2/cs+ACII=;
        b=GpPxx3K71WdBVINrxJVrsPGgYBbSFdUUlMarp1tvbz5c42Bs90gSj0wk+oDdCUUA5X
         btaPlMIRN5lgNPiXpMpmThDq68ryYT6LZSRRwnW7iWs/d6cVnXXsgXR1dC/xrvUjfmSM
         qv/+BqGSNXfVWbzMxelHo2/XWzSkYrUS1/Skg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=cjGD+0VZp7xnljbt98exHQMLn9Esc/PUuOiyJfFmplcDP5uAKnuz9MMV6w/XqcOcPK
         Xi4LPusJ/mRx/dAqCGFWAPyMlV2/GXa0IGro+Muloa/A3lfmCr6hCb1RjfAJzRwliSSN
         z9TLp8mwhCsMcWDC04tO/w+NV0SOPiauGu1Rc=
Received: by 10.142.172.12 with SMTP id u12mr2711035wfe.288.1239646286987;
        Mon, 13 Apr 2009 11:11:26 -0700 (PDT)
Received: from linux.vnet (n1-13-232.dhcp.drexel.edu [129.25.13.232])
        by mx.google.com with ESMTPS id 29sm18509045wfg.33.2009.04.13.11.11.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:11:25 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116456>


Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 Documentation/technical/api-builtin.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 7ede1e6..5cb2b05 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -37,7 +37,7 @@ where options is the bitwise-or of:
 
 	Make sure there is a work tree, i.e. the command cannot act
 	on bare repositories.
-	This makes only sense when `RUN_SETUP` is also set.
+	This only makes sense when `RUN_SETUP` is also set.
 
 . Add `builtin-foo.o` to `BUILTIN_OBJS` in `Makefile`.
 
-- 
1.5.6.3
