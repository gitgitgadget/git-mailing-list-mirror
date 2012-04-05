From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not make sense
Date: Thu, 05 Apr 2012 22:24:06 +0200
Message-ID: <vpqsjgi53mh.fsf@bauges.imag.fr>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
	<20120405124706.GA3921@sigill.intra.peff.net>
	<7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
	<20120405184345.GA6448@burratino>
	<7vlima5591.fsf@alter.siamese.dyndns.org>
	<7vhawy54nd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtEF-0002Kk-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab2DEUYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:24:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53883 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038Ab2DEUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:24:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q35KImSn028943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 22:18:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SFtDz-0005uf-LA; Thu, 05 Apr 2012 22:24:07 +0200
In-Reply-To: <7vhawy54nd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 05 Apr 2012 13:01:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Apr 2012 22:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q35KImSn028943
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334261929.36777@eL8zpFMV15L9f7NWp+B7bg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194806>

Junio C Hamano <gitster@pobox.com> writes:

>  		die(_("You are pushing to remote '%s', which is not the "
> -		      "upstream of your\ncurrent branch '%s'.\n"),
> +		      "upstream of your\ncurrent branch '%s',\n"
> +		      "without telling me to push which local branch to\n"
> +		      " update which remote branch with."),

Sounds overly complex sentence to me. "without telling me what to push"
sounded good enough without being long, so I prefered it.

I like accompanying these messages with the way out for the user, so
perhaps we can add stg like

"To push the current branch to this remote, run:

  git push <remote> <branch>

"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
