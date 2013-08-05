From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: redundant message in builtin/rm.c
Date: Mon, 05 Aug 2013 12:10:37 +0200
Message-ID: <vpqhaf44fdu.fsf@anie.imag.fr>
References: <CANYiYbGQj6mCDraxiBHXEL+qd7OwnFCaMpB3Wb4_Pg=-p+KJAg@mail.gmail.com>
	<CAN0XMOJ+ar+iKwVi_z02x7p3XcZj0SxT69a7ApRxOioet8RwDw@mail.gmail.com>
	<7v1u6l501r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	"'Git List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 12:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Hkv-0004eH-RX
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 12:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab3HEKLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 06:11:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34190 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3HEKLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 06:11:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r75AAa6X032407
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Aug 2013 12:10:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V6HkM-0004cB-55; Mon, 05 Aug 2013 12:10:38 +0200
In-Reply-To: <7v1u6l501r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Jul 2013 23:04:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Aug 2013 12:10:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r75AAa6X032407
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376302239.03482@D5PVPZ0aItfDM090bsH3Mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231641>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks both.  Perhaps we should do something like this?
>
> -- >8 --
> Subject: builtin/rm.c: consolidate error reporting for removing submodules

Sounds good, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
