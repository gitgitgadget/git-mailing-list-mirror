From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git remote update: Report error for non-existing
	groups
Date: Wed, 8 Apr 2009 13:08:45 -0400
Message-ID: <20090408170844.GB28069@coredump.intra.peff.net>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org> <1239025262-16960-2-git-send-email-finnag@pvv.org> <7vprfnubyi.fsf@gitster.siamese.dyndns.org> <20090408080738.GA24386@pvv.org> <7vy6ubo8tn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 19:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrbIj-0003WD-KQ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 19:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934929AbZDHRIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934926AbZDHRIv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 13:08:51 -0400
Received: from peff.net ([208.65.91.99]:38472 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934916AbZDHRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 13:08:49 -0400
Received: (qmail 31412 invoked by uid 107); 8 Apr 2009 17:08:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 08 Apr 2009 13:08:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Apr 2009 13:08:45 -0400
Content-Disposition: inline
In-Reply-To: <7vy6ubo8tn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116097>

On Wed, Apr 08, 2009 at 01:20:36AM -0700, Junio C Hamano wrote:

> I don't know what users want to see when they say "default" explicitly
> without having an explicit configuration.  Should it do the same thing as
> "git remote update"?

I'm not sure we have a choice anymore; is it worth breaking
compatibility to "fix" something that doesn't actually seem to be
harming anyone?

-Peff
