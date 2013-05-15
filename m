From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 20:21:35 +0200
Message-ID: <vpqli7gayts.fsf@grenoble-inp.fr>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
	<7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
	<vpqwqr0azz7.fsf@grenoble-inp.fr>
	<7vppwsazg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 20:22:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcgLe-0007Yj-OC
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038Ab3EOSWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:22:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44305 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945Ab3EOSWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:22:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4FILYkV002975
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 20:21:34 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcgKW-0001zG-5j; Wed, 15 May 2013 20:21:36 +0200
In-Reply-To: <7vppwsazg7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 11:08:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 May 2013 20:21:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FILYkV002975
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369246894.89964@uVc2BL1E76AawPRngWDumQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224438>

Junio C Hamano <gitster@pobox.com> writes:

> Now, realize that after switching the default, these "few people"
> have to live with distracting (or unreadable) output.  Because these
> people are minority, their websearch "disable colors in git" will by
> definition have smaller number of hits than "enable colors in git"
> the above claims people "may not discover it by themselves".

As my message says, "disable colors in git" already gives you the
answer, today (1st hit in Google). I'm not worried about the difficulty
to find the information in the future.

> We should be honest and say what we are doing: "it will make things
> easier for majority while making it less convenient for minority".

I thought this was what I did, but your first complain was I was
mentionning the majority, and you are now suggesting something about
majority/minority, so I'm lost.

In any case, feel free to change the commit message, what's really
important is the actual change, and it does not seem controversial.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
