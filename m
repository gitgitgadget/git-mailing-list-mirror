From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 23:16:55 +0200
Message-ID: <vpqd37pbzqw.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
	<vpqy5qejbjl.fsf@bauges.imag.fr>
	<7vobraf057.fsf@alter.siamese.dyndns.org>
	<vpqwr5ydkqt.fsf@bauges.imag.fr>
	<7vzkatex02.fsf@alter.siamese.dyndns.org>
	<vpqiphhdfzw.fsf@bauges.imag.fr>
	<CANgJU+V57Yz2FXStsYtL38td7FLR=ihaKzvbOBqzbR=qEFgESw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 23:17:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoci-0007ZA-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 23:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab2DBVRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 17:17:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33309 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab2DBVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 17:17:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q32LBkCm023304
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 23:11:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SEocS-0006zg-Iq; Mon, 02 Apr 2012 23:16:56 +0200
In-Reply-To: <CANgJU+V57Yz2FXStsYtL38td7FLR=ihaKzvbOBqzbR=qEFgESw@mail.gmail.com>
	(demerphq@gmail.com's message of "Mon, 2 Apr 2012 23:02:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Apr 2012 23:11:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q32LBkCm023304
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334005908.97785@qgc2V+1jspqb3MH5bvT+sw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194565>

demerphq <demerphq@gmail.com> writes:

> And actually I find your use of "git pull" and "pull" in the
> expression "pull from a branch other than one with the same name"
> confusing. Barring misconfiguration pull operates on only one local
> branch and it is usually the one with the same name. However push
> operates on multiple local branches.

It does with push.default = matching, but with either options we are
discussing here, argumentless "git push" would push only one branch.
The choice we have is whether to push to the branch with the same name,
or to the branch from which "git pull" would take the changes.

(I realize that in this discussion, "current" may be misleading. I mean
"push.default=current", not "the behavior we have currently")

> Lastly I have never really encountered any confusion with explaining
> the default behaviour of git-fetch, nor actually git-pull, but I have
> encountered lots of confusion of people using git-push.  They expect
> git-push to be the opposite of git-pull not git-fetch.

I do also expect "git pull" to be symmetrical to "git pull", and
"push.default=upstream" is the closest to symmetry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
