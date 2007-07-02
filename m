From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Update on builtin-commit
Date: Mon, 2 Jul 2007 17:11:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021709120.4071@racer.site>
References: <11833861634103-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 18:11:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5OUd-0005Sj-Ko
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbXGBQLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbXGBQLN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:11:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:35346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753517AbXGBQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 12:11:12 -0400
Received: (qmail invoked by alias); 02 Jul 2007 16:11:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 02 Jul 2007 18:11:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GnIhTShvGILrOKvotQyAPXMxtOcAEiGDItBHFus
	1z6IReNEbTbgKx
X-X-Sender: gene099@racer.site
In-Reply-To: <11833861634103-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51379>

Hi,

just a quick comment on the option parser:

On most platforms, sizeof(void*)>=sizeof(int). But I would not rely on 
that. Rather (also because it is prettier), I'd use "union".

Besides, your option parser loses order information, correct? IOW, 
something like "--color --no-color --color" would confuse it.

Ciao,
Dscho
