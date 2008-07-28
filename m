From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 01:54:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290153300.2725@eeepc-johanness>
References: <cover.1217288180.git.vmiklos@frugalware.org> <f3af7df2dda2dcb7801314cc993470264259f970.1217288180.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcXc-0007sh-O2
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYG1XxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbYG1XxL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:53:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:60952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751408AbYG1XxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:53:10 -0400
Received: (qmail invoked by alias); 28 Jul 2008 23:53:08 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp043) with SMTP; 29 Jul 2008 01:53:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196OU8vE5B6XZFux/b+r2QVmvL0tK3ifdFfeEEMnq
	McvoFmv1Kfczoj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <f3af7df2dda2dcb7801314cc993470264259f970.1217288180.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90526>

Hi,

On Tue, 29 Jul 2008, Miklos Vajna wrote:

> Testing is done by creating a simple git-merge-theirs strategy which
> just picks the upstream tree. (In other words, this is not the opposite
> of -s ours.)

Actually, this _is_ the opposite of -s ours, no?  -s ours just takes our 
tree, your -s theirs just takes their tree.

Sorry for the confusion I caused,
Dscho
