From: Ivan Kanis <expire-by-2011-02-20@kanis.fr>
Subject: Re: configuring cherry-pick to always use -x?
Date: Tue, 15 Feb 2011 10:38:01 +0100
Message-ID: <87vd0lwscm.fsf@kanis.fr>
References: <4D596435.9020605@gmail.com>
	<AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpHMO-00018K-Jp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1BOJiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:38:10 -0500
Received: from kanis.fr ([75.127.73.245]:3003 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab1BOJiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 04:38:09 -0500
Received: from nantes.visionobjects.com ([92.103.229.106] helo=yan)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <expire-by-2011-02-20@kanis.fr>)
	id 1PpHMB-0006D2-Dp; Tue, 15 Feb 2011 04:38:03 -0500
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
	(Junio C. Hamano's message of "Mon, 14 Feb 2011 13:05:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166833>

Hi Junio,

Junio C Hamano <gitster@pobox.com> wrote:

> On Mon, Feb 14, 2011 at 9:19 AM, Adam Monsen <haircut@gmail.com> wrote:
>> Is there a configuration option to make cherry-pick always include the
>> source commit hash in the new commit log message?
>
> Not currently, but before we go any further, could you please justify
> in what workflow it would make sense to use -x most of the time?
>
> We used to add the "cherry-picked from" by default in the very early
> days, and stopped doing so for a reason, and also deliberately stayed
> away from adding such a configuration to actively discourage the use
> of -x without making the user thinking twice.

Could you elaborate on the reason why -x is a bad idea?

Kind regards,
-- 
Ivan Kanis, Release Manager, Vision Objects,
Tel +33 2 28 01 84 44,  Fax +33 2 40 25 89 20
http://www.visionobjects.com

We meet no Stranger, but Ourself.
    -- Emily Dickinson 
