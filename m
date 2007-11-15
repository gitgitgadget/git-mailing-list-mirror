From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-clean won't read global ignore
Date: Thu, 15 Nov 2007 11:07:43 +0100
Message-ID: <vpqbq9vlt3k.fsf@bauges.imag.fr>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 11:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsbeI-0007GB-1j
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 11:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbXKOKIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 05:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbXKOKIL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 05:08:11 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:50611 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbXKOKIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 05:08:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id lAFA7hmJ007899;
	Thu, 15 Nov 2007 11:07:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IsbdP-0001xh-N0; Thu, 15 Nov 2007 11:07:43 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IsbdP-0003Cy-KN; Thu, 15 Nov 2007 11:07:43 +0100
In-Reply-To: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 14 Nov 2007 00\:05\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 15 Nov 2007 11:07:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65103>

Junio C Hamano <gitster@pobox.com> writes:

> We probably could change git-ls-files to use the standard set
> when no excludes are specified from the command line, or
> something like that, but this will be a change in semantics that
> would affect the scripts in a subtle way.  I am somewhat
> reluctant to make such a change.

+1 for your introduction of setup_standard_excludes().

And woh, I was writting a mail to say that adding a --exclude-standard
would be cool, but it has been implemented even before I said it would
be cool.

Nothing to add, except "Thanks Junio, Thanks Jeff!" :-).

At last, I'll be able to write

$ git ls-files -o --exclude-standard >> .gitignore
$ $EDITOR .gitignore

-- 
Matthieu
