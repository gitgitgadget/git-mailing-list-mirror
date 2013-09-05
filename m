From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Thu, 05 Sep 2013 08:30:53 +0200
Message-ID: <vpqioyf231e.fsf@anie.imag.fr>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
	<1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
	<vpqa9jtayiq.fsf@anie.imag.fr> <52279ACC.2070308@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 05 08:34:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHT95-00058U-4s
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985Ab3IEGeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:34:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57316 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452Ab3IEGeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:34:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r856Uq4J021607
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 08:30:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHT5h-0004VZ-CM; Thu, 05 Sep 2013 08:30:53 +0200
In-Reply-To: <52279ACC.2070308@web.de> (Jens Lehmann's message of "Wed, 04 Sep
	2013 22:40:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Sep 2013 08:30:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r856Uq4J021607
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378967457.7625@nBMo8ihsO5V5UyhdTtM95g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233935>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.09.2013 08:31, schrieb Matthieu Moy:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>>> Tests are included which verify that this change has no effect on git submodule
>>> summary without the --for-status option.
>> 
>> I still don't understand why this is needed.
>
> To avoid a change in behavior for "git submodule summary", as that
> never honored the submodule.*.ignore nor the diff.ignoreSubmodules
> setting (and I don't think it ever should).

I don't get it. If the goal is to keep the old behavior, then "git
status" shouldn't be changed either. Fixing bugs needs to change the
behavior.

IOW, why was it a bug that "git status" showed ignored submodules and
not a bug that "git submodule summary" did the same?

> Fine by me, what would you propose to clarify that? (Though I have the
> suspicion that the explanation will be three years late ;-)

I have no idea, as I do not understand the reason myself yet. I'm not a
frequent user of submodules and not a user of the ignore option at all,
so I can't tell what's best. I'd just like the new behavior to be
justified somewhere.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
