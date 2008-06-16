From: Mike Hommey <mh@glandium.org>
Subject: Re: Mercurial to git converter.
Date: Mon, 16 Jun 2008 10:26:33 +0200
Organization: glandium.org
Message-ID: <20080616082633.GA10752@glandium.org>
References: <1168537766.22649.19.camel@localhost.localdomain> <loom.20080614T101342-542@post.gmane.org> <alpine.DEB.1.00.0806141648020.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 16 10:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8A4r-0008Pi-Gj
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 10:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYFPI1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 04:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbYFPI1n
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 04:27:43 -0400
Received: from vuizook.err.no ([194.24.252.247]:55322 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbYFPI1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 04:27:42 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K8A3o-0004O0-Ll; Mon, 16 Jun 2008 10:27:39 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K8A2r-0002sl-CL; Mon, 16 Jun 2008 10:26:33 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806141648020.6439@racer>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85167>

On Sat, Jun 14, 2008 at 04:53:04PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 14 Jun 2008, Nick Andrew wrote:
> 
> > Stelian Pop <stelian <at> popies.net> writes:
> > 
> > > I switched recently from Mercurial to git for some of my projects, and
> > > needed a conversion tool with branch support (unlike tailor). I didn't
> > > find any, so I ended up writing my own one. 
> > > 
> > > hg-to-git.py can probably be greatly improved (it's a rather crude 
> > > combination of shell and python) but it does already work quite well 
> > > for me. [...]
> > 
> > Thanks for that. One small problem is that it does not get the changelog 
> > right if a commit is made on a local branch. It thinks the "branch:" 
> > line is part of the changelog.
> 
> FWIW I switched my local mercurial2git conversion to the hg-fast-export 
> solution from 
> 
> 	git://repo.or.cz/fast-export.git

Would you happen to have a clonable mirror or this ? repo.or.cz doesn't
respond.

Mike
