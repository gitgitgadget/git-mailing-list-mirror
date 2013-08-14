From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 09:28:24 +0200
Message-ID: <vpqsiycn33b.fsf@anie.imag.fr>
References: <20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
	<CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
	<20130812123921.GA16088@sigill.intra.peff.net>
	<CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
	<20130812154520.GA18215@sigill.intra.peff.net>
	<CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
	<20130813114635.GA16506@sigill.intra.peff.net>
	<7vsiydy2i1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VVo-0008Am-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759165Ab3HNH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:28:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47918 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757923Ab3HNH2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:28:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7E7SOFJ009800
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Aug 2013 09:28:26 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9VVI-0006l4-TF; Wed, 14 Aug 2013 09:28:24 +0200
In-Reply-To: <7vsiydy2i1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Aug 2013 09:33:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Aug 2013 09:28:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7E7SOFJ009800
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377070108.71482@s7aAwzcwssWrrxuehAJRNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232268>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I guess we could do something like:
>>
>>   [include "repo:...your regex here..."]
>>     path = .gitconfig-only-for-some-repos
>>   [include "env:USE_MY_MAGIC_CONFIG"]
>>     path = .gitconfig-only-when-magic-env-set
>
> I am not sure if "env" is very useful, but there certainly are other
> possibilities (e.g. apply this only on this host, only for members
> of this UNIX group, etc.)

I have already wished I had "git version >= XXX" here (but that's tricky
to implement).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
