From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version
 of git
Date: Thu, 6 Dec 2007 21:09:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87hciv7jkt.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0N2S-00053Z-PA
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbXLFUJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbXLFUJS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:09:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:53477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752011AbXLFUJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 15:09:17 -0500
Received: (qmail invoked by alias); 06 Dec 2007 20:09:15 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 06 Dec 2007 21:09:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NXah9BjAN6VzFdc0GS+uLadB+3NId5EeH0D+SiH
	WJ4xW9K/qSFKex
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <87hciv7jkt.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67332>

Hi,

On Thu, 6 Dec 2007, Sergei Organov wrote:

> Prepend $(prefix)/share/man to the MANPATH environment variable before 
> invoking 'man' from help.c:show_man_page().

This commit message is severely lacking.  Why would you _ever_ prefer the 
installed man pages before invoking "man", which should find them anyway?

Ciao,
Dscho
