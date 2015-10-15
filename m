From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Thu, 15 Oct 2015 21:21:53 +0200
Message-ID: <vpq4mhsx7hq.fsf@grenoble-inp.fr>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:22:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmo6k-00073Q-7a
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbbJOTWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:22:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43804 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbJOTWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:22:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9FJLqLF006975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 21:21:52 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FJLrpM025386;
	Thu, 15 Oct 2015 21:21:53 +0200
In-Reply-To: <1444911524-14504-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 21:21:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9FJLqLF006975
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445541716.02023@L465G33mtWxiJtA8FnjBrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279678>

Tobias Klauser <tklauser@distanz.ch> writes:

> + * comments are considered contents to be removed or not. Returns the
> + * number of lines in the resulting buffer.

We write comments at imperative tone, hence "Return", not "Returns".

Other than that, I agree with Junio:

* A preparatory patch introducing parse-options would make the actual
  patch much easier to review.

* Just running strbuf_stripspace and counting the number of lines in the
  result is much simpler. We use stripspace only on user-provided input
  which are never really big so maintainability is more important than
  performance.

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
