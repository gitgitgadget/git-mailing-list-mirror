From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: How do I get a readable diff?
Date: Fri, 26 Aug 2011 17:58:32 -0500
Message-ID: <YLOHfGzBBJxbxqM1qsJcnw-e9_g2VtXOgnU8xvQ_IlNrU6zqGVsN05yN5fm1zRD8rr_rz_2cO52ZPfqe5_03kZm5DwGQebZf_9jzyEsmGQw@cipher.nrlssc.navy.mil>
References: <4E58216A.8060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 00:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx5ML-0003gY-Ef
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 00:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab1HZW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 18:58:40 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:41870 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751244Ab1HZW6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 18:58:39 -0400
Received: by mail3.nrlssc.navy.mil id p7QMwX3I008684; Fri, 26 Aug 2011 17:58:33 -0500
In-Reply-To: <4E58216A.8060508@gmail.com>
X-OriginalArrivalTime: 26 Aug 2011 22:58:32.0623 (UTC) FILETIME=[ADAC2BF0:01CC6443]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180207>

On 08/26/2011 05:42 PM, Bruce Korb wrote:
> I know I can pipe it through "cat", but I'd rather the clutter be gone.
> There has to be a way.

Your terminal does not support color.  Are you on an ancient system?
or something exotic?

You can disable it by setting the color.ui config variable in your
"user" config file ~/.gitconfig like this:

   git config --global color.ui never

-Brandon


> ESC[1mdiff --git a/lustre/include/lustre_disk.h b/lustre/include/lustre_disk.hESC[m
> ESC[1mindex 10f6328..564fc08 100644ESC[m
> ESC[1m--- a/lustre/include/lustre_disk.hESC[m
> ESC[1m+++ b/lustre/include/lustre_disk.hESC[m
> ESC[36m@@ -185,6 +185,7 @@ESC[m ESC[mstruct lustre_mount_data {ESC[m
>          int        lmd_exclude_count;ESC[m
>          int        lmd_recovery_time_soft;ESC[m
>          int        lmd_recovery_time_hard;ESC[m
> ESC[32m+ESC[mESC[32m        int        lmd_reserved_inodes; /* preferred value */ESC[m
>          char      *lmd_dev;           /* device name */ESC[m
>          char      *lmd_profile;       /* client only */ESC[m
>          char      *lmd_mgssec;        /* sptlrpc flavor to mgs */ESC[m
> ESC[36m@@ -202,6 +203,8 @@ESC[m ESC[mstruct lustre_mount_data {ESC[m
>                                          existing MGS services */ESC[m
>  #define LMD_FLG_WRITECONF    0x0040  /* Rewrite config log */ESC[m
>  ESC[m
> ESC[32m+ESC[mESC[32m#define LMD_RESERVED_INODES_DEFAULT 100ESC[m
> ESC[32m+ESC[m
>  #define lmd_is_client(x) ((x)->lmd_flags & LMD_FLG_CLIENT)ESC[m
>  ESC[m
>  ESC[m
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
