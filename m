From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 19:57:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231956280.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com>
 <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjXy-0005AZ-T5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYGWS5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbYGWS5a
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:57:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:49022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754401AbYGWS53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:57:29 -0400
Received: (qmail invoked by alias); 23 Jul 2008 18:57:27 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp001) with SMTP; 23 Jul 2008 20:57:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gxkFTIudg/vPSu4K30H0lSAZRvC2DAx+N9+V4wm
	sUy5NyLQUPIsDV
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89737>

Hi,

On Wed, 23 Jul 2008, Avery Pennarun wrote:

> 1. always CRLF on all platforms (eg. for .bat files)
> 2. always LF on all platforms (eg. for shell scripts and perl scripts)
> 3. just leave it alone no matter what (eg. for binary files)

These are not different, but equal.  "Do no harm to the contents of this 
file".

Hth,
Dscho
