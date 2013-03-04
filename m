From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Configurable .gitignore filename?
Date: Mon, 04 Mar 2013 14:53:59 +0100
Message-ID: <vpqzjyjp8y0.fsf@grenoble-inp.fr>
References: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jari Pennanen <jari.pennanen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 14:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCVqZ-0003jw-FX
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 14:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab3CDNyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 08:54:05 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38022 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756537Ab3CDNyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 08:54:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r24DrwJS019824
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Mar 2013 14:53:58 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UCVq4-000610-9C; Mon, 04 Mar 2013 14:54:00 +0100
In-Reply-To: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
	(Jari Pennanen's message of "Mon, 4 Mar 2013 13:58:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Mar 2013 14:53:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r24DrwJS019824
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363010039.16999@hoeQjrbmTsiJY7Wl436WuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217399>

Jari Pennanen <jari.pennanen@gmail.com> writes:

> If project or directory belongs to more than one GIT_DIR then some of
> the GIT_DIR's may need a different .gitignore files, it would be
> useful if one could define it independently, e.g. in GIT_DIR/config:
>
> [core]
> ignorefilename = .gitalternateignore

There is already core.excludesfile, which does not replace the usual
.gitignore but comes in addition. The common use is a user-wide ignore
file, not a per-directory one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
