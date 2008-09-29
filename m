From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Mon, 29 Sep 2008 22:09:17 +0200
Message-ID: <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:10:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkP4t-0004dl-55
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYI2UJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 16:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYI2UJd
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:09:33 -0400
Received: from frim.nl ([87.230.85.232]:48187 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751980AbYI2UJd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 16:09:33 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KkP3c-0007nW-9Z; Mon, 29 Sep 2008 22:09:24 +0200
In-Reply-To: <20080921104238.GA9217@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97049>

(Sorry for a late response)

On 21 sep 2008, at 12:42, Jeff King wrote:

> OK, I have lived with it for a little while, and I am still  
> annoyed. ;)
>
> My complaints are:
>
>  1. It wastes more horizontal screen real estate, making it more  
> likely
>     that the line will wrap.
>
>  2. In almost all of my projects (including git), I use the subject
>     line convention of "subsystem: one line summary". So you end up
>     with the visually confusing:
>
>       Created commit abcd1234 on master: subsystem: one line summary
>
>     which is even worse on a topic branch which is meaningful to the
>     project:
>
>       Created commit abcd1234 on widget: subwidget: one line summary
>
>     which has literally left me scratching my head wondering why I put
>     "widget" into the commit message.

How about something like

	Created commit abcd1234 on widget -- "subwidget: one line summary"

?
> Maybe it is better to simply break the line, which solves both  
> problems.
> Something like:

I don't like a multi-line approach.. I tried it myself, and the second  
line
makes the first line easier to overlook

- Pieter
