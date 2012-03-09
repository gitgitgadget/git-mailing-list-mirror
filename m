From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 09:25:59 +0100
Message-ID: <vpqobs65gfc.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
	<vpqfwdjas0m.fsf@bauges.imag.fr>
	<20120309033826.GA6164@sigill.intra.peff.net>
	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:26:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5vA6-0003rU-Re
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2CII0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:26:50 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60122 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196Ab2CII0t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 03:26:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q298LnbE022974
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Mar 2012 09:21:49 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5v9E-0000DI-DF; Fri, 09 Mar 2012 09:26:00 +0100
In-Reply-To: <7vsjhi9wku.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Mar 2012 21:23:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Mar 2012 09:21:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q298LnbE022974
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331886114.21396@zr7yUuMX+yhkqa2bG42EBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192693>

Junio C Hamano <gitster@pobox.com> writes:

> I just dug it up; start from here:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541

That's an old discussion. A more recent one is here:

  http://thread.gmane.org/gmane.comp.version-control.git/166743

(interleaved with a discussion about tag namespace, but the end of the
message is about push.default)

In this discussion, you (Junio) proposed a patch and argued exactly in
the direction I do right now. I think the discussion stopped here:

  http://thread.gmane.org/gmane.comp.version-control.git/166743

(i.e. "Care to roll an appliable patch?", which I guess everyone has
been too lazy to do)

Patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
