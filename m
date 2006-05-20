From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] Remove possible segfault in http-fetch.
Date: Sun, 21 May 2006 01:00:59 +0200
Message-ID: <87ejyonvx0.fsf@mid.deneb.enyo.de>
References: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
	<BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 01:01:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhaRZ-0007IR-2j
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWETXBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWETXBF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:01:05 -0400
Received: from mail.enyo.de ([212.9.189.167]:15038 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964801AbWETXBE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 19:01:04 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1FhaRQ-0008W7-NP; Sun, 21 May 2006 01:01:00 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1FhaRP-0004tM-Dt; Sun, 21 May 2006 01:00:59 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE> (Sean's message
	of "Sat, 20 May 2006 18:46:33 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20403>

* Sean:

> Testing seems to confirm that the segfault is removed by this patch.

It seems to fix it for me, too.

> As to why the website returns a 405 error in the first place is still
> a mystery to me.

The web server does not support PROPFIND.
