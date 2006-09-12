From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Mon, 11 Sep 2006 22:32:57 -0400
Message-ID: <20060912023256.GA6596@coredump.intra.peff.net>
References: <20060911232249.GB29736@coredump.intra.peff.net> <20060912020813.GD26332@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 12 04:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMy5F-00039Y-55
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 04:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbWILCc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 22:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWILCc7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 22:32:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:24767 "HELO
	peff.net") by vger.kernel.org with SMTP id S965253AbWILCc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 22:32:59 -0400
Received: (qmail 28219 invoked from network); 11 Sep 2006 22:32:08 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Sep 2006 22:32:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2006 22:32:57 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060912020813.GD26332@socrates.priv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26877>

On Mon, Sep 11, 2006 at 08:08:13PM -0600, Tom Prince wrote:

> > +  1. Copy commit-syntax.vim to vim's syntax directory:
> > +     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
> It would be more obvious if you could do cp gitcomit.vim $HOME/.vim/syntax/

It would be with only one file, but you could just as easily have a
.vim/ftplugin/gitcommit.vim file (I think there are others, too). If you
want to give it the "proper" name, it should probably be
syntax/gitcommit.vim.

-Peff
