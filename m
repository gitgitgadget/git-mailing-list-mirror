From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git strangeness
Date: Mon, 23 Aug 2010 19:43:19 +0000
Message-ID: <AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
References: <AANLkTikrJ+hizEicws8PZAry-WOzOYoXAEW9b1L8OYcR@mail.gmail.com>
	<AANLkTim27gLuAwxrNZFmayufF3ctKDU5vmUSN4v4bQPY@mail.gmail.com>
	<AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Perl5 Porteros <perl5-porters@perl.org>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 21:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OncvW-0008Ho-Vk
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 21:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab0HWTnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 15:43:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64627 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0HWTnV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 15:43:21 -0400
Received: by fxm13 with SMTP id 13so3268518fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rjjk/D+4gBQvpAJ0Mr3pUpHfqPCDbizHHuI3BVV/0BA=;
        b=AzxX+wVcldzdafzHGERD3KOl/nFhSgTEwNC0a57mNtZcUgQCFvPCahq8XniEHnHOCr
         FV2MUGEWf0tLQRhnXd9oPh7J4uEjjVMoYm7vuSn58+2hZAk4YkQg2DOkP4vsvJJIHMSm
         pDksb/Y157rUQxO9kdXZsrNmNaRJnEMYf9meY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uJhuhZi4KoKhf1UIBUMyaiTCveuYJ570Of7qUoZ/EqFm6NGCWzTjM8VjEEjpV/tGLd
         TCqMIEj2XzpDMygpWf7qzBRkpjCLEjKadcIH3ejqnxnEOIKq4caLu+XDe6dYvHhK6FdO
         QKtwzglx43cCmaNdR7paC0B4HbRW+0G583ZTs=
Received: by 10.223.115.194 with SMTP id j2mr4945995faq.47.1282592599141; Mon,
 23 Aug 2010 12:43:19 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 23 Aug 2010 12:43:19 -0700 (PDT)
In-Reply-To: <AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154247>

On Mon, Aug 23, 2010 at 19:33, demerphq <demerphq@gmail.com> wrote:
> On 23 August 2010 19:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>> On Sat, Aug 21, 2010 at 11:54, demerphq <demerphq@gmail.com> wrote:
>>> Today I was trying to pull some updates over my wlan connection at =
the
>>> hotel I'm in right now.
>>>
>>> For some reason it repeatedly hung. I tried using the git protocol,
>>> and using ssh, each time it hung at the same point (object transfer=
 -
>>> and after the same number of objects).
>>>
>>> Eventually I opened a tunnel, with control master enabled to camel
>>> (obviously not everybody can do this), and then tried to pull using
>>> the established tunnel. At which point it pulled just fine - and da=
mn
>>> fast.
>>>
>>> Anybody else experienced strangeness like this? Could we have a gli=
tch
>>> somewhere?
>>
>> It would help to clarify what the strangeness is, but obviously you
>> can't debug it *now*.
>>
>> If you have issues like this one useful thing is to try to use the
>> plumbing tools to see if you can reproduce the issue. E.g. use
>> git-fetch, and stuff like git-receive-pack / git-send-pack if you ca=
n.
>
> I actually did use git-fetch. Same thing. It was weird. I had about
> 1200 objects to transfer, after, i think, 345 objects it just hung.
> For minutes, after which i killed it. I tried again, and it hung
> again, etc, and like I said until I had opened a tunnel to camel and
> switched to ssh it huing every time, with ssh as the protocol and wit=
h
> git as the protocol.
>
> I actually still have the repo in unpulled form, so ill try again,
> what exactly should I do to obtain better diagnostics?

To start with, add the Git mailing list to the CC-list, which I've
just done.

I don't know what you should do exactly, but...:

 * If you rsync the perl.git repository from camel to somewhere else
   and use ssh+git to *there* does it still hang? Maybe you can make
   both copies of perl.git available online for others to try?

 * How does it hang? Run it with GIT_TRACE=3D1 <your commands>, What
   process hangs exactly? Is it using lots of CPU or memory in top?
   How about if you strace it, is it hanging on something there?

 * Does this all go away if you you upgrade git (e.g. build from
   master git.git) on either the client or server?

 * If not, maybe run it under gdb with tracing and see where it hangs?

=2E.would seem like good places to start.

>>> Also, I noticed that git-web, or perhaps our config of it, has a
>>> glitch when using pick-axe. It seems to die in mid processing
>>> (probably a timeout) and thus returns broken XML/HTML to the browse=
r,
>>> which in turn inconveniently means that firefox shows an XML error =
and
>>> doesn't show the results that it /has/ found. Im wondering if there=
 is
>>> anything we should do about this?
>>
>> What were you looking at when you got the XML error? There was a
>> recent report about this to the git list and it's been solved upstre=
am
>> IIRC. It was a simple matter of a missing escape_binary_crap()
>> somewhere.
>
> I was doing a pick-axe search for PERL_STRING_ROUNDUP (however it is
> actually spelled), after about 5 minutes the connection terminated an=
d
> resulted in broken output...

What's the gitweb link for that? I'm not familiar with how to make it
do a blame search.
