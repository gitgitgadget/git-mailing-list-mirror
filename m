From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 13:40:53 +0200
Message-ID: <vpqps1dyxbu.fsf@bauges.imag.fr>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
	<20070823203246.GB3516@steel.home>
	<6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
	<7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
	<9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
	<Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 13:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOXZc-0001xO-Ns
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 13:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbXHXLn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 07:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbXHXLn2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 07:43:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:37244 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbXHXLn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 07:43:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7OBer5j016172
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Aug 2007 13:40:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IOXX3-0002sy-Jk; Fri, 24 Aug 2007 13:40:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IOXX3-0007N0-ET; Fri, 24 Aug 2007 13:40:53 +0200
In-Reply-To: <Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Fri\, 24 Aug 2007 11\:55\:41 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 24 Aug 2007 13:40:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56571>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Would it not be better to imitate the "-x" and "-X" options of ls-files, 
> then?  You could achieve the effect you desire by "git status -x \*"
> then.

That's equivalent feature-wise, but a bit slower performance-wise (the
proposed patch skips file listing totally). But since the use-case for
it is not the common case, it probably doesn't matter (and in case,
it's possible to hardcode an optimisation if the pattern is "*").

-- 
Matthieu
