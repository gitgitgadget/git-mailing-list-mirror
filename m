From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] git-gc --auto: add documentation.
Date: Mon, 17 Sep 2007 10:36:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171031420.28586@racer.site>
References: <11900186941912-git-send-email-gitster@pobox.com>
 <11900187073420-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD2Y-0005Jj-QJ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbXIQJhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbXIQJhH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:37:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:48686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753917AbXIQJhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:37:05 -0400
Received: (qmail invoked by alias); 17 Sep 2007 09:37:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 17 Sep 2007 11:37:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mt21P6kSmy89Ei0dEMTG40bUQ35bdQvDlPaGCpr
	QiYuXnPkSNoydu
X-X-Sender: gene099@racer.site
In-Reply-To: <11900187073420-git-send-email-gitster@pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58409>

Hi,

On Mon, 17 Sep 2007, Junio C Hamano wrote:

> +	When there are approximately more than this many loose
> +	objects in the repository, `git gc --auto` that is
> +	invoked by some Porcelain commands will create a new
> +	pack and prune them.

It might strike a newbie as dangerous to read "prune them" here.  Maybe

	... `git gc --auto` will pack the loose objects.  Some Porcelain 
	commands use this command, to do a light weight garbage collection
	from time to time.
+
*Note*: you should still run "git gc" from time to time, since the 
"--auto" option is designed to be fast, whereas "git gc" _without_ 
auto is designed to create small packs.

Hmm? (I think that this is the most visible part of the --auto business, 
so I would document the "git gc" note here...)

Ciao,
Dscho
