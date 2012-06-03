From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: i18n: git-submodule message does not appear in git.pot
Date: Sun, 03 Jun 2012 10:24:04 +0200
Message-ID: <m2r4tw3isb.fsf@linux-m68k.org>
References: <4FC9FA97.7020908@lyx.org>
	<CANYiYbFrdNGpyTy3sVHPfm9R0bK-0S0Yh8BxxK4WkAbaaQRaNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 10:24:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb67K-00018N-4p
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 10:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab2FCIYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 04:24:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44255 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2FCIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 04:24:12 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3W4skf0t3Mz3hjwD;
	Sun,  3 Jun 2012 10:24:10 +0200 (CEST)
Received: from linux.local (ppp-93-104-157-151.dynamic.mnet-online.de [93.104.157.151])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3W4skZ2BMbz4KK5F;
	Sun,  3 Jun 2012 10:24:06 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id D23321E52D1; Sun,  3 Jun 2012 10:24:04 +0200 (CEST)
X-Yow: A can of ASPARAGUS, 73 pigeons, some LIVE ammo, and a FROZEN DAQUIRI!!
In-Reply-To: <CANYiYbFrdNGpyTy3sVHPfm9R0bK-0S0Yh8BxxK4WkAbaaQRaNA@mail.gmail.com>
	(Jiang Xin's message of "Sun, 3 Jun 2012 16:05:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199070>

Jiang Xin <worldhello.net@gmail.com> writes:

>  	gettext () {
> +		# Bypass options, such as '--'.
> +		while test $# -gt 1
> +		do
> +			shift
> +		done

                shift $(($#-1))

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
