From: Julian Gindi <juliangindi@gmail.com>
Subject: [PATCH] CodingGuidelines: updating 'rough' rule count
Date: Sun, 12 Apr 2015 19:47:20 -0400
Message-ID: <20150412234720.GA37658@Serenity.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 01:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhRb7-0003kP-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 01:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbDLXrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 19:47:25 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32918 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbDLXrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 19:47:24 -0400
Received: by qkx62 with SMTP id 62so148929449qkx.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=KrLQGfToS5+th7Pcco0kyLT8mSa9+wzMfUwHgliBJTw=;
        b=HP5ipsf1Ad/PSQMbRbJvUrXbQDUZE91EHt1ETLxjex/Y078h//T3ve7Vkap/2MbW/y
         4kDgsRfPQ3bViaXNkMSZfGgQHm6r4Y2mlD5THalZu+4rMi2rPcHApeqXnkIisLFLxidT
         A/Qren84y+mxnzSCm6eH9mQ+dke5vy6msFun+aY337Rhc7ZGgnMU6cRTvRc/0bH+BnVy
         6lsTLFHHQ+ZBiC6ZCVaHIUAoDp4CoXtXHFajs4dXX/aY7pmaxQLR5yfuDSlhst6+cS9j
         D73OX5Peab8gb6FCBV/nSvKFroIo5gg+DhRSO3Tkj4Odpa9JxsK1XHiJh1VCqaCQyBw9
         mmNg==
X-Received: by 10.55.20.132 with SMTP id 4mr24310805qku.104.1428882443878;
        Sun, 12 Apr 2015 16:47:23 -0700 (PDT)
Received: from localhost (c-50-190-25-147.hsd1.dc.comcast.net. [50.190.25.147])
        by mx.google.com with ESMTPSA id z77sm4502589qkg.44.2015.04.12.16.47.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 16:47:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267058>

Changed inaccurate count of "rough rules" from three to four.

Signed-off-by: Julian Gindi <juliangindi@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0f8cccf..c422ecd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -1,5 +1,5 @@
 Like other projects, we also have some guidelines to keep to the
-code.  For Git in general, three rough rules are:
+code.  For Git in general, four rough rules are:
 
  - Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
-- 
2.3.5
