From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 15:47:21 +0100
Message-ID: <vpqhaxrz1c6.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<vpqhaxrzh2a.fsf@bauges.imag.fr>
	<CAHkcotgMgqr29WEQfiH+89JVbTAAQyLwscXRtTyrf3JRxEuVbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:52:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7pYh-0001YJ-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295Ab2CNOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:52:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50908 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965296Ab2CNOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:52:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2EEgtsd026948
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 15:42:55 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7pU2-0004oC-7x; Wed, 14 Mar 2012 15:47:22 +0100
In-Reply-To: <CAHkcotgMgqr29WEQfiH+89JVbTAAQyLwscXRtTyrf3JRxEuVbA@mail.gmail.com>
	(Dmitry Potapov's message of "Wed, 14 Mar 2012 16:23:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Mar 2012 15:42:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2EEgtsd026948
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332340979.48682@rK/ecnpI3lzTe1eCEP3f+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193119>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Not of course. I said above non-fast forward push should not be used by
> beginners.

Do you mean "beginners should not force non-fast forward push", or
"beginners should not use flow where push may be denied because of
non-fast forward"?

If the second, this implies that beginners should never have a shared
repository, either shared for one user and multiple machines, or shared
between developers?

If you mean that shared repositories are too complex for beginners, my
experience is exactly the opposite.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
