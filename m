From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 08:47:09 +0200
Message-ID: <vpqmx4orgnm.fsf@bauges.imag.fr>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7v4nqy4wrz.fsf@alter.siamese.dyndns.org>
	<20120530130914.Horde.CK7IZHwdC4BPxf-ak9fkbPA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu May 31 08:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZzAO-0005Jb-Ul
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab2EaGrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:47:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41075 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2EaGrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:47:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4V6coDB022513
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:38:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZzA6-0002SV-Hg; Thu, 31 May 2012 08:47:10 +0200
In-Reply-To: <20120530130914.Horde.CK7IZHwdC4BPxf-ak9fkbPA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Wed, 30 May 2012 13:09:14
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 08:38:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V6coDB022513
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339051131.78091@Pe3zLEOvT3RbMtn1fEOtkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198866>

konglu@minatec.inpg.fr writes:

> Yes, we first thought that we could use statusHints to protect the
> new messages warnings. But users that disabled statusHints and still
> wished to know what to do during am/rebase/bisect etc.

I don't think you should worry too much about people who already set
statusHints. By definition, they are people who read the documentation,
which already disqualifies them as "newbies". If you show the state
unconditionally, and just hide the commands, then at worse, they will
have to read the doc again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
