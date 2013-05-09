From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH 1/3] poll.h lies in the same folder, so use normal quotes
 for include
Date: Thu, 09 May 2013 03:12:10 +0200
Message-ID: <518AF7EA.6020403@cs-ware.de>
References: <518AF79A.5000408@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:20:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFXC-0002wd-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab3EIBUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:20:07 -0400
Received: from srv1.79p.de ([213.239.234.118]:33166 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016Ab3EIBUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:20:04 -0400
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 1721844103D;
	Thu,  9 May 2013 03:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368061930;
	bh=VPf4svFBKsxpsXZjq0Omr2tXEIkAFncxsQqZxOX2OYc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=UfRpfTh7OmRA9uMXxDsgiZRyw9D2qzEG2q16CYX/2uxUusx1y8oj3A77pNdB/Zp6H
	 BIdU48HvMkW2i1/i8NmaQEIuFstDT8jOPssRNA0pM7AsZ3ppuN1HjZJ5zHiNPkkt4r
	 mQlj7bGze0Vee/vGSQ5L7saXoY6s5ybTHWKZnPeo=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518AF79A.5000408@cs-ware.de>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223701>

Some compilers, like Visual C++ complain when <> is used instead of
double quotes for non system includes.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 7d226ec..b85386a 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -31,7 +31,7 @@
 #include <sys/types.h>
 
 /* Specification.  */
-#include <poll.h>
+#include "poll.h"
 
 #include <errno.h>
 #include <limits.h>
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
