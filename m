From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 09:44:12 +0200
Message-ID: <vpq61zk8er7.fsf@grenoble-inp.fr>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<7vsj2od841.fsf@alter.siamese.dyndns.org>
	<CAMP44s0q4k+bjQDhWAiYoj2P+7PJqFRs9s0arhy+F7YDO50dZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjW7-0006s7-IO
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966263Ab3DRHoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:44:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44908 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965993Ab3DRHoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 03:44:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3I7iCc7026789
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Apr 2013 09:44:12 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1USjVt-00052N-6X; Thu, 18 Apr 2013 09:44:13 +0200
In-Reply-To: <CAMP44s0q4k+bjQDhWAiYoj2P+7PJqFRs9s0arhy+F7YDO50dZg@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 17 Apr 2013 22:59:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Apr 2013 09:44:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3I7iCc7026789
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366875853.43814@QkXP/asHrihytOuVccCz+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221619>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> * How many times have you tracked regressions in transport helper's
> import/export functionality?
>
> Hint: zero.

The real question to make the situation non-hypothetical would actually
be "how many times did you track a regression that bisected down to
*this particular commit*". Any regression that ends up on another commit
is irrelevant.

I guess you realize how stupid my argument is. But how is yours
different? You do realize that your claim that nobody is ever going to
bisect down to your commit is as hypothetical as other people's claim
(if you think it is not, then try to point us a proof that nobody is
ever going to need a good message in the future to understand what I
mean).

We're trying to make all the code and all the commits clean. It seems to
be a consensus here that review is good. I see no reason to purposely
make some commits less good than others based on the fact that they may
not be used in the future.

Search your favorite search engine for "broken window principle" to get
more arguments in this direction.

> * How many times has *anybody* done so?
>
> Hint: other than me, quite possibly zero.

If you want to be the only developer, and avoid being disturbed by
others, then why are you pushing your changes to git.git? Why are you
even discussing on this list?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
