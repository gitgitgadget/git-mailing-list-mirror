From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -p: Preserve fast-forwardable merges
Date: Mon, 25 Jan 2010 15:10:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001251508400.8733@intel-tinevez-2-302>
References: <dd10f5481001222329i58e7b709m2c547c74161b6771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Alex Scarborough <alex@gameclay.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 15:11:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZPeA-0006aK-ST
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 15:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab0AYOKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 09:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939Ab0AYOKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 09:10:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:47618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750853Ab0AYOKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 09:10:24 -0500
Received: (qmail invoked by alias); 25 Jan 2010 14:10:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 25 Jan 2010 15:10:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ysvJdBQVy6kdqCDOF41FC/2xMkCpXsMJEWCYNJa
	iQnN/sSktwaPNv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <dd10f5481001222329i58e7b709m2c547c74161b6771@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137965>

Hi,

On Fri, 22 Jan 2010, Alex Scarborough wrote:

> Previously, rebase -p would not preserve a merge commit if the merge
> could be resolved as a fast-forward.  rebase -p now passes --no-ff to
> git merge when recreating a merge commit, which ensures that merge
> commits created with git merge --no-ff are preserved.

For my use case (well, it used to be my use case), namely keeping a number 
of topic branches on top of an upstream up-to-date, this is not the 
desired action.  In my use case, merged topic branches should just vanish, 
and not even leave a merge commit.

> First patch, so here's hoping neither I nor my mail client messed up
> too much.

I think you did real fine, even providing a test case, which not many 
submitters do!

Ciao,
Dscho
