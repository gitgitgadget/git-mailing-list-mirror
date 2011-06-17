From: Jeff King <peff@peff.net>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 10:14:50 -0400
Message-ID: <20110617141450.GA12114@sigill.intra.peff.net>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Mc Donnell <michael@mcdonnell.dk>
X-From: git-owner@vger.kernel.org Fri Jun 17 16:15:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXZp8-0005YK-5k
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 16:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759053Ab1FQOO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 10:14:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34362
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758223Ab1FQOO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 10:14:56 -0400
Received: (qmail 25944 invoked by uid 107); 17 Jun 2011 14:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jun 2011 10:15:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2011 10:14:50 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175946>

On Fri, Jun 17, 2011 at 03:35:04PM +0200, Michael Mc Donnell wrote:

> I'm using git imap-send to send patches to wine-patches, and it seems
> like it converts all my patches to have CRLF line endings?

The canonical line ending for mail is CRLF. So yes, it will convert your
patch to CRLF for storage. But anything pulling it out of the IMAP
folder should convert it back to native line endings.

> I can see it when I download the patch from the Gmail drafts folder.
> Git complains about white space when I apply the downloaded patch. It
> works fine if I just use git to create the patch and then apply it on
> a new branch. Is it git imap-send or just Gmail that's the problem?

How do you download and apply the patch exactly? If you are speaking
imap to gmail, generally the client would strip out the CR's from the
mail.

-Peff
