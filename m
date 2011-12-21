From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-commit: add option --date-now
Date: Wed, 21 Dec 2011 17:24:57 +0100
Message-ID: <vpqmxalrixy.fsf@bauges.imag.fr>
References: <4EF1F3AB.5080607@elegosoft.com>
	<20111221153837.GC2160@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Schubert <mschub@elegosoft.com>, git <git@vger.kernel.org>
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Dec 21 17:25:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdOzG-0008FW-C3
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 17:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab1LUQZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 11:25:46 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35413 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab1LUQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 11:25:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pBLGOgmQ030809
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Dec 2011 17:24:42 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RdOyP-00019a-UL; Wed, 21 Dec 2011 17:24:57 +0100
In-Reply-To: <20111221153837.GC2160@beez.lab.cmartin.tk> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Wed, 21 Dec 2011 15:38:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Dec 2011 17:24:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pBLGOgmQ030809
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1325089484.25047@JGv7m2qcJ7HG3WxlJZ/GMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187571>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> I was surpised when I tried 'git commit --amend --date=3Dnow' that gi=
t
> didn't understand 'now' as a date, which seems like a more obvious
> place to fix it.

+1

I really don't think Git wants yet-another-option for each use-case we
find, and accepting "now" as a date (either by hardcoding "now" as an
accepted value, or by running approxidate on the argument of --date).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
