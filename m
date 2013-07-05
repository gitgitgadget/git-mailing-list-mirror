From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 3/7] git-remote-mediawiki: New git bin-wrapper for developement
Date: Fri, 05 Jul 2013 09:04:11 +0200
Message-ID: <vpqfvvtzdw4.fsf@anie.imag.fr>
References: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
	<1372970340-6545-4-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Fri Jul 05 09:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv04J-0008Om-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 09:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab3GEHE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 03:04:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53415 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3GEHEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 03:04:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6574B37020379
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Jul 2013 09:04:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uv03v-00080d-P5; Fri, 05 Jul 2013 09:04:11 +0200
In-Reply-To: <1372970340-6545-4-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 4 Jul 2013 22:38:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 05 Jul 2013 09:04:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6574B37020379
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373612655.13876@F784AEoq3B+pHQupPYdHlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229628>

benoit.person@ensimag.fr writes:

> --- a/contrib/mw-to-git/Makefile
> +++ b/contrib/mw-to-git/Makefile
> @@ -2,6 +2,12 @@
>  # Copyright (C) 2013
>  #     Matthieu Moy <Matthieu.Moy@imag.fr>
>  #
> +# To build and test:
> +#
> +#   make:
> +#     bin-wrapper/git mw preview Some_page.mw
> +#     bin-wrapper/git clone mediawiki::http://example.com/wiki/
> +#

The colon after "make" and the indentation look weird. Shouldn't this be

+# To build and test:
+#
+#   make
+#   bin-wrapper/git mw preview Some_page.mw
+#   bin-wrapper/git clone mediawiki::http://example.com/wiki/
+#

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
