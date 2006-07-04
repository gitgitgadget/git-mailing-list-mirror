From: Jeff King <peff@peff.net>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 21:44:41 -0400
Message-ID: <20060704014441.GB9061@coredump.intra.peff.net>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net> <44A9C2D2.6010409@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:44:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZy6-0001Zr-KH
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGDBoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWGDBoo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:44:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:44459 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751213AbWGDBon (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:44:43 -0400
Received: (qmail 8597 invoked from network); 3 Jul 2006 21:44:20 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Jul 2006 21:44:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  3 Jul 2006 21:44:41 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <44A9C2D2.6010409@michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23235>

On Mon, Jul 03, 2006 at 06:22:26PM -0700, Ryan Anderson wrote:

> You can have multiple source trees, one per 'branch' (which is a bit of
> a bad term here), and have completely unrelated things in the branches.
> 
> See, for an example, the main Git repo, which has the "man", "html", and
> "todo" branches, logically distinct and (somewhat) unrelated to the main
> branch tucked away in "master".

Right, I know, but my complaint is that I can't then turn that into a
directory hierarchy of .../man, .../html, .../todo that are all checked
out at the same time (there are obviously ways of playing with it, say
by setting GIT_DIR and doing a checkout in those directories, but then I
can't use git in the normal way).

The best I can come up with is having man, html, and todo repos pointing
to the one (now local) repo which contains everything. But then pushing
is a two-step process.

-Peff
