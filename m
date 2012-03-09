From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 09:05:02 +0100
Message-ID: <vpqr4x26vyp.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
	<7vlinbdkb0.fsf@alter.siamese.dyndns.org>
	<vpq1up3aqk8.fsf@bauges.imag.fr>
	<7vty1ydh7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <jeremy@configit.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:05:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5upd-0000nx-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab2CIIFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:05:40 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36622 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab2CIIFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 03:05:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2980r7S018702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Mar 2012 09:00:53 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5uox-0008H5-KD; Fri, 09 Mar 2012 09:05:03 +0100
In-Reply-To: <7vty1ydh7p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Mar 2012 11:29:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Mar 2012 09:00:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2980r7S018702
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331884859.59304@GTJsXyrdBWnwfl9vyz03Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192690>

Junio C Hamano <gitster@pobox.com> writes:

> That is exactly what I said in the parentheses above, isn't it?  The
> danger of "--force" does not have anything to do with which branches
> are pushed.

I disagree. A user may use --force because he has good reason to think
that a branch hasn't been been touched by others, but it's much harder
to guarantee that all branches haven't been touched.

> That does not change the conclusion that current is more suitable
> for shared repository workflow and matching is more (not "equally to
> current") suitable for publishing repository workflow, and we have a
> way for user to tell Git which one is being used in a particular
> project exactly for that purpose.

We're not talking about the same thing. You're talking about how
_appropriate_ a value is, and I'm mentionning how _dangerous_ it can be.

And regardless of the danger, if I look around me, I see almost only
people working with shared archives, and a few projects (including Git,
obviously) using the "one commiter per repository" workflow (I teach Git
to 200 students and several colleagues every year, I've tried teaching
the "one public repository per developer" and it was a complete disaster).

I really think the default should help these people.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
