From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 1 Jul 2007 15:09:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011507310.4438@racer.site>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 01 16:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I507B-0000uF-2N
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 16:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbXGAOJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbXGAOJP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 10:09:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753843AbXGAOJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 10:09:14 -0400
Received: (qmail invoked by alias); 01 Jul 2007 14:09:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 01 Jul 2007 16:09:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vJXMEB2Gv0bkZImnXpCPfRB7MMfWKFsdyFjewHx
	SCVW8IggffV2j6
X-X-Sender: gene099@racer.site
In-Reply-To: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51297>

Hi,

On Sun, 1 Jul 2007, Sven Verdoolaege wrote:

> gpg: Warning: using insecure memory!
> gpg: [don't know]: invalid packet (ctb=00)
> gpg: read_keyblock: read error: invalid packet
> gpg: enum_keyblocks failed: invalid keyring
> gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
> gpg: signing failed: invalid keyring

That means that gpg somehow barfs on the keyring. I somehow had the 
impression that the keyrings were binary compatible on different 
systems... What system do you have?

> bash-3.00$ gpg --version
> gpg (GnuPG) 1.0.6

It is 1.4.5 here.

> Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA, ELG

AFAIK DSA should suffice.

Ciao,
Dscho
