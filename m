From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v3] add configuration variable for --autosquash option of 
	interactive rebase
Date: Tue, 13 Jul 2010 14:34:54 +0200
Message-ID: <AANLkTilFOOK1eXkzWJXlr3zf78xZ82nIK9Jrr1END3-Y@mail.gmail.com>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> 
	<20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org> 
	<20100713112316.GA758@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jul 13 14:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYeho-0006gW-CE
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 14:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054Ab0GMMfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 08:35:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37271 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab0GMMfP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 08:35:15 -0400
Received: by wyb42 with SMTP id 42so70250wyb.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 05:35:14 -0700 (PDT)
Received: by 10.103.221.1 with SMTP id y1mr2354230muq.19.1279024514251; Tue, 
	13 Jul 2010 05:35:14 -0700 (PDT)
Received: by 10.102.228.2 with HTTP; Tue, 13 Jul 2010 05:34:54 -0700 (PDT)
In-Reply-To: <20100713112316.GA758@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150899>

On Tue, Jul 13, 2010 at 1:24 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> If you use this feature regularly you can now enable it by default. I=
n
> case the user wants to override this config on the commandline
> --no-autosquash can be used to force disabling.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

[...]

> @@ -335,6 +338,11 @@ idea unless you know what you are doing (see BUG=
S below).
> =A0+
> =A0This option is only valid when the '--interactive' option is used.
>
> +--no-autosquash::
> + =A0 =A0 =A0 If the '--autosquash' option is enabled by default usin=
g the
> + =A0 =A0 =A0 configuration variable `rebase.autosquash` this option =
can be
> + =A0 =A0 =A0 used to override and disable this setting.
> +

You could also merge this entry with the --autosquash as with --squash
option in git-pull(1):

--autosquash::
--noautosquash::
[original text]
+
If the '--autosquash' option is enabled by default using the
configuration variable `rebase.autosquash` this option can be
used to override and disable this setting.

Santi
