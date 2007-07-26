From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fully resolve symlinks when creating lockfiles
Date: Thu, 26 Jul 2007 19:35:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261934080.14781@racer.site>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
 <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE8BN-00034o-QV
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934438AbXGZSfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934213AbXGZSfX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:35:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:47493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932738AbXGZSfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:35:22 -0400
Received: (qmail invoked by alias); 26 Jul 2007 18:35:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 26 Jul 2007 20:35:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hc503Z46hn0ncUp8DVU6FeeC5J/mXmOoMlYRpYg
	Bz3YWhNovoT32z
X-X-Sender: gene099@racer.site
In-Reply-To: <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53855>

Hi,

On Thu, 26 Jul 2007, Bradford C. Smith wrote:

> Make the code for resolving symlinks in lockfile.c more robust as
> follows:
> 
> 1. Handle relative symlinks
> 2. recursively resolve symlink chains up to OS limit

FWIW I like what it does, but how.  What is so wrong with just relying on 
is_absolute_path() and make_absolute_path()?  The code would be much 
shorter then, and we need those functions anyway, methinks.

Ciao,
Dscho
