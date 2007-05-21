From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Mon, 21 May 2007 10:01:13 +0200
Message-ID: <vpqr6pafvw6.fsf@bauges.imag.fr>
References: <20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
	<vpq8xbkoir8.fsf@bauges.imag.fr>
	<839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
	<7vfy5sy91f.fsf@assigned-by-dhcp.cox.net>
	<vpq7ir3658t.fsf_-_@bauges.imag.fr>
	<7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net>
	<20070521072025.GO3141@spearce.org>
	<7viramfwkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 10:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2u7-0005Hg-SL
	for gcvg-git@gmane.org; Mon, 21 May 2007 10:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbXEUIFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 04:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbXEUIFb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 04:05:31 -0400
Received: from imag.imag.fr ([129.88.30.1]:57888 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557AbXEUIF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 04:05:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4L81DNa021228
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 May 2007 10:01:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hq2pN-0007vE-Fm; Mon, 21 May 2007 10:01:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hq2pN-0005TR-DX; Mon, 21 May 2007 10:01:13 +0200
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, "Shawn O. Pearce" <spearce@spearce.org>, Brian Gernhardt <benji@silverinsanity.com>, Anand Kumria <wildfire@progsoc.org>,  git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7viramfwkq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 21 May 2007 00\:46\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 May 2007 10:01:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47992>

Junio C Hamano <junkio@cox.net> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Junio C Hamano <junkio@cox.net> wrote:
>>> wouldn't this be useful?
>>> 
>>> $ git-describe --contains --tags 1b600e659
>>> v1.5.0-rc3~34

[ I didn't receive this message, and gmane doesn't seem to have it.
  Strange ]

>> Like this?  ;-)
>
> Yeah, something like that.
>
> Now we need to make sure that the name of the option --contains
> is sane, I guess.

It seems OK to me. Perhaps --forward (optionally with a --backward
overriding it) could do too.

-- 
Matthieu
