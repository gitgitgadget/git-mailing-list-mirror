From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Sun, 2 Sep 2007 13:32:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021331570.28586@racer.site>
References: <11887028854022-git-send-email-doug@11011.net>
 <7vveatpklg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Douglas Stockwell <douglas.stockwell@gmail.com>,
	git@vger.kernel.org, Douglas Stockwell <doug@11011.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 14:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRodj-0000QL-1G
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 14:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbXIBMdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 08:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbXIBMdP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 08:33:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:36568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965136AbXIBMdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 08:33:14 -0400
Received: (qmail invoked by alias); 02 Sep 2007 12:33:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 02 Sep 2007 14:33:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194BrAyB7l4EjCx2GEFBKiujL0pZS2Xq5aiQIn/z+
	qD/jVG/WCMBbbB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vveatpklg.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57321>

Hi,

On Sun, 2 Sep 2007, Junio C Hamano wrote:

> Thanks for the patch.  I think SMTP-AUTH is a worthy addition.
> 
> I however have a bit of reservation about making the password
> itself a configuration variable.

Why not have the password in $HOME/.netrc, and ask interactively if none 
was found?

Ciao,
Dscho
