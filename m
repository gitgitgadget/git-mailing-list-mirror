From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Fri, 25 Jul 2008 02:01:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com>
 <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAkz-0003JH-7H
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbYGYAA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbYGYAA7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:00:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:33646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752087AbYGYAA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:00:58 -0400
Received: (qmail invoked by alias); 25 Jul 2008 00:00:56 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp023) with SMTP; 25 Jul 2008 02:00:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181Lpt+9ww1Mv9BPzh+Qkuocmc/Zno6piKvYgTl3u
	GrgRgpkEcFPRdl
X-X-Sender: user@eeepc-johanness
In-Reply-To: <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89977>

Hi,

On Thu, 24 Jul 2008, Eyvind Bernhardsen wrote:

> On 23. juli. 2008, at 21.44, Johannes Schindelin wrote:
> 
> [...]
> 
> >I deem it not, uhm, magical.  By your reasoning there should be a way 
> >for Git to convert a file to UTF-8 when some entertaining person 
> >converted the working directory file to ISO-8859-15.
> 
> Um, what?  This discussion is about figuring out when Git should mess 
> with the line endings a user is trying to commit.

This discusion is about when Git should mess with _content_ at all.

It is not limited to line endings.

Ciao,
Dscho "who personally could not care less about CR if it was not for M$' 
stupidity"
