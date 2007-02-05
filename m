From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why is git-clone --reference so slow?
Date: Mon, 5 Feb 2007 16:31:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702051629450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1170676004.29759.767.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 16:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE5oK-0007u0-Aj
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 16:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbXBEPbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 10:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbXBEPbL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 10:31:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:37901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932518AbXBEPbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 10:31:11 -0500
Received: (qmail invoked by alias); 05 Feb 2007 15:31:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 05 Feb 2007 16:31:09 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1170676004.29759.767.camel@pmac.infradead.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38753>

Hi,

On Mon, 5 Feb 2007, David Woodhouse wrote:

> My DSL line sucks; I know this. But why is git-clone so bad at using it?
> 
> This is slow and seems to be downloading a lot of stuff it doesn't
> need...
> 
> pmac /pmac/git $ git-clone --reference /pmac/git/linux-2.6 git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git

Is this a Mac? Is it Mac OS X? Which git version do you use?

We recently had a case like this, and it was fixed: apparently, mmap() on 
Mac OS X is less than fast...

Hth,
Dscho
