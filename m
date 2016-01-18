From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] ls-remote: use parse-options api
Date: Mon, 18 Jan 2016 14:33:38 -0500
Message-ID: <20160118193338.GC1009@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:33:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFYf-0003Xi-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469AbcARTdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:33:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:55588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756248AbcARTdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:33:41 -0500
Received: (qmail 30033 invoked by uid 102); 18 Jan 2016 19:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:33:41 -0500
Received: (qmail 13046 invoked by uid 107); 18 Jan 2016 19:34:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:34:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:33:38 -0500
Content-Disposition: inline
In-Reply-To: <1453136238-19448-5-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284307>

On Mon, Jan 18, 2016 at 05:57:17PM +0100, Thomas Gummerer wrote:

> Currently ls-remote uses a hand rolled parser for the its command line

s/the its/its/

> arguments.  Use the parse-options api instead of the hand rolled parser
> to simplify the code and make it easier to add new arguments.  In
> addition this improves the help message.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/ls-remote.c | 82 +++++++++++++++++++----------------------------------
>  1 file changed, 29 insertions(+), 53 deletions(-)

Patch itself looks good to me.

-Peff
