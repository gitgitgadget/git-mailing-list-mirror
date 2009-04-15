From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: avoid crash if closed while reading references
Date: Wed, 15 Apr 2009 18:46:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904151846060.6814@intel-tinevez-2-302>
References: <87prfdnbck.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, paulus@samba.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8Hm-00074t-5z
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZDOQq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZDOQq5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:46:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:42894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbZDOQq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:46:56 -0400
Received: (qmail invoked by alias); 15 Apr 2009 16:46:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 15 Apr 2009 18:46:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eZBQEbPQe6Pp+jnRGkp1Z2ehDscJgzqBM02jfif
	zb5kFIAA8FSabt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <87prfdnbck.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116625>

Hi,

On Wed, 15 Apr 2009, Pat Thoyts wrote:

> 
>   As recorded in msysGit issue 125 if the user closes gitk while it
>   reports itself as still reading references then Tk will crash in the
>   geometry management code. This has been fixed for Tk 8.5.7 and above.
>   This patch avoids the problem by flushing outstanding geometry events
>   before calling the readrefs procedure.
> 
>   See also http://code.google.com/p/msysgit/issues/detail?id=125
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

This is commit 3d3ecb65e34a62b83648516150ec8a99e1b3ace7 in 4msysgit's 
'devel' branch now, and will be part of the next msysGit release.

Thanks,
Dscho
