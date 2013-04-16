From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 12:36:20 +0200
Message-ID: <vpqppxudaor.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
	<vpqppxvoqsc.fsf@grenoble-inp.fr>
	<7vobdfztz9.fsf@alter.siamese.dyndns.org>
	<CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
	<7vr4ibu14j.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
	<vpqli8je8w0.fsf@grenoble-inp.fr>
	<CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
	<vpqvc7mdd3x.fsf@grenoble-inp.fr>
	<CALkWK0m+NQ_ZdDkD31VxEpFHGm006mGiAy6GHi31+MrPmzB1mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 12:36:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US3Fa-0003Tj-3V
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 12:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab3DPKg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 06:36:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60472 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab3DPKg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 06:36:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3GAaJWM023521
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Apr 2013 12:36:19 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1US3FN-0002cn-1B; Tue, 16 Apr 2013 12:36:21 +0200
In-Reply-To: <CALkWK0m+NQ_ZdDkD31VxEpFHGm006mGiAy6GHi31+MrPmzB1mQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 16 Apr 2013 15:25:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 16 Apr 2013 12:36:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3GAaJWM023521
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366713383.60102@46lzd26nUAkydokMC0Xd7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221406>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Yes, touching a simple "autostash" file at stash-time, and removing it
> at pop-time will do.  I don't see why it should be part of a
> (potentially user-editable) todo-list, which serves an entirely
> different purpose.

You'll have to apply the index state and then the tree state. How do you
know whether the next call to "git rebase" should apply one or the other?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
