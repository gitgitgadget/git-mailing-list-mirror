From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-checkout --push/--pop
Date: Wed, 05 Dec 2007 11:26:45 +0100
Message-ID: <vpqir3de8t6.fsf@bauges.imag.fr>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201>
	<7vir3e428i.fsf@gitster.siamese.dyndns.org>
	<200712042204.lB4M4SVB002260@mi1.bluebottle.com>
	<7vprxl1v9v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	Salikh Zakirov <salikh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzrUe-0006cM-Uq
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXLEK2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbXLEK2G
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:28:06 -0500
Received: from imag.imag.fr ([129.88.30.1]:60256 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbXLEK2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:28:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lB5AQp9Z011554
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Dec 2007 11:26:51 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IzrSn-0002IZ-HE; Wed, 05 Dec 2007 11:26:45 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IzrSn-0008Hf-Ek; Wed, 05 Dec 2007 11:26:45 +0100
In-Reply-To: <7vprxl1v9v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 04 Dec 2007 22\:59\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Dec 2007 11:26:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67133>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu, is this something that forgetful people would find useful?

Not sure. That's obviously an interesting feature, but adding two more
options to checkout (which is already a huge swiss-army knife) might
not be worth the trouble.

And the issue with push/pop approaches is that I usually notice I have
to use pop after not having used push (i.e. I use "cd -" all the time,
but rarely "pushd"/"popd").

-- 
Matthieu
