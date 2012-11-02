From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 2 Nov 2012 13:19:50 -0400
Message-ID: <20121102171949.GA28958@sigill.intra.peff.net>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
 <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
 <5093D193.3030108@gmail.com>
 <CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com>
 <5093EFF4.5080308@gmail.com>
 <CAMP44s2T7iOdn6mWXqcUw97d8_-=pR=7ZQ5t_ygPGOphXW5cQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 18:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUKuc-0008A3-9e
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 18:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760871Ab2KBRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 13:19:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758141Ab2KBRTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 13:19:52 -0400
Received: (qmail 7190 invoked by uid 107); 2 Nov 2012 17:20:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 13:20:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 13:19:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2T7iOdn6mWXqcUw97d8_-=pR=7ZQ5t_ygPGOphXW5cQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208963>

On Fri, Nov 02, 2012 at 05:19:33PM +0100, Felipe Contreras wrote:

> > In any case, I agree that having a clean, understandable code as a
> > starting point is better than having a more "portable" but trickier
> > one right away.  If it will need converting to POSIX, that can be
> > done as a follow up (and as we've both noticed, this would be the
> > only point where such a conversion might be problematic -- the other
> > changes would be trivial, almost automatic).
> 
> As things are the options are:
> 
> 1) Remove this code and move to POSIX sh. People looking for reference
> might scratch their heads as to why 'git push' is not showing the
> update.
> 2) Keep this code and remain in bash.
> 
> Until we have a:
> 
> 3) Replace this code with a clean POSIX sh alternative
> 
> I would rather vote for 2)

I'm fine with bash. The critical thing is that it not break people's
"make test" if they do not have bash (or do not have bash as /bin/bash).

-Peff
