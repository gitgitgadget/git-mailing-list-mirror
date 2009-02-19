From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Introduce the function strip_path_suffix()
Date: Thu, 19 Feb 2009 21:44:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902192143320.6223@intel-tinevez-2-302>
References: <499C63E7.5040306@kdbg.org> <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de> <499DC08F.3030106@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFt8-0004xF-Tx
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZBSUv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbZBSUvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:51:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:40691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754565AbZBSUvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:51:25 -0500
Received: (qmail invoked by alias); 19 Feb 2009 20:44:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 19 Feb 2009 21:44:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cyCwI4HacEP1n1sptkiQ3EqNqjLtmEUtA35V4e5
	vpk/h+f8uiaCdc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499DC08F.3030106@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110749>

Hi,

On Thu, 19 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +/* sets prefix if the suffix matches */
> 
> /*
>  * If path ends with suffix (complete path components), returns the
>  * part before suffix (sans trailing directory separators).
>  * Otherwise returns NULL.
>  */

Thanks.  It shows that I did not really have time to polish this properly 
today, does it not?

Ciao,
Dscho
