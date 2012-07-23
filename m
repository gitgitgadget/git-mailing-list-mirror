From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 21:46:49 +0200
Message-ID: <vpqwr1ugt06.fsf@bauges.imag.fr>
References: <4514544.Xip1OCQ7Uj@flomedio> <5998541.c9PWeIAsEV@flomedio>
	<vpqr4s2jvhz.fsf@bauges.imag.fr> <1406203.FoHCDc6FfD@flomedio>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOax-0003tM-D9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab2GWTrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:47:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48982 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab2GWTrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:47:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6NJir9E008934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 21:44:53 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1StOag-0004vp-9B; Mon, 23 Jul 2012 21:46:50 +0200
In-Reply-To: <1406203.FoHCDc6FfD@flomedio> (Florian Achleitner's message of
	"Mon, 23 Jul 2012 21:28:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Jul 2012 21:44:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6NJir9E008934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343677498.97973@JWa4VZWMZvm1VItqOQ51hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201968>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> On Monday 23 July 2012 18:24:40 Matthieu Moy wrote:
>> You also have whitespace damages (i.e. line wrapping introduced by your
>> mailer). Using git-send-email avoids this kind of problem (there are
>> also some advices for some mailers in Documentation/SubmittingPatches).
>
> Damn. That's usually no problem with kmail either, if the config is right.
> I've already used git-send-email several times.
> But for replying to threads and adding several Cc: addresses it's a little 
> cumbersome.
> How do you do that in a nice way?

For the threading itself, I usually find the message-id, and use
"git send-email --in-reply-to='<cut-and-pasted-id>'". The painful part
is when you want to reproduce a Cc: list, but I have no magic trick for
that ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
