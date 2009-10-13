From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 09/16] Move WebDAV HTTP push under remote-curl
Date: Tue, 13 Oct 2009 20:04:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910132003520.4985@pacific.mpi-cbg.de>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-10-git-send-email-spearce@spearce.org> <20091013044141.GA18961@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:07:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxlla-0004TI-1H
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760451AbZJMSCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZJMSCt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:02:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:38611 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753802AbZJMSCs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:02:48 -0400
Received: (qmail invoked by alias); 13 Oct 2009 18:02:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 13 Oct 2009 20:02:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Xq0RNV/MX1wwphh7nHFpRrHhthBIbfAgS24/xcI
	w0XhjADPz0y5Ml
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091013044141.GA18961@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130172>

Hi,

On Tue, 13 Oct 2009, Mike Hommey wrote:

> On Mon, Oct 12, 2009 at 07:25:08PM -0700, Shawn O. Pearce wrote:
> > The remote helper interface now supports the push capability, which 
> > can be used to ask the implementation to push one or more specs to the 
> > remote repository.  For remote-curl we implement this by calling the 
> > existing WebDAV based git-http-push executable.
> > 
> > Internally the helper interface uses the push_refs transport hook so 
> > that the complexity of the refspec parsing and matching can be reused 
> > between remote implementations.  When possible however the helper 
> > protocol uses source ref name rather than the source SHA-1, thereby 
> > allowing the helper to access this name if it is useful.
> 
> It's been a while I haven't followed changes in the remote code but this 
> looks nice, though I haven't checked thoroughly. I guess the next step 
> would be to kill http-push as an external program.

Ilari made signs on IRC that he got something working.  After, ahem, 
saying a few things about the design of the remote helpers.

Ciao,
Dscho
