From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Msysgit 1.6.2 cannot clone from network drive
Date: Thu, 19 Mar 2009 18:49:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191845070.6357@intel-tinevez-2-302>
References: <1237483985187-2504254.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMOg-0005f3-5D
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbZCSRtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZCSRtm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:49:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:38424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751280AbZCSRtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:49:41 -0400
Received: (qmail invoked by alias); 19 Mar 2009 17:49:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 19 Mar 2009 18:49:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l275juWal794LZT1aTHnO9GE/14dqJNbQgdB/F5
	HeAj6wQ2/fWkNn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1237483985187-2504254.post@n2.nabble.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113801>

Hi,

On Thu, 19 Mar 2009, Henk wrote:

> I recently installed Msysgit 1.6.2 and noticed that using this version I
> cannot clone from (mapped) network drive anymore. This does work in Msysgit
> 1.6.1. I double checked this on the computer of a coworker.
> 
> We use Windows Vista Professional and are using active directory. Is this a
> known bug?

Yes.  It goes by the number 204.

Oh, and it is fixed, and the fix will be part of the next release.

There are a few things holding up a new release:

- there has been a bug report about "WARNING: terminal is not fully 
  functional" that I do not understand yet,

- there has been a bug report that adjust_perm() fails while cloning, and 
  I do not understand that either,

- Hannes was busy with fixing the test suite, and I am not decided yet if 
  I'd rather wait with Git-1.6.2.1-preview, or not, and

- there have been a lot of duplicate bug reports that are taking my scarce 
  time away from preparing the release. :-)

Ciao,
Dscho
