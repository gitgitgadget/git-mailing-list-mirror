From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sat, 31 Oct 2015 11:25:18 +0100
Message-ID: <vpqbnbfpc6p.fsf@anie.imag.fr>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 31 11:25:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsTLn-0000IQ-7h
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 11:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbbJaKZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2015 06:25:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36148 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbbJaKZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 06:25:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9VAPHp1032215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 31 Oct 2015 11:25:17 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9VAPIwf026955;
	Sat, 31 Oct 2015 11:25:18 +0100
In-Reply-To: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de> ("Torsten
	\=\?iso-8859-1\?Q\?B\=F6gershausen\=22's\?\= message of "Sat, 31 Oct 2015 11:12:05
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 31 Oct 2015 11:25:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9VAPHp1032215
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1446891918.01218@UMUFo+d/06ENHYbjps8vbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280576>

Torsten B=F6gershausen <tboegi@web.de> writes:

> ca:text-no-eol   wt:text-no-eol   t/t5100/empty
> ca:binary        wt:binary        t/test-binary-2.png
> ca:text-lf       wt:text-lf       t/t5100/rfc2047-info-0007
> ca:text-lf       wt:text-crlf     doit.bat
> ca:text-crlf-lf  wt:text-crlf-lf  locale/XX.po

I would spell the first "in" or "idx" (for "index"), not "ca" (for
"cache"). I think we avoid talking about "the cache" these days even
though the doc sometimes says "cached in the index" (i.e. use "cache" a=
s
a verb, not a noun).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
