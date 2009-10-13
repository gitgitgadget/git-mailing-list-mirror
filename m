From: Jeff King <peff@peff.net>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 21:43:32 -0400
Message-ID: <20091013014332.GB13737@coredump.intra.peff.net>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
 <1255383459.15646.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sylvain@demarque.qc.ca, git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 03:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxWVF-0006M4-SM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 03:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbZJMBoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 21:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbZJMBoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 21:44:09 -0400
Received: from peff.net ([208.65.91.99]:59800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbZJMBoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 21:44:09 -0400
Received: (qmail 9742 invoked by uid 107); 13 Oct 2009 01:47:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 21:47:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 21:43:32 -0400
Content-Disposition: inline
In-Reply-To: <1255383459.15646.10.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130101>

On Mon, Oct 12, 2009 at 11:37:39PM +0200, Daniele Segato wrote:

> I don't see the point of using git on the root directory :)
> 
> but that made me think that it could actually be a good idea
> for /etc/ :)
> I happen to modify some configuration and then I forgot which one... and
> sometimes updates broke something

Take a look at:

  http://joey.kitenet.net/code/etckeeper/

> can I have a git report of $HOME/.* (without . and ..)? (all user
> setting)

This seems to work:

  $ cd ~
  $ git init
  $ echo '*' >.gitignore
  $ echo '!.*' >.gitignore

> Or better: provide a list of directory under $HOME I want to track 

Same thing, but make your ! pattern more specific.

-Peff
