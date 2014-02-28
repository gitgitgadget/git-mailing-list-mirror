From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] branch: use skip_prefix
Date: Fri, 28 Feb 2014 00:46:14 -0500
Message-ID: <20140228054613.GB32556@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <1393556659-32717-2-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 06:46:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJGH6-00041P-1x
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 06:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbaB1FqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 00:46:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:58470 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbaB1FqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 00:46:16 -0500
Received: (qmail 7368 invoked by uid 102); 28 Feb 2014 05:46:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 23:46:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 00:46:14 -0500
Content-Disposition: inline
In-Reply-To: <1393556659-32717-2-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242887>

On Fri, Feb 28, 2014 at 12:04:19PM +0900, Brian Gesiak wrote:

> From: modocache <modocache@gmail.com>

Both your emailed patches have this, which is due to your author name
not matching your sending identity. You probably want to set user.name,
or if you already have (which it looks like you might have from your
Signed-off-by), use "git commit --amend --reset-author" to update the
author information.

> The install_branch_config function reimplemented the skip_prefix
> function inline. Use skip_prefix function instead for brevity.
> 
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>

It's a minor thing, but usually these footer lines try to follow a
chronological order. So the report would come before the signoff (and a
further signoff from the maintainer would go after yours).

> diff --git a/branch.c b/branch.c
> index 723a36b..e163f3c 100644
> --- a/branch.c
> +++ b/branch.c
> [...]

The patch itself looks OK to me.

-Peff
