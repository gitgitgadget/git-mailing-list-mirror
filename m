From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] checkout,clone: check return value of create_symref
Date: Tue, 12 Jan 2016 04:49:58 -0500
Message-ID: <20160112094957.GA9855@sigill.intra.peff.net>
References: <20160111154651.GA25338@sigill.intra.peff.net>
 <20160111154935.GA22778@sigill.intra.peff.net>
 <56947C63.8000507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:50:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvad-0002cx-6c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934682AbcALJuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:50:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:51982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934605AbcALJuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:50:01 -0500
Received: (qmail 20877 invoked by uid 102); 12 Jan 2016 09:50:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:50:01 -0500
Received: (qmail 11450 invoked by uid 107); 12 Jan 2016 09:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:50:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 04:49:58 -0500
Content-Disposition: inline
In-Reply-To: <56947C63.8000507@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283780>

On Tue, Jan 12, 2016 at 05:09:07AM +0100, Michael Haggerty wrote:

> > This patch could go to maint. I don't know if it's worth the trouble. I
> > was unable to figure out a way to trigger this reliably (hence no
> > tests). The two ways I considered were:
> > 
> >   - "chmod -w .git", but it results in a die() already
> > 
> >   - the bug I'm fixing in 2/2; but we don't want to rely on that in our
> >     test suite, since I'm about to fix it. :-/
> 
> A locking conflict is an easy way to trigger this error:
> [...]

Thanks, that's a good suggestion; I'll add a test in the re-roll.

-Peff
