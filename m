From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Thu, 05 Sep 2013 10:05:41 +0200
Message-ID: <vpqob87zoa2.fsf@anie.imag.fr>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
	<1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
	<vpqa9jtayiq.fsf@anie.imag.fr> <52279ACC.2070308@web.de>
	<vpqioyf231e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 05 10:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHUeD-0004mq-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 10:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab3IEIJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 04:09:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40732 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763483Ab3IEIJC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 04:09:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8585ern008070
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 10:05:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHUZR-0005Nu-C0; Thu, 05 Sep 2013 10:05:41 +0200
In-Reply-To: <vpqioyf231e.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	05 Sep 2013 08:30:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Sep 2013 10:05:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8585ern008070
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378973142.16963@AEozhSZOD35wYDxFFtqjiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233940>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Fine by me, what would you propose to clarify that? (Though I have the
>> suspicion that the explanation will be three years late ;-)
>
> I have no idea, as I do not understand the reason myself yet. I'm not a
> frequent user of submodules and not a user of the ignore option at all,
> so I can't tell what's best. I'd just like the new behavior to be
> justified somewhere.

I also think that the documentation in Documentation/config.txt could be
updated. Perhaps adding something like

	To view the summary for submodules ignored by 'git status', one
	can use 'git submodules summary' which shows a similar output
	but does not honor this option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
