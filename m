From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git help -w should not create nohup.out
Date: Fri, 8 Feb 2008 01:55:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802080153570.11591@racer.site>
References: <1202434421-8066-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 02:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNITD-0006g2-Da
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 02:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761859AbYBHBz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 20:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761761AbYBHBz0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 20:55:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:48254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761168AbYBHBzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 20:55:25 -0500
Received: (qmail invoked by alias); 08 Feb 2008 01:55:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp002) with SMTP; 08 Feb 2008 02:55:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZP9wDJkxZDzlirkj8AdZcVZakbhmrxdB620gt0P
	ElN9ljLeXGbsL9
X-X-Sender: gene099@racer.site
In-Reply-To: <1202434421-8066-1-git-send-email-dpotapov@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73026>

Hi,

On Fri, 8 Feb 2008, Dmitry Potapov wrote:

> git-help--browse uses 'nohup' to launch some browsers.

Why?

"nohup" should be used to start a program that should persist even after 
you logged out.  I fail to see how this should be sensible for "git help 
-w".  So "off with the head", uh, do away with the "nohup", I say!

Ciao,
Dscho
