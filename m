From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Import git-forest (20080403)
Date: Thu, 3 Apr 2008 06:03:44 -0400
Message-ID: <20080403100344.GB6673@coredump.intra.peff.net>
References: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de> <9aca54e6e106be3f26ae289606b9a47a91806d54.1207169779.git.jengelh@computergmbh.de> <7vve3053n7.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0804030231180.26216@fbirervta.pbzchgretzou.qr> <7vej9n49jn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org,
	jnareb@gmail.com, kzak@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhMJ4-000645-MC
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 12:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbYDCKDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 06:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYDCKDr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 06:03:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1414 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbYDCKDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 06:03:47 -0400
Received: (qmail 8300 invoked by uid 111); 3 Apr 2008 10:03:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 06:03:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 06:03:44 -0400
Content-Disposition: inline
In-Reply-To: <7vej9n49jn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78741>

On Thu, Apr 03, 2008 at 01:39:08AM -0700, Junio C Hamano wrote:

> >>    Content-Type: TEXT/PLAIN; charset=ISO-8859-1
> >>
> >>> +#	git-??????
> >>
> >> Hmmmm...
> >
> > A git-send-email bug it seems.
> 
> Do we know if it has been fixed?  I see you used 1.5.4.4.

I think the problem is that the characters are in the _patch_. We do the
right thing for the commit message, SoB, and all headers, but we have
always just assumed the patch was OK, since we have no encoding
information on the files (and worse, if we have a _different_ encoding
for the commit message versus the diff content, we will have to
re-encode something or make it an attachment).

-Peff
