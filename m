From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Wed, 8 Oct 2008 21:41:46 -0400
Message-ID: <20081009014146.GA14204@coredump.intra.peff.net>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv> <20081008015352.GA29313@coredump.intra.peff.net> <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Thu Oct 09 03:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knka0-0003Dz-LC
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 03:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYJIBlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 21:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbYJIBlu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 21:41:50 -0400
Received: from peff.net ([208.65.91.99]:2460 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbYJIBlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 21:41:49 -0400
Received: (qmail 23855 invoked by uid 111); 9 Oct 2008 01:41:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 08 Oct 2008 21:41:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2008 21:41:46 -0400
Content-Disposition: inline
In-Reply-To: <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97818>

On Wed, Oct 08, 2008 at 09:16:56AM +0100, Jonathan del Strother wrote:

> > Why is the --template parameter to clone and init not sufficient?
> >
>  Partly that I never remember to include the --template parameter,

In that case, I would think a core.template parameter might make more
sense.

> partly that I wanted to customize its behaviour (it copies the files,
> I want symlinks so I only have to edit my hooks in one place whenever
> I change them)

This makes a lot of sense to me as a best-practice. I wonder if we
wouldn't do better to add a core.symlink-templates option?

-Peff
