From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead of "(no branch)"
Date: Sun, 03 Feb 2013 22:23:46 +0100
Message-ID: <vpqpq0hnlb1.fsf@grenoble-inp.fr>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
	<1359870520-22644-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U272y-0006wf-W4
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 22:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab3BCVXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 16:23:55 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36640 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab3BCVXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 16:23:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r13LNixK014528
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Feb 2013 22:23:44 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U272Q-000108-P2; Sun, 03 Feb 2013 22:23:46 +0100
In-Reply-To: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 3 Feb
 2013 12:48:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Feb 2013 22:23:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r13LNixK014528
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360531428.17824@i6YgF7+0sEso+dtRfoVcxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215336>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git=
/BISECT_START" not modified if
>  	cp .git/BISECT_START saved &&
>  	test_must_fail git bisect start $HASH4 foo -- &&
>  	git branch > branch.output &&
> -	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
> +	test_i18ngrep "* (bisecting other)" branch.output > /dev/null &&

I'd have spelled it (no branch, bisecting other) to make it clear that
we're on detached HEAD, and avoid confusing old-timers. But maybe your
version is enough, I'm not sure.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
