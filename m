From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GIT-GUI) 0/3] Improve gui blame usability for large
	repositories
Date: Thu, 17 Jul 2008 02:16:23 +0000
Message-ID: <20080717021623.GC16740@spearce.org>
References: <200807170042.29462.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 04:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJJ3a-0007ZU-ST
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 04:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbYGQCQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 22:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754916AbYGQCQY
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 22:16:24 -0400
Received: from george.spearce.org ([209.20.77.23]:44752 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057AbYGQCQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 22:16:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 54D80382A4; Thu, 17 Jul 2008 02:16:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807170042.29462.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88798>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> Full copy detection can take quite some time on large repositories, which
> substantially decreases perceived usability of the 'git gui blame' command.
> This set of patches tries to overcome it by:
> 
> 1) Allowing the user to disable '-C -C' and/or set the detection threshold.
> 
> 2) Explicitly killing back-end processes, which don't produce any output
>   during copy detection, and thus normally won't receive SIGPIPE until
>   it is finished. Runaway processes are annoying.
> 
> 3) To compensate for (1), adding a context menu item to manually invoke
>   blame -C -C -C on a group of lines.

This series is nicely done.  Works well on revision.c in git.git,
where the blame can be costly to compute with full copy detection.
And getting the incremental from the context menu also works well.

Thanks.
 
-- 
Shawn.
