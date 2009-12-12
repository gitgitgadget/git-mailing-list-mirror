From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] commit/status: "git add <path>" is not necessarily
 how to resolve
Date: Sat, 12 Dec 2009 04:15:56 -0500
Message-ID: <20091212091556.GA30509@coredump.intra.peff.net>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com>
 <1260608523-15579-2-git-send-email-gitster@pobox.com>
 <1260608523-15579-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 10:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJO5S-00070r-AK
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbZLLJPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758094AbZLLJPz
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:15:55 -0500
Received: from peff.net ([208.65.91.99]:36751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758089AbZLLJPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:15:53 -0500
Received: (qmail 1243 invoked by uid 107); 12 Dec 2009 09:20:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Dec 2009 04:20:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Dec 2009 04:15:56 -0500
Content-Disposition: inline
In-Reply-To: <1260608523-15579-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135130>

On Sat, Dec 12, 2009 at 01:02:02AM -0800, Junio C Hamano wrote:

> When the desired resolution is to remove the path, "git rm <path>" is the
> command the user needs to use.  Just like in "Changed but not updated"
> section, suggest to use "git add/rm" as appropriate.

I no longer even see these messages due to advice.statushints, but the
overall direction of the series looks sane to me.

However:

> -	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to mark resolution)");
> +	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appropriately to mark resolution)");

This should be "as appropriate".

-Peff
