From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: default in-progress color to header color
Date: Mon, 16 Jul 2012 11:59:45 +0200
Message-ID: <vpq8vek10xa.fsf@bauges.imag.fr>
References: <20120714122828.GA6259@sigill.intra.peff.net>
	<20120714123638.GA10431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 12:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqi6f-0000zE-CF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 12:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab2GPKAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 06:00:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55262 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab2GPKAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 06:00:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6G9wCXk001753
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 11:58:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sqi5i-0000fI-SH; Mon, 16 Jul 2012 11:59:46 +0200
In-Reply-To: <20120714123638.GA10431@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 14 Jul 2012 08:36:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 11:58:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6G9wCXk001753
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343037495.79191@3oQVTOddQCRnnWkiLlnLoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201499>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] status: color in-progress message like other header messages

My feeling is that these "in progress" messages would deserve to be more
visible than the usual headers (like "Not currently on any branch.",
which is both legit and likely to be a user-error). For example, the
other day, the patch told me I was bisecting. I thought it was a bug in
the patch, but it was indeed a user-error of mine, I did not end this
bisect session properly around a month ago ;-).

This would argue in favor of having a different, configurable color.

But as the code currently does not allow user-configuration anyway, it's
probably best to make the code clean and uniform. If someone wants to
add customizability afterwards, it won't be that hard (it's probably a
good idea to have people leave with these messages for a while before
deciding what color it should be).

This second patch looks better to me, but no strong opinion here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
