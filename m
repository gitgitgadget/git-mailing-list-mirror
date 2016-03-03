From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: add a helper function to derive .idx/.keep
 filename
Date: Thu, 3 Mar 2016 17:29:03 -0500
Message-ID: <20160303222902.GB26712@sigill.intra.peff.net>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
 <xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:34:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbp8-0007TM-46
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758629AbcCCWeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 17:34:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:54461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758451AbcCCW3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:29:11 -0500
Received: (qmail 20754 invoked by uid 102); 3 Mar 2016 22:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 17:29:05 -0500
Received: (qmail 10504 invoked by uid 107); 3 Mar 2016 22:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 17:29:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 17:29:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288220>

On Thu, Mar 03, 2016 at 01:37:18PM -0800, Junio C Hamano wrote:

> These are automatically named by replacing .pack suffix in the
> name of the packfile.  Add a small helper to do so, as I'll be
> adding another one soonish.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/index-pack.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)

Even without the upcoming "another one", this is a nice readability
improvement.

-Peff
