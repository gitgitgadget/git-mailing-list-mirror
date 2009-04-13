From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] doc/checkout: split checkout and branch creation
	in synopsis
Date: Mon, 13 Apr 2009 09:19:49 -0400
Message-ID: <20090413131949.GA16293@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net> <20090413111933.GD15982@coredump.intra.peff.net> <fabb9a1e0904130613g5b664706jb6a3c29107ac1fc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 15:21:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtM6d-0003jw-Ff
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 15:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbZDMNTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 09:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZDMNTw
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 09:19:52 -0400
Received: from peff.net ([208.65.91.99]:47862 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbZDMNTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 09:19:51 -0400
Received: (qmail 32381 invoked by uid 107); 13 Apr 2009 13:19:54 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 09:19:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 09:19:49 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0904130613g5b664706jb6a3c29107ac1fc9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116438>

On Mon, Apr 13, 2009 at 03:13:06PM +0200, Sverre Rabbelier wrote:

> On Mon, Apr 13, 2009 at 13:19, Jeff King <peff@peff.net> wrote:
> > +'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
> 
> This way doesn't it say you can leave out the [-b <new branch>] part
> but still specify a start point? I thought the general syntax for this
> would make it:
> 
> > +'git checkout' [-q] [-f] [-m] [-b <new_branch> [<start_point>]]

Oops, actually it is supposed to be:

 'git checkout' ... -b <new_branch> [<start_point>]

The cause where "-b <new_branch>" isn't used is covered in the line
above.

-Peff
