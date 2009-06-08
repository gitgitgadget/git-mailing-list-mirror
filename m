From: Jeff King <peff@peff.net>
Subject: Re: problem with file mode
Date: Mon, 8 Jun 2009 09:57:09 -0400
Message-ID: <20090608135709.GC28101@sigill.intra.peff.net>
References: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com> <20090608123006.GF13775@coredump.intra.peff.net> <18e14dc30906080649y2efa7facv1109fcd797614d27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Romanenco <andrew@romanenco.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDfLq-0006iW-2A
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 15:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbZFHN5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 09:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbZFHN5I
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 09:57:08 -0400
Received: from peff.net ([208.65.91.99]:52294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309AbZFHN5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 09:57:08 -0400
Received: (qmail 21676 invoked by uid 107); 8 Jun 2009 13:57:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Jun 2009 09:57:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 09:57:09 -0400
Content-Disposition: inline
In-Reply-To: <18e14dc30906080649y2efa7facv1109fcd797614d27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121075>

On Mon, Jun 08, 2009 at 04:49:44PM +0300, Andrew Romanenco wrote:

> true - B is Fat

Then you probably want to:

  git config core.filemode false

on B. Though I thought we automagically tested whether the filesystem
supported executable bits when creating the repository. Did you create
the repository on a different filesystem and then move it to FAT, or did
you directly clone to FAT?

-Peff
