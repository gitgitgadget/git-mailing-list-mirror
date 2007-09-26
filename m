From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] User Manual: document import-tars.perl
Date: Wed, 26 Sep 2007 20:58:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709262055210.28395@racer.site>
References: <20070925201306.GW30845@fieldses.org>
 <1190759824-18896-1-git-send-email-vmiklos@frugalware.org>
 <20070926181451.GA20976@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iad2t-0005CZ-FD
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 21:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbXIZT7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbXIZT7g
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 15:59:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:47881 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752323AbXIZT7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 15:59:36 -0400
Received: (qmail invoked by alias); 26 Sep 2007 19:59:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 26 Sep 2007 21:59:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+L59JNvayL23mA3vg82ofEukuxiV43VPctHLOz15
	3XZC16TGJEK14e
X-X-Sender: gene099@racer.site
In-Reply-To: <20070926181451.GA20976@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59242>

Hi,

On Wed, 26 Sep 2007, J. Bruce Fields wrote:

> On Wed, Sep 26, 2007 at 12:37:04AM +0200, Miklos Vajna wrote:
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> > ---
> > 
> > On Tue, Sep 25, 2007 at 04:13:06PM -0400, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > > One exception--the "series of tarballs" thing--I think it's cool that
> > > you can just unpack a bunch of tarballs and string them together into a
> > > git history.  It gives a good sense of how git works, and I don't think
> > > it's documented explicitly anywhere.  I think that might be kinda fun to
> > > write up.  But I haven't tried.
> > 
> > something like this?
> 
> Neat-o, I'd missed (or forgotten about) import-tars.perl.

You should also mention

$ mkdir my-new-repo
$ cd my-new-repo
$ git init
$ for z in /blub/*.zip
  do
	rm -rf * 2> /dev/null &&
	unzip "$z" &&
	git add . &&
	git commit -m "$z" ||
	break
  done

import-tars.pl is much faster than this, of course, when it comes to tars, 
but it has no clue about other archive formats.

Ciao,
Dscho
