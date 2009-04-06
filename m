From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to format-patch
Date: Mon, 06 Apr 2009 13:36:24 +0200
Message-ID: <vpqvdpi5807.fsf@bauges.imag.fr>
References: <20090331185018.GD72569@macbook.lan>
	<20090331200457.GA23879@coredump.intra.peff.net>
	<20090331204338.GA88381@macbook.lan>
	<20090401102610.GC26181@coredump.intra.peff.net>
	<20090401175153.GA90421@macbook.lan>
	<7veiw69p26.fsf@gitster.siamese.dyndns.org> <49D9E040.40007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 13:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqnCQ-0004rj-RX
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 13:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbZDFLjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 07:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbZDFLji
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 07:39:38 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:49324 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821AbZDFLji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 07:39:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n36BaS5C027099;
	Mon, 6 Apr 2009 13:36:28 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lqn7o-0006qZ-6q; Mon, 06 Apr 2009 13:36:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lqn7o-0007By-4L; Mon, 06 Apr 2009 13:36:24 +0200
In-Reply-To: <49D9E040.40007@op5.se> (Andreas Ericsson's message of "Mon\, 06 Apr 2009 12\:58\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 06 Apr 2009 13:36:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115807>

Andreas Ericsson <exon@op5.com> writes:

> How about:
> "Some projects (notably the Linux kernel and git itself) put special
> meaning in a 'Signed-off-by' line while other's dont. Please refer
> to your project's documentation for appropriate behaviour."
>
> Optionally with the following amendment:
>
> "In general, you should refrain from signing off on a patch containing
> material that you're not sure can be legally spread under the project's
> license."

To me, this is at least an improvement over refering to
SubmittingPatches (which is targeted to Git contributors) in the
documentation (targeted to Git users), yes.

Not sure whether these two sentences should come in the documentation
for the config option or the command-line switch.

-- 
Matthieu
