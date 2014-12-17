From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 09:32:13 -0500
Message-ID: <20141217143212.GA23085@peff.net>
References: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1FeH-0006GL-81
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 15:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaLQOcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 09:32:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:53787 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750953AbaLQOcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 09:32:15 -0500
Received: (qmail 14203 invoked by uid 102); 17 Dec 2014 14:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 08:32:14 -0600
Received: (qmail 31230 invoked by uid 107); 17 Dec 2014 14:32:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Dec 2014 09:32:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2014 09:32:13 -0500
Content-Disposition: inline
In-Reply-To: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261486>

On Wed, Dec 17, 2014 at 03:18:56PM +0100, Peter Wu wrote:

> This is the fourth revision of the patch that allows for just setting the fetch
> URL. Eric wondered why '--fetch --push' is not used to describe the state
> '--both', so I added this to the commit message.

Thanks, I think that explanation is very clear.

This version overall looks good to me.

> The t5505-remote.sh test still passes after this change (I was unable to run the
> full test suite as it broke due to an unrelated gpg issue).

It is it because you have gpg 2.1, and the patches to handle that are
not yet merged to master? Or is it because you are using the new patches
and they are breaking things for your older gpg version?

If the former, that's fine. If the latter, it would be nice to see a
report of the breakage. :)

-Peff
