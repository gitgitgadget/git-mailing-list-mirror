From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Enable setting attach in .gitconfig for
 git-format-patch.
Date: Sat, 7 Feb 2009 23:45:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902072344350.10279@pacific.mpi-cbg.de>
References: <498E038F.3090704@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 23:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvwY-0007uQ-3l
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 23:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZBGWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 17:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZBGWoz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 17:44:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:47032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753104AbZBGWoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 17:44:55 -0500
Received: (qmail invoked by alias); 07 Feb 2009 22:44:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 07 Feb 2009 23:44:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181/UtCyNs1wfRTVov04BYXmi222D0cxAHuLCoKR9
	qNKipAxnP5DSmu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <498E038F.3090704@codeweavers.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108899>

Hi,

On Sat, 7 Feb 2009, Jeremy White wrote:

> In an attempt to keep us Thunderbird users from embarrassing ourselves.
> 
> Signed-off-by: Jeremy White <jwhite@codeweavers.com>
> ---
>  Documentation/git-format-patch.txt |    4 +++-
>  builtin-log.c                      |   15 +++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletions(-)

Pity.  You attached the patch.  So I do not quote the part where you use a 
strlen() > 0 which would better be a *value.  But it would be nice to fix 
the issue.

Ciao,
Dscho
