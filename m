From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/5] Add git-credential support to git-send-email
Date: Mon, 11 Feb 2013 11:51:36 -0500
Message-ID: <20130211165136.GC16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:52:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wbr-0006Cc-B4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab3BKQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:51:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44336 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887Ab3BKQvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:51:39 -0500
Received: (qmail 23745 invoked by uid 107); 11 Feb 2013 16:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 11:53:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 11:51:36 -0500
Content-Disposition: inline
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216051>

On Mon, Feb 11, 2013 at 05:23:34PM +0100, Michal Nazarewicz wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> The third version of the patch with changes suggested by Jeff in the
> 4/5 patch.  Also credential_read and credential_write are now public
> functions in case someone wants to write a helper in perl.

Thanks, the changes you made look good. And I think it's a good idea to
make the read/write functions public.

I have two minor comments, which I'll reply inline with. But even with
those comments, I think this would be OK to merge.

-Peff
