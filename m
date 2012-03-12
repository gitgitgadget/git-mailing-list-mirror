From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Mon, 12 Mar 2012 10:34:00 +0100
Message-ID: <vpqmx7mcgdz.fsf@bauges.imag.fr>
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
	<vpqobs65gfc.fsf@bauges.imag.fr>
	<7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 10:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S71eW-0008VP-DO
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 10:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab2CLJes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 05:34:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38881 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab2CLJeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 05:34:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2C9TfZJ020230
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 10:29:41 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S71dh-0004G0-D7; Mon, 12 Mar 2012 10:34:01 +0100
In-Reply-To: <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Mar 2012 01:57:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Mar 2012 10:29:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2C9TfZJ020230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332149386.23216@ZZlaIGPAcyjfzN2IPDlmrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192849>

Junio C Hamano <gitster@pobox.com> writes:

> I can send a message saying "There is a proposal to change the
> default behaviour of 'git push' on the Git mailing list, and you may
> be negatively affected if you do not see anything in the output from
> 'git config push.default' when such a change happens. On the other
> hand, you may want to see the default behaviour to change. In either
> case, please join the discussion to give us more data point and help
> us decide the future of Git." to the kernel list. Anybody could, for
> that matter.

Here's an attempt to an improved message. The first paragraph is here to
make sure people understand their opinion counts (before they stop
reading because it's too long). The rest explains the change and the way
to get involved:

---------- 8< ---------- 8< -----------

There is a proposal to change the default behaviour of 'git push'
on the Git mailing list. The goal of this message is to encourage you
to discuss it before it happens (or the change is aborted, depending
on the outcome of the discussion).

In the current setting (i.e. push.default=matching), 'git push' without
argument will push all branches that exist locally and remotely with
the same name. This is usually appropriate when a developer pushes to
his own public repository, but confusing if not dangerous when using a
shared repository. The proposal is to change the default to
'upstream', i.e. push only the current branch, and push it to the
upstream branch (the one 'git pull' would pull from). 'current' is
another candidate.

For more details on the behavior of Git with these values, read
the documentation about 'push.default' in 'man git-config'
(http://schacon.github.com/git/git-config.html).

You may be negatively affected when such a change happens if you
do not see anything in the output from 'git config push.default'
and if you rely on the fact that 'git push' pushes all your
matching branches. On the other hand, you may want to see the
default behaviour to change, especially if you are using shared
repositories. In either case, please join the discussion to give
us more data point and help us decide the future of Git.

To join the discussion, send your messages to: git@vger.kernel.org
You don't need to subscribe the list to post, and it's customary to
Cc: posters when replying on this list.
To view the current discussion, see this thread:
http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
