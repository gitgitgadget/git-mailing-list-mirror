From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Removed redundant static functions such as
	update_tracking_ref() and verify_remote_names() from
	builtin-send-pack.c, and made the ones in transport.c not be static
	so they can be used instead.
Date: Wed, 29 Apr 2009 00:09:46 -0400
Message-ID: <20090429040946.GC14912@coredump.intra.peff.net>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com> <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de> <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com> <49F5C377.9010200@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andy Lester <andy@petdance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 06:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz17M-0002uF-Ol
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 06:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZD2EJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 00:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbZD2EJt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 00:09:49 -0400
Received: from peff.net ([208.65.91.99]:59463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbZD2EJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 00:09:48 -0400
Received: (qmail 2615 invoked by uid 107); 29 Apr 2009 04:10:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 00:10:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 00:09:46 -0400
Content-Disposition: inline
In-Reply-To: <49F5C377.9010200@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117846>

On Tue, Apr 28, 2009 at 02:38:47AM +1200, Sam Vilain wrote:

> Subject: [PATCH] SubmittingPatches: itemize and reflect upon well written changes
> 
> The SubmittingPatches file was trimmed down from a somewhat
> overwhelming set of requirements from the Linux Kernel equivalent;
> however perhaps a little of it can be returned without making the
> text too long.

This is an improvement, IMHO (and much less verbose than what I wrote to
Andy earlier).

-Peff
