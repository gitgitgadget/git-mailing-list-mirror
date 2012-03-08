From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 12:54:00 +0100
Message-ID: <vpqeht3qpev.fsf@bauges.imag.fr>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bvk-0002gf-CE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab2CHLyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:54:44 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49830 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686Ab2CHLyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 06:54:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q28BnqgA014673
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Mar 2012 12:49:52 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S5buy-00084O-UX; Thu, 08 Mar 2012 12:54:01 +0100
In-Reply-To: <1331202483.21444.11.camel@beez.lab.cmartin.tk> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Thu, 08 Mar 2012 11:28:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Mar 2012 12:49:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q28BnqgA014673
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331812193.62933@ysCqsuak/kdDpsZDUEgtDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192575>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> On Thu, 2012-03-08 at 10:13 +0000, Jeremy Morton wrote:
>> Right, so I guess I'm saying that the default value for push.default
>> should be upstream instead of matching...
>
> Any default is going to leave some people unhappy. If upstream is the
> right thing for you, then that's what you should use. Most questions =
I
> see about push not doing what the users expect would actually benefit
> from 'current'. 'matching' is a fairly safe default, as it won't try =
to
> push private branches or changes in private branches that track
> something upstream.

There were some discussions about changing the default, and I thought
people agreed that 'upstream' was a better default value for
push.default:

  http://permalink.gmane.org/gmane.comp.version-control.git/167149

it needs to be done with a sane migration path, however, and I guess no
one stepped in to start the process (but I may have missed some further
discussions).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
