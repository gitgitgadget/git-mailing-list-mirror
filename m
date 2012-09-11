From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 18:21:09 +0200
Message-ID: <vpqbohc7cp6.fsf@bauges.imag.fr>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
	<vpqy5kgdctm.fsf@bauges.imag.fr>
	<007001cd9016$8f980f80$aec82e80$@schmitz-digital.de>
	<vpq4nn4d968.fsf@bauges.imag.fr>
	<7v1ui8k0in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Joachim Schmitz" <jojo@schmitz-digital.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTDK-0005fn-OB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab2IKQVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:21:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46857 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab2IKQVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:21:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8BGG7gP013755
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 18:16:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBTD4-0005p7-BK; Tue, 11 Sep 2012 18:21:10 +0200
In-Reply-To: <7v1ui8k0in.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 11 Sep 2012 09:05:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Sep 2012 18:16:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BGG7gP013755
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347984968.53941@U9hRx3X5DQF5T95xnMYvaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205245>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Anyway, you can easily get it from the commit that merges the branch
>> (it's the-merge-commit^1).
>
> I think it is the-merge-commit^2;

Right. I forgot that Git counted parents from 1, not 0.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
