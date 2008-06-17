From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 16:46:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806171645300.2308@eeepc-johanness>
References: <1213635227.17814.6.camel@localhost>  <1213667245.14393.3.camel@localhost>  <alpine.DEB.1.00.0806171140470.6439@racer> <1213712520.6400.1.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nicolas Bock <nbock@lanl.gov>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8cSq-00010D-BP
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943AbYFQOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757768AbYFQOqI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:46:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:59541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757902AbYFQOqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:46:07 -0400
Received: (qmail invoked by alias); 17 Jun 2008 14:46:04 -0000
Received: from pspc-eac34.st-and.ac.uk (EHLO pspc-eac34.st-and.ac.uk) [138.251.155.131]
  by mail.gmx.net (mp068) with SMTP; 17 Jun 2008 16:46:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9+8YD+zz98/uAK/eJwCg96dHLMQzqT44FXYMHYv
	BZitBZQJM71mpn
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1213712520.6400.1.camel@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85306>

Hi,

On Tue, 17 Jun 2008, Nicolas Bock wrote:

> This is what I get:
> 
> $ git show-ref
> a4995ae293fd95697a643cd3ea45585ecc38a19d refs/heads/ACT
> 3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/heads/master
> 78e33155a0ab4ab0acba4c64758681fe99f1c5ca refs/heads/nick
> ef66b3aa74b8c1edb55161e01a99dee7cf9edaa3 refs/remotes/origin/*

This is the culprit.  It is obviously a wrong name: "*" is not allowed.

Hth,
Dscho
