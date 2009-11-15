From: Jeff King <peff@peff.net>
Subject: Re: .gitignore polution
Date: Sun, 15 Nov 2009 04:43:53 -0500
Message-ID: <20091115094352.GA21477@coredump.intra.peff.net>
References: <fabb9a1e0911141557k5f6b0b8aud48b95784a9da4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9beg-0003t4-SG
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZKOJoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZKOJoI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:44:08 -0500
Received: from peff.net ([208.65.91.99]:49329 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbZKOJoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:44:07 -0500
Received: (qmail 7876 invoked by uid 107); 15 Nov 2009 09:47:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Nov 2009 04:47:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Nov 2009 04:43:53 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911141557k5f6b0b8aud48b95784a9da4e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132924>

On Sun, Nov 15, 2009 at 12:57:31AM +0100, Sverre Rabbelier wrote:

> I usually compile git from next (sometimes pu to test out a new
> feature), and when I then switch back to a development branch (usually
> based off master) I get something like this:
> 
> $ git status
> # On branch remote-helpers
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	git-http-backend
> #	git-notes
> #	git-remote-hg
> #	test-index-version
> 
> Now I can easily do 'git clean -f', but it's somewhat annoying. How do
> other developers deal with this?

I use "git clean". :)

The other option is to mark them for ignore outside of the
branch-specific ignore:

  git ls-files -o --exclude-standard >>.git/info/exclude

-Peff
