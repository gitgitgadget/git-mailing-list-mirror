From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 06 Jan 2009 14:27:53 +0100
Message-ID: <vpq3afwd0o6.fsf@bauges.imag.fr>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
	<7vy6xohkt2.fsf@gitster.siamese.dyndns.org>
	<488807870901060118y2dbc7430ocea5cf9ce4bca3c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johnny Lee" <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 14:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKC3l-0003iu-BL
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 14:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZAFNb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 08:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZAFNb6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 08:31:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:62217 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbZAFNb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 08:31:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n06DRrT7010426
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 14:27:53 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LKByL-0007oa-33; Tue, 06 Jan 2009 14:27:53 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LKByL-0003LQ-0i; Tue, 06 Jan 2009 14:27:53 +0100
In-Reply-To: <488807870901060118y2dbc7430ocea5cf9ce4bca3c7@mail.gmail.com> (Johnny Lee's message of "Tue\, 6 Jan 2009 17\:18\:21 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 06 Jan 2009 14:27:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104686>

"Johnny Lee" <johnnylee194@gmail.com> writes:

> Thanks for your consideration Junio,
>
> Peff has already helped me to figure out the root cause of this error
> is a possible bad practice on collaboration work.
>
> Here I attached the previous mail.

See core.sharedRepository in man git-config or
http://www.kernel.org/pub/software/scm/git/docs/git-config.html

-- 
Matthieu
