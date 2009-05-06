From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tracking the untracked
Date: Wed, 6 May 2009 11:36:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905061130340.14230@intel-tinevez-2-302>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 11:36:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1dYH-0003UW-Bt
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZEFJgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZEFJgY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 05:36:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:35972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752813AbZEFJgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 05:36:24 -0400
Received: (qmail invoked by alias); 06 May 2009 09:36:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 06 May 2009 11:36:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cpQwNIr5cdUkA8ltwmHUq3UKph06PnHVcKj3SGI
	a0QIepwA4liXoq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118334>

Hi,

On Wed, 6 May 2009, Geoff Russell wrote:

> Bug or feature? I don't know.
> 
> On the master branch I have some untracked files e.g., object modules,
> executables.
> 
> I create a branch B1 and add+commit the untracked files.
> 
> When I switch back to the master (git checkout master), the untracked
> files are no longer where I left them.

This is exactly what Git is supposed to do.  You were on branch B1, which 
has the files tracked, and you do not have the files tracked in master, so 
when switching to master, they should be removed.

Probably you have to rethink what you are trying to do.

Ciao,
Dscho
