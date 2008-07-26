From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sat, 26 Jul 2008 15:17:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261515290.26810@eeepc-johanness>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 15:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMjea-0000eV-Sh
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 15:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYGZNQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 09:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYGZNQn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 09:16:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:37745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbYGZNQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 09:16:42 -0400
Received: (qmail invoked by alias); 26 Jul 2008 13:16:41 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp062) with SMTP; 26 Jul 2008 15:16:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/19GUjrEX1EKXlADwRHs+EVBBNrar1JEAFgd323C
	+l6tmuIV3wK5vI
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217065304-27815-1-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90223>

Hi,

On Sat, 26 Jul 2008, Steffen Prohaska wrote:

> -#define main(c,v) main(int argc, const char **argv) \
> +#define main(c,v) dummy_decl_mingw_main(); \

What is this dummy_*() statement supposed to do?

Note that I still think it would be a better fix to refactor the 
lookup_prog() function from mingw.c.

Ciao,
Dscho
