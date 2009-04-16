From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: integrating make and git
Date: Thu, 16 Apr 2009 11:55:05 +0200
Message-ID: <vpq63h42a9y.fsf@bauges.imag.fr>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
	<alpine.LNX.1.00.0904151148030.19665@iabervon.org>
	<3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
	<200904151930.32816.robin.rosenberg.lists@dewire.com>
	<20090416082615.GA27365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 12:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuOQZ-0004k8-2N
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 12:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbZDPKBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 06:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZDPKBE
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 06:01:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:49873 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbZDPKBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 06:01:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3G9tu04000690
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 11:55:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuOJG-0004Is-4W; Thu, 16 Apr 2009 11:55:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuOJG-0006vW-2F; Thu, 16 Apr 2009 11:55:06 +0200
In-Reply-To: <20090416082615.GA27365@coredump.intra.peff.net> (Jeff King's message of "Thu\, 16 Apr 2009 04\:26\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 11:55:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116690>

Jeff King <peff@peff.net> writes:

> But one could probably design a system to replace both ccache and make
> that relies on git's fast sha-1 reporting to avoid duplicate work. I
> suspect nobody has bothered because make+ccache is "fast enough" that
> the added complexity would not be worth it.

AIUI, ClearCase does something similar to that. Call that an immense
bloatware where everything has to come together, or a nice integration
of different tools, I never used it, so I don't know (I heard the
first option more than the second ...).

-- 
Matthieu
