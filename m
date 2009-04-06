From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 06 Apr 2009 14:54:40 +0200
Message-ID: <vpqprfq3ptb.fsf@bauges.imag.fr>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	<alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
	<33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoQp-0005ZY-QS
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZDFM6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZDFM6d
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:58:33 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:63128 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbZDFM6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 08:58:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n36Cse59014316;
	Mon, 6 Apr 2009 14:54:41 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LqoLY-0000AV-GX; Mon, 06 Apr 2009 14:54:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LqoLY-0007Tn-Dz; Mon, 06 Apr 2009 14:54:40 +0200
In-Reply-To: <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com> (Klas Lindberg's message of "Mon\, 6 Apr 2009 14\:41\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 06 Apr 2009 14:54:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115816>

Klas Lindberg <klas.lindberg@gmail.com> writes:

> Hello
>
> Thank you, but I don't understand the answer. If I mistakenly publish
> a tree that contains secrets and someone manages to fetch against it
> before I correct the mistake; how does the limitation to only fetch
> named references help me???

What Johannes pointed out is that someone could fetch from your repo
_after_ you correct the mistake (if you don't control garbage
collection).

-- 
Matthieu
