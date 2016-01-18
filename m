From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] ls-remote: document --refs option
Date: Mon, 18 Jan 2016 14:31:40 -0500
Message-ID: <20160118193140.GB1009@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:31:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFWn-0002lr-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbcARTbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:31:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:55578 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756403AbcARTbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:31:43 -0500
Received: (qmail 29885 invoked by uid 102); 18 Jan 2016 19:31:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:31:43 -0500
Received: (qmail 13017 invoked by uid 107); 18 Jan 2016 19:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:32:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:31:40 -0500
Content-Disposition: inline
In-Reply-To: <1453136238-19448-3-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284306>

On Mon, Jan 18, 2016 at 05:57:15PM +0100, Thomas Gummerer wrote:

> +--refs::
> +	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
> +	in the output.
> +

Minor nit: we show whatever the other side sends us, which is the refs,
HEAD, and peeled tags. So mentioning MERGE_HEAD isn't wrong (if the
server _did_ send it to us, we would omit it), but it is a bit
misleading.

I think saying "pseudo-refs like HEAD" is OK; even though we know it is
only HEAD in the current server implementation, it better describes what
the client side is doing.

-Peff
