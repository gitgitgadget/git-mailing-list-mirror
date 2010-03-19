From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 06:08:04 -0600
Message-ID: <b4087cc51003190508m3651e929w2dc16156a84d09f@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> 
	<b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> 
	<alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 19 13:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsb0C-0003w5-IU
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0CSMI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 08:08:27 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:41663 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0CSMI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 08:08:26 -0400
Received: by fxm19 with SMTP id 19so520282fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oo7okREigSppCrVFD3YU6d0PLNVOVaef307aoEtxBJw=;
        b=yHvzE0ta6th7fpAo1IVvOHafLLhHoSwW9wRS/td5EqDyJASYmIIyoGlUqvVmWpxJaj
         4GU3yx768NhWp6BpBx0rgBuDgRYZ4ip2/eooBj1vVg+lZRey5fS6Ic9Epgm2ztWz06lS
         lLoHZ882MmR79qkpGJ+0rhzOgR6LNHI30guaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ulhj7cWdYjADJY7iTPp6AwD/J0igxOVHgZRdUn9lCc6rj2tjvx5vO06X09/Q62edK3
         MQ0y0EMw46ZCOVBvpW6wC7v3ulNl0SKca+hsEXWKFo9L26vrHVNAZt7rnyAmJHvLkBtP
         s4xq3NgUP7rLzUt2Q9dVr+2Pkwua98lXBhe7g=
Received: by 10.239.191.194 with SMTP id c2mr1570953hbi.169.1269000504710; 
	Fri, 19 Mar 2010 05:08:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142578>

On Fri, Mar 19, 2010 at 05:45,  <david@lang.hm> wrote:
> On Fri, 19 Mar 2010, Michael Witten wrote:
>
>> On Fri, Mar 19, 2010 at 02:41, Michael Haggerty <mhagger@alum.mit.ed=
u>
>> wrote:
>>>
>>> Michael Witten wrote:
>>>>
>>>> Rather than use a (name,email) pair to identify people, let's use
>>>> a (uuid,name,email) triplet.
>>>> [...]
>>>
>>> A UUID doesn't need to be a big hex number. =C2=A0All it has to be =
is a
>>> "Universally Unique Identifier". =C2=A0Like, oh, for example, your
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *** =
EMAIL ADDRESS ***
>>>
>>> [1]. =C2=A0There is even already a way to fix up mistakes or unavoi=
dable
>>> email address changes, namely the .mailmap file.
>>
>> *facepalm*
>>
>> You've just repeated everything that I've said; go look at the rest =
of
>> the thread, where I spend plenty of time correcting the same hangups
>> about my choice of the word UUID and my use of hex digits.
>>
>> I'm only observing that the current name/email system pair conflates
>> an individual with his current email system and that it would be
>> worthwhile to ALLOW an individual to FURTHER describe himself by
>> including another piece of information that is solely meant as
>> identification within git. That piece of information could be whatev=
er
>> a user deems to be uniquely identifying for himself. You could use
>> "Michael Haggerty <mhagger@alum.mit.edu>" as your uuid, and you coul=
d
>> still use it after you change the `email' config variable to somethi=
ng
>> else.
>>
>> There is MUCH LESS CHANCE of such a uuid getting trashed by typos,
>> changing names, and changing email addresses; of course it can still
>> get messed up, but the rate at which something like .mailmap would
>> need to be updated would likely be greatly decreased and it would ma=
ke
>> gathering statistics easier (especially for the individuals who take
>> advantage of such a uuid for describing themselves---and it only
>> requires setting one config variable to something easily remembered =
by
>> that person).
>
> here is where you are missing the point.
>
> no, there is not 'much less chance' of it getting messed up.
>
> you seem to assume that people would never need to set the UUID on mu=
ltiple
> machines.

I covered that in the first email, highlighting the importance of
using an easily remembered, already reasonably unique piece of
information (like a name/email pair) that you don't need to change.

> if they don't need to set it on multiple machines, then the e-mail/us=
erid is
> going to be reliable anyway

The problem is that the name/email pair (as in the 'name' and 'email'
config variables) is NOT ONLY subject to typos, but it is ALSO subject
to changing email accounts and changing real life names.

If you don't use the uuid `field' that I propose, then everything
would be just like it was before. If you do use it, then you can
easily identify all of your own contributions regardless of what your
name/email du jour is.

> if they do need to set it on multiple machines and can't be bothered =
to keep
> their e-mail consistant, why would they bother keeping this additiona=
l thing
> considtant? Linus is pointing out that people don't care now about th=
eir
> e-mail and name, and will care even less about some abstract UUID

The user doesn't have a damn choice!

The email can't be kept consistent over time because the tools expect
it to be and/or use the actual physical email used to send/receive
stuff. It's information that CONFLATES identity with whatever
tool/system you're using.

=46or instance, Michael Haggerty cannot reasonably use

    [user]
        name  =3D Michael Haggerty
        email =3D mhagger@MIT.EDU

because he likely no longer has that email account to use. He is
forced to change it and therefore forced to make his identity
confused.

I'm proposing ALLOWING him to say:

    [user]
        uuid  =3D Michael Haggerty <mhagger@MIT.EDU>
        name  =3D Michael Haggerty
        email =3D mhagger@ALUM.mit.edu

Heck, let's say he works at Red Hat as well; he might make some
commits under this config AT WORK:

    [user]
        uuid  =3D Michael Haggerty <mhagger@MIT.EDU>
        name  =3D Michael Haggerty
        email =3D mhagger@redhat.com

Then, he can make, say, commits to the Linux kernel repo for both work
and hobby related issues and still be recognized as the same person.
That is, he can have some commits under "Michael Haggerty
<mhagger@ALUM.mit.edu>" and other commits under "Michael Haggerty
<mhagger@redhat.com" and still link them all together as the same
identity with just the uuid "Michael Haggerty <mhagger@MIT.EDU>".

Sincerely,
Michael Witten
