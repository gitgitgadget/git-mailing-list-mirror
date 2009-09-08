From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 08 Sep 2009 21:41:21 +0200
Message-ID: <vpqzl95z0ke.fsf@bauges.imag.fr>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	<81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
	<vpqhbvekldk.fsf@bauges.imag.fr>
	<a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
	<4AA66C54.4060101@viscovery.net>
	<a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 21:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml6ZN-0005QW-DG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 21:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbZIHTl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZIHTl0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 15:41:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55608 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbZIHTlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 15:41:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n88JbZRe028305
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Sep 2009 21:37:35 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ml6Z7-00073t-3r; Tue, 08 Sep 2009 21:41:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ml6Z7-0000V7-2S; Tue, 08 Sep 2009 21:41:21 +0200
In-Reply-To: <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com> (Thiago Farina's message of "Tue\, 8 Sep 2009 10\:52\:46 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Sep 2009 21:37:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n88JbZRe028305
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253043458.08437@m62AUEWcWexYa0+pAvUiXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128027>

Thiago Farina <tfransosi@gmail.com> writes:

> Running only "make".
> $ make

[...]

> Running configure and then make
> $ make configure
> GIT_VERSION = 1.6.5.rc0.dirty
>     GEN configure
> $ make

[...]

What about trying to do what the INSTALL file suggests, then?

| Alternatively you can use autoconf generated ./configure script to
| set up install paths (via config.mak.autogen), so you can write
| instead
| 
|         $ make configure ;# as yourself
|         $ ./configure --prefix=/usr ;# as yourself
|         $ make all doc ;# as yourself
|         # make install install-doc install-html;# as root

You did the first line, but the three next one give you instructions
that you didn't follow. These instructions start line 16 of the
INSTALL file, that is, in the first screen when viewing the file with
a reasonable window size.

I tend to disagree with the mainainer that the configure should be the
"alternate" and plain make the recommanded way, but the configure
script is there, it works, it's documented early enough in the INSTALL
file, so what's the problem?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
