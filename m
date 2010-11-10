From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: URL-escape the '@' sign in username/password
Date: Wed, 10 Nov 2010 17:07:57 +0100
Message-ID: <vpqpqudw49u.fsf@bauges.imag.fr>
References: <4CD9F655.8030908@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 17:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGDDY-0006Gk-SY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 17:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab0KJQIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 11:08:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54377 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab0KJQIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 11:08:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oAAFqZp1006614
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Nov 2010 16:52:35 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PGDDK-00027n-2G; Wed, 10 Nov 2010 17:07:58 +0100
In-Reply-To: <4CD9F655.8030908@enst-bretagne.fr> (Gabriel Corona's message of "Wed\, 10 Nov 2010 02\:33\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Nov 2010 16:52:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAAFqZp1006614
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290009156.08789@USEPQekaZ5XMid3f3nxDBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161156>

Gabriel Corona <gabriel.corona@enst-bretagne.fr> writes:

> Hello,
>
> I've been trying to use git with a http/webdav repository with an
> username containing a '@' character (foobar@host). The git FAQ [1]
> suggests escaping the '@' character with percent encoding.

Yes, I'm the one to blame for this: I wrote the FAQ entry trying to
help someone on the list, but I didn't have a webserver to actually do
the test.

> diff --git a/http.c b/http.c
> index 0a5011f..c4d18a9 100644
> --- a/http.c
> +++ b/http.c

The patch sounds good. Can you resend it properly (i.e. use git
format-patch and/or git send-email, read about signed-off-by in
Documentation/SubmittingPatches, ...) ?

Thanks in advance,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
