From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Mon, 20 Feb 2012 09:50:40 +0100
Message-ID: <vpqy5rxsxb3.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<7v8vk2zghl.fsf@alter.siamese.dyndns.org>
	<vpqty2px4l5.fsf@bauges.imag.fr>
	<7vmx8hvb69.fsf@alter.siamese.dyndns.org>
	<vpqobsx7d9s.fsf@bauges.imag.fr>
	<7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
	<m34nups3q2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Tim Haga <timhaga@ebene6.org>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:50:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOxQ-0003DB-1O
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab2BTIur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:50:47 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57529 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab2BTIuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:50:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1K8l3eH008368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Feb 2012 09:47:03 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RzOxF-0001bg-5t; Mon, 20 Feb 2012 09:50:41 +0100
In-Reply-To: <m34nups3q2.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Fri, 17 Feb 2012 10:40:26 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 20 Feb 2012 09:47:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1K8l3eH008368
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330332424.31011@OM6O3jM4WDRL4T94e28ywQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191056>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Aren't there LaTeX tools archives that would be a much better home for
>> this tool?
>
> There is CTAN: Comprehensive TeX Archive Network (http://ctan.org),
> which hosts tools such like latexmk (cousin of the general make
> utility), autolatex (generates Makefile), chktex, ite (interactive TeX
> editor),... latexdiff itself is also there.

It's not really the same thing: AFAIK, ctan is a good place to
distribute things, but not to develop them (i.e. I don't see revision
control or developpers mailing-lists there, which were the two
motivations for pushing git-latexdiff in git.git).

Anyway, since no one spoke up to defend my position, I'll have to find
another place to host it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
