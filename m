From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Mon, 20 Feb 2012 13:00:26 +0100
Message-ID: <vpqmx8dg1et.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<7v8vk2zghl.fsf@alter.siamese.dyndns.org>
	<vpqty2px4l5.fsf@bauges.imag.fr>
	<7vmx8hvb69.fsf@alter.siamese.dyndns.org>
	<vpqobsx7d9s.fsf@bauges.imag.fr>
	<7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
	<m34nups3q2.fsf@localhost.localdomain>
	<vpqy5rxsxb3.fsf@bauges.imag.fr>
	<7v4nulnac8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub Narebski <jnareb@gmail.com>, Tim Haga <timhaga@ebene6.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 13:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzRvi-0006Dj-2s
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 13:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2BTMBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 07:01:13 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54172 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab2BTMBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 07:01:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1KBv9Hk004009
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Feb 2012 12:57:09 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RzRus-000359-Vo; Mon, 20 Feb 2012 13:00:27 +0100
In-Reply-To: <7v4nulnac8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Feb 2012 01:05:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 20 Feb 2012 12:57:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1KBv9Hk004009
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330343834.2483@eD8G9j8gJyHVsdLec8Q4+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191063>

Junio C Hamano <gitster@pobox.com> writes:

> Carry on the discussion in a forum where you think the most people with
> appropriate skills and interests hang out, and if that forum is this list,
> that is perfectly fine. Host a development repository at GitHub, Gitorious
> or somesuch, if it would help people stay in sync with the current status
> to have a public repository.

The script is now available here:

  https://gitorious.org/git-latexdiff/git-latexdiff/trees/master

In the meantime, I discovered another script doing essentially the
same : latexdiff-git

  https://github.com/cawka/latexdiff/blob/master/latexdiff-git

My feeling is that the development of latexdiff is stalled (the
author's email included in the script bounces ...), and there are a few
unofficial forks, more or less stalled too.

When I have time, I may try to add the features of my script to
latexdiff-git (written in perl, while latexdiff is already in perl, so
the choice of language is probably better). But that's most likely not
going to happen soon.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
