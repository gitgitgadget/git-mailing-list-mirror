From: Mike Hommey <mh@glandium.org>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 19:23:23 +0200
Organization: glandium.org
Message-ID: <20070817172323.GA14145@glandium.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site> <20070817170411.GF28529@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:24:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5Yz-0007tO-Gs
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbXHQRYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXHQRYn
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:24:43 -0400
Received: from vawad.err.no ([85.19.200.177]:42645 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbXHQRYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:24:38 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM5Yo-0008SV-VU; Fri, 17 Aug 2007 19:24:38 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM5Xf-0003gf-V4; Fri, 17 Aug 2007 19:23:24 +0200
Content-Disposition: inline
In-Reply-To: <20070817170411.GF28529@fieldses.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56073>

On Fri, Aug 17, 2007 at 01:04:11PM -0400, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Fri, Aug 17, 2007 at 05:52:52PM +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Fri, 17 Aug 2007, Mike Hommey wrote:
> > 
> > >   ?   committer name and email and the commit time.
> > >   If not provided, "git-commit-tree" uses your name, hostname and domain to
> > >   provide author and committer info. This can be overridden by either
> > >   .git/config file, or using the following environment variables.
> > >   (...)
> > > 
> > > The "If not provided" part doesn't make sense.
> > 
> > It does, if you know how to specify the committer info.
> >
> > Which the man page specifies how to provide:
> 
> At least on a first reading all of the following appears to fall under
> the "if not provided" case.  I know what you mean, but the language here
> is misleading.  One simple fix would be just to delete the words "If not
> provided", or maybe replace them by "By default, ...".

I think it would be better to put the fact that "If not provided..."
*after* telling that you can provide author, committer, etc. by setting
environment or editing the conf.

Mike
