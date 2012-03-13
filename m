From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Tue, 13 Mar 2012 10:47:11 +0100
Message-ID: <vpqwr6o3k9s.fsf@bauges.imag.fr>
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
	<vpqmx7mcgdz.fsf@bauges.imag.fr>
	<7vk42pu6io.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 10:48:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7OKv-0003Mm-K4
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068Ab2CMJsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:48:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43075 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965037Ab2CMJsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:48:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2D9gn9p014586
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 10:42:49 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7OK0-0004Dj-En; Tue, 13 Mar 2012 10:47:12 +0100
In-Reply-To: <7vk42pu6io.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Mar 2012 09:29:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 13 Mar 2012 10:42:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2D9gn9p014586
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332236571.36421@yEdBBFS37UbFgMJX6sDV1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192994>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Here's an attempt to an improved message. The first paragraph is here to
>> make sure people understand their opinion counts (before they stop
>> reading because it's too long). The rest explains the change and the way
>> to get involved:
>
> Sounds OK from a cursory read, except for a few minor details.
>
> Thanks.  Nitpicks follow.

I'm taking them all. Here's the result:

---------- 8< ---------- 8< -----------

There is a proposal to change the default behaviour of 'git push'
on the Git mailing list. The goal of this message is to encourage you
to discuss it before it happens (or the change is aborted, depending
on the outcome of the discussion).

In the current setting (i.e. push.default=matching), 'git push' without
argument will push all branches that exist locally and remotely with the
same name. This is usually appropriate when a developer pushes to his
own public repository, but may be confusing if not dangerous when using
a shared repository. The proposal is to change the default to
'upstream', i.e. push only the current branch, and push it to the branch
'git pull' would pull from. Another candidate is 'current'; this pushes
only the current branch to the remote branch of the same name.

For more details on the behavior of Git with these values, read
the documentation about 'push.default' in 'man git-config'
(http://schacon.github.com/git/git-config.html).

You may be negatively affected when such a change happens if you do not
see anything in the output from 'git config push.default' and if you
rely on the default that pushes all your matching branches. On the other
hand, you may want to see the

default behaviour to change, especially if you are using shared
repositories. In either case, please join the discussion to give
us more data point and help us decide the future of Git.

What has been discussed so far can be seen in this thread:
http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694
Previous relevant discussions include:
http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541
http://thread.gmane.org/gmane.comp.version-control.git/166743

To join the discussion, send your messages to: git@vger.kernel.org
The list accepts messages from non-subscribers, and you do
not have to ask "please Cc me, I am not subscribed", as it's
customary to Cc: posters when replying on this list.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
