From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: Fix a bug in a regexp
Date: Sat, 08 Jun 2013 20:38:56 +0200
Message-ID: <vpqmwr0v45b.fsf@anie.imag.fr>
References: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlO2w-0003Xj-85
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3FHSjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 14:39:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53685 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab3FHSjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:39:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r58IcsVa020192
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 20:38:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlO2T-0001S5-9O; Sat, 08 Jun 2013 20:38:57 +0200
In-Reply-To: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
	(=?iso-8859-1?Q?=22C=E9lestin?= Matte"'s message of "Sat, 8 Jun 2013
 15:35:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 20:38:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58IcsVa020192
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371321539.49414@U9/CeDnfnVfOiQuLLtHJ8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226853>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> In Perl, '\n' is not a newline, but instead a literal backslash follo=
wed by an
> "n". As the output of "rev-list --first-parent" is line-oriented, wha=
t we want
> here is a newline.

This is right, but the code actually worked the way it was. I'm not
sure, but my understanding is that '\n' is the string "backslash
followed by n", but interpreted as a regexp, it is a newline.

The new code looks better than the old one, but the log message may be
improved.

In any case, Acked-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
