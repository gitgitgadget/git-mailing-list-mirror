From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 18:52:30 +0200
Message-ID: <vpqipbcpp69.fsf@grenoble-inp.fr>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
	<vpqy5k8raig.fsf@grenoble-inp.fr>
	<CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
	<vpqd31kr7v4.fsf@grenoble-inp.fr>
	<CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
	<vpqvcfcps2z.fsf@grenoble-inp.fr>
	<7v4nmwwqox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:00:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDeg9-0003AL-C0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2IQRAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:00:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45853 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab2IQRAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:00:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8HGllxb023883
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2012 18:47:47 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDeYg-0006Ub-Jd; Mon, 17 Sep 2012 18:52:30 +0200
In-Reply-To: <7v4nmwwqox.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Sep 2012 09:37:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Sep 2012 18:47:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8HGllxb023883
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348505271.93197@1qkGufdtJkU0EFx9ACw2VA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205709>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't been paying attention, but does that mean on that system,
> a total stranger kseygold can write, modify, and remove whatever Ram
> owns?  I am hoping that is not the case.

I can see two reasons for having the same UID for two login names:

1) the sysadmin really messed up, and as you say, a total stranger has
complete ownership of your files. Ramkumar, you should check that this
is not your case.

2) the sysadmin explicitely gave two login names to the same physical
person, as kinds of aliases for the same UID (e.g. the person got
married, changed her name and login, but expects ~oldlogin to continue
working). I'm not sure how common this is, and to which extend we want
to support this in our test scripts.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
