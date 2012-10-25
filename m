From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Doc repository-layout: Show refs/replace
Date: Thu, 25 Oct 2012 06:34:14 -0400
Message-ID: <20121025103413.GQ8390@sigill.intra.peff.net>
References: <1350852757-3924-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKlj-0000ho-9c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2JYKeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:34:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757265Ab2JYKeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:34:18 -0400
Received: (qmail 7859 invoked by uid 107); 25 Oct 2012 10:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 06:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 06:34:14 -0400
Content-Disposition: inline
In-Reply-To: <1350852757-3924-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208385>

On Sun, Oct 21, 2012 at 09:52:37PM +0100, Philip Oakley wrote:

> Signed-off-by: Philip Oakley <philipoakley@iee.org>

Thanks, this makes sense.

> +refs/replace/`<obj-sha1>`::
> +	records the SHA1 of the object that replaces `<obj-sha1>`.
> +	This is similar to info/grafts and is internally used and
> +	maintained by `git replace`. Such refs can be exchanged between
> +	repositories while grafts are not.

This should probably be an actual link to the git-replace manpage. I'll
convert it to a linkgit. No need to resend.

-Peff
