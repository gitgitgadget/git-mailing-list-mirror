From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/3] MSVC: Compile fix by including io.h
Date: Fri, 21 Oct 2011 21:39:42 +0200
Message-ID: <4EA1CA7E.5030301@lyx.org>
References: <4EA1C9C9.9010904@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 21:39:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKwb-0003mr-TX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1JUTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 15:39:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50665 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1JUTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:39:49 -0400
Received: by eye27 with SMTP id 27so4175543eye.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 12:39:48 -0700 (PDT)
Received: by 10.213.109.12 with SMTP id h12mr3385721ebp.146.1319225987729;
        Fri, 21 Oct 2011 12:39:47 -0700 (PDT)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id 49sm37539628eec.1.2011.10.21.12.39.46
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 12:39:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA1C9C9.9010904@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184082>

Include io.h when compiling with MSVC

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
  compat/msvc.h |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index a33b01c..aa4b563 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -4,6 +4,7 @@
  #include <direct.h>
  #include <process.h>
  #include <malloc.h>
+#include <io.h>

  /* porting function */
  #define inline __inline
--
1.7.6.msysgit.0
