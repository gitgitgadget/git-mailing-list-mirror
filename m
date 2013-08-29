From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Thu, 29 Aug 2013 08:50:58 +0200
Message-ID: <vpqppsx3s8d.fsf@anie.imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<20130828231326.GA4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 08:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEw4e-0006Vx-4C
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 08:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab3H2GvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 02:51:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48108 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab3H2GvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 02:51:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7T6owtB022137
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 08:50:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEw4I-0004EE-Pv; Thu, 29 Aug 2013 08:50:58 +0200
In-Reply-To: <20130828231326.GA4110@google.com> (Jonathan Nieder's message of
	"Wed, 28 Aug 2013 16:13:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 08:50:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7T6owtB022137
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378363861.01638@IcZG1rpgmIom3VnU30gWBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233237>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>>                                                In the long run, if users
>> like the non-prefix output, it may make sense to flip the default value
>> to true.
>
> Hmm, do you mean that the configuration is to give the change-averse
> some time to get used to the new output?  I think it would make sense
> to do it all at once (and even think that that would be less
> confusing).

The actual reason was that I initially thought the change would be much
more controversial. I wanted to live with the option on for some time to
see how much I liked it, and allow others to do the same without forcing
the change.

If everybody agree that status it better without the comment, and that
the switch does not need a config option, then I'm fine with dropping
the config option.

We can also keep the config option, but document it as a transitional
option only ("the behavior changed in Git XXX, to keep the old behavior,
set this to YYY"). Then it could be status.oldStyle instead.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
