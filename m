From: Jeff King <peff@peff.net>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 14:55:39 -0400
Message-ID: <20101015185539.GA30380@sigill.intra.peff.net>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org>
 <i9a6kn$d7o$1@dough.gmane.org>
 <20101015184302.GA22990@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 20:55:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pR2-0005rR-2S
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 20:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647Ab0JOSzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 14:55:13 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51955 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab0JOSzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 14:55:12 -0400
Received: (qmail 19099 invoked by uid 111); 15 Oct 2010 18:55:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 15 Oct 2010 18:55:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Oct 2010 14:55:39 -0400
Content-Disposition: inline
In-Reply-To: <20101015184302.GA22990@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159130>

On Fri, Oct 15, 2010 at 01:43:02PM -0500, Jonathan Nieder wrote:

> Neal Kreitzinger wrote:
> 
> > However, there is an option in git-commit to copy files directly from the 
> > working-tree to the object-store by totally bypassing the index
> 
> What option is this?  I thought "git commit --include" added content
> to the index.

git commit -o|--only, which is the same as "git commit <paths>". Of
course it still uses an index, to create the tree, but it uses a
temporary one based on HEAD instead of the current index contents.

-Peff
