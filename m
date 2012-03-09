From: demerphq <demerphq@gmail.com>
Subject: Re: git push default behaviour?
Date: Fri, 9 Mar 2012 09:06:18 +0100
Message-ID: <CANgJU+WMxnNgdsP4JV6aAVW07NeWXUa5LsEa4dk5_1CZXC1nXA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com>
	<vpq62efjeqd.fsf@bauges.imag.fr>
	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
	<vpqfwdjas0m.fsf@bauges.imag.fr>
	<20120309033826.GA6164@sigill.intra.peff.net>
	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>
	<7vobs69vwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5uqG-0001TS-Hw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab2CIIGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 03:06:20 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42437 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2CIIGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 03:06:19 -0500
Received: by gghe5 with SMTP id e5so722239ggh.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QotlMYr5Ei8pBZLSNp6jdGCdn+pA8dOKHw2GHUZxqkM=;
        b=KzytlKxIVKKzi/waNGeR6nDEcJaXPFy4LssQQYyRnCX8njSn3hAxmx7MG+DzCaR2+N
         sMi+8oQwH/5wAwdRI2MslJKwTn2TDoPD0FQN+yvmh0LeU/P9j0dtSUE6FCWDJxMdqLgo
         0s0iryCB5ZlWq89g7Ta7HX/6ES6E8mRWLKn0bFtBGz3iLG9Gfmax9bCyNDqKejMBB5XR
         aVHE/9Pgg5qaJR7qADzAVRe/34Dl9M2bJgKyBYzKZuu2Uv3DmOH1fP77qGJK9+a9EXPl
         Po0+PuxeZGw6jwqZLrgIMBp5tvvUqNHfRbdOs5X41+jsvPKzdklAy8dBC0bZ1XxeOZMd
         UB2A==
Received: by 10.236.165.34 with SMTP id d22mr1176117yhl.86.1331280378989; Fri,
 09 Mar 2012 00:06:18 -0800 (PST)
Received: by 10.236.176.1 with HTTP; Fri, 9 Mar 2012 00:06:18 -0800 (PST)
In-Reply-To: <7vobs69vwj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192691>

On 9 March 2012 06:38, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I just dug it up; start from here:
>>
>> =A0 =A0 http://thread.gmane.org/gmane.comp.version-control.git/12335=
0/focus=3D123541
>>
>> read on a few messages downthread, and then jump to the other thread
>> Nana points at in the above message.
>>
>> In short, we started warning that we _might_ change the default
>> someday, without having a clear concensus or plan, that ended up
>> confusing and annoying users without giving them anything good,
>> other than awareness that such a feature is _available_.
>>
>> So no, the conversation did not decide if changing the default was
>> warranted or not. It just confirmed that we weren't anywhere close
>> to deciding back then.
>
> I think MJG's message (the second on in the "git push origin error"
> thread) is probably what we would need to repeat, and this time more
> strongly to squelch the opposition from old timers, if somebody
> wants to resurrect the "warn until you set the default explicitly,
> intending to change the default in the future" patch. And this time
> around, the plan to change the default should be more concrete with
> specific date, e.g. "Starting from April 1st, 2013".
>
> I was in the "keep the default to matching, so that nobody among
> existing 47 million users would be annoyed" camp (back then we
> probably didn't have 47 million users, but that is besides the
> point) and I still am, but notice that I was defending the argument
> by the "let's be ( (new user) friendly )" camp in that thread. And
> without much fire-support from those who were vocal about it.
>
> Re-reading the thread made me sick.
>
> I wish I had enough energy remaining to say "Let's try one more
> time, and hope that people from the 'let's change the default' camp
> will behave much better than the last time", but I do not have high
> hopes, after having been burned once already with exactly the same
> issue.

I think I read all the relevant mails, and I have a thought concerning
what I see to be the class of the problem here: the general question
of "how do you change default behavior if it turns out that the
original choice was inappropriate". It seems to me you can think of
solutions to that problem in general without considering the subject
of this thread.

A possible solution might be to give config files a "format version"
of their own. They already contain a repository format version number,
so add a new variable "ConfigVersionLevel". Alongside that you might
introduce a policy of having new git "fill in" the defaults missing
from the config file whenever it operates, so that people can
explicitly view then all at once. Then if the defaults change in the
future an old repo will continue to work as it did before. This alone
would allow you to change the defaults for existing configurable
behavior, but you need the version number to handle new options.

Once you have that you can change the default behavior based on the
version level so that older users operating in older repositories get
the old behavior, and new repositories get the new behavior. And you
have more flexibility in how your approach these problems when they
come up, and it seems to me that they are inevitable.

Cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
