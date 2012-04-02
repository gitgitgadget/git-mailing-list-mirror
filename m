From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 19:20:14 +0200
Message-ID: <vpqy5qejbjl.fsf@bauges.imag.fr>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkvg-0008Dp-K2
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab2DBRU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 13:20:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50313 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab2DBRUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 13:20:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q32HEpAo003378
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 19:14:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SEkvP-0004TE-MT; Mon, 02 Apr 2012 19:20:15 +0200
In-Reply-To: <7vlimegjw9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 02 Apr 2012 09:48:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Apr 2012 19:14:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q32HEpAo003378
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333991693.07113@LTuaKateSjLbolItv1UqRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194541>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Obviously the
>>> former is much simpler to explain and understand, as people do not have to
>>> learn upstream tracking before doing their first "push".
>>
>> Again, this is simple only for people who never run "git pull" without
>> argument.
>
> If you are running "git pull" with what to pull and integrate, you know
> system much better than those who only use the canned "git pull without
> argument" settings, so customizing push.default should be easier for you
> than the real beginners whom we try to avoid confusing with the built-in
> default, no?

I don't understand what you mean, sorry.

I'll rephrase my point in case it wasn't clear. My claim is that a
beginner who want to run argumentless "git pull" has to understand where
his changes come from. So, he already has to understand what "upstream
branch" means to Git.

I agree that explaining "push.default=current" is easy alone, but once
you've taught "git pull", explaining that "git push" does something else
and why doesn't seem that easy to me. OTOH, once you understand "git
pull", explaining "push.default=upstream" should be as simple as "send
your changes where git pull would get them".

> Before saying "again", perhaps we should read and think about what the
> other side said.  I think [*1*] raises a good point.

> *1* http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=194470

I think this message precisely supports my claim: we focus the
discussion on "git push", without thinking on the big picture "git pull"
AND "git push". The message you point to does not talk at all about "git
pull".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
