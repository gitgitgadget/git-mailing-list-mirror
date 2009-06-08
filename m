From: Jeff King <peff@peff.net>
Subject: Re: deleting / adding files throughout the repository
Date: Mon, 8 Jun 2009 18:55:08 -0400
Message-ID: <20090608225508.GA21389@coredump.intra.peff.net>
References: <e4a904790906081025s76bdd1a0k73003e861da98371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDnkY-0001Fm-TC
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZFHWzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 18:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbZFHWzP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:55:15 -0400
Received: from peff.net ([208.65.91.99]:47725 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbZFHWzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:55:14 -0400
Received: (qmail 24597 invoked by uid 107); 8 Jun 2009 22:55:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 18:55:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 18:55:08 -0400
Content-Disposition: inline
In-Reply-To: <e4a904790906081025s76bdd1a0k73003e861da98371@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121125>

On Mon, Jun 08, 2009 at 06:25:00PM +0100, Alex K wrote:

> Suppose I made a mistake in my repository. There is a file that should
> never have been there. How do I delete this file from the entire
> repository history? How do I add a file throughout the entire
> repository history as if this later file had always been there?

Use "git filter-branch". The examples section of "git help
filter-branch" does the first part of what you're asking (and the second
part is fairly easy to extrapolate).

-Peff
