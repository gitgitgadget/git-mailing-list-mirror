From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for quoted paths
Date: Thu, 29 Nov 2012 19:47:32 +0100
Message-ID: <vpqhao8gsaj.fsf@grenoble-inp.fr>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
	<1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
	<20121129181141.GA17309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te99Z-0007RG-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab2K2Sru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:47:50 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44827 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab2K2Srt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:47:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qATIbwOZ017710
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 19:37:58 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Te992-0001Mu-I9; Thu, 29 Nov 2012 19:47:32 +0100
In-Reply-To: <20121129181141.GA17309@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 Nov 2012 13:11:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Nov 2012 19:37:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qATIbwOZ017710
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354819082.84087@H0tPooyN9A1WGFiTjgtcow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210859>

Jeff King <peff@peff.net> writes:

> So technically, your modification to the beginning of the sentence is
> not correct.

I'd say the resulting sentence is somehow incorrect, but not more than
the previous one (both say "if ..." without really telling what the
condition was).

>> If an `LF`, backslash or double quote must be encoded
>                        ^
>                        missing comma as list delimiter

Google tells me that my version was UK-correct but not US-correct. As
french, I have no opinion on the subject, I take yours ;-).

How about this:

A path can use the C-style string quoting (this is accepted in all
cases and mandatory if the filename starts with double quote or
contains `LF`). In C-style quoting, `LF`, backslash, and double quote
characters must be escaped by preceding them with a backslash. Also,
the complete name should be surrounded with double quotes (e.g.
`"path/with\n, \\ and \" in it"`).

This should be technically correct, and "this is accepted in all cases"
should encourrage people to use it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
