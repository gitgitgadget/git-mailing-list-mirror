From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 6 Mar 2008 21:38:32 +0100
Message-ID: <200803062138.32743.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXMry-0007oZ-PT
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705AbYCFUig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757295AbYCFUig
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:38:36 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:60201 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbYCFUif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:38:35 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 98AC9BEF46;
	Thu,  6 Mar 2008 21:38:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 64D1F611DD;
	Thu,  6 Mar 2008 21:38:33 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803052317350.15786@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76419>

On Wednesday 05 March 2008 23:18, Johannes Schindelin wrote:
> On Wed, 5 Mar 2008, Johannes Sixt wrote:
> > I've now created compat/mingw.h. Below is the interdiff. Of course, it
> > mostly only moves code around. But you might want to look at at mkstemp,
> > PATH_SEP, PRIuMAX, and has_dos_drive_prefix. Notice also that I include
> > compat/mingw.h early in git-compat-util.h instead of late.
>
> Thanks!
>
> With this, I think I have nothing to add to your series (except maybe an
> Acked-by: where it applies, or a Reviewed-by:, but I think that this
> would only be a burden on our maintainer).

Thank you!

I now wait for vsnprintf patches and the recent start_command patch to hit 
master, then I'll do a final rebase and fix-up before I consider the series 
ready for inclusion into git.git.

-- Hannes
