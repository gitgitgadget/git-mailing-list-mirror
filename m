From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 10/16] pack-objects: use bitmaps when packing objects
Date: Tue, 25 Jun 2013 08:58:42 -0700
Message-ID: <87sj05lvsy.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-11-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uras9-00058r-QP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab3FYVdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6749 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab3FYVdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:53 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:51 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:51 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228998>

Vicent Marti <tanoku@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index e03c773..0f2e72b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -703,6 +703,7 @@ LIB_H += notes.h
>  LIB_H += object.h
>  LIB_H += pack-revindex.h
>  LIB_H += pack.h
> +LIB_H += pack-bitmap.h
>  LIB_H += parse-options.h
>  LIB_H += patch-ids.h
>  LIB_H += pathspec.h
> @@ -838,6 +839,7 @@ LIB_OBJS += notes.o
>  LIB_OBJS += notes-cache.o
>  LIB_OBJS += notes-merge.o
>  LIB_OBJS += object.o
> +LIB_OBJS += pack-bitmap.o
>  LIB_OBJS += pack-check.o
>  LIB_OBJS += pack-revindex.o
>  LIB_OBJS += pack-write.o

What does this apply on?  When starting with the series from
origin/master, git-am fails, and 'git am -3' tells me I don't have the
necessary blobs (from the 'index' line above).

Not that it's super hard to fix this up as long as it's in the Makefile
only, but still.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
