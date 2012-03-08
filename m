From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 16:26:34 +0100
Message-ID: <vpq62efjeqd.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:27:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fFq-0007uy-4T
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab2CHP1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 10:27:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58220 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764Ab2CHP1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 10:27:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q28FMQ7g000994
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Mar 2012 16:22:26 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5fEh-0004du-B3; Thu, 08 Mar 2012 16:26:35 +0100
In-Reply-To: <4F58C977.8000400@xiplink.com> (Marc Branchaud's message of "Thu,
	08 Mar 2012 10:00:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Mar 2012 16:22:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q28FMQ7g000994
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331824947.77383@T9CYNIIbOpmTo1L8JLB/ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192608>

Marc Branchaud <marcnarc@xiplink.com> writes:

> I agree with Jeremy that the default is dangerous, or at the very
> least surprising.

Yes, --force is not the only problem. Getting constant non-fast forward
errors just because you have out-of-date local ref is annoying, and
really, really confusing.

'push.default = matching' is never a good idea if you use shared
repository actually. It makes sense for people like Junio pushing a
local repository to a public one, which is read-only for the rest of the
world. But my experience is that people using such workflow are advanced
users, and would know how to configure Git, so it wouldn't really harm
them to change the default.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
