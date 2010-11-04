From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 11:15:05 +0100
Message-ID: <AANLkTik=hwAmB4Ha74pqgR-cDW87GnATEpfVFDCfEHks@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
 <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
 <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com>
 <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com>
 <alpine.DEB.2.00.1011041053120.31519@cone.home.martin.st> <AANLkTimzS1tnykzjoywaLdBUi4zhwzUC6bght0-vnaGO@mail.gmail.com>
 <alpine.DEB.2.00.1011041118200.31519@cone.home.martin.st>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:15:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwqz-00040k-2G
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab0KDKP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 06:15:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62564 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab0KDKP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 06:15:26 -0400
Received: by fxm16 with SMTP id 16so1282612fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=381U5/3okRD0H3Tp5GnqHaHFTE80izolGxNOH5TVb34=;
        b=nU0QP8PRHvK6wJLJF8foPVNXaV6MtGol0VEkXsN2WZ3OcG9mP9f0QpEM2MEt6w22Jw
         F+jKTg4hFELrtWzONGsA5VCDvGRbzt3AasmpN9R+U9SDdcR+IwnYk/rdj56WHo25qMIO
         2Igk+6IKP5icWP5aG4qeYUA723cCSOMmb7SRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Wbq2VsSEl8KSEM/gqcuJX0upMbFsbISznMxy88RObu0jWKIkArHNoyvhH1tH5Oz4J+
         sAB4057IkvK7jD5RgwBHTA6rtGHtgEJjLDrja/uKNtLPXLu5X2CfhwNcY2q2HA5uZ2ca
         Ux+DhyrXt5icuXknnXNT1wI+Aw0y/zt8cm0iA=
Received: by 10.223.89.142 with SMTP id e14mr443399fam.143.1288865725249; Thu,
 04 Nov 2010 03:15:25 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Thu, 4 Nov 2010 03:15:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1011041118200.31519@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160711>

On Thu, Nov 4, 2010 at 10:35 AM, Martin Storsj=C3=B6 <martin@martin.st>=
 wrote:
> On Thu, 4 Nov 2010, Erik Faye-Lund wrote:
>
>> On Thu, Nov 4, 2010 at 9:58 AM, Martin Storsj=C3=B6 <martin@martin.s=
t> wrote:
>> > On Thu, 4 Nov 2010, Erik Faye-Lund wrote:
>> >
>> >> On Thu, Nov 4, 2010 at 1:06 AM, Erik Faye-Lund <kusmabite@gmail.c=
om> wrote:
>> >> >
>> >> > Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when bu=
ilt
>> >> > with IPv6 support) in a union and passing that around instead d=
oes
>> >> > seem to fix the issue completely. I don't find it very elegant,=
 but
>> >> > some google-searches on the issue seems to reveal that this is =
the
>> >> > only way of getting rid of this. Any other suggestions, people?
>> >> >
>> >>
>> >> Just for reference, this is the patch that fixes it. What do you =
think?
>> >>
>> >> diff --git a/daemon.c b/daemon.c
>> >> index 941c095..8162f10 100644
>> >> --- a/daemon.c
>> >> +++ b/daemon.c
>> >> @@ -902,9 +903,15 @@ static int service_loop(struct socketlist *s=
ocklist)
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i =
< socklist->nr; i++) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (pfd[i].revents & POLLIN) {
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr_storage ss;
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct s=
ockaddr sa;
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct s=
ockaddr_in sai;
>> >> +#ifndef NO_IPV6
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct s=
ockaddr_in6 sai6;
>> >> +#endif
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } ss;
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int sslen =3D sizeof(ss=
);
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int incoming =3D accept(pfd[i].fd, (=
struct sockaddr *)&ss, &sslen);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int incoming =3D accept(pfd[i].fd, &=
ss.sa, &sslen);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (incoming < 0) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swit=
ch (errno) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 EAGAIN:
>> >> @@ -915,7 +922,7 @@ static int service_loop(struct socketlist *so=
cklist)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 die_errno("accept returned");
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle(incoming, (struct sockaddr *)=
&ss, sslen);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle(incoming, &ss.sa, sslen);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> =C2=A0 =C2=A0 =C2=A0 }
>> >
>> > As you say yourself, it's not elegant at all - sockaddr_storage is
>> > intended to be just that, an struct large enough to fit all the so=
ckaddrs
>> > you'll encounter on this platform, with all fields aligned in the =
same way
>> > as all the other sockaddr structs. You're supposed to be able to c=
ast the
>> > sockaddr struct pointers like currently is done, although I'm not =
familiar
>> > with the strict aliasing stuff well enough to know if anything els=
e would
>> > be required somewhere.
>> >
>>
>> Strict aliasing isn't exactly about the structure being large enough
>> or not, it's only being able to access a particular piece of memory
>> through one type only (unless specificly marked with "union").
>> sockaddr_storage is an attempt at fixing the storage-problem without
>> addressing the type punning problem, which doesn't help us much.
>
> Given this, does that mean that all code that uses sockaddr_storage
> directly without a union, and casting pointers to this struct into
> sockaddr, sockaddr_in and sockaddr_in6 is incorrect with regards to s=
trict
> aliasing?
>
> That is, even this example from RFC 2553 is faulty:
>
> =C2=A0 =C2=A0 =C2=A0struct sockaddr_storage __ss;
> =C2=A0 =C2=A0 =C2=A0struct sockaddr_in6 *sin6;
> =C2=A0 =C2=A0 =C2=A0sin6 =3D (struct sockaddr_in6 *) &__ss;
>

Yes, at least with C99. Section 6.5, paragraph 7 of the C99 specificati=
on says:

"An object shall have its stored value accessed only by an lvalue
expression that has one of
the following types:

- a type compatible with the effective type of the object,
- a quali=EF=AC=81ed version of a type compatible with the effective ty=
pe of the object,
- a type that is the signed or unsigned type corresponding to the
effective type of the
object,
- a type that is the signed or unsigned type corresponding to a
quali=EF=AC=81ed version of the
effective type of the object,
- an aggregate or union type that includes one of the aforementioned
types among its
members (including, recursively,amember of a subaggregate or contained
union), or
- a character type."

A type punned pointer does not meet any of those requirements.

=46or pre-C99 I don't have any reference other than Wikpedia, which
indicates that it's illegal in the ISO version of the standard (which
I assume must be C90):

"To enable such optimizations in a predictable manner, the ISO
standard for the C programming language (including its newer C99
edition, see section 6.5, paragraph 7) specifies that it is illegal
(with some exceptions) for pointers of different types to reference
the same memory location."

ref: http://en.wikipedia.org/wiki/Aliasing_(computing)

But the code above is incorrect in another sense: it's declaring a
symbol with a name starting with double underscore, something that is
reserved for the compiler. So I don't think I would trust the person
who wrote it to care much about standards compliance.
