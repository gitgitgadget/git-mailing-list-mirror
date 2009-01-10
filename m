From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] submodule: allow tracking of the newest revision of
 a branch in a submodule
Date: Sat, 10 Jan 2009 15:23:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101522560.30769@pacific.mpi-cbg.de>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, j.sixt@viscovery.net, hjemli@gmail.com,
	gitster@pobox.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLelO-0007sj-DU
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZAJOXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZAJOXI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:23:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:59095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbZAJOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:23:05 -0500
Received: (qmail invoked by alias); 10 Jan 2009 14:23:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 10 Jan 2009 15:23:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rqEhuEjlrhEdttWKFMMP1rPRBx/0SCFMywtmuw1
	RuXplALdCxFH3J
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105113>

Hi,

On Sat, 10 Jan 2009, Fabian Franz wrote:

> Submodules currently only allow tracking a specific revision and each 
> update in a submodule leads to a new commit in the master repository. 
> However some users may want to always track the newest revision of a 
> specific (named) tag or branch or HEAD. For example the user might want 
> to track a staging branch in all submodules.

I wonder how you want to deal with "git bisect".  Or for that matter, with 
"git checkout HEAD^500".

Ciao,
Dscho
