From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 16:06:44 +0200
Message-ID: <AANLkTikDcZRHpKp9phlThK5x-8A0OfTYIlhGkqookiFj@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
	<AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:06:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdja-0008Ly-FO
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab0E0OGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 10:06:47 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:57168 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0E0OGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 10:06:46 -0400
Received: by wyb36 with SMTP id 36so201830wyb.11
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=51C6qG7T5UdO73Gv/Z3vHyzjH4bf4nNI8kZbAG5Wmdk=;
        b=FZHyuU8iNsUVk/G1zhRAKgcepIBmw9JTgo38CxO+MC74n7KPe3XnWZiMuR+T0Axirw
         y4CxtsKToekIicH/dtd2gqV03cFA/QEW+HsjkvtYs7xHdyK9/OGgTpmiUrx5mf2zU7to
         q8AaXdtI4ErcLS1ihz4/FpwnE0/1KkTVQcf40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Bjk4VyItgmIO+EecK7ckJlwfW0Oyv53pPEuwv+kZsmyptZKaWB7eHTru7Smac/ZfGp
         CJq6sbYhG7TPZqQdKLorkIQ/8tCH5gaORkz/qMNfLJ27jV4eR+RdrOt98rarn4PJZOII
         9PX7i3z4qYrBomdWJz2Iki4Ak3H8LvcVWLqxo=
Received: by 10.216.91.3 with SMTP id g3mr70942wef.101.1274969204301; Thu, 27 
	May 2010 07:06:44 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 07:06:44 -0700 (PDT)
In-Reply-To: <AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147859>

On Thu, May 27, 2010 at 3:58 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.com> wro=
te:
>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> =A0>> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>> =A0>> =A0<kusmabite@googlemail.com> wrote:
>> =A0>> =A0> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnied=
er@gmail.com> wrote:
>> =A0>> =A0>> Implement the subset of poll() semantics needed by git i=
n terms of
>> =A0>> =A0>> select(), for use by the Interix port. =A0Inspired by co=
mmit 6ed807f
>> =A0>> =A0>> (Windows: A rudimentary poll() emulation, 2007-12-01).
>> =A0>> =A0>>
>> =A0>> =A0>
>> =A0>> =A0> A possible problem with this approach is that the maximum=
 number of
>> =A0>> =A0> file descriptors poll can handle limited by RLIMIT_NOFILE=
, whereas the
>> =A0>> =A0> maximum number of file descriptors select can handle is l=
imited by
>> =A0>> =A0> FD_SETSIZE.
>> =A0>> =A0>
>> =A0>> =A0> I don't think this is a big problem in reality, though - =
both values
>> =A0>> =A0> seem to be pretty high in most implementations. And IIRC =
git-daemon is
>> =A0>> =A0> the only one who needs more than 2, and it doesn't even c=
heck
>> =A0>> =A0> RLIMIT_NOFILE.
>> =A0>> =A0>
>> =A0>>
>> =A0>>
>> =A0>> To be clear: I think this strategy is the best option (at leas=
t for
>> =A0>> =A0non-Windows, where select() might be our only option).
>> =A0>>
>> =A0>> =A0But perhaps you should include a check along the lines of t=
his:
>> =A0>>
>> =A0>> =A0if (nfds > FD_SETSIZE)
>> =A0>> =A0 =A0 =A0 =A0 return errno =3D EINVAL, error("poll: nfds mus=
t be below %d", FD_SETSIZE);
>> =A0>>
>> =A0>> =A0Just so we can know when the code fails :)
>> =A0>
>> =A0> Well, per your own FD_SET example, the FD_SETSIZE on windows
>> =A0> means different thing than FD_SETSIZE on old-style bitmap-based
>> =A0> select() implementation.
>> =A0>
>> =A0> On Unix, it's max fd number + 1, on windows it's max count.
>> =A0>
>>
>>
>> Are you sure this applies for all Unix, not just some given Unix-y s=
ystem?
>
> Not sure. =A0Just pointing out that the above check is not
> universal enough.
>

Isn't it? How could one possibly pass more than max fd number + 1 file
descriptors, since they start at 0? I guess one could specify a given
fd more than once, but that'd be kind of redundant... and also very
unlikely in our case ;)

--=20
Erik "kusma" Faye-Lund
