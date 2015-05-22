From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule does not yield complete logs")
Date: Fri, 22 May 2015 18:14:07 +0200
Message-ID: <vpqd21slhdc.fsf@anie.imag.fr>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 18:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvpaa-0002oJ-1f
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbbEVQOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:14:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39416 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757136AbbEVQOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:14:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4MGE6J8011588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 May 2015 18:14:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4MGE7Lr031311;
	Fri, 22 May 2015 18:14:07 +0200
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
	(Roberto Tyley's message of "Fri, 22 May 2015 09:33:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 May 2015 18:14:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4MGE6J8011588
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432916049.43275@jU29hI0nOH0XeRG843ZZQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269732>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:
>
> https://submitgit.herokuapp.com/

This is absolutely awsome. A few thoughts after testing the system to
send two patches:

* This is awesome :-). Really.

* I found no way to specify a version like [PATCH v2 ...]. Similarly,
  there could be a way to say [RFC/PATCH ...].

* I'm used to 'git send-email' and I have an alias to add the --signoff
  for me. I just sent a series where I forgot the signed-off-by. The
  system could warn if I didn't signoff.

* I had a text+subject for the pull-request, I was expecting a cover
  letter email with them.

* A simple way to add "below-triple-dash" comments would be cool. For
  now, I guess we can do this by having the --- within the commit
  message.

* The explanation on how to register one's email were unclear to me. It
  told me that I had to register my email without telling how, and that
  I had to send the series to myself before. Once I sent the series to
  myself I got better explanation, hence reversing the order of the
  advices would already be an improvement.

* The link to the original PR could be more visible. For now, I can get
  to the PR by clicking the octocat icon, but perhaps a text "click here
  to view the PR on GitHub" or a link on the whole title would have been
  easier to find.

* I missed a way to specify In-reply-to: to follow up to my previous
  version.

* The submitGit link on the top left does nothing for me. I would expect
  to come back to the home page of submitGit.

* For completess: Junio just noticed in another thread that the patch
  order is reversed, PATCH 2/2 predates PATCH 1/2 and the second is
  In-Reply-To: the first.

* I was about to suggest that you post a comment on the GitHub pull
  request when sending the email, but it is already the case, with a
  link to Gmane. Very very cool.

* Did I mention how awesome the application is already? 'Cause it really
  is!

Thanks a lot for doing this!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
