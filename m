From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] send-pack: check ref->status before updating tracking
 refs
Date: Sat, 17 Nov 2007 13:05:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711171251030.12193@iabervon.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
 <20071117125515.GB23186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItS3D-0006lw-35
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758348AbXKQSFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbXKQSFe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 13:05:34 -0500
Received: from iabervon.org ([66.92.72.58]:54705 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757606AbXKQSFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 13:05:34 -0500
Received: (qmail 19332 invoked by uid 1000); 17 Nov 2007 18:05:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Nov 2007 18:05:32 -0000
In-Reply-To: <20071117125515.GB23186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65290>

On Sat, 17 Nov 2007, Jeff King wrote:

> Previously, we manually checked the 'NONE' and 'UPTODATE'
> conditions. Now that we have ref->status, we can easily
> say "only update if we pushed successfully".
> 
> This adds a test for and fixes a regression introduced in
> ed31df31 where deleted refs did not have their tracking
> branches removed. This was due to a bogus per-ref error test
> that is superseded by the more accurate ref->status flag.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
