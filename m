From: Jeff King <peff@peff.net>
Subject: Re: Removing some files from history
Date: Fri, 17 Oct 2008 06:42:43 -0400
Message-ID: <20081017104243.GA15848@sigill.intra.peff.net>
References: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gennady Kushnir <genkush@rujel.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 12:44:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqmoJ-0005y3-RC
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 12:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYJQKms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 06:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYJQKms
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 06:42:48 -0400
Received: from peff.net ([208.65.91.99]:2922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYJQKmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 06:42:47 -0400
Received: (qmail 20540 invoked by uid 111); 17 Oct 2008 10:42:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 17 Oct 2008 06:42:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Oct 2008 06:42:43 -0400
Content-Disposition: inline
In-Reply-To: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98471>

On Fri, Oct 17, 2008 at 02:38:54PM +0400, Gennady Kushnir wrote:

> I'm going to make my repository public, but I have found that one of
> my files contains some private data that I would not like to share.
> Is it possible to remove that file from all commits in my local
> repository history before publishing it?

Yes, see "git help filter-branch". The first example given does exactly
what you are asking for.

-Peff
