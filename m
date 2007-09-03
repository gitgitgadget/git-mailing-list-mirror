From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in
 archive files)
Date: Mon, 3 Sep 2007 19:40:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031935540.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGqV-0008Uc-MJ
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXICSkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXICSkS
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:40:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:56473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753954AbXICSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 14:40:16 -0400
Received: (qmail invoked by alias); 03 Sep 2007 18:40:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 03 Sep 2007 20:40:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Wj0Nlek+Wl6diypFmGALv2L4fb0TGx4Zk4/g0qW
	efYVaMZzD9fE/l
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC4D45.4030208@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57501>

Hi,

On Mon, 3 Sep 2007, Ren? Scharfe wrote:

> Add support for a new attribute, specfile.  Files marked as being
> specfiles are expanded by git-archive when they are written to an
> archive.  It has no effect on worktree files.  The same placeholders
> as those for the option --pretty=format: of git-log et al. can be
> used.

I almost like this approach.  Would it not be a little more useful if you 
could mark the placeholders with something like "$Format: xyz %c$"?  
Because then we could just shut up all those complainers that want to 
insert some revision specific information into the files, without 
affecting formats for printf().

Of course, the idea to keep the worktree unaffected is brilliant.

Ciao,
Dscho
