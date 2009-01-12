From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Mon, 12 Jan 2009 20:09:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901122007070.3586@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <7vfxjpmhow.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0901120041260.19665@iabervon.org> <20090112154224.GD10179@spearce.org> <alpine.LNX.1.00.0901121246320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSAe-00054L-CD
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbZALTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbZALTIb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:08:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:41038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752620AbZALTIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:08:30 -0500
Received: (qmail invoked by alias); 12 Jan 2009 19:08:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 12 Jan 2009 20:08:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+seNAdCMes5FKFqRRJmhefm/Np3MGDMeAzDiOvog
	u2FSTjaGe0DEWB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0901121246320.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105373>

Hi,

On Mon, 12 Jan 2009, Daniel Barkalow wrote:

> Maybe fast-import should be able to run with a bi-directional connection 
> to its input, so it can acknowledge checkpoints?

Whoa.

fast-import was first and foremost a very simple way to get stuff done.  
Is it absolutely necessary to complicate that?

I mean, I don't know about git-svn, but shouldn't it be 
relatively easy to use fast-import to import from Subversion once the 
information is extracted from Subversion?

Ciao,
Dscho
