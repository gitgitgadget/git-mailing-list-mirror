From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/18] Follow perlcritic's recommendations - level 5 and 4
Date: Fri, 07 Jun 2013 19:43:32 +0200
Message-ID: <vpqr4gd24vv.fsf@anie.imag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-2-git-send-email-celestin.matte@ensimag.fr>
	<vpqa9n25ojz.fsf@anie.imag.fr> <51B1CDE5.6040109@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr
To: =?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0hV-0004pv-IH
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3FGRnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 13:43:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47727 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab3FGRnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:43:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57HhUTq008148
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 19:43:30 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ul0hI-00027k-KK; Fri, 07 Jun 2013 19:43:32 +0200
In-Reply-To: <51B1CDE5.6040109@ensimag.fr> (=?iso-8859-1?Q?=22C=E9lestin?=
 Matte"'s message of
	"Fri, 07 Jun 2013 14:11:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 19:43:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57HhUTq008148
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371231814.85061@w4cU9kkxUBeN0Dt7UrI2Rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226655>

C=E9lestin Matte <celestin.matte@ensimag.fr> writes:

> The problem is that I took some policies into account for some parts =
of
> the code, but not for all of it. For instance, in commit [15/18], I p=
ut
> some numeric values in constants, but not all of them, as I think hav=
ing
> "arg[3]" in the code does make sense. Ignoring this policy for future
> developement just to prevent the related warnings from appearing woul=
d
> prevent us to see useful warning messages from this policy.

OK. Perhaps a "make sloppy-perlcritic" with zero output and a "make
pedantic-perlcritic" with more policies can make sense. Or just "make
perlcritic", and accept that there are warnings.

> Anyway, should this be integrated in the current patch or added as an
> independant patch?

That could be a new patch, preferably the first of the series.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
