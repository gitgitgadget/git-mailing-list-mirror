From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git add -p and unresolved conflicts
Date: Fri, 30 Mar 2012 10:11:09 +0200
Message-ID: <vpqiphmfqzm.fsf@bauges.imag.fr>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
	<7vbongyd67.fsf@alter.siamese.dyndns.org>
	<vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de>
	<vpqk424zfb1.fsf@bauges.imag.fr> <4F737027.5020503@ira.uka.de>
	<vpqvclnhnpc.fsf@bauges.imag.fr>
	<7vfwcrqfnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 10:11:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDWvj-0001Bl-BA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 10:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab2C3IL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 04:11:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41864 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab2C3ILX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 04:11:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2U86CNF004907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Mar 2012 10:06:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SDWvO-0000vS-ID; Fri, 30 Mar 2012 10:11:10 +0200
In-Reply-To: <7vfwcrqfnq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 29 Mar 2012 14:08:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Mar 2012 10:06:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2U86CNF004907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333699575.44941@gpW+OnCV3rKlvzg9ViDE3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194339>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> The "'git reset $path' before 'add -p'" workaround is not really handy
>> there: it requires typing the path,...
>
> That is exactly why "add -i" was written without first giving "add -p"
> shorthand, which spoiled you and at the same time robbed you the other
> parts of "add -i".

Quite frankly, I never liked the interface of "git add -i". It saves
very little compared to typing "git status" and then doing stuff
directly from the shell. "git add -p" on the other hand just requires
"y" and "n" most of the time, and that really does what I want.

In the case of conflicts, I don't think "git add -i" solves the problem
"view the diff and mark it as resolved" smoothly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
