From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Tue, 13 Nov 2007 10:52:03 +0100
Message-ID: <vpq3avah3r0.fsf@bauges.imag.fr>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	<Pine.LNX.4.64.0711121412410.4362@racer.site>
	<9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	<Pine.LNX.4.64.0711121613570.4362@racer.site>
	<9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	<Pine.LNX.4.64.0711121635130.4362@racer.site>
	<9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
	<20071113042017.GB9745@sigill.intra.peff.net>
	<9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 10:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsSP-0004kU-Mb
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXKMJxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbXKMJxF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:53:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:59212 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbXKMJxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:53:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAD9q8h5008806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 10:52:08 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IrsR9-0000eo-Lq; Tue, 13 Nov 2007 10:52:03 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IrsR9-00015C-JO; Tue, 13 Nov 2007 10:52:03 +0100
In-Reply-To: <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com> (Jon Smirl's message of "Mon\, 12 Nov 2007 23\:30\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Nov 2007 10:52:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64777>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Execute bit was not set. I just set it for all the scripts. +x is not
> getting turned on with a default git init-db. I just made a new repo
> to check, no +x on the scripts.

That's by design: "git init" gives you _example_ hooks, but they won't
run until you activate them explicitely with the appropriate chmod.

That said, I'm not sure there's a really good reason not to run
update-server-info by default on push. It doesn't cost much and saves
a lot of troubles for beginners. Perhaps there are cases where the
performance cost is non-negligible.

-- 
Matthieu
