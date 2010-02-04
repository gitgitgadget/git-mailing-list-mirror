From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 19:00:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>  <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302> <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 19:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd609-0006Jl-TZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 19:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab0BDSAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 13:00:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:47915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754892Ab0BDSAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 13:00:12 -0500
Received: (qmail invoked by alias); 04 Feb 2010 18:00:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 04 Feb 2010 19:00:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zhntZCDXzhiIFb9jG/KNHRNX7g40oSU0CsLfyxH
	0RvW1Fz9aWAEF6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138993>

Hi,

On Thu, 4 Feb 2010, Jay Soffian wrote:

> On Thu, Feb 4, 2010 at 8:27 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> (Here I'm setting GIT_EDITOR=true just to demonstrate that I didn't
> >> change the list of commits in the latter case.)
> >
> > You can get _exactly_ the same behavior if you use -m.
> 
> Or rather, -p. ;-)

No.  -p tries to preserve merges, and it will use 
git-rebase--interactive.sh for hysterical raisins.

I meant -m.

Ciao,
Dscho
