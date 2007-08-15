From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: squelch empty diffs even more
Date: Wed, 15 Aug 2007 16:47:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708151646250.19222@wbgn129.biozentrum.uni-wuerzburg.de>
References: <46C21A25.2040304@lsrfire.ath.cx> <7v643hbyao.fsf@assigned-by-dhcp.cox.net>
 <46C22F7C.1000502@lsrfire.ath.cx> <7vvebhad3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 16:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILK9q-00080o-8h
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 16:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014AbXHOOr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 10:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760275AbXHOOr0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 10:47:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:55152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759939AbXHOOrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 10:47:25 -0400
Received: (qmail invoked by alias); 15 Aug 2007 14:47:23 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp049) with SMTP; 15 Aug 2007 16:47:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zF7Y6VjKzN9ZWC8MTq3eqoV78SRkWVP/Mlp+Cid
	cfx6wBzksxYHqK
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvebhad3k.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55908>

Hi,

On Tue, 14 Aug 2007, Junio C Hamano wrote:

> Yeah, I've always hated that -2 magic hack, and I think this is the 
> right way to go.  Dscho?

Right.  It is how I should have done it to begin with.  If I find the time 
(and nobody beats be to it), I'll try to find the rest of the places 
tomorrow, and send a fix.

Ciao,
Dscho
