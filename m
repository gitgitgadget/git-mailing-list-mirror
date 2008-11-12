From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
	packs with a .keep file
Date: Wed, 12 Nov 2008 03:09:09 -0500
Message-ID: <20081112080909.GA29176@coredump.intra.peff.net>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ao0-0004nr-PD
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbYKLIJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYKLIJN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:09:13 -0500
Received: from peff.net ([208.65.91.99]:3749 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbYKLIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:09:12 -0500
Received: (qmail 17520 invoked by uid 111); 12 Nov 2008 08:09:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:09:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:09:09 -0500
Content-Disposition: inline
In-Reply-To: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100718>

On Mon, Nov 03, 2008 at 02:37:05PM -0600, Brandon Casey wrote:

> This version replaces the use of 'head -n -1' with a grep, and should work on
> all platforms.

Hmm. I'm not sure what happened, but the version in 'next' has "head -n
-1" in it.

-Peff
