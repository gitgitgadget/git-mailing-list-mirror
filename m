From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 01:21:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901230119490.3586@pacific.mpi-cbg.de>
References: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9oj-0005uX-UG
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbZAWAVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZAWAVN
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:21:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:37540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421AbZAWAVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:21:13 -0500
Received: (qmail invoked by alias); 23 Jan 2009 00:21:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 23 Jan 2009 01:21:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Zqv86AhGZkvDcwYYVAMt+UNBln7u265/uqryP86
	NTFF/Xh/bmn0w+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106807>

Hi,

On Thu, 22 Jan 2009, Christian MICHON wrote:

> I've a big set of patches in a mbox file: there's sufficient info inside 
> for git-am to work.
> 
> Yet, each time I do import these, my sha1sums are changing because of 
> different commit dates.
> 
> I'd like to force the commit date to match the info/date from the time I 
> received the email (and therefore always get back the right sha1sums).
> 
> is this possible ?

Have you tried setting GIT_COMMITTER_DATE to the given date?

Alternatively, you can always use a commit-message filter with 
filter-branch to fix it up.

Ciao,
Dscho
