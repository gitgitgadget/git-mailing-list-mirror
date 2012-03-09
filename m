From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 12:54:10 +0100
Message-ID: <vpq8vjavvkt.fsf@bauges.imag.fr>
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
	<vpqr4x26vyp.fsf@bauges.imag.fr>
	<7vipie85nk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <jeremy@configit.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 12:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5yPM-0004ka-CC
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 12:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab2CILyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 06:54:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55486 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab2CILyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 06:54:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q29Bo0Ws002121
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Mar 2012 12:50:00 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5yOh-0006If-Sz; Fri, 09 Mar 2012 12:54:11 +0100
In-Reply-To: <7vipie85nk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Mar 2012 01:50:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Mar 2012 12:50:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q29Bo0Ws002121
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331898603.46196@xgEi3xpHNgDwFnO3AMYSbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192712>

Junio C Hamano <gitster@pobox.com> writes:

>> to 200 students and several colleagues every year, I've tried teaching
>> the "one public repository per developer" and it was a complete disaster).
>
> Interesting.  I have a couple of questions.
>
> Who are these 200 people and what do they do with Git?  If the
> answer is "They work on a class assignment project, 20 teams of 10
> members each",

Teams are smaller, but that's essentially that, yes. I'm not saying it's
representative, my point just that I do have experience teaching Git to
new users.

> I am also curious to learn a bit more about "a complete disaster",

There are several points:

* It is often the case that one of the member of a team is more
  knowledgeable than others. Then, this user can set up a shared
  archive, and other users do not have to. When your project is
  open-source, it's rather easy to click GitHub's web interface and
  create a fork, but when it's a private project (and you don't want to
  pay), you have to do some kind of magic with ACLs or so to create a
  new repository. Doing this magic just once saves a lot of trouble.

  In practice, when working with colleagues (all being computer
  scientists), if I don't set up a shared repository, they just send me
  their files (yes, their files, not their patches :-( ) by email and
  ask me to do merges if needed.

* Users like to know where "the latest version" is. They are already
  confused by the fact that the last local revision may not be the same
  as the last remote one, and having multiple public repositories adds
  to the confusion.

> even though this question (and its answer) would not be directly
> relevant to this topic, as nobody is trying to convert projects to
> use the "publish to be pulled" model when the "push to the shared
> central repository" model is more appropriate for them.

Sure. I'm not saying in any way that the "shared repository" is
superior. Just that it's easier to grab for newbies.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
