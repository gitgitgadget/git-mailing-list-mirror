From: Jeff King <peff@peff.net>
Subject: Re: problem with file mode
Date: Mon, 8 Jun 2009 08:30:06 -0400
Message-ID: <20090608123006.GF13775@coredump.intra.peff.net>
References: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Romanenco <andrew@romanenco.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 14:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdzb-0006cm-EH
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 14:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbZFHMaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 08:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZFHMaO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 08:30:14 -0400
Received: from peff.net ([208.65.91.99]:44853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZFHMaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 08:30:13 -0400
Received: (qmail 21391 invoked by uid 107); 8 Jun 2009 12:30:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 08:30:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 08:30:06 -0400
Content-Disposition: inline
In-Reply-To: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121069>

On Mon, Jun 08, 2009 at 12:09:23PM +0300, Andrew Romanenco wrote:

> Both stations are ubuntu 8.10
> And I have repo with text files on station A
> When I do git clone to station B all files become executable 755
> And git status show that all files are modified, diff shows mode change

What filesystem is station B running? Is it something that actually has
a proper executable bit (i.e., not FAT or similar)?

-Peff
