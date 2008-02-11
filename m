From: Jeff King <peff@peff.net>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 03:03:25 -0500
Message-ID: <20080211080325.GA2706@coredump.intra.peff.net>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de> <20080211074817.GA18898@sigill.intra.peff.net> <e5bfff550802102355n3076ae6ax636e6c5635e6a0ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTe1-00039F-IX
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbYBKID3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYBKID3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:03:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2030 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbYBKID2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:03:28 -0500
Received: (qmail 5621 invoked by uid 111); 11 Feb 2008 08:03:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 11 Feb 2008 03:03:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 03:03:25 -0500
Content-Disposition: inline
In-Reply-To: <e5bfff550802102355n3076ae6ax636e6c5635e6a0ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73479>

On Mon, Feb 11, 2008 at 08:55:07AM +0100, Marco Costalba wrote:

> On Feb 11, 2008 8:48 AM, Jeff King <peff@peff.net> wrote:
> >
> > It may also be that multiple rename limits are appropriate. I don't mind
> > waiting 30 seconds for rename detection during a particularly tricky
> > merge. I probably do when running 'git-log -p'.
> >
> 
> That's exactly my point: ignoring diff.renamelimit in case of merges.

I think you missed my point. You never want to _ignore_ it. You want to
set it higher.

-Peff
