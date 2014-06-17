From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: State coding guideline for error message punctuation
Date: Tue, 17 Jun 2014 05:37:59 -0400
Message-ID: <20140617093759.GA6267@sigill.intra.peff.net>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
 <1402923357-3788-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:38:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwpqA-0007DE-5j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbaFQJiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 05:38:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:45917 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753304AbaFQJiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 05:38:00 -0400
Received: (qmail 23131 invoked by uid 102); 17 Jun 2014 09:38:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 04:38:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 05:37:59 -0400
Content-Disposition: inline
In-Reply-To: <1402923357-3788-2-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251857>

On Mon, Jun 16, 2014 at 01:55:57PM +0100, Philip Oakley wrote:

> +Error Messages
> +
> + - We typically do not end error messages with a full stop. While
> +   we've been rather inconsistent in the past, these days we mostly
> +   settle on no punctuation.

Unlike Junio, I do not mind spelling out guidance for error messages.
However, I do not think the second sentence is adding anything here
(everything in CodingGuidelines is subject to "we did not always do it
this way, but this is the preferred way now"). So I'd drop it.

And then add in more guidance. Besides "no full stop", probably:

  1. do not capitalize ("unable to open %s", not "Unable to open %s"

  2. maybe something on sentence structure / ordering? We tend to prefer
     "cannot open 'foo': No such file or directory" to "foo: cannot
     open: No such file or directory".

Perhaps there are others (we do not have to be exhaustive, but it makes
sense to think for a moment while we are here).

-Peff
