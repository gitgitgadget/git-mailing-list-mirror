From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] fixup! push: switch default from "matching" to "simple"
Date: Mon, 17 Jun 2013 22:48:03 +0200
Message-ID: <vpqy5a8wjjw.fsf@anie.imag.fr>
References: <1371492079-19283-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vhagwcyqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UogLY-0006xk-F4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab3FQUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:48:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44224 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3FQUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:48:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5HKm1ar001077
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 22:48:01 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UogLM-00045i-1U; Mon, 17 Jun 2013 22:48:04 +0200
In-Reply-To: <7vhagwcyqf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Jun 2013 12:40:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Jun 2013 22:48:02 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228115>

Junio C Hamano <gitster@pobox.com> writes:

> Note that this has to further change if Ram's triangular push fix
> comes before 2.0.

I didn't follow precisely this topic. In any case, better have this in
the patch, if only as a reminder that this part will need to be updated.

> I am not sure if these original two lines are necessary.  Wouldn't
> it more appropriate to just drop the "Without additional configuration"
> and go straight to "The default behaviour of this command..."?

I think it makes sense to avoid having to go through too many sections
to understand the default behavior.

Right now, to know what "git push" does, the reader reads the
DESCRIPTION and finds nothing, reads the <refspec>... part and does not
see what happens when it's omitted, then see the EXAMPLE section

git push
=> see git push origin

git push origin
=> see push.default in git config --help

At least, keeping these lines, we avoid the last indirection.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
