From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 18:56:17 +0200
Message-ID: <vpqy59zsb0u.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	<vpqsj07vb3m.fsf@anie.imag.fr>
	<7vfvw7bh0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA4H-00050e-HQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab3FXQ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:56:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40254 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433Ab3FXQ4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:56:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OGuF0k002187
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 18:56:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UrA3u-0000tN-4p; Mon, 24 Jun 2013 18:56:18 +0200
In-Reply-To: <7vfvw7bh0u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 09:38:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 18:56:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228873>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> benoit.person@ensimag.fr writes:
>>
>>> diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
>>> new file mode 100644
>>> index 0000000..a2f0aa1
>>> --- /dev/null
>>> +++ b/contrib/mw-to-git/git-mw.perl
>>
>> *.perl scripts are usually executable in Git's tree (although it's
>> usually better to run the non-*.perl version).
>
> Good eyes.  But if we encourage people to run non-*.perl version,
> perhaps we should drop the executable bit from the source, no?

But by default, I'd say consistency is most important so if other *.perl
are executable, we should do the same (otherwise my "ls" shows different
colors and it's ugly ;-) ).

But it may make sense to change the convention, i.e. run a "chmod -x
*.perl" in Git's tree (in any case, people can still run "perl
foo.perl").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
