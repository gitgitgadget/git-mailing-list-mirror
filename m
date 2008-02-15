From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Fri, 15 Feb 2008 12:20:44 -0500
Message-ID: <20080215172043.GA24221@sigill.intra.peff.net>
References: <20080214103256.GA17951@coredump.intra.peff.net> <7vabm2i1pf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ4FW-0003Xl-15
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbYBORUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYBORUs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:20:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1890 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbYBORUr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:20:47 -0500
Received: (qmail 23651 invoked by uid 111); 15 Feb 2008 17:20:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 15 Feb 2008 12:20:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Feb 2008 12:20:44 -0500
Content-Disposition: inline
In-Reply-To: <7vabm2i1pf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73963>

On Fri, Feb 15, 2008 at 09:11:56AM -0800, Junio C Hamano wrote:

> > We also hard-code the special ref '{}' as an alias for the
> > empty tree. Users may refer to the empty tree by its
> > sha1 or by '{}'.
> 
> I think the users of hard coded empty tree are oddballs.  Let's
> not be too cute and instead leave it in the add -i patch.  {} is
> already too cute.

By "it" I assume you mean "the sha1 of the empty tree", meaning to not
include the {} bit at all?

I am fine with that, as I don't think anyone has even mentioned a
workflow where such a shorthand would be beneficial to users. The only
one I can think of is to represent some tree using diff tools (e.g., "git
diff --stat {} HEAD" instead of some variant on ls-files), but I have
never once actually wanted to do that.

Should I re-send, or do you want to just markup the existing patches?

-Peff
