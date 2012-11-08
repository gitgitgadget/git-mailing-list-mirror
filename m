From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: make remote_heads config setting work.
Date: Thu, 8 Nov 2012 11:56:48 -0500
Message-ID: <20121108165648.GG15560@sigill.intra.peff.net>
References: <20121105235047.GA78156@redoubt.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Phil Pennock <phil@apcera.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:57:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWVPe-0005Ed-1k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab2KHQ4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 11:56:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36453 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756201Ab2KHQ4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:56:52 -0500
Received: (qmail 30748 invoked by uid 107); 8 Nov 2012 16:57:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 11:57:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 11:56:48 -0500
Content-Disposition: inline
In-Reply-To: <20121105235047.GA78156@redoubt.spodhuis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209174>

On Mon, Nov 05, 2012 at 06:50:47PM -0500, Phil Pennock wrote:

> Git configuration items can not contain underscores in their name; the
> 'remote_heads' feature can not be enabled on a per-repository basis with
> that name.
> 
> This changes the git-config option to be `gitweb.remoteheads` but does
> not change the gitweb.conf option, to avoid backwards compatibility
> issues.  We strip underscores from keys before looking through
> git-config output for them.

Makes sense. Thanks for considering the backwards compatibility angle.
Hopefully we can avoid adding names with underscores in the future, but I
think the mapping of "remote_head -> remotehead" is obvious enough that
we do not need to worry about deprecating and replacing the old name.

-Peff
