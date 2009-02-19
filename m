From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] system_path(): simplify using strip_path_suffix(),
 and add suffix "git"
Date: Thu, 19 Feb 2009 21:48:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902192147180.6223@intel-tinevez-2-302>
References: <499C63E7.5040306@kdbg.org> <b91ca090ef4eed9e457b579df2e3fbede3d26299.1235070304u.git.johannes.schindelin@gmx.de> <499DC375.60105@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFq3-0003fg-6v
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbZBSUsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZBSUsO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:48:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753527AbZBSUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:48:14 -0500
Received: (qmail invoked by alias); 19 Feb 2009 20:48:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 19 Feb 2009 21:48:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//AVQK26P/BUzBok5tAct6jpdQAdw9tO8Bainy0E
	3sk1Uh+iTP2HbJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499DC375.60105@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110748>

Hi,

On Thu, 19 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > The real change is to add the suffix "git", so that a runtime prefix will
> > be computed correctly even when the executable was called in /git/ as is
> > the case in msysGit (Windows insists to search the current directory
> > before the PATH when looking for an executable).
> 
> msysgit is important enough to be supported by upstream git, in particular
> since it is *the* user of RUNTIME_PREFIX, so that this special-casing is
> warranted. Therefore:
> 
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.

Note, however, that IMHO RUNTIME_PREFIX would be good for non-Windows, 
too, as it would make Git relocatable.

Ciao,
Dscho
