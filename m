From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 1.6.0.2 make test fails at t1301 under mac os x 10.4.
Date: Tue, 21 Oct 2008 23:24:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810212315530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <p06240800c523ac94cb4d@[192.168.47.9]>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Fergus McMenemie <fergus@twig.me.uk>
X-From: git-owner@vger.kernel.org Tue Oct 21 23:19:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsOd3-00042j-Ic
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 23:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYJUVRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYJUVRp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 17:17:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:46167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752678AbYJUVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 17:17:44 -0400
Received: (qmail invoked by alias); 21 Oct 2008 21:17:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 21 Oct 2008 23:17:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GDXpizfsGpVSez1TOeqk/eQai1+bkDKhn3ICmzi
	6dMjJjoa9K5eK5
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <p06240800c523ac94cb4d@[192.168.47.9]>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98819>

Hi,

On Tue, 21 Oct 2008, Fergus McMenemie wrote:

> >++ mkdir sub
> >++ cd sub
> >++ umask 002
> >++ git init --shared=1
> >fatal: Could not make /usr/local/packages/git-1.6.0.2/t/trash
> >directory/sub/.git/refs writable by group

I guess this is the problem.

Could you inspect what owner/group that directory has?

Ciao,
Dscho
