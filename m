From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 13:39:38 -0500
Message-ID: <20111107183938.GA5155@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:39:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNU6j-0005db-BY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab1KGSjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 13:39:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35870
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab1KGSjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 13:39:40 -0500
Received: (qmail 28757 invoked by uid 107); 7 Nov 2011 18:39:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 13:39:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 13:39:38 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185011>

On Mon, Nov 07, 2011 at 08:35:07PM +0200, Felipe Contreras wrote:

> I don't know, seems logical to me what 'git remote sync' does, but
> 'git push sync'? That sounds weird, and there are no 'git push foo'
> commands.

What I don't understand is why it is not:

  git push --mirror <URL|remote>

> > And how does this differ from "git push --mirror"? It looks like you
> > have more options for what pushing all versus pruning, but wouldn't it
> > be better for "git push" to grow those options?
> 
> But how? --mirror is just an option, I want a separate command, with
> it's own options.

That's what I don't understand from your proposal. Your command is just
pushing something to the remote, right? Why isn't "push" the command,
and your sync options become options to push?

Can you step back and describe the problem you're trying to solve? Maybe
we're not connecting there.

-Peff
