From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't set-group-id on directories on apple
Date: Mon, 22 Oct 2007 15:16:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221234070.25221@racer.site>
References: <20071022075459.GA1157@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijy56-0006t2-68
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXJVOQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbXJVOQY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:16:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:48338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751318AbXJVOQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:16:23 -0400
Received: (qmail invoked by alias); 22 Oct 2007 14:16:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 22 Oct 2007 16:16:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19z3MVg2ANzyHKjG0ycre6wQE1UiX65Rb5syHiB7i
	a3rlfZW9LXcevu
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022075459.GA1157@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62010>

Hi,

On Mon, 22 Oct 2007, Scott R Parish wrote:

> "git init --shared=all" was failing because chmod was returning
> EPERM.

Not here.  This is git version 1.5.3.rc4.1716.gc3498, and "uname -a" says

Darwin michael-stirrats-mac-mini.local 8.10.0 Darwin Kernel Version 
8.10.0: Wed May 23 16:50:59 PDT 2007; root:xnu-792.21.3~1/RELEASE_PPC 
Power Macintosh powerpc

Is it possible that you have stricter permission settings?  Or that you 
try to re-initialise a repository that somebody else initialised 
originally?

Ciao,
Dscho
