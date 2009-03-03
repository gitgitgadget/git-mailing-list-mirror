From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: git write-tree failed to write a tree
Date: Tue, 3 Mar 2009 11:05:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031103580.6399@intel-tinevez-2-302>
References: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>  <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de> <81bfc67a0903022147m42e8fe38gb93773084614d30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:07:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRWe-0002ay-9B
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 11:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbZCCKFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 05:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZCCKFQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 05:05:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:49303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbZCCKFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 05:05:14 -0500
Received: (qmail invoked by alias); 03 Mar 2009 10:05:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 03 Mar 2009 11:05:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ug1Ej4qPus79k2MZFRGPvL3PpLVmmzsdDInXH1N
	Aaf0ZzZr9/hO20
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81bfc67a0903022147m42e8fe38gb93773084614d30@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112046>

Hi,

On Tue, 3 Mar 2009, Caleb Cushing wrote:

> On Sun, Mar 1, 2009 at 4:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > A tree cannot contain unmerged files.
> 
> 
> so... still looking for a solution since it seems I can no longer do a
> merge from this remote. There has to be a way to get the tree back
> into a proper state...

You have a tree with unmerged entries.  Why don't you look into the issue 
and solve it?  A simple "git status" should show you what are the unmerged 
entries.  A simple look at those files should show you conflict markers.

Resolve the issue, commit, continue.

Ciao,
Dscho
