From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save
 author information
Date: Sun, 21 Jun 2009 23:55:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906212354030.26154@pacific.mpi-cbg.de>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 23:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIV1V-0001kn-Ik
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 23:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbZFUVx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZFUVxz
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 17:53:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752166AbZFUVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 17:53:54 -0400
Received: (qmail invoked by alias); 21 Jun 2009 21:53:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 21 Jun 2009 23:53:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BGVNgri5BoSHRe1ht26l4pLm4dU2R9eJqB/BBJU
	iq4TY0nWJOw3V8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090620023413.3995.3630.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121995>

Hi,

On Sat, 20 Jun 2009, Christian Couder wrote:

> This is better than saving in a shell script, because it will make
> it much easier to port "rebase -i" to C. This also removes some sed
> regexps and some "eval"s.

It will not make it easier to port "rebase -i" to C, as this is an 
internal file.  The user is not supposed to touch it at all.  Only "rebase 
-i".  So it would be very easy to just use a different on-disk format when 
turning "rebase -i" into a builtin.

Ciao,
Dscho
