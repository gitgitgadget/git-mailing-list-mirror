From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 17:40:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>  <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>  <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>  <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
  <492D6CC3.2050408@drmicha.warpmail.net> <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 17:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5NL8-0007yY-9K
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYKZQcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYKZQcy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:32:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:58673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752239AbYKZQcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 11:32:53 -0500
Received: (qmail invoked by alias); 26 Nov 2008 16:32:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 26 Nov 2008 17:32:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QLKUg7gHQ9DM7FWvx3o2X5WOtYXduVCo2F7nKvb
	IuAEtFTG98J5WE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101744>

Hi,

On Wed, 26 Nov 2008, Ondrej Certik wrote:

> I am also trying to make the example simpler. I tried to squash the 
> first uninteresting ~1500 commits into one, but "git rebase -i" uterrly 
> fails after squashing about 600 commits. Still investigating.

1500... wow.

The best idea would probably be to just "edit" the first, delete the rest 
of the 1500, and then 'git read-tree -u -m <last-of-the-1500-commits>"' on 
the command line (when git rebase stops after the "edit" command).

rebase -i was _never_ meant for such _massive_ interactions; that's just 
too much for a shell script.

Ciao,
Dscho
