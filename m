From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 18:35:36 -0500
Message-ID: <20151124233536.GB13872@sigill.intra.peff.net>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <554d29f019f52d18cf1d6c5835df0a3a098a1df4.1448407832.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1N7f-0004rI-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbbKXXfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 18:35:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:33562 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932485AbbKXXfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:35:39 -0500
Received: (qmail 30525 invoked by uid 102); 24 Nov 2015 23:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:35:38 -0600
Received: (qmail 20032 invoked by uid 107); 24 Nov 2015 23:35:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 18:35:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 18:35:36 -0500
Content-Disposition: inline
In-Reply-To: <554d29f019f52d18cf1d6c5835df0a3a098a1df4.1448407832.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281651>

On Tue, Nov 24, 2015 at 11:31:40PM +0000, John Keeping wrote:

> If the CA path isn't found it's most likely to indicate a
> misconfiguration, in which case accepting any certificate is unlikely to
> be the correct thing to do.

Thanks.

> Changes since v1:
> - add missing path to error message
> - remove trailing '.' on error message since die appends "at
>   /path/to/git-send-email line ..."

It won't if the error message ends with a newline. We seem to be wildly
inconsistent about that in send-email, though.

-Peff
