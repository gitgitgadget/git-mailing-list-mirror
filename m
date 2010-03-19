From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 06:43:44 -0600
Message-ID: <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com> 
	<4BA36F5F.9080706@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>, tytso@mit.edu,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsbYm-000327-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0CSMoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 08:44:11 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:50677 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0CSMoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 08:44:09 -0400
Received: by fxm19 with SMTP id 19so547740fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9SkQXqQnJXOwnMI7+1zi5eh77JkSdQz9YUQjedLgSio=;
        b=hEYgm7Jz65dqPQeJRJs3RuyYm7YMNZk143Fd0xkE8HVJwGnNqzrWxabM2w8oq7hcdE
         zAX+6f8CxKTTMNZ0hN2fITAdcIGgbnu7HpyS0b1Dk+oExvhOHdm5D/+67n3CXhX4dL3V
         AaKItjzMwy21XJA64x0w932KWn1INjswShlFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HQdQ5Cli+h0OEZDFDPZDfYXH+JFi8KayW+hU5xrlt4Y/n7pe8/1BcBdnkmuHuVwIBN
         1raY4pbneMLA0qCouZwdeWFC7+pX3w+YGPVhFCfGffolkUR43kiYpue3gNTogqoj5scv
         V5K4zHwaOd4uuLIkblq54UAmPfZdKkpclZ9tY=
Received: by 10.239.182.210 with SMTP id r18mr104819hbg.54.1269002645104; Fri, 
	19 Mar 2010 05:44:05 -0700 (PDT)
In-Reply-To: <4BA36F5F.9080706@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142586>

On Fri, Mar 19, 2010 at 06:34, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 03/18/2010 10:57 PM, Michael Witten wrote:
>>
>> On Thu, Mar 18, 2010 at 16:39, Martin Langhoff
>> <martin.langhoff@gmail.com> =C2=A0wrote:
>>>
>>> On Thu, Mar 18, 2010 at 5:29 PM, Michael Witten<mfwitten@gmail.com>
>>> =C2=A0wrote:
>>>>
>>>> On Thu, Mar 18, 2010 at 16:19, Martin Langhoff
>>>>>
>>>>> What's the value? For me it'll be "Martin Langhoff". I already ha=
ve
>>>>> that.
>>>>
>>>> Well, that's rather egotistical considering you're probably not th=
e
>>>> only Martin Langhoff in this world. I'd advocate something like
>>>> "Martin Langhoff<martin.langhoff@gmail.com>".
>>>
>>> So you are saying we should change the core datamodel of git to say=
=2E..
>>> what we already can say?
>>
>> You see, Martin, you might want/need to stop using "Martin Langhoff
>> <martin.langhoff@gmail.com>" as your email account, but there's no
>> reason why you can't continue to use it for your UUID.
>
> While a gnu.org or gmail.com will (most likely) stay with some person
> forever, hindsight is 20/20 and many people may generate his UUID fro=
m a
> work email. =C2=A0So, suppose I make my UUID based on <pbonzini@redha=
t.com> what
> will guarantee that in 20 years I won't find a new career as a barten=
der,
> and Red Hat wouldn't hire someone with my same name, and give him the=
 same
> email address?

=46irstly, the UUID need not be a name/email pair.

Secondly, you're being ridiculous; even if that ridiculous scenario
played out not-infrequently, there would still be less identity
confusion in git repos over time, because changing real life names,
and changing email accounts do happen frequently and are not
ridiculous events.

> Heck, some people use gmail only for their personal email, and they r=
ightly
> cannot be bothered to create another account to solve a problem they =
don't
> understand and they probably do not have.

This doesn't make any sense. Why does anybody need to create another
account? Are you still confused about what a uuid is this context?

> For the UUID to make sense, it would need to be what the acronym says=
:
> universally unique. =C2=A0An SHA-1 value is _not_ universally unique,=
 it is just
> a one-way function. =C2=A0There are tons of git repos out there with =
a blob
> hashing to e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 or
> 257cc5642cb1a054f08cc83f2d943e56fd3ebe99.

The SHA-1 is supposed to be an optimization; it's not essential, as
I've already explained; I also get the feeling that you're being
ridiculous again. In particular, I don't see your point.

> I have an idea. =C2=A0Start your own website uuidemail.com. =C2=A0One=
 registers and
> gets an alias for their email, something like
> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b@uuidemail.com. =C2=A0Then pe=
ople can
> start using
> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b+pbonzini--redhat.com@uuidema=
il.com
> as their git user.email. =C2=A0I bet nobody will.

This is nonsense that betrays your misunderstanding.
