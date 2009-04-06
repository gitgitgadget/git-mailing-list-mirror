From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git diff bug?
Date: Mon, 06 Apr 2009 19:37:29 +0200
Message-ID: <vpqeiw53cpy.fsf@bauges.imag.fr>
References: <m2ocvdkyul.fsf@boostpro.com>
	<20090404014527.GA13350@coredump.intra.peff.net>
	<1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
	<20090406155303.GA3275@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 19:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqsox-0005cT-2K
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbZDFRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbZDFRju
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:39:50 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:37806 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbZDFRjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:39:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n36HbUvG011164;
	Mon, 6 Apr 2009 19:37:30 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LqslF-0007g2-Va; Mon, 06 Apr 2009 19:37:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LqslF-0007vJ-TM; Mon, 06 Apr 2009 19:37:29 +0200
In-Reply-To: <20090406155303.GA3275@sigill.intra.peff.net> (Jeff King's message of "Mon\, 6 Apr 2009 11\:53\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 06 Apr 2009 19:37:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115858>

Jeff King <peff@peff.net> writes:

> But the latter two lines are about preference: "here is how _I_ would
> like to generate diffs for el files".

... and they are commands to be executed. If they were in the
repository, and propagated with clone, then doing

git clone git://some.git/repo
cd repo
git diff

would execute arbitrary commands, which wouldn't be acceptable for
security reasons.

-- 
Matthieu
