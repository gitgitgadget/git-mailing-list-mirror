From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 19:56:44 +0200
Message-ID: <vpqwqr0azz7.fsf@grenoble-inp.fr>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
	<7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 19:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfxC-0004Zj-PC
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977Ab3EOR5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:57:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44490 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759876Ab3EOR5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:57:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4FHugxE027716
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 19:56:42 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcfwS-0001Us-S5; Wed, 15 May 2013 19:56:44 +0200
In-Reply-To: <7v8v3gcfk1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 10:34:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 May 2013 19:56:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FHugxE027716
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369245408.25372@X/kokMyg5dEKIJWWHdKTSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224433>

Junio C Hamano <gitster@pobox.com> writes:

> I think you are missing the entire point, which is not "is anyone
> harmed?"

Again, it is. If the new default is really harmful for too many people,
then documentations will have to mention how to fix it.

And really, I do not forsee any newbie-oriented starting with "here's
how to disable colors in case you need it", because of the reasons
mentionned in the message.

> Our recommendation has been "use color=auto"

Not really. Neither Documentation/gittutorial.txt nor
Documentation/user-manual.txt mention colors. Pro Git mentions it, but
more as a possibility than as a recommandation. This is the
recommandation of the rest of the world, not "ours".

It's not "either we update the docs or we update the code", it's "follow
what the rest of the world is doing", and "rest of the world" has to
imply a notion of majority (not all tutorials talk about color.ui).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
