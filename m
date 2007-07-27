From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] another attempt at make_absolute_path()
Date: Fri, 27 Jul 2007 20:22:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707272022090.14781@racer.site>
References: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bradford C Smith <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVOe-0006nR-9B
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760025AbXG0TWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759610AbXG0TWl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:22:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:44615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758866AbXG0TWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:22:41 -0400
Received: (qmail invoked by alias); 27 Jul 2007 19:22:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 27 Jul 2007 21:22:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RstwgKulRVu5hoE87tc4odISPFAKrlc/HNYwHRA
	2X4a0MORi2qJsu
X-X-Sender: gene099@racer.site
In-Reply-To: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53954>

Hi,

On Fri, 27 Jul 2007, Bradford C Smith wrote:

> Here's my attempt at make_absolute_path() and friends.  I think this
> version handles symlinks cleanly to avoid problems with '..' path
> elements Junio pointed out recently.
> 
> I built these with another patch I previously submitted to make
> git-config consistently use lockfile.c routines and tested it with the
> regular test suite plus some extra tests Junio sent to the list for
> checking git-config symlink handling.
> 
> I also built a separate executable with just the path handling routines
> in it and spot-checked several cases to make sure it appeared to be
> working as expected.  ('/', loop of symlinks, lots of extra slashes, .
> and .. elements, etc.)

Heh.  Just a couple of minutes after I sent my version...

Although I added tests, and you did not...

Ciao,
Dscho
