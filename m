From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Mon, 29 Dec 2008 14:29:01 +0100
Message-ID: <200812291429.01822.markus.heidelberg@web.de>
References: <200812290037.25890.markus.heidelberg@web.de> <200812291400.08924.trast@student.ethz.ch>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 29 14:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHICG-0003uf-3U
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 14:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYL2N2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 08:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYL2N2y
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 08:28:54 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33780 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYL2N2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 08:28:53 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8BD9EFB27A29;
	Mon, 29 Dec 2008 14:28:52 +0100 (CET)
Received: from [91.19.66.120] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LHIAu-0001RZ-00; Mon, 29 Dec 2008 14:28:52 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200812291400.08924.trast@student.ethz.ch>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/RbE+a8VnkSaoxQR1bM2Eptuvaq596X/FTWzLP
	/HzE0aCfxDPIhVLXit3WYvabKEUTaTDxCx1sMfqXmuqUxgpuBe
	G2gvl893saa+lxfDGGoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104100>

Thomas Rast, 29.12.2008:
> Markus Heidelberg wrote:
> >  	Specify a starting "Cc:" value for each email.
> > +	Default is the value of 'sendemail.cc'.
> >  +
> >  The --cc option must be repeated for each user you want on the cc list.
> 
> Judging from the source, this is not a default value that you can
> override: any recipients listed in sendemail.cc configuration(s) are
> always added to the Cc list.  The same goes for --bcc and
> sendemail.bcc however, which uses the exact same formulation.

OK, and --to and sendemail.to is also affected.

> Maybe something like
> 
>   You can also add Cc recipients via 'sendemail.cc' configuration
>   settings.
> 
> would clarify?

It is already in next, I think a following patch should be against next
now, shouldn't it?

Markus
