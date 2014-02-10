From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sun, 9 Feb 2014 20:19:02 -0500
Message-ID: <20140210011859.GB12773@sigill.intra.peff.net>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
 <20140208164548.GA24600@sigill.intra.peff.net>
 <CACsJy8C_Lc+mcJxGc7S5AB47YKDrhmWPwZp2oxJ9Z1tONVT0kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 02:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfWi-00068Q-4s
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbaBJBTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:19:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:47705 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbaBJBTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 20:19:05 -0500
Received: (qmail 26287 invoked by uid 102); 10 Feb 2014 01:19:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (107.224.177.31)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Feb 2014 19:19:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Feb 2014 20:19:02 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C_Lc+mcJxGc7S5AB47YKDrhmWPwZp2oxJ9Z1tONVT0kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241897>

On Sun, Feb 09, 2014 at 06:48:18AM +0700, Duy Nguyen wrote:

> > I guess by quoting you meant:
> >
> >   echo '"trailing  "' >.gitignore
> 
> This makes " special. If we follow shell convention then things
> between ".." should be literal (e.g. "*" is no longer a wildcard). We
> don't support it yet. So I rather go with backslash as it adds less
> code.

For some reason I was thinking that we already handled double-quotes
here (as we do in other places where quoting is optional). But it looks
like we don't currently, so yeah, I don't think it is worth adding due
to the potential confusion.

Backslash-escaping was what I had originally assumed you meant, and it
was, so we are all on the same page (the patch was just broken. ;) ).

-Peff
