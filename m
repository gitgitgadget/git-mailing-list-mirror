From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 13:07:15 +0200
Message-ID: <vpqbpqr1t3w.fsf@bauges.imag.fr>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 19:40:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvxT4-0007tZ-4d
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 19:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbZDTRiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 13:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbZDTRiF
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:38:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:42561 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbZDTRiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 13:38:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3KHX6ma021977
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2009 19:33:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LvrLH-0000Ak-AI; Mon, 20 Apr 2009 13:07:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LvrLH-000894-7g; Mon, 20 Apr 2009 13:07:15 +0200
In-Reply-To: <7vfxg3ipib.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 20 Apr 2009 03\:33\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Apr 2009 19:33:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117009>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Ideally, "git push" from an empty repository to another empty one
>> should be a no-op, or perhaps should error out cleanly. Currently, i=
t
>> just segfaults.
>
> Didn't we see this fixed by Nguy=E1=BB=85n with 55f0566 (get_local_he=
ads(): do not
> return random pointer if there is no head, 2009-04-17)?

Oops, right, I wasn't up to date. Still, the test-case is relevant,
I'll resend with test_expect_success.

--=20
Matthieu
