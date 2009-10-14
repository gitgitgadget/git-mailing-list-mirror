From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 14:40:18 -0400
Message-ID: <20091014184018.GB15522@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <20091014050851.GE31810@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910141233060.4985@pacific.mpi-cbg.de>
 <20091014153934.GA3680@coredump.intra.peff.net>
 <7vljjdese3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8mv-0005gB-L5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814AbZJNSkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757511AbZJNSky
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:40:54 -0400
Received: from peff.net ([208.65.91.99]:42112 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757431AbZJNSky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:40:54 -0400
Received: (qmail 31108 invoked by uid 107); 14 Oct 2009 18:43:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 14:43:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 14:40:18 -0400
Content-Disposition: inline
In-Reply-To: <7vljjdese3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130320>

On Wed, Oct 14, 2009 at 11:34:44AM -0700, Junio C Hamano wrote:

> >> AFAIR we still remember HEAD to be a symlink.
> >
> > I think that has been abandoned for detached HEAD (that is, if you
> > support only symlinked HEAD, then you cannot detach at all). But I might
> > be wrong. It has been a while since I looked at that code.
> 
> If I understand what Daniel is doing correctly, the idea is to keep this
> extra information only while the HEAD is detached, no?  "HEAD itself
> could be a symlink" is an irrelevant issue, isn't it?

Right. That is what I was trying to say, but somehow it didn't come out
very clearly.

-Peff
