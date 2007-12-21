From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 18:27:39 +0100
Message-ID: <vpq4pec7yb8.fsf@bauges.imag.fr>
References: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
	<2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lhV-0005Vm-Cb
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbXLUR3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbXLUR3y
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:29:54 -0500
Received: from imag.imag.fr ([129.88.30.1]:56418 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbXLUR3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:29:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBLHRd6g025978
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2007 18:27:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J5let-0001M7-Pb; Fri, 21 Dec 2007 18:27:39 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J5let-0000XY-ND; Fri, 21 Dec 2007 18:27:39 +0100
In-Reply-To: <2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com> (Steven Grimm's message of "Fri\, 21 Dec 2007 09\:23\:47 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 21 Dec 2007 18:27:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69076>

Steven Grimm <koreth@midwinter.com> writes:

> Git's command line interface is already confusing enough without
> adding this kind of variability

It also makes portable scripts harder. It's easy to write a script
that works only if you have the option set ...

-- 
Matthieu
