From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 17:03:06 +0200
Message-ID: <vpqfvukdy39.fsf@anie.imag.fr>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Rla-0003EX-Fv
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965711Ab3HHPEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:04:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49807 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965294Ab3HHPEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:04:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r78F3586027385
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 17:03:05 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7Rk3-0006qW-4E; Thu, 08 Aug 2013 17:03:07 +0200
In-Reply-To: <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Aug 2013 10:00:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Aug 2013 17:03:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78F3586027385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376578987.30471@mmTKVjC0WWpBg1L97sjDYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231892>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The only thing it does is to scratch an irrelevant itch by people
>> who peek the codebase and find an old command whose existence does
>> not even hurt them.  They may have too much time on their hand, but
>> that is not an excuse to waste other people's time by adding extra
>> makework on our plate, or changing the behaviour for people who use
>> the command without explanation.
>
> It's a maintenance burden 

I'm not really worried about the maintainance of a 20-lines long
function ...

> that confuses users.

... but I do agree that the doc is really confusing. It would be much
better if the doc could be reduced to:

"This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
Please refer to the documentation of that command."

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
