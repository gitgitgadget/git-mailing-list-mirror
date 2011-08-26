From: Bruce Korb <bruce.korb@gmail.com>
Subject: How do I get a readable diff?
Date: Fri, 26 Aug 2011 15:42:50 -0700
Message-ID: <4E58216A.8060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Development <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 00:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx576-00070x-OK
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 00:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab1HZWm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 18:42:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60193 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1HZWmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 18:42:54 -0400
Received: by ywf7 with SMTP id 7so3244802ywf.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=snF4l7FXCqwS/E1LHvutxOAGLIgcJk69uN8nGsUZpEo=;
        b=tkQGk9PX/fTIY2IHRQcZL1s30Uy4jHGap8C4tpKtW6pduYQxLsRPMGPyzDjAnMTKdn
         2Vp0YIif+h6kt3hSQuQ3eQxDPYwS6gdWhAX0tXq83MZ1F2ffmDuWanovYlv4lRehM8Ik
         wNHxBtw5LXm00kwaw76qh4AIK81+XfSJi9Pbw=
Received: by 10.42.178.194 with SMTP id bn2mr793126icb.475.1314398574084;
        Fri, 26 Aug 2011 15:42:54 -0700 (PDT)
Received: from [10.0.0.2] (adsl-75-2-137-220.dsl.pltn13.sbcglobal.net [75.2.137.220])
        by mx.google.com with ESMTPS id bv10sm2127183icb.13.2011.08.26.15.42.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 15:42:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180206>

I know I can pipe it through "cat", but I'd rather the clutter be gone.
There has to be a way.

ESC[1mdiff --git a/lustre/include/lustre_disk.h b/lustre/include/lustre_disk.hESC[m
ESC[1mindex 10f6328..564fc08 100644ESC[m
ESC[1m--- a/lustre/include/lustre_disk.hESC[m
ESC[1m+++ b/lustre/include/lustre_disk.hESC[m
ESC[36m@@ -185,6 +185,7 @@ESC[m ESC[mstruct lustre_mount_data {ESC[m
          int        lmd_exclude_count;ESC[m
          int        lmd_recovery_time_soft;ESC[m
          int        lmd_recovery_time_hard;ESC[m
ESC[32m+ESC[mESC[32m        int        lmd_reserved_inodes; /* preferred value */ESC[m
          char      *lmd_dev;           /* device name */ESC[m
          char      *lmd_profile;       /* client only */ESC[m
          char      *lmd_mgssec;        /* sptlrpc flavor to mgs */ESC[m
ESC[36m@@ -202,6 +203,8 @@ESC[m ESC[mstruct lustre_mount_data {ESC[m
                                          existing MGS services */ESC[m
  #define LMD_FLG_WRITECONF    0x0040  /* Rewrite config log */ESC[m
  ESC[m
ESC[32m+ESC[mESC[32m#define LMD_RESERVED_INODES_DEFAULT 100ESC[m
ESC[32m+ESC[m
  #define lmd_is_client(x) ((x)->lmd_flags & LMD_FLG_CLIENT)ESC[m
  ESC[m
  ESC[m
