From: Mike Hommey <mh@glandium.org>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git
	HEAD" doesn't work
Date: Sat, 14 Jun 2008 11:28:18 +0200
Organization: glandium.org
Message-ID: <20080614092818.GA2401@glandium.org>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <loom.20080614T074854-525@post.gmane.org> <20080614090244.GA1262@glandium.org> <20080614091900.GA22538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven <svoop@delirium.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7S5P-0000q4-Qr
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbYFNJ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbYFNJ3W
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:29:22 -0400
Received: from vuizook.err.no ([194.24.252.247]:50635 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbYFNJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:29:21 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K7S4O-0001X9-GX; Sat, 14 Jun 2008 11:29:18 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K7S3W-0000eZ-2x; Sat, 14 Jun 2008 11:28:18 +0200
Content-Disposition: inline
In-Reply-To: <20080614091900.GA22538@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84998>

On Sat, Jun 14, 2008 at 05:19:00AM -0400, Jeff King wrote:
> On Sat, Jun 14, 2008 at 11:02:44AM +0200, Mike Hommey wrote:
> 
> > > How likely is it that ls-remote HEAD is added for HTTP as well rather than
> > > stripped for all protocols?
> > 
> > When someone sends a patch ;)
> 
> I'm not sure I can bring myself to wait for that. After all, it could
> take nearly negative seven weeks:
> 
>   $ git log -1 --pretty=tformat:'%s (%ar)' be885d96
>   Make ls-remote http://... list HEAD, like for git://... (7 weeks ago)

Erf, now I must blame myself to have taken a look at a very old
transport.c file ;)

Mike
