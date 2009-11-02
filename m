From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Mon, 2 Nov 2009 18:34:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911021832530.2479@felix-maschine>
References: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50na-0003i7-IM
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 18:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbZKBReW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbZKBReW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 12:34:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755724AbZKBReW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 12:34:22 -0500
Received: (qmail invoked by alias); 02 Nov 2009 17:34:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 02 Nov 2009 18:34:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uIUNJYIDuffekLYoo5jogn/VEd57VIeTwf0GMWW
	bU4QneYzes2kPQ
X-X-Sender: johannes@felix-maschine
In-Reply-To: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131929>

Hi,

On Mon, 2 Nov 2009, Constantine Plotnikov wrote:

> I have encountered what looks like critical bugs in the git rebase -i
> -p (it can be reproduced on mingw and cygwin, I have not tried other
> platforms).

rebase -i -p was never intended to reorder commits.  In fact, the "-i" of 
it was only for convenience: I was more familiar with the code base of 
rebase -i than that of rebase.

Having said that, I worked for some time on fixing this issue, and I 
actually run a version of rebase -i -p here that allows reordering 
commits, but it is far from stable (and due to GSoC and day-job 
obligations, I had no time to work on it in months).

Ciao,
Dscho
